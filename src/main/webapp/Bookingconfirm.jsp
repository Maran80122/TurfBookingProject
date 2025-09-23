<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Booking Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet"/>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #111827, #1f2937);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
            padding: 20px;
        }
        .confirm-box {
            background: rgba(17,24,39,0.9);
            padding: 30px;
            border-radius: 16px;
            max-width: 600px;
            width: 100%;
            text-align: center;
            box-shadow: 0 6px 20px rgba(0,0,0,0.6);
        }
        h2 {
            color: #4ade80;
            margin-bottom: 20px;
        }
        .detail {
            background: #1f2937;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 10px;
            text-align: left;
        }
        .btn-pay {
            background: linear-gradient(45deg, #4ade80, #22c55e);
            border: none;
            padding: 12px 20px;
            border-radius: 30px;
            font-weight: 600;
            color: #000;
            width: 100%;
            transition: all 0.3s ease;
        }
        .btn-pay:hover {
            background: linear-gradient(45deg,#22c55e,#15803d);
            color: #fff;
        }
    </style>
</head>
<body>

<div class="confirm-box">
    <h2><i class="bi bi-check-circle-fill"></i> Booking Confirmation</h2>

    <%
        // Message from BookingServlet
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="alert alert-info"><%= message %></div>
    <%
        }
        
        // Booking details passed as request attributes
        String bookingId = (String) request.getAttribute("bookingId");
        String name = (String) request.getAttribute("name");
        String email = (String) request.getAttribute("email");
        String phone = (String) request.getAttribute("phone");
        String bookingDate = (String) request.getAttribute("bookingDate");
        String slot = (String) request.getAttribute("slot");
        String duration = (String) request.getAttribute("duration");
    %>

    <div class="detail"><strong>Name:</strong> <%= name %></div>
    <div class="detail"><strong>Email:</strong> <%= email %></div>
    <div class="detail"><strong>Phone:</strong> <%= phone %></div>
    <div class="detail"><strong>Date:</strong> <%= bookingDate %></div>
    <div class="detail"><strong>Slot:</strong> <%= slot %></div>
    <div class="detail"><strong>Duration:</strong> <%= duration %> hour(s)</div>

    <form action="PaymentServlet" method="post" class="mt-4">
        <input type="hidden" name="bookingId" value="<%= bookingId %>">
        <div class="mb-3 text-start">
            <label for="paymentMethod" class="form-label">Choose Payment Method:</label>
            <select name="paymentMethod" id="paymentMethod" class="form-select" required>
                <option value="UPI">UPI / QR</option>
                <option value="Card">Credit / Debit Card</option>
                <option value="Cash">Cash on Arrival</option>
            </select>
        </div>
        <button type="submit" class="btn-pay"><i class="bi bi-currency-rupee"></i> Proceed to Payment</button>
    </form>
</div>

</body>
</html>
