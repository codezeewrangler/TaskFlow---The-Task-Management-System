package com.taskmanager.controller;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.taskmanager.dao.UserDAO;
import com.taskmanager.model.User;
import com.taskmanager.util.CSRFUtil;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    // Handle GET by showing the registration page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Validate CSRF token
        String csrfToken = request.getParameter("csrfToken");
        if (!CSRFUtil.validateToken(session, csrfToken)) {
            CSRFUtil.generateToken(session);
            response.sendRedirect("register.jsp?error=csrf");
            return;
        }

        // Get parameters from the registration form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic input validation
        if (username == null || username.trim().isEmpty() ||
                password == null || password.isEmpty() ||
                confirmPassword == null || confirmPassword.isEmpty()) {
            CSRFUtil.generateToken(session);
            response.sendRedirect("register.jsp?error=validation");
            return;
        }

        // Trim and validate username
        username = username.trim();
        if (username.length() < 3 || username.length() > 50 ||
                !username.matches("^[a-zA-Z0-9_]+$")) {
            CSRFUtil.generateToken(session);
            response.sendRedirect("register.jsp?error=validation");
            return;
        }

        // Validate password length
        if (password.length() < 8) {
            CSRFUtil.generateToken(session);
            response.sendRedirect("register.jsp?error=validation");
            return;
        }

        // Check password confirmation
        if (!password.equals(confirmPassword)) {
            CSRFUtil.generateToken(session);
            response.sendRedirect("register.jsp?error=password_mismatch");
            return;
        }

        // Create a new User object
        User newUser = new User(username, password);

        try {
            // Attempt to register the user
            boolean isRegistered = userDAO.registerUser(newUser);

            if (isRegistered) {
                // Success: Send to login page with success message
                CSRFUtil.generateToken(session);
                response.sendRedirect("login.jsp?registered=true");
            } else {
                // Failed: Username probably taken
                CSRFUtil.generateToken(session);
                response.sendRedirect("register.jsp?error=username_taken");
            }
        } catch (SQLException e) {
            CSRFUtil.generateToken(session);
            throw new ServletException(e);
        }
    }
}