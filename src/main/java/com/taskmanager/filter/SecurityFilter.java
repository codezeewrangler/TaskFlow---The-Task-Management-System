package com.taskmanager.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Security filter that adds important HTTP security headers to all responses.
 * These headers help protect against common web vulnerabilities.
 */
@WebFilter("/*")
public class SecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (response instanceof HttpServletResponse) {
            HttpServletResponse httpResponse = (HttpServletResponse) response;

            // Prevent MIME type sniffing
            httpResponse.setHeader("X-Content-Type-Options", "nosniff");

            // Prevent clickjacking - deny embedding in frames
            httpResponse.setHeader("X-Frame-Options", "DENY");

            // Enable XSS filter in browsers (legacy, but still useful)
            httpResponse.setHeader("X-XSS-Protection", "1; mode=block");

            // Prevent caching of sensitive pages
            httpResponse.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
            httpResponse.setHeader("Pragma", "no-cache");

            // Referrer policy - don't leak referrer to external sites
            httpResponse.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");

            // Content Security Policy - restrict resource loading
            httpResponse.setHeader("Content-Security-Policy",
                    "default-src 'self'; " +
                            "script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; " +
                            "style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; " +
                            "font-src 'self' https://cdn.jsdelivr.net; " +
                            "img-src 'self' data:; " +
                            "connect-src 'self'");
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}
