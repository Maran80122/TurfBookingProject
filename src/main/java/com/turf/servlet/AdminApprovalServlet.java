package com.turf.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminApprovalServlet")
public class AdminApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/turfdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Maran@9095";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdStr = request.getParameter("booking_id");
        String action = request.getParameter("action");

        if (bookingIdStr == null || action == null) {
            response.sendRedirect("AdminBookingServlet");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "UPDATE bookings1 SET status = ? WHERE id = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, action);
                    ps.setInt(2, bookingId);
                    ps.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdminBookingServlet");
    }
}
