<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teller Dashboard - SecureBank</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            overflow-x: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
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
        .floating-shape:nth-child(5) { width: 50px; height: 50px; top: 80%; left: 20%; animation-delay: 1s; }
        .floating-shape:nth-child(6) { width: 70px; height: 70px; top: 30%; left: 85%; animation-delay: 3s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .dashboard-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 600px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1);
        }

        .dashboard-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6b6b, #ffa500, #ff6b6b);
            background-size: 200% 100%;
            animation: gradientShift 3s ease-in-out infinite;
        }

        @keyframes gradientShift {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
        }

        .logo-container {
            margin-bottom: 20px;
        }

        .logo {
            width: 70px;
            height: 70px;
            background: linear-gradient(45deg, #ff6b6b, #ffa500);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 24px;
            font-weight: bold;
            color: white;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
        }

        .dashboard-title {
            font-size: 32px;
            font-weight: 700;
            color: white;
            margin-bottom: 8px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .dashboard-subtitle {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
        }

        .teller-info {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 32px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .teller-avatar {
            width: 48px;
            height: 48px;
            background: linear-gradient(45deg, #3b82f6, #8b5cf6);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            color: white;
            font-weight: 600;
            font-size: 18px;
        }

        .teller-name {
            color: white;
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 4px;
        }

        .teller-role {
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
        }

        .button-group {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .action-button {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 18px 24px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            color: white;
            background: linear-gradient(45deg, #3b82f6, #8b5cf6);
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
        }

        .action-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .action-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
        }

        .action-button:hover::before {
            left: 100%;
        }

        .action-button:active {
            transform: translateY(-1px);
        }

        .action-button i {
            margin-right: 12px;
            font-size: 18px;
        }

        /* Specific button colors */
        .action-button.create-customer {
            background: linear-gradient(45deg, #10b981, #059669);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
        }

        .action-button.create-customer:hover {
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
        }

        .action-button.deposit {
            background: linear-gradient(45deg, #f59e0b, #d97706);
            box-shadow: 0 4px 15px rgba(245, 158, 11, 0.3);
        }

        .action-button.deposit:hover {
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.4);
        }

        .action-button.withdraw {
            background: linear-gradient(45deg, #ef4444, #dc2626);
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }

        .action-button.withdraw:hover {
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4);
        }

        .action-button.transfer {
            background: linear-gradient(45deg, #8b5cf6, #7c3aed);
            box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3);
        }

        .action-button.transfer:hover {
            box-shadow: 0 8px 25px rgba(139, 92, 246, 0.4);
        }

        .action-button.info {
            background: linear-gradient(45deg, #06b6d4, #0891b2);
            box-shadow: 0 4px 15px rgba(6, 182, 212, 0.3);
        }

        .action-button.info:hover {
            box-shadow: 0 8px 25px rgba(6, 182, 212, 0.4);
        }

        .logout-section {
            padding-top: 24px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logout-button {
            background: linear-gradient(45deg, #ef4444, #dc2626) !important;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3) !important;
            width: 100%;
        }

        .logout-button:hover {
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.4) !important;
        }

        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 16px;
            margin-bottom: 32px;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 16px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .stat-value {
            font-size: 24px;
            font-weight: 700;
            color: white;
            margin-bottom: 4px;
        }

        .stat-label {
            font-size: 12px;
            color: rgba(255, 255, 255, 0.7);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 24px;
                margin: 10px;
            }

            .button-group {
                grid-template-columns: 1fr;
            }

            .dashboard-title {
                font-size: 24px;
            }

            .quick-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 480px) {
            .dashboard-container {
                padding: 20px;
            }

            .quick-stats {
                grid-template-columns: 1fr;
            }
        }

        /* Animation for entrance */
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

        .dashboard-container {
            animation: slideUp 0.6s ease-out;
        }

        .action-button {
            animation: slideUp 0.6s ease-out;
        }

        .action-button:nth-child(1) { animation-delay: 0.1s; }
        .action-button:nth-child(2) { animation-delay: 0.2s; }
        .action-button:nth-child(3) { animation-delay: 0.3s; }
        .action-button:nth-child(4) { animation-delay: 0.4s; }
        .action-button:nth-child(5) { animation-delay: 0.5s; }

        /* Loading animation */
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<div class="bg-animation">
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
    <div class="floating-shape"></div>
</div>

<div class="dashboard-container">
    <div class="header">
        <div class="logo-container">
            <div class="logo">SB</div>
            <h1 class="dashboard-title">Teller Dashboard</h1>
            <p class="dashboard-subtitle">SecureBank Teller Operations</p>
        </div>
    </div>

    <div class="teller-info">
        <div class="teller-avatar">T</div>
        <div class="teller-name">Welcome, Teller!</div>
        <div class="teller-role">Bank Teller</div>
    </div>

    <div class="quick-stats">
        <div class="stat-item">
            <div class="stat-value">24</div>
            <div class="stat-label">Today's Transactions</div>
        </div>
        <div class="stat-item">
            <div class="stat-value">8</div>
            <div class="stat-label">Active Customers</div>
        </div>
        <div class="stat-item">
            <div class="stat-value">$45.2K</div>
            <div class="stat-label">Total Processed</div>
        </div>
    </div>

    <div class="button-group">
        <a href="${pageContext.request.contextPath}/pages/teller/create-customer.jsp" class="action-button create-customer">
            <i class="fas fa-user-plus"></i>
            Create Customer
        </a>
        <a href="${pageContext.request.contextPath}/pages/teller/deposit.jsp" class="action-button deposit">
            <i class="fas fa-money-check-alt"></i>
            Deposit
        </a>
        <a href="${pageContext.request.contextPath}/pages/teller/withdraw.jsp" class="action-button withdraw">
            <i class="fas fa-money-bill-alt"></i>
            Withdraw
        </a>
        <a href="${pageContext.request.contextPath}/pages/teller/transfer.jsp" class="action-button transfer">
            <i class="fas fa-exchange-alt"></i>
            Transfer
        </a>
        <a href="${pageContext.request.contextPath}/pages/teller/customer-info.jsp" class="action-button info">
            <i class="fas fa-info-circle"></i>
            Customer Info
        </a>
    </div>

    <div class="logout-section">
        <a href="${pageContext.request.contextPath}/logout" class="action-button logout-button">
            <i class="fas fa-sign-out-alt"></i>
            Logout
        </a>
    </div>
</div>

<script>
    // Add loading animation to buttons
    document.querySelectorAll('.action-button').forEach(button => {
        button.addEventListener('click', function(e) {
            // Don't prevent default for navigation
            this.classList.add('loading');

            // Remove loading after a short delay (for visual feedback)
            setTimeout(() => {
                this.classList.remove('loading');
            }, 1000);
        });
    });

    // Add click animation
    document.querySelectorAll('.action-button').forEach(button => {
        button.addEventListener('mousedown', function() {
            this.style.transform = 'translateY(-1px) scale(0.98)';
        });

        button.addEventListener('mouseup', function() {
            this.style.transform = '';
        });

        button.addEventListener('mouseleave', function() {
            this.style.transform = '';
        });
    });

    // Add hover sound effect (optional)
    document.querySelectorAll('.action-button').forEach(button => {
        button.addEventListener('mouseenter', function() {
            // You can add a subtle sound effect here if needed
        });
    });

    // Quick stats animation
    function animateStats() {
        const statValues = document.querySelectorAll('.stat-value');
        statValues.forEach(stat => {
            const finalValue = stat.textContent;
            let currentValue = 0;
            const increment = Math.ceil(parseInt(finalValue.replace(/[^\d]/g, '')) / 50);

            const timer = setInterval(() => {
                currentValue += increment;
                if (currentValue >= parseInt(finalValue.replace(/[^\d]/g, ''))) {
                    stat.textContent = finalValue;
                    clearInterval(timer);
                } else {
                    stat.textContent = finalValue.replace(/\d+/, currentValue);
                }
            }, 30);
        });
    }

    // Start animation when page loads
    window.addEventListener('load', () => {
        setTimeout(animateStats, 500);
    });
</script>
</body>
</html>