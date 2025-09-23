<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.turf.model.Booking" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Your Bookings</h2>

    <%
        List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
        if (bookings == null || bookings.isEmpty()) {
    %>
        <div class="alert alert-info">You have no bookings yet.</div>
    <%
        } else {
    %>
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Date</th>
                    <th>Slot</th>
                    <th>Duration</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Booking b : bookings) {
            %>
                <tr>
                    <td><%= b.getId() %></td>
                    <td><%= b.getDate() %></td>
                    <td><%= b.getSlot() %></td>
                    <td><%= b.getDuration() %> hrs</td>
                    <td><%= b.getStatus() %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    <%
        }
    %>
</div>

</body>
</html>
