<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transfer Funds - SecureBank</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        /* CSS Reset & Basic Styles */
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

        /* Animated background shapes */
        .bg-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
        }

        .floating-shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 12s ease-in-out infinite;
        }

        .floating-shape:nth-child(1) { width: 60px; height: 60px; top: 10%; left: 10%; }
        .floating-shape:nth-child(2) { width: 80px; height: 80px; top: 70%; left: 80%; animation-delay: 2s; }
        .floating-shape:nth-child(3) { width: 40px; height: 40px; top: 40%; left: 60%; animation-delay: 4s; }
        .floating-shape:nth-child(4) { width: 100px; height: 100px; top: 20%; left: 90%; animation-delay: 6s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-25px) rotate(180deg); }
        }

        /* Main form container */
        .form-container {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 450px; /* Increased width for better layout */
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-container h1 {
            font-size: 24px;
            font-weight: 700;
            color: white;
            margin-bottom: 24px;
        }

        /* Form groups, labels, and inputs */
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            color: rgba(255, 255, 255, 0.85);
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-group input[type="text"],
        .form-group input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .form-group input:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.5);
            background: rgba(255, 255, 255, 0.15);
        }

        /* Buttons */
        .form-group button, .back-button {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            display: inline-block;
            color: white;
        }

        .form-group button {
            background: linear-gradient(45deg, #8b5cf6, #7c3aed);
            box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3);
        }

        .form-group button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.4);
        }

        .back-button {
            margin-top: 16px;
            background: rgba(255, 255, 255, 0.15);
        }

        .back-button:hover {
            background: rgba(255, 255, 255, 0.25);
        }

        /* Success and Error Messages */
        .message {
            margin-bottom: 16px;
            padding: 12px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 500;
            text-align: left;
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

        /* Styles for AJAX-loaded account details */
        .account-details {
            text-align: left;
            margin-top: -10px; /* Pull up under the input */
            margin-bottom: 20px;
            padding: 15px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            display: none; /* Initially hidden */
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }

        .account-details p { margin-bottom: 8px; font-size: 14px; }
        .account-details p:last-child { margin-bottom: 0; }
        .account-details strong { color: rgba(255, 255, 255, 0.85); margin-right: 8px; }

        .details-error {
            display: none; /* Initially hidden */
            margin-top: -10px;
            margin-bottom: 15px;
        }

        /* Responsive design */
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
    <h1>Transfer Funds</h1>

    <%-- Display success or error messages passed from the servlet --%>
    <%
        String status = request.getParameter("status");
        String message = request.getParameter("message");
        if ("success".equals(status) && message != null) {
    %>
    <div class="message success">✅ <%= message %></div>
    <%
    } else if (request.getAttribute("errorMessage") != null) {
    %>
    <div class="message error">❌ <%= request.getAttribute("errorMessage") %></div>
    <%
        }
    %>

    <form action="${pageContext.request.contextPath}/teller/dashboard" method="post">
        <input type="hidden" name="action" value="transfer">

        <div class="form-group">
            <label for="fromAccountNumber">From Account Number</label>
            <input type="text" id="fromAccountNumber" name="fromAccountNumber" placeholder="Enter source account & press Tab" required onblur="fetchAccountDetails('from')">
        </div>
        <div id="fromAccountDetails" class="account-details">
            <p><strong>Name:</strong> <span id="fromCustomerName"></span></p>
            <p><strong>Balance:</strong> LKR <span id="fromBalance"></span></p>
        </div>
        <div id="fromAccountError" class="message error details-error"></div>

        <div class="form-group">
            <label for="toAccountNumber">To Account Number</label>
            <input type="text" id="toAccountNumber" name="toAccountNumber" placeholder="Enter destination account & press Tab" required onblur="fetchAccountDetails('to')">
        </div>
        <div id="toAccountDetails" class="account-details">
            <p><strong>Name:</strong> <span id="toCustomerName"></span></p>
        </div>
        <div id="toAccountError" class="message error details-error"></div>

        <div class="form-group">
            <label for="amount">Amount</label>
            <input type="number" id="amount" name="amount" step="0.01" min="0.01" placeholder="Enter amount to transfer" required>
        </div>

        <div class="form-group">
            <button type="submit">
                <i class="fas fa-exchange-alt"></i> Transfer Funds
            </button>
        </div>
    </form>

    <a href="${pageContext.request.contextPath}/teller/dashboard" class="back-button">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<script>
    /**
     * Fetches account details from the server using AJAX.
     * @param {string} type - The type of account, either 'from' or 'to'.
     */
    function fetchAccountDetails(type) {
        const accountNumberInput = document.getElementById(type + 'AccountNumber');
        const detailsContainer = document.getElementById(type + 'AccountDetails');
        const errorContainer = document.getElementById(type + 'AccountError');

        const accountNumber = accountNumberInput.value.trim();

        // Reset state before fetching
        detailsContainer.style.display = 'none';
        errorContainer.style.display = 'none';

        if (!accountNumber) {
            return; // Don't fetch if the input is empty
        }

        const url = '${pageContext.request.contextPath}/teller/dashboard?action=getAccountDetails&accountNumber=' + encodeURIComponent(accountNumber);

        fetch(url)
            .then(response => {
                if (!response.ok) { // Handles HTTP errors like 404 or 500
                    throw new Error('Network response was not ok. Status: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'success') {
                    // Populate the details and show the container
                    document.getElementById(type + 'CustomerName').textContent = data.customerName;

                    // Only show balance for the 'from' account
                    if (type === 'from') {
                        document.getElementById('fromBalance').textContent = parseFloat(data.balance).toFixed(2);
                    }

                    detailsContainer.style.display = 'block';
                } else {
                    // Show error message from the server's JSON response
                    errorContainer.textContent = '❌ ' + data.message;
                    errorContainer.style.display = 'block';
                }
            })
            .catch(error => {
                // Handle network or parsing errors
                console.error('Fetch error:', error);
                errorContainer.textContent = '❌ Error fetching details. Please check connection or account number.';
                errorContainer.style.display = 'block';
            });
    }
</script>

</body>
</html>