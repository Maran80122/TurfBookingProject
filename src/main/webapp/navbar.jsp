<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="navbar.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ul class="navbar-nav ms-auto">
    <%
        // Check if user is logged in
        String username = (String) session.getAttribute("username"); // or "user_id"
        if (username == null) {
    %>
        <!-- Show this if NOT logged in -->
        <li class="nav-item ms-3">
          <a href="register.html" class="btn btn-sm btn-outline-success me-2">Register</a>
          <a href="login.html" class="btn btn-sm btn-success">Login</a>
        </li>
    <%
        } else {
    %>
        <!-- Show this if user IS logged in -->
        <li class="nav-item ms-3 d-flex align-items-center">
          <span class="text-white me-2">Welcome, <%= username %></span>
          <a href="LogoutServlet" class="btn btn-sm btn-danger">Logout</a>
        </li>
    <%
        }
    %>
</ul>

</body>
</html>