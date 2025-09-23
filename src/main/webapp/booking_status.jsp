<%@page session="true" %>
<%@ page import="java.sql.*" %>
<%
    // Ensure user is logged in
    

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<html>
<head>
  <title>My Booking Status</title>
</head>
<body>
  <h2>Booking Status</h2>
  <table border="1" cellpadding="10">
    <tr>
      <th>Booking ID</th>
      <th>Slot</th>
      <th>Duration</th>
      <th>Status</th>
    </tr>
    <%
      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/turfdb", "root", "Maran@9095");

          String sql = "SELECT id, slot, duration, status FROM bookings1 WHERE user_id=? ORDER BY created_at DESC";
          ps = conn.prepareStatement(sql);
          ps.setInt(1, userId);
          rs = ps.executeQuery();

          while (rs.next()) {
    %>
            <tr>
              <td><%= rs.getInt("id") %></td>
              <td><%= rs.getString("slot") %></td>
              <td><%= rs.getInt("duration") %> hrs</td>
              <td>
                <% 
                   String st = rs.getString("status");
                   if("CONFIRMED".equals(st)) { %>
                      ✅ Confirmed
                <% } else if("CANCELLED".equals(st)) { %>
                      ❌ Cancelled
                <% } else if("PAID".equals(st)) { %>
                      ⏳ Waiting for Admin Approval
                <% } else { %>
                      🟡 Pending
                <% } %>
              </td>
            </tr>
    <%
          }
      } catch(Exception e) {
          e.printStackTrace();
          out.println("Error loading status.");
      } finally {
          try { if(rs!=null) rs.close(); } catch(Exception e) {}
          try { if(ps!=null) ps.close(); } catch(Exception e) {}
          try { if(conn!=null) conn.close(); } catch(Exception e) {}
      }
    %>
  </table>
</body>
</html>
