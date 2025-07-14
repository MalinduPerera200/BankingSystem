package lk.jiat.banking.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.banking.entities.User; // Import the User entity
import java.io.IOException;

@WebFilter(urlPatterns = {"/pages/*", "/admin/*", "/customer/*", "/teller/*"}) // Apply filter to all pages under /pages/ and role-specific paths
public class AuthenticationFilter implements Filter {

    private static final String LOGIN_PAGE = "/login.jsp";
    private static final String INDEX_PAGE = "/index.jsp"; // Or your application's home page

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false); // Do not create a new session if one doesn't exist

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Allow access to static resources (CSS, JS, Images)
        // You might need to adjust this regex or add more paths based on your resource structure
        if (requestURI.startsWith(contextPath + "/resources/") ||
                requestURI.startsWith(contextPath + "/css/") ||
                requestURI.startsWith(contextPath + "/js/") ||
                requestURI.startsWith(contextPath + "/images/")) {
            chain.doFilter(request, response);
            return;
        }

        // Allow access to login page and index page without authentication
        if (requestURI.equals(contextPath + LOGIN_PAGE) || requestURI.equals(contextPath + INDEX_PAGE) ||
                requestURI.equals(contextPath + "/login") || // Allow login servlet itself
                requestURI.equals(contextPath + "/")) { // Allow root context path (might redirect to index.jsp)
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        if (isLoggedIn) {
            // User is logged in, proceed with the request
            // You can add role-based authorization here if needed
            // User user = (User) session.getAttribute("loggedInUser");
            // String userRole = user.getRole().name();
            // if (requestURI.startsWith(contextPath + "/pages/admin/") && !userRole.equals("ADMIN")) {
            //     httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            //     return;
            // }
            chain.doFilter(request, response);
        } else {
            // User is not logged in, redirect to login page
            httpResponse.sendRedirect(contextPath + LOGIN_PAGE);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}