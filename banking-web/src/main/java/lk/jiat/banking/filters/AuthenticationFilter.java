package lk.jiat.banking.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.jiat.banking.entities.User;
import java.io.IOException;

@WebFilter(urlPatterns = {"/pages/*", "/admin/*", "/customer/*", "/teller/*"})
public class AuthenticationFilter implements Filter {

    private static final String LOGIN_PAGE = "/login.jsp";
    private static final String INDEX_PAGE = "/index.jsp";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        if (requestURI.startsWith(contextPath + "/resources/") ||
                requestURI.startsWith(contextPath + "/css/") ||
                requestURI.startsWith(contextPath + "/js/") ||
                requestURI.startsWith(contextPath + "/images/")) {
            chain.doFilter(request, response);
            return;
        }

        if (requestURI.equals(contextPath + LOGIN_PAGE) || requestURI.equals(contextPath + INDEX_PAGE) ||
                requestURI.equals(contextPath + "/login") || requestURI.equals(contextPath + "/")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(contextPath + LOGIN_PAGE);
        }
    }

    @Override
    public void destroy() {
    }
}
