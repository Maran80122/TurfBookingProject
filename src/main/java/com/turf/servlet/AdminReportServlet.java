package com.turf.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminReportServlet")
public class AdminReportServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/turfdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Maran@9095";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalUsers = 0, activeUsers = 0, totalBookings = 0;
        double totalRevenue = 0;
        List<String> months = new ArrayList<>();
        List<Integer> monthlyBookings = new ArrayList<>();
        List<Double> monthlyRevenue = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // ✅ Totals
            Statement st = con.createStatement();
            ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM users1");
            if (rs1.next()) totalUsers = rs1.getInt(1);

            ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM users1 WHERE active=1");
            if (rs2.next()) activeUsers = rs2.getInt(1);

            ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM bookings1");
            if (rs3.next()) totalBookings = rs3.getInt(1);

            ResultSet rs4 = st.executeQuery("SELECT COALESCE(SUM(amount),0) FROM payments1");
            if (rs4.next()) totalRevenue = rs4.getDouble(1);

            // ✅ Monthly Bookings (last 6 months)
            String sqlBookings = "SELECT DATE_FORMAT(created_at,'%Y-%m') AS m, COUNT(*) " +
                                 "FROM bookings1 GROUP BY m ORDER BY m DESC LIMIT 6";
            ResultSet rs5 = st.executeQuery(sqlBookings);
            while (rs5.next()) {
                months.add(rs5.getString("m"));
                monthlyBookings.add(rs5.getInt(2));
            }
            Collections.reverse(months);
            Collections.reverse(monthlyBookings);

            // ✅ Monthly Revenue (last 6 months)
            String sqlRevenue = "SELECT DATE_FORMAT(created_at,'%Y-%m') AS m, SUM(amount) " +
                                "FROM payments1 GROUP BY m ORDER BY m DESC LIMIT 6";
            ResultSet rs6 = st.executeQuery(sqlRevenue);
            List<Double> revTmp = new ArrayList<>();
            while (rs6.next()) {
                revTmp.add(rs6.getDouble(2));
            }
            Collections.reverse(revTmp);

            for (int i = 0; i < months.size(); i++) {
                if (i < revTmp.size()) monthlyRevenue.add(revTmp.get(i));
                else monthlyRevenue.add(0.0);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ Convert to JSON-like strings
        String monthsJson = "[\"" + String.join("\",\"", months) + "\"]";
        String bookingsJson = monthlyBookings.toString();
        String revenueJson = monthlyRevenue.toString();

        // ✅ Send to JSP
        request.setAttribute("monthsJson", monthsJson);
        request.setAttribute("bookingsJson", bookingsJson);
        request.setAttribute("revenueJson", revenueJson);

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalRevenue", totalRevenue);

        RequestDispatcher rd = request.getRequestDispatcher("adminReports.jsp");
        rd.forward(request, response);
    }
}
