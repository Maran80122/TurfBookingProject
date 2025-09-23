<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String monthsJson = (String) request.getAttribute("monthsJson");
    String bookingsJson = (String) request.getAttribute("bookingsJson");
    String revenueJson = (String) request.getAttribute("revenueJson");

    int totalUsers = (Integer) request.getAttribute("totalUsers");
    int activeUsers = (Integer) request.getAttribute("activeUsers");
    int totalBookings = (Integer) request.getAttribute("totalBookings");
    double totalRevenue = (Double) request.getAttribute("totalRevenue");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Reports</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            padding: 2rem 0;
        }
        
        .container {
            max-width: 1400px;
        }
        
        .page-header {
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            color: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .page-title {
            margin: 0;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        
        /* Summary Cards */
        .card-container {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
            margin-bottom: 3rem;
        }
        
        .stat-card {
            flex: 1;
            min-width: 220px;
            padding: 1.5rem;
            background: white;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            border: none;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
        }
        
        .stat-card:nth-child(1):before { background: linear-gradient(90deg, var(--primary), var(--secondary)); }
        .stat-card:nth-child(2):before { background: linear-gradient(90deg, var(--success), #27ae60); }
        .stat-card:nth-child(3):before { background: linear-gradient(90deg, var(--warning), #e67e22); }
        .stat-card:nth-child(4):before { background: linear-gradient(90deg, var(--purple), #8e44ad); }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.15);
        }
        
        .stat-card h3 {
            margin: 0 0 10px;
            font-size: 1rem;
            color: #7f8c8d;
            font-weight: 500;
        }
        
        .stat-card p {
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
            color: var(--dark);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            opacity: 0.8;
        }
        
        .stat-card:nth-child(1) .stat-icon { color: var(--secondary); }
        .stat-card:nth-child(2) .stat-icon { color: var(--success); }
        .stat-card:nth-child(3) .stat-icon { color: var(--warning); }
        .stat-card:nth-child(4) .stat-icon { color: var(--purple); }
        
        /* Charts section */
        .charts-container {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }
        
        .charts-title {
            text-align: center;
            margin-bottom: 2rem;
            color: var(--dark);
            font-weight: 600;
            position: relative;
            padding-bottom: 0.5rem;
        }
        
        .charts-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: var(--secondary);
            border-radius: 2px;
        }
        
        .charts {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
        }
        
        .chart-box {
            width: 350px;
            height: 280px;
            background: white;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }
        
        .chart-box:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
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
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .btn-back:hover {
            background: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        /* Responsive adjustments */
        @media (max-width: 992px) {
            .chart-box {
                width: 300px;
            }
        }
        
        @media (max-width: 768px) {
            .stat-card {
                min-width: calc(50% - 20px);
            }
            
            .chart-box {
                width: 100%;
            }
        }
        
        @media (max-width: 576px) {
            .stat-card {
                min-width: 100%;
            }
            
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
                <i class="fas fa-chart-bar"></i> Admin Reports Dashboard
            </h1>
        </div>

        <!-- Summary Cards -->
        <div class="card-container">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h3>Total Users</h3>
                <p><%= totalUsers %></p>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-user-check"></i>
                </div>
                <h3>Active Users</h3>
                <p><%= activeUsers %></p>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3>Total Bookings</h3>
                <p><%= totalBookings %></p>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-rupee-sign"></i>
                </div>
                <h3>Total Revenue</h3>
                <p>₹<%= totalRevenue %></p>
            </div>
        </div>

        <!-- Charts -->
        <div class="charts-container">
            <h2 class="charts-title">Performance Analytics</h2>
            <div class="charts">
                <div class="chart-box">
                    <canvas id="bookingsChart"></canvas>
                </div>
                <div class="chart-box">
                    <canvas id="revenueChart"></canvas>
                </div>
                <div class="chart-box">
                    <canvas id="usersChart"></canvas>
                </div>
            </div>
        </div>
        
        <div class="text-center">
            <a href="adminPanel.jsp" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Admin Panel
            </a>
        </div>
    </div>

    <script>
        const months = <%= monthsJson %>;
        const bookings = <%= bookingsJson %>;
        const revenue = <%= revenueJson %>;
        const activeUsers = <%= activeUsers %>;
        const inactiveUsers = <%= totalUsers - activeUsers %>;

        // Bookings Chart (Bar)
        new Chart(document.getElementById("bookingsChart"), {
            type: "bar",
            data: {
                labels: months,
                datasets: [{
                    label: "Bookings",
                    data: bookings,
                    backgroundColor: "#3498db",
                    borderRadius: 8,
                    borderWidth: 0
                }]
            },
            options: {
                animation: { 
                    duration: 1800, 
                    easing: "easeOutBounce" 
                },
                plugins: { 
                    legend: { 
                        display: false 
                    },
                    title: {
                        display: true,
                        text: 'Monthly Bookings',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    }
                },
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            drawBorder: false
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });

        // Revenue Chart (Line)
        new Chart(document.getElementById("revenueChart"), {
            type: "line",
            data: {
                labels: months,
                datasets: [{
                    label: "Revenue (₹)",
                    data: revenue,
                    borderColor: "#2ecc71",
                    backgroundColor: "rgba(46, 204, 113, 0.1)",
                    tension: 0.4,
                    fill: true,
                    pointRadius: 5,
                    pointHoverRadius: 8,
                    pointBackgroundColor: "#2ecc71",
                    borderWidth: 3
                }]
            },
            options: {
                animation: { 
                    duration: 2000, 
                    easing: "easeInOutQuart" 
                },
                plugins: { 
                    legend: { 
                        display: false 
                    },
                    title: {
                        display: true,
                        text: 'Monthly Revenue',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    }
                },
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            drawBorder: false
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });

        // Users Chart (Doughnut)
        new Chart(document.getElementById("usersChart"), {
            type: "doughnut",
            data: {
                labels: ["Active Users", "Inactive Users"],
                datasets: [{
                    data: [activeUsers, inactiveUsers],
                    backgroundColor: ["#2ecc71", "#e74c3c"],
                    hoverOffset: 8,
                    borderWidth: 0
                }]
            },
            options: {
                animation: { 
                    animateRotate: true, 
                    animateScale: true, 
                    duration: 1800 
                },
                plugins: { 
                    legend: { 
                        position: "bottom",
                        labels: {
                            font: {
                                size: 12
                            }
                        }
                    },
                    title: {
                        display: true,
                        text: 'User Status Distribution',
                        font: {
                            size: 14,
                            weight: 'bold'
                        }
                    }
                },
                responsive: true,
                maintainAspectRatio: false,
                cutout: '60%'
            }
        });
    </script>
</body>
</html>