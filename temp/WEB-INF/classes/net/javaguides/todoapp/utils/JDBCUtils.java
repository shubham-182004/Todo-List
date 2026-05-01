package net.javaguides.todoapp.utils;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.time.LocalDate;

public class JDBCUtils {

    // FIX: Use environment variables with fallback defaults so DB config is flexible
    private static String jdbcURL = System.getenv("DB_URL") != null
            ? System.getenv("DB_URL")
            : "jdbc:mysql://localhost:3306/todo_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static String jdbcUsername = System.getenv("DB_USER") != null
            ? System.getenv("DB_USER")
            : "root";
    private static String jdbcPassword = System.getenv("DB_PASSWORD") != null
            ? System.getenv("DB_PASSWORD")
            : "root";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // FIX: Use updated driver class name (old com.mysql.jdbc.Driver is deprecated)
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }

    public static Date getSQLDate(LocalDate date) {
        return java.sql.Date.valueOf(date);
    }

    public static LocalDate getUtilDate(Date sqlDate) {
        return sqlDate.toLocalDate();
    }
}
