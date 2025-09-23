<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.turf.model.Payment" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Payments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
  table {
    word-wrap: break-word;
  }
  @media (max-width: 768px) {
    .table-responsive {
      display: block;
      width: 100%;
      overflow-x: auto;
    }
  }
</style>
    
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">💳 Manage Payments</h2>
<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Booking ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Slot</th>
                <th>Duration</th>
                <th>Amount</th>
                <th>Payment Method</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Payment> payments = (List<Payment>) request.getAttribute("payments");
            if (payments != null && !payments.isEmpty()) {
                for (Payment p : payments) {
        %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getBookingId() %></td>
                <td><%= p.getName() %></td>
                <td><%= p.getEmail() %></td>
                <td><%= p.getPhone() %></td>
                <td><%= p.getSlot() %></td>
                <td><%= p.getDuration() %></td>
                <td>₹ <%= p.getAmount() %></td>
                <td><%= p.getPaymentMethod() %></td>
                <td><%= p.getCreatedAt() %></td>
                <td>
                    <!-- Delete -->
                    <a href="DeletePaymentServlet?id=<%= p.getId() %>" 
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure you want to delete this payment?')">Delete</a>

                    <!-- Update -->
                    <form action="UpdatePaymentServlet" method="post" class="d-inline">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <input type="number" step="0.01" name="amount" value="<%= p.getAmount() %>" 
                               required class="form-control form-control-sm d-inline" style="width:100px;">
                        <select name="payment_method" class="form-select form-select-sm d-inline" style="width:100px;">
                            <option <%= p.getPaymentMethod().equals("UPI") ? "selected" : "" %>>UPI</option>
                            <option <%= p.getPaymentMethod().equals("CARD") ? "selected" : "" %>>CARD</option>
                            <option <%= p.getPaymentMethod().equals("CASH") ? "selected" : "" %>>CASH</option>
                        </select>
                        <button type="submit" class="btn btn-warning btn-sm">Update</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr><td colspan="11" class="text-center">No payments found</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
    </div>
</div>
</body>
</html>
