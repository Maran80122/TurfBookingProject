<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.turf.model.Booking" %>
<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings - Admin</title>
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
            max-width: 1400px;
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
        }
        
        .table thead th {
            background: var(--primary);
            color: white;
            font-weight: 500;
            padding: 1rem 0.75rem;
            border: none;
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
        
        .badge {
            padding: 0.5rem 0.75rem;
            border-radius: 50px;
            font-weight: 500;
        }
        
        .btn-action {
            border-radius: 6px;
            padding: 0.4rem 0.8rem;
            font-size: 0.875rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-success {
            background: var(--success);
            border: none;
        }
        
        .btn-danger {
            background: var(--danger);
            border: none;
        }
        
        .btn-success:hover, .btn-danger:hover {
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
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 500;
        }
        
        .status-pending {
            background-color: rgba(243, 156, 18, 0.15);
            color: #f39c12;
        }
        
        .status-confirmed {
            background-color: rgba(46, 204, 113, 0.15);
            color: #27ae60;
        }
        
        .status-cancelled {
            background-color: rgba(231, 76, 60, 0.15);
            color: #c0392b;
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
        @media (max-width: 992px) {
            .table-container {
                overflow-x: auto;
            }
            
            .table {
                min-width: 900px;
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
    </style>
</head>
<body>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-calendar-alt"></i> Manage Bookings
            </h1>
        </div>
        
        <!-- Bookings Table -->
        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User ID</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Booking Date</th>
                            <th>Slot</th>
                            <th>Duration</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if (bookings != null && !bookings.isEmpty()) {
                            for (Booking b : bookings) {
                    %>
                        <tr>
                            <td><%= b.getId() %></td>
                            <td><%= b.getUserId() %></td>
                            <td><%= b.getName() %></td>
                            <td><%= b.getPhone() %></td>
                            <td><%= b.getEmail() %></td>
                            <td><%= b.getBookingDate() %></td>
                            <td><%= b.getSlot() %></td>
                            <td><%= b.getDuration() %> hrs</td>
                            <td>
                                <% if ("PENDING".equalsIgnoreCase(b.getStatus())) { %>
                                    <span class="status-badge status-pending"><%= b.getStatus() %></span>
                                <% } else if ("CONFIRMED".equalsIgnoreCase(b.getStatus())) { %>
                                    <span class="status-badge status-confirmed"><%= b.getStatus() %></span>
                                <% } else if ("CANCELLED".equalsIgnoreCase(b.getStatus())) { %>
                                    <span class="status-badge status-cancelled"><%= b.getStatus() %></span>
                                <% } else { %>
                                    <span class="badge bg-secondary"><%= b.getStatus() %></span>
                                <% } %>
                            </td>
                            <td>
                                <form action="UpdateBookingStatusServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="bookingId" value="<%= b.getId() %>"/>
                                    <button type="submit" name="status" value="CONFIRMED" class="btn btn-success btn-action">
                                        <i class="fas fa-check"></i> Approve
                                    </button>
                                    <button type="submit" name="status" value="CANCELLED" class="btn btn-danger btn-action">
                                        <i class="fas fa-times"></i> Cancel
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="10">
                                <div class="empty-state">
                                    <i class="fas fa-calendar-times"></i>
                                    <h4>No bookings found</h4>
                                    <p>There are no bookings to display at this time.</p>
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