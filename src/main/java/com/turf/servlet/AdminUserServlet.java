package com.turf.servlet;

import com.turf.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminUserServlet")
public class AdminUserServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/turfdb";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Maran@9095";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String query = "SELECT * FROM users1";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                User u = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getBoolean("active")
                );
                users.add(u);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("users", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminUsers.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("user_id"));
        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "";
            if ("ACTIVATE".equals(action)) {
                sql = "UPDATE users1 SET active=1 WHERE id=?";
            } else if ("DEACTIVATE".equals(action)) {
                sql = "UPDATE users1 SET active=0 WHERE id=?";
            }

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdminUserServlet");
    }
}
