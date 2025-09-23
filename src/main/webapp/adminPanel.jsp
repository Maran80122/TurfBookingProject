<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Turf Booking</title>
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
            --card-1: linear-gradient(135deg, #3498db, #2c3e50);
            --card-2: linear-gradient(135deg, #9b59b6, #34495e);
            --card-3: linear-gradient(135deg, #e74c3c, #c0392b);
            --card-4: linear-gradient(135deg, #f39c12, #d35400);
        }
        
        body {
            background: linear-gradient(to right, #f5f7fa, #c3cfe2);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
        }
        
        .navbar {
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 0.8rem 1rem;
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .container {
            padding-top: 2rem;
            padding-bottom: 3rem;
        }
        
        .page-title {
            position: relative;
            margin-bottom: 2.5rem;
            font-weight: 700;
            color: var(--dark);
            text-align: center;
        }
        
        .page-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--secondary);
            border-radius: 2px;
        }
        
        .page-subtitle {
            text-align: center;
            color: #7f8c8d;
            margin-bottom: 3rem;
            font-weight: 400;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.4s ease;
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
            height: 100%;
        }
        
        .card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .card-body {
            padding: 2rem 1.5rem;
            color: white;
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            height: 100%;
        }
        
        .card-body:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.1);
            z-index: -1;
        }
        
        .card-title {
            font-weight: 600;
            font-size: 1.4rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .card-text {
            font-weight: 300;
            opacity: 0.9;
        }
        
        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            opacity: 0.9;
        }
        
        .card-1 {
            background: var(--card-1);
        }
        
        .card-2 {
            background: var(--card-2);
        }
        
        .card-3 {
            background: var(--card-3);
        }
        
        .card-4 {
            background: var(--card-4);
        }
        
        .logout-btn {
            border-radius: 50px;
            font-weight: 500;
            padding: 0.5rem 1.5rem;
            transition: all 0.3s;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        /* Animation for cards */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .card {
            animation: fadeIn 0.6s ease forwards;
        }
        
        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }
        .card:nth-child(3) { animation-delay: 0.3s; }
        .card:nth-child(4) { animation-delay: 0.4s; }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .card-title {
                font-size: 1.2rem;
            }
            
            .card-body {
                padding: 1.5rem 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand" href="adminDashboard.jsp">
                <i class="fas fa-football-ball"></i> Turf Booking - Admin
            </a>
            <div class="ms-auto">
                <a href="LogoutServlet" class="btn btn-danger logout-btn">
                    <i class="fas fa-sign-out-alt me-1"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <!-- Page Content -->
    <div class="container mt-4">
        <h2 class="page-title">Admin Control Panel</h2>
        <p class="page-subtitle">Select an option below to manage the system</p>

        <div class="row g-4">
            <!-- Manage Bookings -->
            <div class="col-md-3 col-sm-6 col-12">
                <a href="AdminBookingsServlet" class="text-decoration-none">
                    <div class="card card-1">
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <h5 class="card-title">
                                <i class="fas fa-cog"></i> Manage Bookings
                            </h5>
                            <p class="card-text">View, approve, or cancel user bookings.</p>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Manage Payments -->
            <div class="col-md-3 col-sm-6 col-12">
                <a href="ManagePaymentServlet" class="text-decoration-none">
                    <div class="card card-2">
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-credit-card"></i>
                            </div>
                            <h5 class="card-title">
                                <i class="fas fa-cog"></i> Manage Payments
                            </h5>
                            <p class="card-text">Track and verify payments.</p>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Manage Users -->
            <div class="col-md-3 col-sm-6 col-12">
                <a href="AdminUserServlet" class="text-decoration-none">
                    <div class="card card-3">
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <h5 class="card-title">
                                <i class="fas fa-cog"></i> Manage Users
                            </h5>
                            <p class="card-text">View, edit or deactivate user accounts.</p>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Reports -->
            <div class="col-md-3 col-sm-6 col-12">
                <a href="AdminReportServlet" class="text-decoration-none">
                    <div class="card card-4">
                        <div class="card-body">
                            <div class="card-icon">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <h5 class="card-title">
                                <i class="fas fa-cog"></i> Reports
                            </h5>
                            <p class="card-text">Generate reports of bookings & payments.</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>