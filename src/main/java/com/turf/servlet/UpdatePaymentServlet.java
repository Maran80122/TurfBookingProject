package com.turf.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdatePaymentServlet")
public class UpdatePaymentServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/turfdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Maran@9095";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String paymentMethod = request.getParameter("paymentMethod");

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String query = "UPDATE payments1 SET amount=?, payment_method=? WHERE id=?";
                try (PreparedStatement ps = con.prepareStatement(query)) {
                    ps.setDouble(1, amount);
                    ps.setString(2, paymentMethod);
                    ps.setInt(3, id);
                    ps.executeUpdate();
                }
            }

            // Redirect back to ManagePaymentServlet
            response.sendRedirect("ManagePaymentServlet");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating payment: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
