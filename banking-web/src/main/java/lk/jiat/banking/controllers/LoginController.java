package lk.jiat.banking.controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.banking.entities.User;
import lk.jiat.banking.enums.UserRole;
import lk.jiat.banking.security.AuthenticationService;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/login") // Map this servlet to the /login URL
public class LoginController extends HttpServlet {

    @EJB
    private AuthenticationService authService; // Inject the AuthenticationService EJB

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Basic validation
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        Optional<User> authenticatedUser = authService.authenticate(username, password);

        if (authenticatedUser.isPresent()) {
            User user = authenticatedUser.get();
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user); // Store the authenticated User object in session
            session.setAttribute("userRole", user.getRole().name()); // Store user role for easy access

            // Redirect based on user role
            if (user.getRole() == UserRole.ADMIN) {
                response.sendRedirect(request.getContextPath() + "/pages/admin/dashboard.jsp"); // Admin dashboard
            } else if (user.getRole() == UserRole.CUSTOMER) {
                response.sendRedirect(request.getContextPath() + "/pages/customer/dashboard.jsp"); // Customer dashboard (assuming you'll create this)
            } else if (user.getRole() == UserRole.TELLER) {
                response.sendRedirect(request.getContextPath() + "/pages/teller/dashboard.jsp"); // Teller dashboard (assuming you'll create this)
            } else {
                // Default redirect if role is not recognized or dashboard not defined
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    // For simplicity, you might not need a doGet for login, or it can just redirect to login.jsp
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // If someone directly tries to access /login via GET, redirect them to the login page
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}