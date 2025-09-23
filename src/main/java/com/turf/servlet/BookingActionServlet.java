package com.turf.servlet;
import java.io.*;
//import javax.servlet.*;
//import javax.servlet.http.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.*;

@WebServlet("/BookingActionServlet")
public class BookingActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        String action = request.getParameter("action");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/turfdb", "root", "Maran@9095");

            String sql = "UPDATE bookings1 SET status=? WHERE id=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, action);
            ps.setInt(2, Integer.parseInt(id));
            ps.executeUpdate();

            response.sendRedirect("AdminBookingServlet"); // reload list

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating booking status");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
