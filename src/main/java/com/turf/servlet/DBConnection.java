package com.turf.servlet;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/turfdb1";
    private static final String USER = "root";
    private static final String PASS = "Maran@9095";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // ✅ MySQL 8 driver
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("✅ DB Connected Successfully!");
        } catch (Exception e) {
            e.printStackTrace();  // <-- print full error in console
        }
        return conn;
    }
}
