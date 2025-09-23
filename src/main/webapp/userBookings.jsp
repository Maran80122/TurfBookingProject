<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.turf.model.Booking" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Bookings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">

    <h2 class="mb-3">My Bookings</h2>

    <%
        List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
        if (bookings == null || bookings.isEmpty()) {
    %>
        <div class="alert alert-info">No bookings found.</div>
    <%
        } else {
    %>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Booking ID</th>
                    <th>Date</th>
                    <th>Slot</th>
                    <th>Duration</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (Booking b : bookings) {
                    String status = b.getStatus();
                    String displayStatus = "⏳ Pending";

                    if ("CONFIRMED".equalsIgnoreCase(status) || "PAID".equalsIgnoreCase(status)) {
                        displayStatus = "✅ " + status;
                    } else if ("CANCELLED".equalsIgnoreCase(status)) {
                        displayStatus = "❌ Cancelled";
                    }
            %>
                <tr>
                    <td><%= b.getId() %></td>
                    <td><%= b.getBookingDate() %></td>
                    <td><%= b.getSlot() %></td>
                    <td><%= b.getDuration() %> hr(s)</td>
                    <td><%= displayStatus %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    <%
        }
    %>

    <a href="userDashboard" class="btn btn-primary mt-3">⬅ Back to Dashboard</a>

</body>
</html>
