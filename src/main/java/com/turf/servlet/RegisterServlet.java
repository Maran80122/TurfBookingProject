package com.turf.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ✅ Handle GET request (direct link to /register)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    // ✅ Handle POST request (form submission)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // must not be null

        // Debugging check
        System.out.println("Password received: " + password);

        // ✅ Phone number validation
        if (phone == null || !phone.matches("\\d{10}")) {
            request.setAttribute("errorMsg", "⚠️ Phone number must be exactly 10 digits.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/turfdb", "root", "Maran@9095");
                 PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO users1(name, phone, email, password) VALUES (?, ?, ?, ?)")) {

                ps.setString(1, name);
                ps.setString(2, phone);
                ps.setString(3, email);
                ps.setString(4, password);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    request.getRequestDispatcher("registerSuccess.jsp").forward(request, response);
                }
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            
            request.getRequestDispatcher("registerFailed.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "⚠️ Something went wrong. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
