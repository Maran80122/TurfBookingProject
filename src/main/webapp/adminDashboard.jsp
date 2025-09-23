<%@ page session="true" %>
<%
  if (session.getAttribute("role") == null || !"ADMIN".equals(session.getAttribute("role"))) {
    response.sendRedirect("adminlogin.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #0062E6;
            --primary-light: #33AEFF;
            --secondary: #6c757d;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --light: #f8f9fa;
            --dark: #343a40;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s ease;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ee 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: white;
            padding: 30px 20px;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 98, 230, 0.2);
        }
        
        .dashboard-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            transform: rotate(30deg);
        }
        
        .dashboard-header h1 {
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 10px;
            position: relative;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .dashboard-header p {
            font-size: 1.2rem;
            opacity: 0.9;
            position: relative;
        }
        
        .card {
            border-radius: 16px;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            border: none;
            overflow: hidden;
            position: relative;
            margin-bottom: 20px;
        }
        
        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--primary-light));
        }
        
        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.12);
        }
        
        .card-body {
            padding: 25px;
            position: relative;
            z-index: 1;
        }
        
        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            opacity: 0.8;
        }
        
        .card-title {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: rgba(0, 0, 0, 0.7);
        }
        
        .card-value {
            font-size: 2.2rem;
            font-weight: 700;
            margin: 0;
        }
        
        .bg-primary { background: linear-gradient(135deg, var(--primary), #2982ff) !important; }
        .bg-warning { background: linear-gradient(135deg, var(--warning), #ffd54f) !important; }
        .bg-success { background: linear-gradient(135deg, var(--success), #4caf50) !important; }
        .bg-danger { background: linear-gradient(135deg, var(--danger), #f44336) !important; }
        
        .nav-btn {
            margin: 10px;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-width: 2px;
        }
        
        .nav-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
        }
        
        .btn-outline-primary {
            color: var(--primary);
            border-color: var(--primary);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        .btn-outline-danger {
            color: var(--danger);
            border-color: var(--danger);
        }
        
        .btn-outline-danger:hover {
            background-color: var(--danger);
            border-color: var(--danger);
        }
        
        .container {
            max-width: 1200px;
        }
        
        .stats-container {
            margin-top: -40px;
            position: relative;
            z-index: 10;
        }
        
        .welcome-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 50px;
            display: inline-block;
            margin-top: 10px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        @media (max-width: 768px) {
            .dashboard-header h1 {
                font-size: 2rem;
            }
            
            .stats-container {
                margin-top: -20px;
            }
            
            .card-value {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

    <!-- Header -->
    <div class="dashboard-header">
        <h1><i class="bi bi-speedometer2"></i> Admin Dashboard</h1>
        <div class="welcome-badge">
            <p class="mb-0">Welcome, ${sessionScope.adminName} <i class="bi bi-person-circle ms-2"></i></p>
        </div>
    </div>

    <div class="container">
        <div class="stats-container">
            <div class="row g-4">
                <!-- Total Bookings -->
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body text-center">
                            <div class="card-icon">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                            <h5 class="card-title">Total Bookings</h5>
                            <h2 class="card-value">${totalBookings}</h2>
                        </div>
                    </div>
                </div>
                <!-- Pending Approvals -->
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="card text-white bg-warning">
                        <div class="card-body text-center">
                            <div class="card-icon">
                                <i class="bi bi-hourglass-split"></i>
                            </div>
                            <h5 class="card-title">Pending Approvals</h5>
                            <h2 class="card-value">${pendingBookings}</h2>
                        </div>
                    </div>
                </div>
                <!-- Payments -->
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="card text-white bg-success">
                        <div class="card-body text-center">
                            <div class="card-icon">
                                <i class="bi bi-cash-stack"></i>
                            </div>
                            <h5 class="card-title">Total Payments</h5>
                            <h2 class="card-value">${totalPayments}</h2>
                        </div>
                    </div>
                </div>
                <!-- Users -->
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="card text-white bg-danger">
                        <div class="card-body text-center">
                            <div class="card-icon">
                                <i class="bi bi-people"></i>
                            </div>
                            <h5 class="card-title">Registered Users</h5>
                            <h2 class="card-value">${totalUsers}</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="text-center mt-5 py-4">
            <a href="adminPanel.jsp" class="btn btn-lg btn-outline-primary nav-btn">
                <i class="bi bi-gear"></i> Admin Panel
            </a>
            <a href="LogoutServlet" class="btn btn-lg btn-outline-danger nav-btn">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>