<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Withdraw Funds - SecureBank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css ">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

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

        .floating-shape:nth-child(1) { width: 60px; height: 60px; top: 10%; left: 10%; }
        .floating-shape:nth-child(2) { width: 80px; height: 80px; top: 70%; left: 80%; animation-delay: 2s; }
        .floating-shape:nth-child(3) { width: 40px; height: 40px; top: 40%; left: 60%; animation-delay: 4s; }
        .floating-shape:nth-child(4) { width: 100px; height: 100px; top: 20%; left: 90%; animation-delay: 6s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .form-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: slideUp 0.6s ease-out;
        }

        .form-container h1 {
            font-size: 24px;
            font-weight: 700;
            color: white;
            margin-bottom: 24px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 600;
            margin-bottom: 6px;
        }

        .form-group input[type="text"],
        .form-group input[type="number"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 14px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .form-group button {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            background: linear-gradient(45deg, #ef4444, #dc2626);
            color: white;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .form-group button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
        }

        .form-group button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .form-group button:hover::before {
            left: 100%;
        }

        .message {
            margin-top: 16px;
            padding: 12px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 500;
        }

        .message.success {
            background-color: rgba(16, 185, 129, 0.2);
            color: #ecfdf5;
            border: 1px solid rgba(16, 185, 129, 0.4);
        }

        .message.error {
            background-color: rgba(239, 68, 68, 0.2);
            color: #fef2f2;
            border: 1px solid rgba(239, 68, 68, 0.4);
        }

        .back-button {
            display: inline-block;
            margin-top: 16px;
            padding: 12px 24px;
            background: linear-gradient(45deg, #7c3aed, #8b5cf6);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .back-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(139, 92, 246, 0.4);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 500px) {
            .form-container {
                padding: 24px;
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

<div class="form-container">
    <h1>Withdraw Funds</h1>

    <%
        String status = request.getParameter("status");
        if ("success".equals(status)) {
    %>
    <div class="message success">✅ Withdrawal successful!</div>
    <%
    } else if ("error".equals(status)) {
        String message = request.getParameter("message");
        if (message == null || message.isEmpty()) {
            message = "Unknown error occurred.";
        }
    %>
    <div class="message error">❌ <%= message %></div>
    <%
        }
    %>

    <form action="${pageContext.request.contextPath}/teller/dashboard" method="post">
        <input type="hidden" name="action" value="withdraw">

        <div class="form-group">
            <label for="accountNumber">Account Number</label>
            <input type="text" id="accountNumber" name="accountNumber" placeholder="Enter account number" required>
        </div>

        <div class="form-group">
            <label for="amount">Amount</label>
            <input type="number" id="amount" name="amount" step="0.01" min="0.01" placeholder="Enter amount" required>
        </div>

        <div class="form-group">
            <button type="submit">Withdraw</button>
        </div>
    </form>

    <a href="${pageContext.request.contextPath}/teller/dashboard" class="back-button">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

</body>
</html>