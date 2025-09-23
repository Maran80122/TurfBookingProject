package com.turf.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/turfdb", "root", "Maran@9095")) {

                String sql = "SELECT * FROM users1 WHERE email=? AND password=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // ✅ Fetch user details
                    int userId = rs.getInt("id");
                    String name = rs.getString("name");

                    // ✅ Store in session
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user_id", userId);
                    session.setAttribute("user_name", name);

                    // ✅ Redirect to dashboard (NOT turf1.html anymore)
                    response.sendRedirect("turf1.html");

                } else {
                    out.println("<p style='color:red;'>❌ Invalid email or password!</p>");
                    request.getRequestDispatcher("login.jsp").include(request, response);
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>⚠️ Error: " + e.getMessage() + "</p>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to login.jsp
        response.sendRedirect("login.jsp");
    }
}
