<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Payment Successful</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }
    
    .container {
      max-width: 500px;
      width: 100%;
      background: white;
      border-radius: 20px;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      text-align: center;
      animation: fadeIn 0.5s ease-out;
    }
    
    .header {
      background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%);
      padding: 30px 20px;
      color: white;
    }
    
    .checkmark-container {
      width: 80px;
      height: 80px;
      background: white;
      border-radius: 50%;
      margin: 0 auto;
      display: flex;
      justify-content: center;
      align-items: center;
      animation: scaleIn 0.5s ease-out;
    }
    
    .checkmark {
      color: #4CAF50;
      font-size: 50px;
    }
    
    .content {
      padding: 30px;
    }
    
    h1 {
      font-size: 28px;
      margin-bottom: 15px;
      color: #2E7D32;
    }
    
    p {
      font-size: 18px;
      color: #555;
      margin: 20px 0;
      line-height: 1.6;
    }
    
    .booking-id {
      font-size: 22px;
      font-weight: bold;
      color: #2E7D32;
      background: #f0f9f0;
      padding: 12px 20px;
      border-radius: 10px;
      display: inline-block;
      margin: 15px 0;
      border: 2px dashed #4CAF50;
    }
    
    .booking-details {
      background: #f9f9f9;
      border-radius: 10px;
      padding: 20px;
      margin: 20px 0;
      text-align: left;
    }
    
    .booking-details h3 {
      color: #2E7D32;
      margin-bottom: 15px;
      text-align: center;
    }
    
    .detail-row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 10px;
      padding-bottom: 10px;
      border-bottom: 1px solid #eee;
    }
    
    .detail-label {
      font-weight: 600;
      color: #555;
    }
    
    .detail-value {
      color: #333;
    }
    
    .button-container {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin-top: 25px;
      flex-wrap: wrap;
    }
    
    .home-button, .dashboard-button {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 14px 25px;
      color: white;
      text-decoration: none;
      border-radius: 50px;
      font-weight: 600;
      transition: all 0.3s ease;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }
    
    .home-button {
      background: #4CAF50;
    }
    
    .dashboard-button {
      background: #2196F3;
    }
    
    .home-button:hover {
      background: #388E3C;
      transform: translateY(-3px);
      box-shadow: 0 7px 20px rgba(76, 175, 80, 0.4);
    }
    
    .dashboard-button:hover {
      background: #1976D2;
      transform: translateY(-3px);
      box-shadow: 0 7px 20px rgba(33, 150, 243, 0.4);
    }
    
    .home-button:active, .dashboard-button:active {
      transform: translateY(0);
    }
    
    .confetti {
      position: absolute;
      width: 10px;
      height: 10px;
      background-color: #f39c12;
      opacity: 0;
      z-index: -1;
    }
    
    .features {
      display: flex;
      justify-content: space-around;
      margin: 30px 0;
      flex-wrap: wrap;
    }
    
    .feature {
      flex-basis: 30%;
      padding: 15px;
    }
    
    .feature i {
      font-size: 30px;
      color: #4CAF50;
      margin-bottom: 10px;
    }
    
    .feature p {
      font-size: 14px;
      margin: 0;
    }
    
    footer {
      margin-top: 30px;
      color: #777;
      font-size: 14px;
    }
    
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    
    @keyframes scaleIn {
      from { transform: scale(0); }
      to { transform: scale(1); }
    }
    
    @keyframes pulse {
      0% { transform: scale(1); }
      50% { transform: scale(1.05); }
      100% { transform: scale(1); }
    }
    
    @media (max-width: 500px) {
      .container {
        border-radius: 15px;
      }
      
      .header {
        padding: 20px 15px;
      }
      
      .content {
        padding: 20px 15px;
      }
      
      .features {
        flex-direction: column;
      }
      
      .button-container {
        flex-direction: column;
        align-items: center;
      }
      
      .home-button, .dashboard-button {
        width: 100%;
        justify-content: center;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <div class="checkmark-container">
        <i class="checkmark fas fa-check"></i>
      </div>
    </div>
    
    <div class="content">
      <h1>Payment Successful!</h1>
      <p>Thank you for your booking. Your payment has been processed successfully.</p>
      
      <div class="booking-id">
        <i class="fas fa-ticket-alt"></i>
        Booking ID: <span id="bookingIdDisplay">Generating...</span>
      </div>
      
      <div class="booking-details">
        <h3>Booking Details</h3>
        <div class="detail-row">
          <span class="detail-label">Date:</span>
          <span class="detail-value" id="bookingDate">Loading...</span>
        </div>
        <div class="detail-row">
          <span class="detail-label">Time Slot:</span>
          <span class="detail-value" id="bookingTime">Loading...</span>
        </div>
        <div class="detail-row">
          <span class="detail-label">Turf Name:</span>
          <span class="detail-value" id="turfName">Loading...</span>
        </div>
        <div class="detail-row">
          <span class="detail-label">Amount Paid:</span>
          <span class="detail-value" id="amountPaid">Loading...</span>
        </div>
      </div>
      
      <div class="features">
        <div class="feature">
          <i class="fas fa-envelope"></i>
          <p>Confirmation Sent</p>
        </div>
        <div class="feature">
          <i class="fas fa-calendar-check"></i>
          <p>Booking Confirmed</p>
        </div>
        <div class="feature">
          <i class="fas fa-headset"></i>
          <p>Support 24/7</p>
        </div>
      </div>
      
      <p>We've sent a confirmation email with your booking details. Your booking is now marked as <b>PAID</b> and is pending admin approval.</p>
      
      <div class="button-container">
        <a href="turf1.html" class="home-button">
          <i class="fas fa-home"></i> Go Home
        </a>
        <a href="userdashboard.jsp" class="dashboard-button">
          <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
      </div>
      
      <footer>
        <p>Need help? Contact us: support@turfbooking.com</p>
      </footer>
    </div>
  </div>

  <script>
    // Function to generate a unique booking ID
    function generateBookingId() {
      const timestamp = Date.now().toString(36); // Base36 timestamp
      const randomStr = Math.random().toString(36).substr(2, 5).toUpperCase(); // Random string
      return `TB-${timestamp}-${randomStr}`;
    }
    
    // Function to get URL parameters
    function getUrlParameter(name) {
      name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
      const regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
      const results = regex.exec(location.search);
      return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }
    
    // Function to format date
    function formatDate(dateString) {
      const options = { year: 'numeric', month: 'long', day: 'numeric' };
      return new Date(dateString).toLocaleDateString(undefined, options);
    }
    
    // Function to format time
    function formatTime(timeString) {
      return timeString; // You can enhance this to format time as needed
    }
    
    // Function to format currency
    function formatCurrency(amount) {
      return new Intl.NumberFormat('en-IN', {
        style: 'currency',
        currency: 'INR'
      }).format(amount);
    }
    
    document.addEventListener('DOMContentLoaded', function() {
      // Generate and display booking ID
      const bookingId = generateBookingId();
      document.getElementById('bookingIdDisplay').textContent = bookingId;
      
      // Get booking details from URL parameters or use defaults
      const bookingDate = getUrlParameter('booking_date') || new Date().toISOString().split('T')[0];
      const bookingTime = getUrlParameter('booking_time') || '18:00 - 19:00';
      const turfName = getUrlParameter('turf_name') || 'Premium Turf Arena';
      const amount = getUrlParameter('amount') || 1500;
      
      // Display booking details
      document.getElementById('bookingDate').textContent = formatDate(bookingDate);
      document.getElementById('bookingTime').textContent = bookingTime;
      document.getElementById('turfName').textContent = turfName;
      document.getElementById('amountPaid').textContent = formatCurrency(amount);
      
      // Add animation to booking ID
      const bookingIdElement = document.querySelector('.booking-id');
      bookingIdElement.style.animation = 'pulse 1s ease-in-out';
      
      // Create confetti effect
      const colors = ['#4CAF50', '#f39c12', '#e74c3c', '#3498db', '#9b59b6'];
      
      for (let i = 0; i < 50; i++) {
        const confetti = document.createElement('div');
        confetti.className = 'confetti';
        confetti.style.left = Math.random() * 100 + 'vw';
        confetti.style.top = Math.random() * 100 + 'vh';
        confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
        confetti.style.transform = `rotate(${Math.random() * 360}deg)`;
        document.body.appendChild(confetti);
        
        // Animate confetti
        setTimeout(() => {
          confetti.style.transition = 'opacity 1s, transform 2s';
          confetti.style.opacity = '1';
          confetti.style.transform += ' translateY(-100px)';
          
          // Remove confetti after animation
          setTimeout(() => {
            confetti.style.opacity = '0';
            setTimeout(() => confetti.remove(), 1000);
          }, 2000);
        }, i * 50);
      }
      
      // Log booking details (in a real app, you would send this to your server)
      console.log('Booking confirmed with ID:', bookingId);
      console.log('Booking details:', {
        date: bookingDate,
        time: bookingTime,
        turf: turfName,
        amount: amount
      });
    });
  </script>
</body>
</html>

<%---  <h2 style="color:green;">🎉 Payment Successful!</h2>
  <p>Your booking is now marked as <b>PAID</b>.</p>
  <p>Please wait for admin approval ✅</p>
  <a href="userdashboard.jsp">Go Back to Dashboard</a>--%>  