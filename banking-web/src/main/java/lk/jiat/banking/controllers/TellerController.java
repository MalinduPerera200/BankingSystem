package lk.jiat.banking.controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.banking.entities.Account;
import lk.jiat.banking.entities.Customer;
import lk.jiat.banking.enums.AccountType;
import lk.jiat.banking.exceptions.AccountNotFoundException;
import lk.jiat.banking.exceptions.BankingException;
import lk.jiat.banking.services.interfaces.AccountServiceLocal;
import lk.jiat.banking.services.interfaces.CustomerServiceLocal;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.concurrent.ThreadLocalRandom;

@WebServlet("/teller/dashboard")
public class TellerController extends HttpServlet {

    @EJB
    private CustomerServiceLocal customerService;

    @EJB
    private AccountServiceLocal accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            request.getRequestDispatcher("/pages/teller/dashboard.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "showCreateCustomer":
                request.getRequestDispatcher("/pages/teller/create-customer.jsp").forward(request, response);
                break;
            case "showDeposit":
                request.getRequestDispatcher("/pages/teller/deposit.jsp").forward(request, response);
                break;
            case "getAccountDetails":
                handleGetAccountDetails(request, response);
                break;
            default:
                request.getRequestDispatcher("/pages/teller/dashboard.jsp").forward(request, response);
                break;
        }
    }

    private void handleGetAccountDetails(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String accountNumber = request.getParameter("accountNumber");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse;

        // Add logging for debugging
        System.out.println("Searching for account number: " + accountNumber);

        try {
            if (accountNumber == null || accountNumber.trim().isEmpty()) {
                jsonResponse = "{\"status\": \"error\", \"message\": \"Account number is required.\"}";
            } else {
                Account account = accountService.findAccountByNumber(accountNumber.trim());
                Customer customer = account.getCustomer();

                // Build JSON object manually with proper escaping
                jsonResponse = String.format(
                        "{\"status\": \"success\", \"accountNumber\": \"%s\", \"customerName\": \"%s\", \"customerNic\": \"%s\", \"balance\": %.2f, \"accountType\": \"%s\"}",
                        escapeJson(account.getAccountNumber()),
                        escapeJson(customer.getFirstName() + " " + customer.getLastName()),
                        escapeJson(customer.getNic()),
                        account.getBalance(),
                        account.getAccountType().toString()
                );
            }

        } catch (AccountNotFoundException e) {
            jsonResponse = String.format("{\"status\": \"error\", \"message\": \"%s\"}", escapeJson(e.getMessage()));
        } catch (Exception e) {
            // Log the actual exception for debugging
            e.printStackTrace();
            jsonResponse = "{\"status\": \"error\", \"message\": \"An unexpected error occurred.\"}";
        }

        out.print(jsonResponse);
        out.flush();
    }

    // Helper method to escape JSON strings
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String statusMessage = null;
        String errorMessage = null;
        String forwardPage = "/pages/teller/dashboard.jsp"; // Default forward page

        try {
            if ("createCustomer".equals(action)) {
                forwardPage = "/pages/teller/create-customer.jsp";
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String nic = request.getParameter("nic");
                String address = request.getParameter("address");
                String phoneNumber = request.getParameter("phoneNumber");
                String email = request.getParameter("email");
                String dobString = request.getParameter("dateOfBirth");
                LocalDate dateOfBirth = null;

                if (firstName == null || firstName.trim().isEmpty() || lastName == null || lastName.trim().isEmpty() || nic == null || nic.trim().isEmpty()) {
                    throw new BankingException("First name, last name, and NIC are required.");
                }

                if (dobString != null && !dobString.isEmpty()) {
                    try {
                        dateOfBirth = LocalDate.parse(dobString);
                    } catch (DateTimeParseException e) {
                        throw new BankingException("Invalid date of birth format. Please use YYYY-MM-DD.");
                    }
                }

                Customer newCustomer = new Customer(firstName.trim(), lastName.trim(), nic.trim(), address != null ? address.trim() : null, phoneNumber != null ? phoneNumber.trim() : null, email != null ? email.trim() : null, dateOfBirth);
                customerService.createCustomer(newCustomer);

                String accountNumber = generateUniqueAccountNumber();
                Account newAccount = new Account(accountNumber, newCustomer, BigDecimal.ZERO, AccountType.SAVINGS, LocalDateTime.now());

                accountService.createAccount(newAccount);

                statusMessage = "Customer created successfully! New account number: " + accountNumber;

            } else if ("deposit".equals(action)) {
                forwardPage = "/pages/teller/deposit.jsp";
                String accountNumber = request.getParameter("accountNumber");
                String amountStr = request.getParameter("amount");
                BigDecimal amount;

                // Validate inputs
                if (accountNumber == null || accountNumber.trim().isEmpty()) {
                    throw new BankingException("Account number is required.");
                }
                if (amountStr == null || amountStr.trim().isEmpty()) {
                    throw new BankingException("Deposit amount is required.");
                }

                try {
                    amount = new BigDecimal(amountStr.trim());
                } catch (NumberFormatException e) {
                    throw new BankingException("Invalid amount format. Please enter a valid number.");
                }

                if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                    throw new BankingException("Deposit amount must be greater than zero.");
                }

                accountService.deposit(accountNumber.trim(), amount);

                statusMessage = String.format("Successfully deposited LKR %.2f to account %s.", amount, accountNumber.trim());

            } else {
                errorMessage = "Unknown action specified.";
            }
        } catch (BankingException e) {
            errorMessage = e.getMessage();
        } catch (Exception e) {
            errorMessage = "An unexpected error occurred. Please contact support.";
            e.printStackTrace();
        }

        if (statusMessage != null) {
            response.sendRedirect(request.getContextPath() + "/teller/dashboard?action=showDeposit&status=" + URLEncoder.encode(statusMessage, StandardCharsets.UTF_8));
        } else {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher(forwardPage).forward(request, response);
        }
    }

    private String generateUniqueAccountNumber() {
        long randomNumber = ThreadLocalRandom.current().nextLong(1_000_000_000L, 10_000_000_000L);
        return String.valueOf(randomNumber);
    }
}