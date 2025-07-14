<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join SecureBank - Create Your Account</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        'inter': ['Inter', 'sans-serif'],
                    },
                    colors: {
                        'primary': '#3B82F6',
                        'primary-dark': '#1E40AF',
                        'surface': '#F8FAFC',
                        'card': '#FFFFFF',
                    }
                }
            }
        }
    </script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .input-group {
            position: relative;
        }

        .floating-label {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            color: #6B7280;
            font-size: 14px;
            transition: all 0.3s ease;
            pointer-events: none;
            background: white;
            padding: 0 4px;
        }

        .floating-label.textarea {
            top: 20px;
            transform: translateY(0);
        }

        .form-input:focus + .floating-label,
        .form-input:not(:placeholder-shown) + .floating-label {
            top: 0;
            font-size: 12px;
            color: #3B82F6;
            font-weight: 500;
        }

        .form-input {
            transition: all 0.3s ease;
        }

        .form-input:focus {
            border-color: #3B82F6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .btn-primary {
            background: linear-gradient(135deg, #3B82F6 0%, #1E40AF 100%);
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(59, 130, 246, 0.4);
        }

        .progress-bar {
            height: 4px;
            background: linear-gradient(90deg, #3B82F6 0%, #1E40AF 100%);
            transition: width 0.5s ease;
        }

        .step-indicator {
            transition: all 0.3s ease;
        }

        .step-indicator.active {
            background: #3B82F6;
            color: white;
        }

        .step-indicator.completed {
            background: #10B981;
            color: white;
        }

        .section-card {
            background: white;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(229, 231, 235, 0.5);
            transition: all 0.3s ease;
        }

        .section-card:hover {
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center py-8 px-4">
<div class="w-full max-w-2xl">
    <!-- Header -->
    <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-white rounded-full shadow-lg mb-4">
            <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
            </svg>
        </div>
        <h1 class="text-3xl font-bold text-white mb-2">Join SecureBank</h1>
        <p class="text-white/80 text-lg">Create your secure banking account in minutes</p>
    </div>

    <!-- Progress Bar -->
    <div class="mb-8">
        <div class="flex justify-between items-center mb-4">
            <span class="step-indicator active w-8 h-8 rounded-full flex items-center justify-center text-sm font-semibold bg-blue-600 text-white">1</span>
            <div class="flex-1 h-1 bg-white/20 mx-2 rounded-full">
                <div class="progress-bar rounded-full" style="width: 50%"></div>
            </div>
            <span class="step-indicator w-8 h-8 rounded-full flex items-center justify-center text-sm font-semibold bg-white/20 text-white">2</span>
        </div>
        <div class="flex justify-between text-sm text-white/80">
            <span>Account Setup</span>
            <span>Personal Details</span>
        </div>
    </div>

    <!-- Main Form Card -->
    <div class="glass-card rounded-2xl p-8 shadow-2xl">
        <!-- Error/Success Messages -->
        <div id="errorMessage" class="hidden bg-red-50 border-l-4 border-red-400 p-4 mb-6 rounded-r-lg">
            <div class="flex items-center">
                <div class="flex-shrink-0">
                    <svg class="w-5 h-5 text-red-400" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"></path>
                    </svg>
                </div>
                <div class="ml-3">
                    <p class="text-sm font-medium text-red-800">Error occurred during registration</p>
                </div>
            </div>
        </div>

        <div id="successMessage" class="hidden bg-green-50 border-l-4 border-green-400 p-4 mb-6 rounded-r-lg">
            <div class="flex items-center">
                <div class="flex-shrink-0">
                    <svg class="w-5 h-5 text-green-400" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"></path>
                    </svg>
                </div>
                <div class="ml-3">
                    <p class="text-sm font-medium text-green-800">Registration successful!</p>
                </div>
            </div>
        </div>

        <form action="/register" method="post" class="space-y-8">
            <!-- Account Security Section -->
            <div class="section-card">
                <div class="flex items-center mb-6">
                    <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center mr-3">
                        <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-xl font-semibold text-gray-800">Account Security</h3>
                        <p class="text-gray-600 text-sm">Choose your login credentials</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="input-group">
                        <input type="text" id="username" name="username" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none placeholder-transparent" placeholder="Username" required>
                        <label for="username" class="floating-label">Username</label>
                    </div>

                    <div class="input-group">
                        <input type="password" id="password" name="password" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none placeholder-transparent" placeholder="Password" required>
                        <label for="password" class="floating-label">Password</label>
                    </div>

                    <div class="input-group md:col-span-2">
                        <input type="password" id="confirmPassword" name="confirmPassword" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none placeholder-transparent" placeholder="Confirm Password" required>
                        <label for="confirmPassword" class="floating-label">Confirm Password</label>
                    </div>
                </div>

                <div class="mt-4 p-4 bg-blue-50 rounded-lg">
                    <div class="flex items-start">
                        <svg class="w-5 h-5 text-blue-600 mt-0.5 mr-2 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        <div class="text-sm text-blue-800">
                            <p class="font-medium">Password Requirements:</p>
                            <ul class="mt-1 list-disc list-inside text-blue-700">
                                <li>At least 8 characters long</li>
                                <li>Include uppercase and lowercase letters</li>
                                <li>Include at least one number</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Personal Information Section -->
            <div class="section-card">
                <div class="flex items-center mb-6">
                    <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center mr-3">
                        <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                        </svg>
                    </div>
                    <div>
                        <h3 class="text-xl font-semibold text-gray-800">Personal Information</h3>
                        <p class="text-gray-600 text-sm">Tell us about yourself</p>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="input-group">
                        <input type="text" id="firstName" name="firstName" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none placeholder-transparent" placeholder="First Name" required>
                        <label for="firstName" class="floating-label">First Name</label>
                    </div>

                    <div class="input-group">
                        <input type="text" id="lastName" name="lastName" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none placeholder-transparent" placeholder="Last Name" required>
                        <label for="lastName" class="floating-label">Last Name</label>
                    </div>

                    <div class="input-group">
                        <input type="email" id="email" name="email" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none placeholder-transparent" placeholder="Email Address" required>
                        <label for="email" class="floating-label">Email Address</label>
                    </div>

                    <div class="input-group">
                        <input type="tel" id="phone" name="phone" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none placeholder-transparent" placeholder="Phone Number">
                        <label for="phone" class="floating-label">Phone Number</label>
                    </div>

                    <div class="input-group md:col-span-2">
                        <textarea id="address" name="address" rows="3" class="form-input w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none placeholder-transparent resize-none" placeholder="Your Address"></textarea>
                        <label for="address" class="floating-label textarea">Your Address</label>
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="space-y-4">
                <button type="submit" class="btn-primary w-full py-4 px-6 rounded-lg font-semibold text-white text-lg shadow-lg">
                    Create My Account
                </button>

                <div class="text-center">
                    <p class="text-gray-600">Already have an account?
                        <a href="/banking/login.jsp" class="text-blue-600 hover:text-blue-800 font-semibold transition-colors">Sign in here</a>
                    </p>
                </div>
            </div>

            <!-- Trust Indicators -->
            <div class="border-t pt-6">
                <div class="flex items-center justify-center space-x-6 text-sm text-gray-500">
                    <div class="flex items-center">
                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
                        </svg>
                        SSL Secured
                    </div>
                    <div class="flex items-center">
                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                        FDIC Insured
                    </div>
                    <div class="flex items-center">
                        <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        Privacy Protected
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    // Simulate form validation and interactions
    document.querySelectorAll('.form-input').forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.classList.add('focused');
        });

        input.addEventListener('blur', function() {
            this.parentElement.classList.remove('focused');
        });
    });

    // Password strength indicator (basic)
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;
        const strength = calculatePasswordStrength(password);
        // You can add visual feedback here
    });

    function calculatePasswordStrength(password) {
        let strength = 0;
        if (password.length >= 8) strength++;
        if (/[a-z]/.test(password)) strength++;
        if (/[A-Z]/.test(password)) strength++;
        if (/[0-9]/.test(password)) strength++;
        if (/[^a-zA-Z0-9]/.test(password)) strength++;
        return strength;
    }

    // Form submission handling
    document.querySelector('form').addEventListener('submit', function(e) {
        e.preventDefault();

        // Basic validation
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            document.getElementById('errorMessage').classList.remove('hidden');
            document.getElementById('errorMessage').querySelector('p').textContent = 'Passwords do not match';
            return;
        }

        // Show success message (for demo)
        document.getElementById('successMessage').classList.remove('hidden');
        document.getElementById('errorMessage').classList.add('hidden');

        // In real implementation, submit the form
        // this.submit();
    });
</script>
</body>
</html>