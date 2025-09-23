package com.turf.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/turfdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Maran@9095";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("paymentpage.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("booking_id") == null) {
            request.setAttribute("error", "No booking found. Please book first.");
            request.getRequestDispatcher("paymentpage.jsp").forward(request, response);
            return;
        }

        int bookingId = (int) session.getAttribute("booking_id");

        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String slot = request.getParameter("slot");
        String durationStr = request.getParameter("duration");
        String amountStr = request.getParameter("amount");
        String method = request.getParameter("payment_method");

        int duration;
        double amount;

        // Validate numeric inputs
        try {
            duration = Integer.parseInt(durationStr);
            amount = Double.parseDouble(amountStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid duration or amount.");
            request.getRequestDispatcher("paymentpage.jsp").forward(request, response);
            return;
        }

        // Validate payment method
        if (!(method.equals("UPI") || method.equals("CARD") || method.equals("CASH"))) {
            request.setAttribute("error", "Invalid payment method.");
            request.getRequestDispatcher("paymentpage.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                con.setAutoCommit(false); // Start transaction

                // ✅ Insert payment record
                String insertSQL = "INSERT INTO payments1 (booking_id, name, email, phone, slot, duration, amount, payment_method) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(insertSQL)) {
                    ps.setInt(1, bookingId);
                    ps.setString(2, name);
                    ps.setString(3, email);
                    ps.setString(4, phone);
                    ps.setString(5, slot);
                    ps.setInt(6, duration);
                    ps.setDouble(7, amount);
                    ps.setString(8, method);

                    if (ps.executeUpdate() == 0) {
                        con.rollback();
                        request.setAttribute("error", "Payment insertion failed.");
                        request.getRequestDispatcher("paymentpage.jsp").forward(request, response);
                        return;
                    }
                }

                // ✅ Update booking status
                String updateSQL = "UPDATE bookings1 SET status = 'PAID' WHERE id = ?";
                try (PreparedStatement ps2 = con.prepareStatement(updateSQL)) {
                    ps2.setInt(1, bookingId);
                    if (ps2.executeUpdate() == 0) {
                        con.rollback();
                        request.setAttribute("error", "Booking status update failed.");
                        request.getRequestDispatcher("paymentpage.jsp").forward(request, response);
                        return;
                    }
                }

                // ✅ Commit transaction
                con.commit();

                // Clear booking_id from session (optional, prevents double-payment)
                session.removeAttribute("booking_id");
                session.setAttribute("status", "PAID");

                response.sendRedirect("paymentsuccess.jsp?bookingId=" + bookingId);

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("paymentpage.jsp").forward(request, response);
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found.");
            request.getRequestDispatcher("paymentpage.jsp").forward(request, response);
        }
    }
}
