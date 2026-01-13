package com.taskmanager.dao;

import com.taskmanager.model.User;
import com.taskmanager.util.DBUtil;
import com.taskmanager.util.PasswordUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // SQL for users table
    private static final String INSERT_USER_SQL = "INSERT INTO users (username, password) VALUES (?, ?)";
    private static final String SELECT_USER_BY_USERNAME_SQL = "SELECT * FROM users WHERE username = ?";

    /**
     * Registers a new user in the database with a hashed password.
     */
    public boolean registerUser(User user) throws SQLException {
        boolean rowInserted = false;
        try (Connection connection = DBUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {

            preparedStatement.setString(1, user.getUsername());
            // Hash the password before storing
            String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
            preparedStatement.setString(2, hashedPassword);

            rowInserted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            if (e.getSQLState().startsWith("23")) {
                System.err.println("Error: Username already exists.");
            } else {
                e.printStackTrace();
            }
        }
        return rowInserted;
    }

    /**
     * Validates a user's login credentials using BCrypt verification.
     */
    public User validateUser(String username, String password) {
        User user = null;
        try (Connection connection = DBUtil.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_USERNAME_SQL)) {

            // First, fetch the user by username only
            preparedStatement.setString(1, username);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");

                // Verify the password against the stored hash
                if (PasswordUtil.verifyPassword(password, storedHash)) {
                    user = new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            storedHash // Don't expose the hash back to the app unnecessarily
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}