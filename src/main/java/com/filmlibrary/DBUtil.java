package com.filmlibrary;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection != null) return connection;
        else {
            try {
                String driver = "org.postgresql.Driver";
                String url = "jdbc:postgresql://localhost:5432/FF_test";
                String user = "postgres";
                String password = "password1337";
                Class.forName(driver);
                //ConnectionPool connectionPool = ConnectionPool.getInstance();
                //connection = connectionPool.getConnection();
                connection = DriverManager.getConnection(url, user, password);
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
            return connection;
        }
    }

    public static void main(String[] argv) {

    }
}
