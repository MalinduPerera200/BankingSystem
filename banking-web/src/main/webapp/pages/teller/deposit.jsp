<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Deposit Funds - SecureBank</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --gradient-start: #667eea;
      --gradient-end: #764ba2;
      --button-grad-start: #f59e0b;
      --button-grad-end: #d97706;
      --back-btn-start: #7c3aed;
      --back-btn-end: #8b5cf6;
      --success-bg: rgba(16, 185, 129, 0.2);
      --success-border: rgba(16, 185, 129, 0.4);
      --success-text: #ecfdf5;
      --error-bg: rgba(239, 68, 68, 0.2);
      --error-border: rgba(239, 68, 68, 0.4);
      --error-text: #fef2f2;
    }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, var(--gradient-start) 0%, var(--gradient-end) 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      position: relative;
      overflow: hidden;
    }
    .bg-animation { position: fixed; top: 0; left: 0; width: 100%; height: 100%; pointer-events: none; z-index: 0; }
    .floating-shape { position: absolute; background: rgba(255, 255, 255, 0.1); border-radius: 50%; animation: float 8s ease-in-out infinite; }
    .floating-shape:nth-child(1) { width: 60px; height: 60px; top: 10%; left: 10%; }
    .floating-shape:nth-child(2) { width: 80px; height: 80px; top: 70%; left: 80%; animation-delay: 2s; }
    .floating-shape:nth-child(3) { width: 40px; height: 40px; top: 40%; left: 60%; animation-delay: 4s; }
    .floating-shape:nth-child(4) { width: 100px; height: 100px; top: 20%; left: 90%; animation-delay: 6s; }
    @keyframes float { 0%, 100% { transform: translateY(0px) rotate(0deg); } 50% { transform: translateY(-20px) rotate(180deg); } }
    .form-container {
      position: relative; z-index: 1;
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(20px);
      border: 1px solid rgba(255, 255, 255, 0.2);
      border-radius: 20px;
      padding: 40px;
      width: 100%;
      max-width: 420px;
      box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
      text-align: center;
      animation: slideUp 0.6s ease-out;
    }
    .form-container h1 { font-size: 24px; font-weight: 700; color: white; margin-bottom: 24px; }
    .form-group { margin-bottom: 20px; text-align: left; }
    .form-group label { display: block; color: rgba(255, 255, 255, 0.8); font-weight: 600; margin-bottom: 8px; font-size: 14px; }
    .input-group { display: flex; }
    .form-group input {
      width: 100%; padding: 12px; border: none; border-radius: 12px;
      background: rgba(255, 255, 255, 0.1); color: white; font-size: 14px;
      border: 1px solid rgba(255, 255, 255, 0.2);
      transition: all 0.2s ease;
    }
    .form-group input:focus { outline: none; box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3); }
    .form-group input::placeholder { color: rgba(255, 255, 255, 0.5); }
    #searchBtn {
      border-radius: 0 12px 12px 0; padding: 12px 16px; margin-left: -1px; border: none;
      background: linear-gradient(45deg, var(--back-btn-start), var(--back-btn-end));
      color: white; cursor: pointer; transition: opacity 0.3s;
    }
    #searchBtn:hover { opacity: 0.9; }
    #accountNumberInput { border-radius: 12px 0 0 12px; }
    .submit-button {
      width: 100%; padding: 14px; border: none; border-radius: 12px; font-size: 16px;
      font-weight: 600; cursor: pointer;
      background: linear-gradient(45deg, var(--button-grad-start), var(--button-grad-end));
      color: white; box-shadow: 0 4px 15px rgba(245, 158, 11, 0.3);
      transition: all 0.3s ease; position: relative; overflow: hidden;
    }
    .submit-button:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(245, 158, 11, 0.4); }
    .message { margin-bottom: 16px; padding: 12px; border-radius: 12px; font-size: 14px; font-weight: 500; display: none; }
    .message.success { background-color: var(--success-bg); color: var(--success-text); border: 1px solid var(--success-border); }
    .message.error { background-color: var(--error-bg); color: var(--error-text); border: 1px solid var(--error-border); }
    #accountDetails { margin-top: 24px; text-align: left; color: white; display: none; }
    .details-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 20px; }
    .detail-item { background: rgba(0,0,0,0.15); padding: 10px; border-radius: 8px; }
    .detail-item strong { font-size: 12px; color: rgba(255,255,255,0.7); display: block; margin-bottom: 4px; }
    .detail-item span { font-weight: 600; }
    #depositSection { display: none; }
    .back-button {
      display: inline-block; margin-top: 16px; padding: 12px 24px;
      background: linear-gradient(45deg, var(--back-btn-start), var(--back-btn-end));
      color: white; border: none; border-radius: 12px; font-size: 14px;
      font-weight: 600; cursor: pointer; text-decoration: none; transition: all 0.3s ease;
    }
    .back-button:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(139, 92, 246, 0.4); }
    @keyframes slideUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
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
  <h1>Deposit Funds</h1>

  <div id="messageArea" class="message
        <%
            String status = request.getParameter("status");
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (status != null) { out.print("success"); }
            if (errorMessage != null) { out.print("error"); }
        %>"
       style="<% if (status != null || errorMessage != null) { out.print("display: block;"); } %>">
    <%
      if (status != null) { out.print("✅ " + status); }
      if (errorMessage != null) { out.print("❌ " + errorMessage); }
    %>
  </div>

  <div class="form-group">
    <label for="accountNumberInput">Account Number</label>
    <div class="input-group">
      <input type="text" id="accountNumberInput" placeholder="Enter 10-digit number" required>
      <button type="button" id="searchBtn"><i class="fas fa-search"></i></button>
    </div>
  </div>

  <div id="accountDetails">
    <div class="details-grid">
      <div class="detail-item">
        <strong>Customer Name</strong>
        <span id="customerName"></span>
      </div>
      <div class="detail-item">
        <strong>Customer NIC</strong>
        <span id="customerNic"></span>
      </div>
      <div class="detail-item">
        <strong>Account Type</strong>
        <span id="accountType"></span>
      </div>
      <div class="detail-item">
        <strong>Current Balance</strong>
        <span id="currentBalance"></span>
      </div>
    </div>
  </div>

  <div id="depositSection">
    <form action="${pageContext.request.contextPath}/teller/dashboard" method="post">
      <input type="hidden" name="action" value="deposit">
      <input type="hidden" id="formAccountNumber" name="accountNumber">
      <div class="form-group">
        <label for="amount">Amount to Deposit (LKR)</label>
        <input type="number" id="amount" name="amount" step="0.01" min="0.01" placeholder="e.g., 5000.00" required>
      </div>
      <div class="form-group">
        <button type="submit" class="submit-button">Confirm Deposit</button>
      </div>
    </form>
  </div>

  <a href="${pageContext.request.contextPath}/teller/dashboard" class="back-button">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
  </a>
</div>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const searchBtn = document.getElementById('searchBtn');
    const accountNumberInput = document.getElementById('accountNumberInput');
    const messageArea = document.getElementById('messageArea');
    const accountDetailsDiv = document.getElementById('accountDetails');
    const depositSectionDiv = document.getElementById('depositSection');

    function showMessage(type, text) {
      messageArea.className = 'message ' + type;
      messageArea.textContent = (type === 'success' ? '✅ ' : '❌ ') + text;
      messageArea.style.display = 'block';
    }

    function hideMessage() {
      messageArea.style.display = 'none';
    }

    if (messageArea.textContent.trim() !== '') {
      setTimeout(hideMessage, 5000);
    }

    searchBtn.addEventListener('click', function() {
      findAccount(accountNumberInput.value.trim());
    });

    accountNumberInput.addEventListener('keypress', function (e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        findAccount(accountNumberInput.value.trim());
      }
    });

    async function findAccount(accountNum) {
      const accountNumber = accountNum.trim();

      hideMessage();
      accountDetailsDiv.style.display = 'none';
      depositSectionDiv.style.display = 'none';

      if (!/^\d{10}$/.test(accountNumber)) {
        showMessage('error', 'Please enter a valid 10-digit account number.');
        return;
      }

      try {

        const url = `${pageContext.request.contextPath}/teller/dashboard?action=getAccountDetails&accountNumber=`+ accountNumber;
        console.log('Fetching URL:', url); // Debug log
        console.log('Fetching account:', accountNumber); // Debug log

        const response = await fetch(url);

        console.log('Response status:', response.status); // Debug log

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        console.log('Response data:', data); // Debug log

        if (data.status === 'success') {
          document.getElementById('customerName').textContent = data.customerName;
          document.getElementById('customerNic').textContent = data.customerNic;
          document.getElementById('accountType').textContent = data.accountType;
          document.getElementById('currentBalance').textContent = 'LKR ' + parseFloat(data.balance).toFixed(2);
          document.getElementById('formAccountNumber').value = data.accountNumber;

          accountDetailsDiv.style.display = 'block';
          depositSectionDiv.style.display = 'block';
        } else {
          showMessage('error', data.message || 'Account not found.');
        }
      } catch (error) {
        console.error('Fetch Error:', error);
        showMessage('error', 'Network error: ' + error.message);
      }
    }
  });
</script>

</body>
</html>