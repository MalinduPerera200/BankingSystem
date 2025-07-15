package lk.jiat.banking.controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.banking.services.interfaces.AccountServiceLocal;
import lk.jiat.banking.services.interfaces.CustomerServiceLocal;
import lk.jiat.banking.services.interfaces.TransactionServiceLocal;

import java.io.IOException;

@WebServlet("/teller/dashboard")
public class TellerController extends HttpServlet {

    @EJB
    private CustomerServiceLocal customerService;
    @EJB
    private AccountServiceLocal accountService;
    @EJB
    private TransactionServiceLocal transactionService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/teller/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("createCustomer".equals(action)) {
            // Call customerService.createCustomer()
            // response.sendRedirect(request.getContextPath() + "/teller/dashboard?status=customerCreated");
        } else if ("deposit".equals(action)) {
            // Call transactionService.deposit()
            // response.sendRedirect(request.getContextPath() + "/teller/dashboard?status=depositSuccessful");
        } else if ("withdraw".equals(action)) {
            // Call transactionService.withdraw()
            // response.sendRedirect(request.getContextPath() + "/teller/dashboard?status=withdrawSuccessful");
        } else if ("transfer".equals(action)) {
            // Call transactionService.transfer()
            // response.sendRedirect(request.getContextPath() + "/teller/dashboard?status=transferSuccessful");
        } else {
            doGet(request, response);
        }
    }
}