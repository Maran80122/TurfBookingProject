package com.turf.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalBookings = 0;
        int pendingBookings = 0;
        int totalPayments = 0;
        int totalUsers = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/turfdb", "root", "Maran@9095");

            Statement st = con.createStatement();

            ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM bookings1");
            if (rs1.next()) totalBookings = rs1.getInt(1);

            ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM bookings1 WHERE status='PENDING'");
            if (rs2.next()) pendingBookings = rs2.getInt(1);

            ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM payments1");
            if (rs3.next()) totalPayments = rs3.getInt(1);

            ResultSet rs4 = st.executeQuery("SELECT COUNT(*) FROM users1");
            if (rs4.next()) totalUsers = rs4.getInt(1);

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ Set values in request scope
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("pendingBookings", pendingBookings);
        request.setAttribute("totalPayments", totalPayments);
        request.setAttribute("totalUsers", totalUsers);

        // ✅ Forward to JSP
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }
}
