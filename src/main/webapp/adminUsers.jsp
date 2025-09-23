<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.turf.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Users</title>
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
            --purple: #6f42c1;
        }
        
        body {
            background: linear-gradient(to right, #f5f7fa, #c3cfe2);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            padding-bottom: 2rem;
        }
        
        .container {
            max-width: 1200px;
            margin-top: 2rem;
        }
        
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .card-header {
            background: linear-gradient(90deg, var(--purple), #8e44ad);
            color: white;
            padding: 1.5rem 2rem;
            border: none;
        }
        
        .card-body {
            padding: 2rem;
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
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table thead th {
            background: var(--purple);
            color: white;
            font-weight: 500;
            padding: 1rem 0.75rem;
            border: none;
            text-align: center;
            vertical-align: middle;
        }
        
        .table tbody td {
            padding: 1rem 0.75rem;
            vertical-align: middle;
            border-color: #f1f1f1;
            text-align: center;
        }
        
        .table tbody tr {
            transition: all 0.3s ease;
        }
        
        .table tbody tr:hover {
            background-color: rgba(111, 66, 193, 0.05);
            transform: translateY(-2px);
        }
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 500;
        }
        
        .status-active {
            background-color: rgba(46, 204, 113, 0.15);
            color: #27ae60;
        }
        
        .status-inactive {
            background-color: rgba(231, 76, 60, 0.15);
            color: #c0392b;
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
        
        .btn-warning {
            background: var(--warning);
            border: none;
            color: white;
        }
        
        .btn-success:hover, .btn-warning:hover {
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
            margin-top: 1.5rem;
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
        @media (max-width: 768px) {
            .card-body {
                padding: 1.5rem 1rem;
            }
            
            .table-container {
                overflow-x: auto;
            }
            
            .table {
                min-width: 700px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h3 class="page-title">
                    <i class="fas fa-users"></i> Manage Users
                </h3>
            </div>
            <div class="card-body">
                <div class="table-container">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            List<User> users = (List<User>) request.getAttribute("users");
                            if (users != null && !users.isEmpty()) {
                                for (User u : users) {
                        %>
                            <tr>
                                <td><%= u.getId() %></td>
                                <td><%= u.getName() %></td>
                                <td><%= u.getEmail() %></td>
                                <td><%= u.getPhone() %></td>
                                <td>
                                    <span class="status-badge status-<%= u.isActive() ? "active" : "inactive" %>">
                                        <%= u.isActive() ? "Active" : "Inactive" %>
                                    </span>
                                </td>
                                <td>
                                    <form action="AdminUserServlet" method="post" class="d-inline">
                                        <input type="hidden" name="user_id" value="<%= u.getId() %>">
                                        <% if (u.isActive()) { %>
                                            <button type="submit" name="action" value="DEACTIVATE" class="btn btn-warning btn-action">
                                                <i class="fas fa-user-times"></i> Deactivate
                                            </button>
                                        <% } else { %>
                                            <button type="submit" name="action" value="ACTIVATE" class="btn btn-success btn-action">
                                                <i class="fas fa-user-check"></i> Activate
                                            </button>
                                        <% } %>
                                    </form>
                                </td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="6">
                                    <div class="empty-state">
                                        <i class="fas fa-user-slash"></i>
                                        <h4>No users found</h4>
                                        <p>There are no users to display at this time.</p>
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
        </div>
        
        <a href="adminPanel.jsp" class="btn btn-back">
            <i class="fas fa-arrow-left"></i> Back to Admin Panel
        </a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>