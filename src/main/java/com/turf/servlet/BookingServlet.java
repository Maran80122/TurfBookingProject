package com.turf.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/turfdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Maran@9095";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId;
        try {
            userId = Integer.parseInt(session.getAttribute("user_id").toString());
        } catch (Exception e) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String date = request.getParameter("date");
        String slot = request.getParameter("slot");
        int duration = Integer.parseInt(request.getParameter("duration"));

        // ✅ Convert to 24-hour format before saving
        slot = convertTo24Hour(slot);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                if (!userExists(con, userId)) {
                    session.invalidate();
                    response.sendRedirect("login.jsp");
                    return;
                }

                String sql = "INSERT INTO bookings1 (user_id, name, phone, email, booking_date, slot, duration, status) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, userId);
                    ps.setString(2, name);
                    ps.setString(3, phone);
                    ps.setString(4, email);
                    ps.setDate(5, java.sql.Date.valueOf(date));
                    ps.setString(6, slot);  // ✅ always 24-hour format
                    ps.setInt(7, duration);
                    ps.setString(8, "PENDING");

                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        try (ResultSet rs = ps.getGeneratedKeys()) {
                            if (rs.next()) {
                                int bookingId = rs.getInt(1);
                                session.setAttribute("booking_id", bookingId);
                                session.setAttribute("status", "PENDING");
                                response.sendRedirect("paymentpage.html");
                                return;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher("Booking.html").forward(request, response);
        }
    }

    private boolean userExists(Connection con, int userId) throws SQLException {
        String q = "SELECT 1 FROM users1 WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(q)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ✅ Helper: Convert "10:00 PM - 12:00 AM" → "22:00 - 00:00"
    private String convertTo24Hour(String slot) {
        try {
            String[] parts = slot.split(" - ");
            java.text.SimpleDateFormat inFormat = new java.text.SimpleDateFormat("hh:mm a");
            java.text.SimpleDateFormat outFormat = new java.text.SimpleDateFormat("HH:mm");

            String start24 = outFormat.format(inFormat.parse(parts[0].trim()));
            String end24 = outFormat.format(inFormat.parse(parts[1].trim()));

            return start24 + " - " + end24;
        } catch (Exception e) {
            e.printStackTrace();
            return slot;
        }
    }
}
