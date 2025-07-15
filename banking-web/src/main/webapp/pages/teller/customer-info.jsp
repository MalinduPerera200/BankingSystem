<%@ page import="lk.jiat.banking.entities.Account" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Information - SecureBank</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            overflow-x: hidden;
        }

        /* Animated background */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
        }

        .floating-shape:nth-child(1) { width: 60px; height: 60px; top: 10%; left: 10%; animation-delay: 0s; }
        .floating-shape:nth-child(2) { width: 80px; height: 80px; top: 70%; left: 80%; animation-delay: 2s; }
        .floating-shape:nth-child(3) { width: 40px; height: 40px; top: 40%; left: 60%; animation-delay: 4s; }
        .floating-shape:nth-child(4) { width: 100px; height: 100px; top: 20%; left: 90%; animation-delay: 6s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .info-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 800px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .info-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #ff6b6b, #ffa500);
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo {
            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #ff6b6b, #ffa500);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 24px;
            font-weight: bold;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .info-container h1 {
            font-size: 28px;
            font-weight: 700;
            color: white;
            margin-bottom: 8px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-subtitle {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 30px;
        }

        .search-form {
            display: flex;
            gap: 12px;
            margin-bottom: 30px;
        }

        .search-form input[type="text"] {
            flex: 1;
            padding: 12px 16px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            color: white;
            font-size: 14px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .search-form input[type="text"]:focus {
            outline: none;
            border-color: #17a2b8;
            box-shadow: 0 0 0 3px rgba(23, 162, 184, 0.1);
            background: rgba(255, 255, 255, 0.15);
        }

        .search-form input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .search-btn {
            padding: 12px 24px;
            background: linear-gradient(45deg, #17a2b8, #20c997);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            white-space: nowrap;
        }

        .search-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(23, 162, 184, 0.3);
        }

        .search-btn:hover::before {
            left: 100%;
        }

        .customer-details, .account-details {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            position: relative;
            overflow: hidden;
        }

        .customer-details::before, .account-details::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, #007bff, #6f42c1);
        }

        .customer-details h2, .account-details h2 {
            font-size: 20px;
            font-weight: 600;
            color: white;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .customer-details p, .account-details p {
            margin: 8px 0;
            color: rgba(255, 255, 255, 0.9);
            font-size: 14px;
        }

        .customer-details strong, .account-details strong {
            display: inline-block;
            width: 140px;
            color: rgba(255, 255, 255, 0.7);
            font-weight: 500;
        }

        .account-list {
            margin-top: 16px;
            list-style: none;
        }

        .account-list li {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 12px;
            padding: 20px;
            border-radius: 12px;
            transition: all 0.3s ease;
            position: relative;
        }

        .account-list li:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(8px);
        }

        .account-list li::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 3px;
            background: linear-gradient(180deg, #28a745, #20c997);
            border-radius: 0 3px 3px 0;
        }

        .account-list li p {
            margin: 6px 0;
        }

        .message {
            margin-bottom: 20px;
            padding: 16px;
            border-radius: 12px;
            text-align: center;
            font-weight: 500;
            backdrop-filter: blur(10px);
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message.info {
            background: rgba(226, 227, 229, 0.2);
            color: rgba(255, 255, 255, 0.8);
            border: 1px solid rgba(214, 216, 219, 0.3);
        }

        .back-button {
            display: block;
            width: 100%;
            padding: 16px;
            background: rgba(108, 117, 125, 0.2);
            color: rgba(255, 255, 255, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            text-align: center;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            margin-top: 20px;
        }

        .back-button:hover {
            background: rgba(108, 117, 125, 0.3);
            color: white;
            transform: translateY(-2px);
        }

        /* Mobile responsive */
        @media (max-width: 768px) {
            .info-container {
                padding: 30px 20px;
                margin: 10px;
            }

            .info-container h1 {
                font-size: 24px;
            }

            .logo {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }

            .search-form {
                flex-direction: column;
            }

            .search-btn {
                width: 100%;
            }

            .customer-details strong, .account-details strong {
                width: 100px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<div class="bg-animation">
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
</div>

<div class="info-container">
    <div class="form-header">
        <div class="logo">SB</div>
        <h1>Customer Information</h1>
        <p class="form-subtitle">Search and view customer details</p>
    </div>

    <form action="${pageContext.request.contextPath}/teller/customer-info" method="get" class="search-form">
        <input type="text" name="nic" placeholder="Enter Customer NIC" value="${param.nic != null ? param.nic : ''}" required>
        <button type="submit" class="search-btn">Search</button>
    </form>

    <%
        lk.jiat.banking.entities.Customer customer = (lk.jiat.banking.entities.Customer) request.getAttribute("customer");
        String message = (String) request.getAttribute("message");

        if (customer != null) {
    %>
    <div class="customer-details">
        <h2>Customer Details</h2>
        <p><strong>Name:</strong> <%= customer.getFirstName() %> <%= customer.getLastName() %></p>
        <p><strong>NIC:</strong> <%= customer.getNic() %></p>
        <p><strong>Address:</strong> <%= customer.getAddress() %></p>
        <p><strong>Phone:</strong> <%= customer.getPhoneNumber() %></p>
        <p><strong>Email:</strong> <%= customer.getEmail() %></p>
        <p><strong>Date of Birth:</strong> <%= customer.getDateOfBirth() %></p>
    </div>

    <div class="account-details">
        <h2>Associated Accounts</h2>
        <%
            List<Account> accounts = customer.getAccounts();
            if (accounts != null && !accounts.isEmpty()) {
        %>
        <ul class="account-list">
            <% for (lk.jiat.banking.entities.Account account : accounts) { %>
            <li>
                <p><strong>Account No:</strong> <%= account.getAccountNumber() %></p>
                <p><strong>Type:</strong> <%= account.getAccountType() %></p>
                <p><strong>Balance:</strong> $<%= account.getBalance() %></p>
                <p><strong>Status:</strong> <%= account.getAccountStatus() %></p>
                <p><strong>Opened:</strong> <%= account.getOpenedDate() %></p>
            </li>
            <% } %>
        </ul>
        <% } else { %>
        <div class="message info">No accounts found for this customer.</div>
        <% } %>
    </div>
    <%
    } else if (message != null && !message.isEmpty()) {
    %>
    <div class="message info"><%= message %></div>
    <%
    } else if (request.getParameter("nic") != null && request.getParameter("nic").isEmpty()) {
    %>
    <div class="message info">Please enter a NIC to search for customer information.</div>
    <%
        }
    %>

    <a href="${pageContext.request.contextPath}/teller/dashboard" class="back-button">Back to Dashboard</a>
</div>
</body>
</html>