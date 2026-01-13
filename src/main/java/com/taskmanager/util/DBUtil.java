package com.taskmanager.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.net.URI;
import java.net.URISyntaxException;

public class DBUtil {

    // Default values for local development (MySQL)
    private static final String DEFAULT_JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DEFAULT_DB_URL = "jdbc:mysql://localhost:3306/task_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    private static final String JDBC_DRIVER;
    private static final String DB_URL;
    private static final String USER;
    private static final String PASS;

    static {
        java.util.Properties props = new java.util.Properties();
        String driver = null;
        String url = null;
        String user = null;
        String pass = null;

        // 1) Check for DATABASE_URL (Render/Heroku style)
        String databaseUrl = System.getenv("DATABASE_URL");
        if (databaseUrl != null && !databaseUrl.isEmpty()) {
            try {
                URI dbUri = new URI(databaseUrl);
                String scheme = dbUri.getScheme();

                // Determine driver based on scheme
                if ("postgres".equals(scheme) || "postgresql".equals(scheme)) {
                    driver = "org.postgresql.Driver";
                    // Build JDBC URL for PostgreSQL
                    url = "jdbc:postgresql://" + dbUri.getHost() + ":" +
                            (dbUri.getPort() > 0 ? dbUri.getPort() : 5432) +
                            dbUri.getPath() + "?sslmode=require";
                } else if ("mysql".equals(scheme)) {
                    driver = "com.mysql.cj.jdbc.Driver";
                    url = "jdbc:mysql://" + dbUri.getHost() + ":" +
                            (dbUri.getPort() > 0 ? dbUri.getPort() : 3306) +
                            dbUri.getPath() + "?useSSL=true&serverTimezone=UTC";
                }

                // Extract credentials from URI
                String userInfo = dbUri.getUserInfo();
                if (userInfo != null) {
                    String[] credentials = userInfo.split(":");
                    user = credentials[0];
                    if (credentials.length > 1) {
                        pass = credentials[1];
                    }
                }

                System.out.println("Database connection configured from DATABASE_URL");
                System.out.println("Using driver: " + driver);
                System.out.println("Connecting to host: " + dbUri.getHost());

            } catch (URISyntaxException e) {
                System.err.println("Failed to parse DATABASE_URL: " + e.getMessage());
            }
        }

        // 2) Fallback: attempt to load from classpath application.properties
        if (url == null) {
            try (java.io.InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("application.properties")) {
                if (in != null) {
                    props.load(in);
                    driver = props.getProperty("jdbc.driver");
                    url = props.getProperty("jdbc.url");
                    user = props.getProperty("jdbc.user");
                    pass = props.getProperty("jdbc.password");
                }
            } catch (Exception e) {
                // ignore and fallback to env/defaults
            }
        }

        // 3) Fallback to individual environment variables
        if (driver == null || driver.isEmpty())
            driver = System.getenv("JDBC_DRIVER");
        if (url == null || url.isEmpty())
            url = System.getenv("DB_URL");
        if (user == null || user.isEmpty())
            user = System.getenv("DB_USER");
        if (pass == null || pass.isEmpty())
            pass = System.getenv("DB_PASS");

        // 4) Final fallback to sensible defaults (local development)
        JDBC_DRIVER = (driver != null && !driver.isEmpty()) ? driver : DEFAULT_JDBC_DRIVER;
        DB_URL = (url != null && !url.isEmpty()) ? url : DEFAULT_DB_URL;
        USER = (user != null && !user.isEmpty()) ? user : "root";
        PASS = (pass != null && !pass.isEmpty()) ? pass : "";
    }

    /**
     * Establishes and returns a connection to the database.
     */
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load the JDBC Driver
            Class.forName(JDBC_DRIVER);

            // Establish the connection
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Driver not found: " + JDBC_DRIVER);
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Connection Failed! Check console for details.");
            System.err.println("URL: " + DB_URL);
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * Helper method to close the connection to prevent resource leaks.
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}