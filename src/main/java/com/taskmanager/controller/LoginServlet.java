package com.taskmanager.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.taskmanager.dao.UserDAO;
import com.taskmanager.model.User;
import com.taskmanager.util.CSRFUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    // Handle GET by showing the login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Validate CSRF token
        String csrfToken = request.getParameter("csrfToken");
        if (!CSRFUtil.validateToken(session, csrfToken)) {
            response.sendRedirect("login.jsp?error=csrf");
            return;
        }

        // Get parameters from the login form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Basic input validation
        if (username == null || username.trim().isEmpty() ||
                password == null || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=validation");
            return;
        }

        // Trim username
        username = username.trim();

        // Validate the user with the DAO
        User user = userDAO.validateUser(username, password);

        if (user != null) {
            // SUCCESS: User credentials are correct

            // Regenerate session to prevent session fixation
            session.invalidate();
            session = request.getSession(true);

            // Store the user object in the session
            session.setAttribute("loggedInUser", user);

            // Generate new CSRF token for the new session
            CSRFUtil.generateToken(session);

            // Send the user to the main task list
            response.sendRedirect("TaskController");

        } else {
            // FAILURE: Invalid username or password
            // Regenerate CSRF token after failed attempt
            CSRFUtil.generateToken(session);
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}