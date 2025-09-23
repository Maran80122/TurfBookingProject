package com.turf.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.turf.model.Booking;   // ✅ your Booking model


@WebServlet("/UserDashboardServlet")
public class UserDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/turfdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Maran@9095";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = Integer.parseInt(session.getAttribute("user_id").toString());

        List<Booking> bookings = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "SELECT id, booking_date, slot, duration, status " +
                             "FROM bookings1 WHERE user_id = ? ORDER BY booking_date DESC";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setInt(1, userId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            Booking b = new Booking();
                            b.setId(rs.getInt("id"));
                            b.setDate(rs.getDate("booking_date").toString());
                            b.setSlot(rs.getString("slot"));
                            b.setDuration(rs.getInt("duration"));
                            b.setStatus(rs.getString("status"));
                            bookings.add(b);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("userdashboard.jsp").forward(request, response);
    }
}
