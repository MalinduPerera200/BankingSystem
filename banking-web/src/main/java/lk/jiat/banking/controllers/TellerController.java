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

// ✅ Ensure both URL patterns are registered to this servlet
@WebServlet(urlPatterns = {"/teller/dashboard", "/teller/customer-info"})
public class TellerController extends HttpServlet {

    @EJB
    private CustomerServiceLocal customerService;

    @EJB
    private AccountServiceLocal accountService;

    /**
     * ✅ UPDATED: Handles GET requests by routing based on the URL.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath();

        // Use a switch statement for clear and robust routing
        switch (servletPath) {
            case "/teller/customer-info":
                handleCustomerInfoSearch(request, response);
                break;
            case "/teller/dashboard":
            default: // Fallback to dashboard for any other case
                handleDashboardActions(request, response);
                break;
        }
    }

    /**
     * ✅ NEW: This method specifically handles logic for the customer search page.
     * It is called when the URL is /teller/customer-info.
     */
    private void handleCustomerInfoSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nic = request.getParameter("nic");

        // Only search if the NIC parameter is present and not empty
        if (nic != null && !nic.trim().isEmpty()) {
            Customer customer = customerService.findByNic(nic);
            if (customer != null) {
                request.setAttribute("customer", customer);
            } else {
                request.setAttribute("message", "No customer found with NIC: " + nic);
            }
        }
        // Forward the request to the JSP page
        request.getRequestDispatcher("/pages/teller/customer-info.jsp").forward(request, response);
    }

    /**
     * This method handles all actions originating from the main dashboard.
     */
    private void handleDashboardActions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // If there's no action, just show the dashboard
        if (action == null) {
            request.getRequestDispatcher("/pages/teller/dashboard.jsp").forward(request, response);
            return;
        }

        String forwardPage;
        switch (action) {
            case "showCreateCustomer": forwardPage = "/pages/teller/create-customer.jsp"; break;
            case "showDeposit": forwardPage = "/pages/teller/deposit.jsp"; break;
            case "showWithdraw": forwardPage = "/pages/teller/withdraw.jsp"; break;
            case "showTransfer": forwardPage = "/pages/teller/transfer.jsp"; break;
            case "showCustomerInfo": forwardPage = "/pages/teller/customer-info.jsp"; break; // For navigation
            case "getAccountDetails": handleGetAccountDetails(request, response); return; // AJAX call
            default: forwardPage = "/pages/teller/dashboard.jsp"; break;
        }
        request.getRequestDispatcher(forwardPage).forward(request, response);
    }

    // --- All other methods (doPost, handleWithdraw, etc.) remain unchanged ---
    // ... (Your existing doPost, handleDeposit, handleWithdraw, etc. methods go here) ...
    //<editor-fold desc="doPost and other helper methods">
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String statusMessage = null;
        String errorMessage = null;
        String forwardPage = "/pages/teller/dashboard.jsp"; // Default page

        try {
            switch (action) {
                case "createCustomer":
                    forwardPage = "/pages/teller/create-customer.jsp";
                    String newAccountNumber = handleCreateCustomer(request);
                    statusMessage = "Customer created successfully! New account number: " + newAccountNumber;
                    break;
                case "deposit":
                    forwardPage = "/pages/teller/deposit.jsp";
                    BigDecimal depositedAmount = handleDeposit(request);
                    statusMessage = String.format("Successfully deposited LKR %.2f.", depositedAmount);
                    break;
                case "withdraw":
                    forwardPage = "/pages/teller/withdraw.jsp";
                    BigDecimal withdrawnAmount = handleWithdraw(request);
                    statusMessage = String.format("Successfully withdrew LKR %.2f.", withdrawnAmount);
                    break;
                case "transfer":
                    forwardPage = "/pages/teller/transfer.jsp";
                    handleTransfer(request);
                    statusMessage = "Funds transferred successfully!";
                    break;
                default:
                    errorMessage = "Unknown or unsupported action specified.";
                    break;
            }
        } catch (BankingException e) {
            errorMessage = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            errorMessage = "An unexpected server error occurred. Please contact support.";
        }

        if (errorMessage == null) {
            String redirectUrl = request.getContextPath() + forwardPage + "?status=success&message=" + URLEncoder.encode(statusMessage, StandardCharsets.UTF_8);
            response.sendRedirect(redirectUrl);
        } else {
            request.setAttribute("errorMessage", errorMessage);
            switch (action) {
                case "createCustomer": forwardPage = "/pages/teller/create-customer.jsp"; break;
                case "deposit": forwardPage = "/pages/teller/deposit.jsp"; break;
                case "withdraw": forwardPage = "/pages/teller/withdraw.jsp"; break;
                case "transfer": forwardPage = "/pages/teller/transfer.jsp"; break;
            }
            request.getRequestDispatcher(forwardPage).forward(request, response);
        }
    }

    private void handleGetAccountDetails(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String accountNumber = request.getParameter("accountNumber");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String jsonResponse;

        try {
            Account account = accountService.findAccountByNumber(accountNumber);
            Customer customer = account.getCustomer();

            jsonResponse = String.format(
                    "{\"status\": \"success\", \"accountNumber\": \"%s\", \"customerName\": \"%s\", \"customerNic\": \"%s\", \"balance\": %.2f}",
                    escapeJson(account.getAccountNumber()),
                    escapeJson(customer.getFirstName() + " " + customer.getLastName()),
                    escapeJson(customer.getNic()),
                    account.getBalance()
            );

        } catch (BankingException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse = String.format("{\"status\": \"error\", \"message\": \"%s\"}", escapeJson(e.getMessage()));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
            jsonResponse = "{\"status\": \"error\", \"message\": \"An unexpected server error occurred.\"}";
        }

        out.print(jsonResponse);
        out.flush();
    }

    private String handleCreateCustomer(HttpServletRequest request) throws BankingException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String nic = request.getParameter("nic");
        String dobString = request.getParameter("dateOfBirth");
        String accountTypeStr = request.getParameter("accountType"); // Added

        if (firstName == null || firstName.trim().isEmpty() || lastName == null || lastName.trim().isEmpty() || nic == null || nic.trim().isEmpty()) {
            throw new BankingException("First name, last name, and NIC are required.");
        }

        if (accountTypeStr == null || accountTypeStr.trim().isEmpty()) {
            throw new BankingException("Account type is required.");
        }

        LocalDate dateOfBirth = null;
        if (dobString != null && !dobString.isEmpty()) {
            try {
                dateOfBirth = LocalDate.parse(dobString);
            } catch (DateTimeParseException e) {
                throw new BankingException("Invalid date of birth format. Please use YYYY-MM-DD.");
            }
        }

        AccountType accountType;
        try {
            accountType = AccountType.valueOf(accountTypeStr);
        } catch (IllegalArgumentException e) {
            throw new BankingException("Invalid account type specified.");
        }

        Customer newCustomer = new Customer(firstName.trim(), lastName.trim(), nic.trim(), request.getParameter("address"), request.getParameter("phoneNumber"), request.getParameter("email"), dateOfBirth);
        customerService.createCustomer(newCustomer);

        String accountNumber = generateUniqueAccountNumber();
        Account newAccount = new Account(accountNumber, newCustomer, BigDecimal.ZERO, accountType, LocalDateTime.now()); // Modified
        accountService.createAccount(newAccount);
        return accountNumber;
    }

    private BigDecimal handleDeposit(HttpServletRequest request) throws BankingException {
        String accountNumber = request.getParameter("accountNumber");
        String amountStr = request.getParameter("amount");
        validateTransactionInputs(accountNumber, amountStr);
        BigDecimal amount = parseAmount(amountStr);
        accountService.deposit(accountNumber.trim(), amount);
        return amount;
    }

    private BigDecimal handleWithdraw(HttpServletRequest request) throws BankingException {
        String accountNumber = request.getParameter("accountNumber");
        String amountStr = request.getParameter("amount");
        validateTransactionInputs(accountNumber, amountStr);
        BigDecimal amount = parseAmount(amountStr);
        accountService.withdraw(accountNumber.trim(), amount);
        return amount;
    }

    private void handleTransfer(HttpServletRequest request) throws BankingException {
        String fromAccountNumber = request.getParameter("fromAccountNumber");
        String toAccountNumber = request.getParameter("toAccountNumber");
        String amountStr = request.getParameter("amount");

        if (fromAccountNumber == null || fromAccountNumber.trim().isEmpty() || toAccountNumber == null || toAccountNumber.trim().isEmpty()) {
            throw new BankingException("Both source and destination account numbers are required.");
        }
        if (fromAccountNumber.trim().equals(toAccountNumber.trim())) {
            throw new BankingException("Source and destination accounts cannot be the same.");
        }

        validateTransactionInputs(fromAccountNumber, amountStr);
        BigDecimal amount = parseAmount(amountStr);
        accountService.transfer(fromAccountNumber.trim(), toAccountNumber.trim(), amount);
    }

    private void validateTransactionInputs(String accountNumber, String amountStr) throws BankingException {
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            throw new BankingException("Account number is required.");
        }
        if (amountStr == null || amountStr.trim().isEmpty()) {
            throw new BankingException("Transaction amount is required.");
        }
    }

    private BigDecimal parseAmount(String amountStr) throws BankingException {
        BigDecimal amount;
        try {
            amount = new BigDecimal(amountStr.trim());
        } catch (NumberFormatException e) {
            throw new BankingException("Invalid amount format. Please enter a valid number.");
        }
        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new BankingException("Transaction amount must be positive.");
        }
        return amount;
    }

    private String generateUniqueAccountNumber() {
        long randomNumber = ThreadLocalRandom.current().nextLong(1_000_000_000L, 10_000_000_000L);
        return String.valueOf(randomNumber);
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\").replace("\"", "\\\"").replace("\b", "\\b")
                .replace("\f", "\\f").replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
    }
    //</editor-fold>
}