package com.taskmanager.util;

import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Utility class for CSRF (Cross-Site Request Forgery) protection.
 * Generates and validates tokens to prevent unauthorized form submissions.
 */
public class CSRFUtil {

    public static final String CSRF_TOKEN_ATTR = "csrfToken";
    private static final SecureRandom secureRandom = new SecureRandom();
    private static final int TOKEN_LENGTH = 32;

    /**
     * Generates a new CSRF token and stores it in the session.
     * 
     * @param session The HTTP session
     * @return The generated token
     */
    public static String generateToken(HttpSession session) {
        byte[] tokenBytes = new byte[TOKEN_LENGTH];
        secureRandom.nextBytes(tokenBytes);
        String token = Base64.getUrlEncoder().withoutPadding().encodeToString(tokenBytes);
        session.setAttribute(CSRF_TOKEN_ATTR, token);
        return token;
    }

    /**
     * Gets the current CSRF token from the session, or generates one if none
     * exists.
     * 
     * @param session The HTTP session
     * @return The CSRF token
     */
    public static String getToken(HttpSession session) {
        String token = (String) session.getAttribute(CSRF_TOKEN_ATTR);
        if (token == null) {
            token = generateToken(session);
        }
        return token;
    }

    /**
     * Validates a submitted token against the session token.
     * 
     * @param session        The HTTP session
     * @param submittedToken The token submitted with the form
     * @return true if valid, false otherwise
     */
    public static boolean validateToken(HttpSession session, String submittedToken) {
        if (session == null || submittedToken == null) {
            return false;
        }
        String sessionToken = (String) session.getAttribute(CSRF_TOKEN_ATTR);
        if (sessionToken == null) {
            return false;
        }
        // Use constant-time comparison to prevent timing attacks
        return constantTimeEquals(sessionToken, submittedToken);
    }

    /**
     * Constant-time string comparison to prevent timing attacks.
     */
    private static boolean constantTimeEquals(String a, String b) {
        if (a.length() != b.length()) {
            return false;
        }
        int result = 0;
        for (int i = 0; i < a.length(); i++) {
            result |= a.charAt(i) ^ b.charAt(i);
        }
        return result == 0;
    }
}
