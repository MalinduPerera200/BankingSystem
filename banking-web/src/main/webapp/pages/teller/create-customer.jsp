<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Customer - SecureBank</title>
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

        .form-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 500px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .form-container::before {
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

        .form-container h1 {
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

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 600;
            font-size: 14px;
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="date"] {
            width: 100%;
            padding: 12px 16px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            color: white;
            font-size: 14px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="email"]:focus,
        .form-group input[type="date"]:focus {
            outline: none;
            border-color: #ff6b6b;
            box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
            background: rgba(255, 255, 255, 0.15);
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .form-group input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(1);
            opacity: 0.7;
        }

        .submit-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(45deg, #28a745, #20c997);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 16px;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .back-button {
            display: block;
            width: 100%;
            padding: 14px;
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
        }
        /* --- General Select Dropdown Styling --- */

        .form-group select {
            /* --- Appearance and Sizing --- */
            appearance: none; /* Removes default browser styling */
            -webkit-appearance: none; /* For Safari/Chrome */
            -moz-appearance: none; /* For Firefox */
            display: block;
            width: 100%;
            padding: 15px; /* Adjust padding to match other inputs */
            font-size: 16px; /* Match font size */
            line-height: 1.5;
            color: #ffffff; /* White text color */

            /* --- Background and Border --- */
            background-color: rgba(255, 255, 255, 0.1); /* Translucent white background */
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px; /* Rounded corners */

            /* --- Custom Arrow --- */
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23ffffff%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E');
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 12px; /* Size of the arrow icon */
        }

        /* --- Styling for the Dropdown Options --- */
        .form-group select option {
            background-color: #3e2e72; /* A dark purple that could match your theme */
            color: #ffffff;
        }

        /* --- Focus State --- */
        .form-group select:focus {
            outline: none;
            border-color: #4CAF50; /* Green border on focus to match button */
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
        }

        /* --- Placeholder Option Color --- */
        .form-group select option[value=""] {
            color: #cccccc;
        }

        .back-button:hover {
            background: rgba(108, 117, 125, 0.3);
            color: white;
            transform: translateY(-1px);
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

        .message.success {
            background: rgba(212, 237, 218, 0.2);
            color: #d4edda;
            border: 1px solid rgba(195, 230, 203, 0.3);
        }

        .message.error {
            background: rgba(248, 215, 218, 0.2);
            color: #f8d7da;
            border: 1px solid rgba(245, 198, 203, 0.3);
        }

        /* Mobile responsive */
        @media (max-width: 768px) {
            .form-container {
                padding: 30px 20px;
                margin: 10px;
            }

            .form-container h1 {
                font-size: 24px;
            }

            .logo {
                width: 50px;
                height: 50px;
                font-size: 20px;
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
    <div class="form-header">
        <div class="logo">SB</div>
        <h1>Create New Customer</h1>
        <p class="form-subtitle">Add a new customer to the system</p>
    </div>

    <%
        // Get messages from request attributes (for errors) or request parameters (for success)
        String errorMessage = (String) request.getAttribute("errorMessage");
        String statusMessage = request.getParameter("status");

        if (errorMessage != null && !errorMessage.isEmpty()) {
    %>
    <div class="message error"><%= errorMessage %></div>
    <%
    } else if (statusMessage != null && !statusMessage.isEmpty()) {
    %>
    <div class="message success"><%= statusMessage %></div>
    <%
        }
    %>

    <form action="${pageContext.request.contextPath}/teller/dashboard" method="post">
        <input type="hidden" name="action" value="createCustomer">

        <div class="form-group">
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" name="firstName" placeholder="Enter first name" required>
        </div>

        <div class="form-group">
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" name="lastName" placeholder="Enter last name" required>
        </div>

        <div class="form-group">
            <label for="nic">National ID (NIC)</label>
            <input type="text" id="nic" name="nic" placeholder="Enter NIC number" required>
        </div>

        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" id="address" name="address" placeholder="Enter address">
        </div>

        <div class="form-group">
            <label for="phoneNumber">Phone Number</label>
            <input type="text" id="phoneNumber" name="phoneNumber" placeholder="Enter phone number">
        </div>

        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="Enter email address">
        </div>

        <div class="form-group">
            <label for="dob">Date of Birth</label>
            <input type="date" id="dob" name="dateOfBirth">
        </div>
        <div class="form-group">
            <label for="accountType">Account Type</label>
            <select class="form-control" id="accountType" name="accountType" required>
                <option value="">Select Account Type</option>
                <option value="SAVINGS">Savings</option>
                <option value="CHECKING">Checking</option>
                <option value="FIXED_DEPOSIT">Fixed Deposit</option>
                <option value="LOAN_ACCOUNT">Loan Account</option>
                <option value="CURRENT">Current</option>
            </select>
        </div>

        <button type="submit" class="submit-btn">Create Customer</button>
    </form>

    <a href="${pageContext.request.contextPath}/teller/dashboard" class="back-button">Back to Dashboard</a>
</div>
</body>
</html>
