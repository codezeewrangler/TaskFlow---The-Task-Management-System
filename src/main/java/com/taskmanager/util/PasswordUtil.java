package com.taskmanager.util;

import at.favre.lib.crypto.bcrypt.BCrypt;

/**
 * Utility class for secure password hashing using BCrypt.
 * BCrypt automatically handles salting and is resistant to rainbow table
 * attacks.
 */
public class PasswordUtil {

    // Cost factor for BCrypt (12 is a good balance of security and performance)
    private static final int BCRYPT_COST = 12;

    /**
     * Hashes a plain text password using BCrypt.
     * 
     * @param plainPassword The plain text password to hash
     * @return The hashed password (includes salt)
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        return BCrypt.withDefaults().hashToString(BCRYPT_COST, plainPassword.toCharArray());
    }

    /**
     * Verifies a plain text password against a stored hash.
     * 
     * @param plainPassword  The plain text password to verify
     * @param hashedPassword The stored BCrypt hash
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        BCrypt.Result result = BCrypt.verifyer().verify(plainPassword.toCharArray(), hashedPassword);
        return result.verified;
    }
}
