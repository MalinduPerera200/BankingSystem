<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - SecureBank</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 50%, #dc3545 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        /* Animated background elements */
        .bg-shapes {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 120px;
            height: 120px;
            top: 10%;
            left: 15%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 80px;
            height: 80px;
            top: 70%;
            right: 20%;
            animation-delay: 3s;
        }

        .shape:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 30%;
            left: 20%;
            animation-delay: 6s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-30px) rotate(180deg); }
        }

        .error-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 24px;
            padding: 50px;
            width: 90%;
            max-width: 700px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            position: relative;
            z-index: 2;
            text-align: center;
            animation: slideUp 0.8s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #ff6b6b, #dc3545);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            animation: pulse 2s ease-in-out infinite;
            position: relative;
        }

        .error-icon::before {
            content: '⚠';
            font-size: 48px;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .error-icon::after {
            content: '';
            position: absolute;
            top: -10px;
            left: -10px;
            right: -10px;
            bottom: -10px;
            border: 2px solid rgba(255, 107, 107, 0.3);
            border-radius: 50%;
            animation: ripple 2s ease-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes ripple {
            0% {
                transform: scale(0.8);
                opacity: 1;
            }
            100% {
                transform: scale(1.2);
                opacity: 0;
            }
        }

        h1 {
            font-size: 2.5em;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .subtitle {
            font-size: 1.2em;
            color: #7f8c8d;
            margin-bottom: 30px;
            font-weight: 400;
            line-height: 1.5;
        }

        .error-info {
            background: rgba(255, 107, 107, 0.05);
            border: 1px solid rgba(255, 107, 107, 0.2);
            border-radius: 12px;
            padding: 20px;
            margin: 25px 0;
            text-align: left;
        }

        .error-info p {
            margin-bottom: 10px;
            color: #2c3e50;
            font-size: 1em;
            line-height: 1.6;
        }

        .error-info strong {
            color: #dc3545;
            font-weight: 600;
        }

        .error-details {
            background: rgba(52, 73, 94, 0.05);
            border: 1px solid rgba(52, 73, 94, 0.1);
            border-radius: 12px;
            padding: 20px;
            margin-top: 25px;
            text-align: left;
            max-height: 300px;
            overflow-y: auto;
        }

        .error-details h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.1em;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .error-details h3::before {
            content: '🔧';
            margin-right: 8px;
            font-size: 1.2em;
        }

        .error-details p {
            margin-bottom: 8px;
            color: #34495e;
            font-size: 0.95em;
        }

        .error-details pre {
            background: rgba(44, 62, 80, 0.05);
            border-radius: 8px;
            padding: 15px;
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            font-size: 0.85em;
            color: #2c3e50;
            white-space: pre-wrap;
            word-wrap: break-word;
            line-height: 1.4;
            margin-top: 10px;
        }

        .actions {
            margin-top: 40px;
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            padding: 14px 28px;
            border: none;
            border-radius: 12px;
            text-decoration: none;
            font-size: 1em;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            color: #2c3e50;
            border: 2px solid rgba(52, 152, 219, 0.2);
        }

        .btn-secondary:hover {
            background: rgba(52, 152, 219, 0.1);
            border-color: rgba(52, 152, 219, 0.4);
            transform: translateY(-1px);
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn:hover::before {
            left: 100%;
        }

        .help-text {
            margin-top: 30px;
            color: #7f8c8d;
            font-size: 0.9em;
            line-height: 1.5;
        }

        .contact-info {
            margin-top: 20px;
            padding: 20px;
            background: rgba(52, 152, 219, 0.05);
            border-radius: 12px;
            border: 1px solid rgba(52, 152, 219, 0.1);
        }

        .contact-info h4 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 1.1em;
        }

        .contact-info p {
            color: #34495e;
            margin-bottom: 5px;
            font-size: 0.9em;
        }

        /* Toggle for technical details */
        .toggle-details {
            background: none;
            border: none;
            color: #3498db;
            font-size: 0.9em;
            cursor: pointer;
            text-decoration: underline;
            margin-top: 15px;
            transition: color 0.3s ease;
        }

        .toggle-details:hover {
            color: #2980b9;
        }

        .hidden {
            display: none;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .error-container {
                padding: 30px 20px;
                margin: 20px;
            }

            h1 {
                font-size: 2em;
            }

            .error-icon {
                width: 100px;
                height: 100px;
            }

            .error-icon::before {
                font-size: 36px;
            }

            .actions {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="bg-shapes">
    <div class="shape"></div>
    <div class="shape"></div>
    <div class="shape"></div>
</div>

<div class="error-container">
    <div class="error-icon"></div>

    <h1>Oops! Something Went Wrong</h1>
    <p class="subtitle">We apologize for the inconvenience. An unexpected error has occurred while processing your request.</p>

    <%
        // Get error message from request attribute (set by servlets/controllers)
        String customErrorMessage = (String) request.getAttribute("errorMessage");
        if (customErrorMessage != null && !customErrorMessage.isEmpty()) {
    %>
    <div class="error-info">
        <p><strong>Error Message:</strong> <%= customErrorMessage %></p>
    </div>
    <%
        }

        // Get exception details if this page is configured as an error page
        Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception");
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");
        String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");

        if (statusCode != null || requestUri != null) {
    %>
    <div class="error-info">
        <% if (statusCode != null) { %>
        <p><strong>Status Code:</strong> <%= statusCode %></p>
        <% } %>
        <% if (requestUri != null) { %>
        <p><strong>Requested URI:</strong> <%= requestUri %></p>
        <% } %>
    </div>
    <%
        }

        if (exception != null) {
    %>
    <button class="toggle-details" onclick="toggleTechnicalDetails()">
        <span id="toggleText">Show Technical Details</span>
    </button>

    <div class="error-details hidden" id="technicalDetails">
        <h3>Technical Details</h3>
        <p><strong>Exception Type:</strong> <%= exception.getClass().getName() %></p>
        <p><strong>Message:</strong> <%= exception.getMessage() != null ? exception.getMessage() : "No specific message available" %></p>
        <%
            // For security and user experience, avoid showing full stack traces in production.
            // This is for development/debugging purposes.
            // In a production environment, you might log the stack trace and show a generic message.
            // if (application.getInitParameter("displayStackTraces") != null &&
            //     Boolean.parseBoolean(application.getInitParameter("displayStackTraces"))) {
        %>
        <%-- <pre><% exception.printStackTrace(new java.io.PrintWriter(out)); %></pre> --%>
        <%
            // }
        %>
    </div>
    <%
        }
    %>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">
            🏠 Go to Home Page
        </a>
        <button class="btn btn-secondary" onclick="goBack()">
            ← Go Back
        </button>
    </div>

    <div class="help-text">
        <p>If the problem persists, please contact our support team with the error details above.</p>
    </div>

    <div class="contact-info">
        <h4>Need Help?</h4>
        <p>📞 Support Phone: 1-800-SECURE-BANK</p>
        <p>📧 Email: support@securebank.com</p>
        <p>🕒 Available 24/7 for your assistance</p>
    </div>
</div>

<script>
    function toggleTechnicalDetails() {
        const details = document.getElementById('technicalDetails');
        const toggleText = document.getElementById('toggleText');

        if (details.classList.contains('hidden')) {
            details.classList.remove('hidden');
            toggleText.textContent = 'Hide Technical Details';
        } else {
            details.classList.add('hidden');
            toggleText.textContent = 'Show Technical Details';
        }
    }

    function goBack() {
        if (window.history.length > 1) {
            window.history.back();
        } else {
            window.location.href = '${pageContext.request.contextPath}/index.jsp';
        }
    }

    // Add subtle animations on load
    window.addEventListener('load', function() {
        const elements = document.querySelectorAll('.error-info, .error-details');
        elements.forEach((el, index) => {
            setTimeout(() => {
                el.style.animation = 'slideUp 0.5s ease-out forwards';
            }, index * 200);
        });
    });
</script>
</body>
</html>