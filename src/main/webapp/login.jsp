<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.taskmanager.util.CSRFUtil" %>
<%
    if (session.getAttribute("loggedInUser") != null) {
        response.sendRedirect("TaskController");
        return;
    }
    String csrfToken = CSRFUtil.getToken(session);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - TaskFlow</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: linear-gradient(135deg, #e0f2fe 0%, #f0fdf4 50%, #fef3c7 100%);
            position: relative;
            overflow: hidden;
        }
        body::before {
            content: '';
            position: absolute;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(34, 197, 94, 0.15) 0%, transparent 70%);
            top: -200px;
            right: -200px;
            animation: float 8s ease-in-out infinite;
        }
        body::after {
            content: '';
            position: absolute;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(59, 130, 246, 0.12) 0%, transparent 70%);
            bottom: -150px;
            left: -150px;
            animation: float 10s ease-in-out infinite reverse;
        }
        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(30px, -30px) rotate(5deg); }
        }
        .login-container {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 24px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08), 0 0 0 1px rgba(255,255,255,0.5);
            padding: 48px 40px;
            width: 100%;
            max-width: 420px;
            animation: slideUp 0.6s ease-out;
            position: relative;
            z-index: 10;
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .logo { text-align: center; margin-bottom: 32px; }
        .logo-icon {
            width: 72px; height: 72px;
            background: linear-gradient(135deg, #10b981 0%, #3b82f6 100%);
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
            box-shadow: 0 12px 24px rgba(16, 185, 129, 0.25);
        }
        .logo-icon i { font-size: 32px; color: white; }
        .logo h1 { font-size: 26px; color: #1e293b; font-weight: 700; margin: 0; letter-spacing: -0.5px; }
        .logo p { color: #64748b; margin-top: 6px; font-size: 14px; font-weight: 400; }
        .alert {
            border-radius: 14px; padding: 14px 18px; margin-bottom: 24px;
            border: none; display: flex; align-items: center; gap: 12px;
            font-size: 14px; font-weight: 500;
        }
        .alert-danger { background: linear-gradient(135deg, #fef2f2, #fee2e2); color: #dc2626; }
        .alert-success { background: linear-gradient(135deg, #f0fdf4, #dcfce7); color: #16a34a; }
        .alert i { font-size: 18px; }
        .form-group { margin-bottom: 22px; }
        .form-label { font-weight: 500; color: #475569; margin-bottom: 10px; display: block; font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; }
        .form-control {
            width: 100%; padding: 16px 20px; border: 2px solid #e2e8f0;
            border-radius: 14px; font-size: 15px; transition: all 0.25s ease; background: #f8fafc;
            font-family: inherit;
        }
        .form-control:focus {
            outline: none; border-color: #10b981; background: #fff;
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.12);
        }
        .form-control::placeholder { color: #94a3b8; }
        .input-group { position: relative; }
        .input-icon { position: absolute; right: 18px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 18px; }
        .btn-login {
            width: 100%; padding: 16px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            border: none; border-radius: 14px; color: white;
            font-size: 15px; font-weight: 600; cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.35);
            font-family: inherit;
            display: flex; align-items: center; justify-content: center; gap: 8px;
        }
        .btn-login:hover { transform: translateY(-2px); box-shadow: 0 10px 28px rgba(16, 185, 129, 0.4); }
        .btn-login:active { transform: translateY(0); }
        .divider { display: flex; align-items: center; margin: 28px 0; }
        .divider::before, .divider::after { content: ''; flex: 1; height: 1px; background: linear-gradient(to right, transparent, #e2e8f0, transparent); }
        .divider span { padding: 0 16px; color: #94a3b8; font-size: 13px; font-weight: 500; }
        .register-link { text-align: center; color: #64748b; font-size: 14px; }
        .register-link a { color: #10b981; text-decoration: none; font-weight: 600; transition: color 0.3s ease; }
        .register-link a:hover { color: #059669; }
        @media (max-width: 480px) { .login-container { padding: 36px 24px; } }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <div class="logo-icon"><i class="bi bi-check2-square"></i></div>
            <h1>TaskFlow</h1>
            <p>Welcome back! Please sign in.</p>
        </div>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-circle"></i>
                <span>Invalid username or password.</span>
            </div>
        <% } %>
        <% if (request.getParameter("registered") != null) { %>
            <div class="alert alert-success">
                <i class="bi bi-check-circle"></i>
                <span>Registration successful! Please sign in.</span>
            </div>
        <% } %>
        <form action="LoginServlet" method="post">
            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" autocomplete="username" required>
                    <i class="bi bi-person input-icon"></i>
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" autocomplete="current-password" required>
                    <i class="bi bi-lock input-icon"></i>
                </div>
            </div>
            <button type="submit" class="btn-login"><i class="bi bi-arrow-right-circle"></i> Sign In</button>
        </form>
        <div class="divider"><span>New to TaskFlow?</span></div>
        <p class="register-link"><a href="register.jsp">Create an account</a></p>
    </div>
</body>
</html>
