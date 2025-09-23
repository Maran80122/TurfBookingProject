package com.turf.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/BookingStatusServlet")
public class BookingStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String bookingDate = request.getParameter("date");

        List<String> bookedSlots = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/turfdb", "root", "Maran@9095");

            String sql = "SELECT slot FROM bookings1 WHERE booking_date = ?";
            ps = conn.prepareStatement(sql);
            ps.setDate(1, java.sql.Date.valueOf(bookingDate)); // ✅ Use proper DATE type
            rs = ps.executeQuery();

            while (rs.next()) {
                String slot = rs.getString("slot");
                if (slot != null && slot.contains("-")) {
                    bookedSlots.add(slot.trim());
                }
            }

            // ✅ Build JSON manually
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < bookedSlots.size(); i++) {
                json.append("\"").append(bookedSlots.get(i)).append("\"");
                if (i < bookedSlots.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");

            out.print(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]"); // return empty JSON if error
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
