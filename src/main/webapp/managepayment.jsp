<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.turf.model.Payment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Payments - Admin</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
            --light: #ecf0f1;
            --dark: #2c3e50;
            --success: #2ecc71;
            --warning: #f39c12;
            --danger: #e74c3c;
        }
        
        body {
            background: linear-gradient(to right, #f5f7fa, #c3cfe2);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            padding-bottom: 2rem;
        }
        
        .container {
            max-width: 1800px;
            margin-top: 2rem;
        }
        
        .page-header {
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            color: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .page-title {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .table {
            margin-bottom: 0;
            width: 100%;
        }
        
        .table thead th {
            background: var(--primary);
            color: white;
            font-weight: 500;
            padding: 1rem 0.75rem;
            border: none;
            white-space: nowrap;
        }
        
        .table tbody td {
            padding: 1rem 0.75rem;
            vertical-align: middle;
            border-color: #f1f1f1;
        }
        
        .table tbody tr {
            transition: all 0.3s ease;
        }
        
        .table tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.05);
            transform: translateY(-2px);
        }
        
        .form-control-sm {
            border-radius: 6px;
            padding: 0.375rem 0.5rem;
            font-size: 0.875rem;
        }
        
        .form-select-sm {
            border-radius: 6px;
            padding: 0.375rem 1.75rem 0.375rem 0.5rem;
            font-size: 0.875rem;
        }
        
        .btn-action {
            border-radius: 6px;
            padding: 0.4rem 0.8rem;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.3s ease;
            white-space: nowrap;
        }
        
        .btn-warning {
            background: var(--warning);
            border: none;
            color: white;
        }
        
        .btn-danger {
            background: var(--danger);
            border: none;
        }
        
        .btn-warning:hover, .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        .btn-back {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.6rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-back:hover {
            background: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        
        .empty-state {
            padding: 3rem 1rem;
            text-align: center;
            color: #7f8c8d;
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        
        /* Animation for table rows */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        tbody tr {
            animation: fadeIn 0.5s ease forwards;
        }
        
        tbody tr:nth-child(1) { animation-delay: 0.05s; }
        tbody tr:nth-child(2) { animation-delay: 0.1s; }
        tbody tr:nth-child(3) { animation-delay: 0.15s; }
        tbody tr:nth-child(4) { animation-delay: 0.2s; }
        tbody tr:nth-child(5) { animation-delay: 0.25s; }
        tbody tr:nth-child(6) { animation-delay: 0.3s; }
        tbody tr:nth-child(7) { animation-delay: 0.35s; }
        tbody tr:nth-child(8) { animation-delay: 0.4s; }
        tbody tr:nth-child(9) { animation-delay: 0.45s; }
        tbody tr:nth-child(10) { animation-delay: 0.5s; }
        
        /* Responsive adjustments */
        @media (max-width: 1200px) {
            .table-container {
                overflow-x: auto;
            }
            
            .table {
                min-width: 1400px;
            }
        }
        
        @media (max-width: 576px) {
            .page-header {
                padding: 1rem;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
        }
        
        .payment-method-badge {
            padding: 0.4rem 0.75rem;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.8rem;
        }
        
        .payment-upi {
            background-color: rgba(106, 76, 147, 0.15);
            color: #6a4c93;
        }
        
        .payment-card {
            background-color: rgba(41, 128, 185, 0.15);
            color: #2980b9;
        }
        
        .payment-cash {
            background-color: rgba(39, 174, 96, 0.15);
            color: #27ae60;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-credit-card"></i> Manage Payments
            </h1>
        </div>
        
        <!-- Payments Table -->
        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
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
                            <td>
                                <form action="UpdatePaymentServlet" method="post" class="d-inline">
                                    <input type="hidden" name="id" value="<%= p.getId() %>">
                                    <div class="input-group input-group-sm" style="width: 120px;">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" step="0.01" name="amount" value="<%= p.getAmount() %>" 
                                               required class="form-control">
                                    </div>
                            </td>
                            <td>
                                    <select name="paymentMethod" class="form-select form-select-sm" style="width: 100px;">
                                        <option value="UPI" <%= p.getPaymentMethod().equals("UPI") ? "selected" : "" %>>UPI</option>
                                        <option value="CARD" <%= p.getPaymentMethod().equals("CARD") ? "selected" : "" %>>CARD</option>
                                        <option value="CASH" <%= p.getPaymentMethod().equals("CASH") ? "selected" : "" %>>CASH</option>
                                    </select>
                            </td>
                            <td><%= p.getCreatedAt() %></td>
                            <td>
                                    <button type="submit" class="btn btn-warning btn-action mb-1">
                                        <i class="fas fa-sync-alt"></i> Update
                                    </button>
                                </form>

                                <a href="DeletePaymentServlet?id=<%= p.getId() %>" 
                                   class="btn btn-danger btn-action"
                                   onclick="return confirm('Are you sure you want to delete this payment?')">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="11">
                                <div class="empty-state">
                                    <i class="fas fa-credit-card"></i>
                                    <h4>No payments found</h4>
                                    <p>There are no payments to display at this time.</p>
                                </div>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <a href="adminPanel.jsp" class="btn btn-back">
            <i class="fas fa-arrow-left"></i> Back to Admin Panel
        </a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>