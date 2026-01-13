<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.taskmanager.util.CSRFUtil" %>
        <% if (session.getAttribute("loggedInUser") !=null) { response.sendRedirect("TaskController"); return; } String
            csrfToken=CSRFUtil.getToken(session); %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Register - TaskFlow</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
                    rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <style>
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                        min-height: 100vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 20px;
                        background: linear-gradient(135deg, #fef3c7 0%, #f0fdf4 50%, #e0f2fe 100%);
                        position: relative;
                        overflow: hidden;
                    }

                    body::before {
                        content: '';
                        position: absolute;
                        width: 600px;
                        height: 600px;
                        background: radial-gradient(circle, rgba(59, 130, 246, 0.12) 0%, transparent 70%);
                        top: -200px;
                        left: -200px;
                        animation: float 8s ease-in-out infinite;
                    }

                    body::after {
                        content: '';
                        position: absolute;
                        width: 500px;
                        height: 500px;
                        background: radial-gradient(circle, rgba(34, 197, 94, 0.15) 0%, transparent 70%);
                        bottom: -150px;
                        right: -150px;
                        animation: float 10s ease-in-out infinite reverse;
                    }

                    @keyframes float {

                        0%,
                        100% {
                            transform: translate(0, 0) rotate(0deg);
                        }

                        50% {
                            transform: translate(30px, -30px) rotate(5deg);
                        }
                    }

                    .register-container {
                        background: rgba(255, 255, 255, 0.85);
                        backdrop-filter: blur(20px);
                        -webkit-backdrop-filter: blur(20px);
                        border-radius: 24px;
                        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08), 0 0 0 1px rgba(255, 255, 255, 0.5);
                        padding: 44px 40px;
                        width: 100%;
                        max-width: 420px;
                        animation: slideUp 0.6s ease-out;
                        position: relative;
                        z-index: 10;
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

                    .logo {
                        text-align: center;
                        margin-bottom: 28px;
                    }

                    .logo-icon {
                        width: 72px;
                        height: 72px;
                        background: linear-gradient(135deg, #3b82f6 0%, #10b981 100%);
                        border-radius: 20px;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        margin-bottom: 16px;
                        box-shadow: 0 12px 24px rgba(59, 130, 246, 0.25);
                    }

                    .logo-icon i {
                        font-size: 32px;
                        color: white;
                    }

                    .logo h1 {
                        font-size: 26px;
                        color: #1e293b;
                        font-weight: 700;
                        margin: 0;
                        letter-spacing: -0.5px;
                    }

                    .logo p {
                        color: #64748b;
                        margin-top: 6px;
                        font-size: 14px;
                        font-weight: 400;
                    }

                    .alert {
                        border-radius: 14px;
                        padding: 14px 18px;
                        margin-bottom: 22px;
                        border: none;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        font-size: 14px;
                        font-weight: 500;
                    }

                    .alert-danger {
                        background: linear-gradient(135deg, #fef2f2, #fee2e2);
                        color: #dc2626;
                    }

                    .alert i {
                        font-size: 18px;
                    }

                    .form-group {
                        margin-bottom: 20px;
                    }

                    .form-label {
                        font-weight: 500;
                        color: #475569;
                        margin-bottom: 10px;
                        display: block;
                        font-size: 13px;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .form-control {
                        width: 100%;
                        padding: 16px 20px;
                        border: 2px solid #e2e8f0;
                        border-radius: 14px;
                        font-size: 15px;
                        transition: all 0.25s ease;
                        background: #f8fafc;
                        font-family: inherit;
                    }

                    .form-control:focus {
                        outline: none;
                        border-color: #3b82f6;
                        background: #fff;
                        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.12);
                    }

                    .form-control::placeholder {
                        color: #94a3b8;
                    }

                    .form-control.is-invalid {
                        border-color: #f87171;
                        background: #fef2f2;
                    }

                    .invalid-feedback {
                        color: #dc2626;
                        font-size: 12px;
                        margin-top: 6px;
                        display: none;
                        font-weight: 500;
                    }

                    .form-control.is-invalid~.invalid-feedback {
                        display: block;
                    }

                    .input-group {
                        position: relative;
                    }

                    .input-icon {
                        position: absolute;
                        right: 18px;
                        top: 50%;
                        transform: translateY(-50%);
                        color: #94a3b8;
                        font-size: 18px;
                    }

                    .password-requirements {
                        font-size: 12px;
                        color: #64748b;
                        margin-top: 10px;
                        background: #f8fafc;
                        padding: 10px 14px;
                        border-radius: 10px;
                    }

                    .password-requirements ul {
                        margin: 0;
                        padding-left: 18px;
                    }

                    .password-requirements li {
                        margin-bottom: 2px;
                        transition: color 0.3s;
                    }

                    .password-requirements li.valid {
                        color: #10b981;
                        font-weight: 500;
                    }

                    .btn-register {
                        width: 100%;
                        padding: 16px;
                        background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
                        border: none;
                        border-radius: 14px;
                        color: white;
                        font-size: 15px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        box-shadow: 0 6px 20px rgba(59, 130, 246, 0.35);
                        font-family: inherit;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 8px;
                    }

                    .btn-register:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 10px 28px rgba(59, 130, 246, 0.4);
                    }

                    .btn-register:active {
                        transform: translateY(0);
                    }

                    .btn-register:disabled {
                        opacity: 0.7;
                        cursor: not-allowed;
                        transform: none;
                    }

                    .divider {
                        display: flex;
                        align-items: center;
                        margin: 26px 0;
                    }

                    .divider::before,
                    .divider::after {
                        content: '';
                        flex: 1;
                        height: 1px;
                        background: linear-gradient(to right, transparent, #e2e8f0, transparent);
                    }

                    .divider span {
                        padding: 0 16px;
                        color: #94a3b8;
                        font-size: 13px;
                        font-weight: 500;
                    }

                    .login-link {
                        text-align: center;
                        color: #64748b;
                        font-size: 14px;
                    }

                    .login-link a {
                        color: #3b82f6;
                        text-decoration: none;
                        font-weight: 600;
                        transition: color 0.3s ease;
                    }

                    .login-link a:hover {
                        color: #2563eb;
                    }

                    @media (max-width: 480px) {
                        .register-container {
                            padding: 32px 24px;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="register-container">
                    <div class="logo">
                        <div class="logo-icon"><i class="bi bi-person-plus"></i></div>
                        <h1>TaskFlow</h1>
                        <p>Create your account to get started</p>
                    </div>
                    <% String errorType=request.getParameter("error"); if (errorType !=null) { %>
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-circle"></i>
                            <span>
                                <% if ("username_taken".equals(errorType)) { %>Username already exists.<% } else if
                                        ("password_mismatch".equals(errorType)) { %>Passwords do not match.<% } else if
                                            ("validation".equals(errorType)) { %>Please fill in all fields correctly.<%
                                                } else { %>Registration failed. Please try again.<% } %>
                            </span>
                        </div>
                        <% } %>
                            <form action="RegisterServlet" method="post" id="registerForm">
                                <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="username" name="username"
                                            placeholder="Choose a username" autocomplete="username" minlength="3"
                                            maxlength="50" pattern="[a-zA-Z0-9_]+" required>
                                        <i class="bi bi-person input-icon"></i>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="password" name="password"
                                            placeholder="Create a strong password" autocomplete="new-password"
                                            minlength="8" required>
                                        <i class="bi bi-lock input-icon"></i>
                                    </div>
                                    <div class="password-requirements">
                                        <ul>
                                            <li id="req-length">At least 8 characters</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="confirmPassword"
                                            name="confirmPassword" placeholder="Re-enter your password"
                                            autocomplete="new-password" required>
                                        <i class="bi bi-shield-lock input-icon"></i>
                                    </div>
                                    <div class="invalid-feedback">Passwords do not match</div>
                                </div>
                                <button type="submit" class="btn-register"><i class="bi bi-rocket-takeoff"></i> Create
                                    Account</button>
                            </form>
                            <div class="divider"><span>Already have an account?</span></div>
                            <p class="login-link"><a href="login.jsp">Sign in here</a></p>
                </div>
                <script>
                    const form = document.getElementById('registerForm');
                    const password = document.getElementById('password');
                    const confirmPassword = document.getElementById('confirmPassword');
                    const reqLength = document.getElementById('req-length');
                    password.addEventListener('input', function () {
                        if (this.value.length >= 8) { reqLength.classList.add('valid'); }
                        else { reqLength.classList.remove('valid'); }
                    });
                    confirmPassword.addEventListener('input', function () {
                        if (this.value !== password.value) { this.classList.add('is-invalid'); }
                        else { this.classList.remove('is-invalid'); }
                    });
                    form.addEventListener('submit', function (e) {
                        if (password.value !== confirmPassword.value) { e.preventDefault(); confirmPassword.classList.add('is-invalid'); return false; }
                        if (password.value.length < 8) { e.preventDefault(); password.classList.add('is-invalid'); return false; }
                    });
                </script>
            </body>

            </html>