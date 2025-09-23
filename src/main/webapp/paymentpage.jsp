<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // ✅ Get booking details from session
    Integer bookingId = (Integer) session.getAttribute("bookingId");
    Double amount = (Double) session.getAttribute("amount");

    if (bookingId == null || amount == null) {
        response.sendRedirect("paymentsuccess.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Turf Booking - Payment</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary: #4ade80;
      --primary-dark: #22c55e;
      --primary-light: rgba(74, 222, 128, 0.1);
      --dark: #111827;
      --darker: #0a0e1a;
      --light: #d1fae5;
      --success: #166534;
      --danger: #dc2626;
      --danger-dark: #b91c1c;
      --card-bg: rgba(30, 41, 59, 0.95);
    }
    
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, var(--darker), var(--dark));
      color: #fff;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }
    
    .payment-container {
      max-width: 800px;
      background: var(--card-bg);
      border-radius: 20px;
      padding: 30px;
      box-shadow: 0 15px 40px rgba(0,0,0,0.6);
      border: 1px solid rgba(74, 222, 128, 0.1);
    }
    
    .page-header {
      text-align: center;
      margin-bottom: 30px;
      position: relative;
    }
    
    .page-header::after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 100px;
      height: 3px;
      background: var(--primary);
      border-radius: 3px;
    }
    
    h2 { 
      color: var(--primary); 
      margin-bottom: 10px; 
      font-weight: 700; 
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }
    
    .form-label {
      font-weight: 500;
      margin-bottom: 8px;
      color: var(--light);
    }
    
    .form-control, .form-select {
      background: rgba(255, 255, 255, 0.08);
      border: 1px solid rgba(74, 222, 128, 0.2);
      color: white;
      border-radius: 10px;
      padding: 12px 15px;
      transition: all 0.3s ease;
    }
    
    .form-control:focus, .form-select:focus {
      background: rgba(255, 255, 255, 0.12);
      border-color: var(--primary);
      box-shadow: 0 0 0 0.25rem rgba(74, 222, 128, 0.25);
      color: white;
    }
    
    .form-control::placeholder {
      color: rgba(255, 255, 255, 0.6);
    }
    .form-select option {
  background: #1e293b;   /* dark background for dropdown */
  color: #fff;           /* white text */
}
    .form-select option[value=""] {
  color: rgba(255, 255, 255, 0.6);
}
    
    
    .payment-option {
      display: flex; 
      align-items: center; 
      padding: 15px;
      background: #1e293b; 
      border-radius: 12px; 
      margin-bottom: 15px;
      cursor: pointer; 
      border: 2px solid transparent; 
      transition: all 0.3s;
    }
    
    .payment-option:hover { 
      transform: translateY(-3px); 
      background: #334155; 
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }
    
    .payment-option.selected {
      border-color: var(--primary); 
      background: var(--primary-light);
      box-shadow: 0 0 20px rgba(74, 222, 128, 0.4);
    }
    
    .btn-pay {
      background: linear-gradient(135deg, var(--primary), var(--primary-dark));
      border: none; 
      padding: 15px; 
      border-radius: 50px;
      font-weight: 600; 
      color: #000; 
      width: 100%; 
      margin-top: 20px;
      transition: all 0.3s ease;
      font-size: 1.1rem;
    }
    
    .btn-pay:hover { 
      transform: translateY(-3px); 
      color: #fff; 
      box-shadow: 0 8px 20px rgba(74, 222, 128, 0.4);
    }
    
    .payment-details {
      background: rgba(255, 255, 255, 0.05);
      border-radius: 12px;
      padding: 15px;
      margin-bottom: 20px;
    }
    
    .payment-method-section {
      background: rgba(255, 255, 255, 0.05);
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 20px;
    }
    
    .method-title {
      color: var(--primary);
      margin-bottom: 15px;
      font-weight: 600;
    }
    
    .amount-display {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--primary);
      text-align: center;
      margin: 15px 0;
      padding: 10px;
      background: rgba(74, 222, 128, 0.1);
      border-radius: 10px;
    }
    
    /* Responsive adjustments */
    @media (max-width: 768px) {
      body {
        padding: 10px;
        align-items: flex-start;
      }
      
      .payment-container {
        padding: 20px;
        max-width: 100%;
        border-radius: 15px;
      }
      
      h2 {
        font-size: 1.5rem;
      }
      
      .form-control, 
      select, 
      .btn-pay {
        font-size: 0.95rem;
        padding: 12px;
      }
      
      .payment-option {
        flex-direction: row;
        font-size: 0.95rem;
        padding: 12px;
      }

      #qrCode {
        width: 150px;
      }
    }
  </style>
</head>
<body>
  <div class="payment-container">
    <div class="page-header">
      <h2><i class="bi bi-credit-card-fill"></i> Complete Your Payment</h2>
    </div>

    <form id="paymentForm" action="PaymentServlet" method="post">
      <input type="hidden" name="booking_id" value="${bookingId}">
      <input type="hidden" name="payment_method" id="payment_method">
      
      <div class="row">
        <div class="col-md-6 mb-3">
          <label class="form-label">Full Name</label>
          <input type="text" name="name" class="form-control" placeholder="Enter your full name" required>
        </div>
        <div class="col-md-6 mb-3">
          <label class="form-label">Phone Number</label>
        <input type="text" name="phone" id="phone" class="form-control" 
       placeholder="Enter your phone number" 
       maxlength="10" required>

        </div>
      </div>
      
      <div class="mb-3">
        <label class="form-label">Email Address</label>
        <input type="email" name="email" class="form-control" placeholder="Enter your email address" required>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label class="form-label">Duration (hours)</label>
          <input type="number" id="duration" name="duration" class="form-control" placeholder="Duration in hours" min="1" required>
        </div>
        <div class="col-md-6 mb-3">
          <label class="form-label">Time Slot</label>
          <select id="slot" name="slot" class="form-select" required>
            <option value="">-- Select Slot --</option>
            <option value="00:00">00:00 - 01:00</option>
            <option value="01:00">01:00 - 02:00</option>
            <option value="02:00">02:00 - 03:00</option>
            <option value="03:00">03:00 - 04:00</option>
            <option value="04:00">04:00 - 05:00</option>
            <option value="05:00">05:00 - 06:00</option>
            <option value="06:00">06:00 - 07:00</option>
            <option value="07:00">07:00 - 08:00</option>
            <option value="08:00">08:00 - 09:00</option>
            <option value="09:00">09:00 - 10:00</option>
            <option value="10:00">10:00 - 11:00</option>
            <option value="11:00">11:00 - 12:00</option>
            <option value="12:00">12:00 - 13:00</option>
            <option value="13:00">13:00 - 14:00</option>
            <option value="14:00">14:00 - 15:00</option>
            <option value="15:00">15:00 - 16:00</option>
            <option value="16:00">16:00 - 17:00</option>
            <option value="17:00">17:00 - 18:00</option>
            <option value="18:00">18:00 - 19:00</option>
            <option value="19:00">19:00 - 20:00</option>
            <option value="20:00">20:00 - 21:00</option>
            <option value="21:00">21:00 - 22:00</option>
            <option value="22:00">22:00 - 23:00</option>
            <option value="23:00">23:00 - 00:00</option>
          </select>
        </div>
      </div>

      <div class="amount-display">
        Amount: ₹<span id="amount">0</span>
      </div>
<input type="hidden" name="amount" id="amountInput">

      <!-- Payment Options -->
      <div class="payment-method-section">
        <h5 class="method-title">Select Payment Method</h5>
        
        <div class="payment-option" onclick="selectPayment('UPI')">
          <i class="bi bi-qr-code me-2"></i> UPI (Scan QR)
        </div>
        
        <div class="payment-option" onclick="selectPayment('CARD')">
          <i class="bi bi-credit-card me-2"></i> Debit/Credit Card
        </div>
        
        <div class="payment-option" onclick="selectPayment('CASH')">
          <i class="bi bi-cash-coin me-2"></i> Cash on Pay
        </div>

       <div id="upiSection" style="display:none; text-align:center; margin-top: 15px;">
  <h5>Scan QR to Pay</h5>
  <img id="qrCode" src="images/qrcodegenerator.jpg" alt="UPI QR Code" 
       style="width:200px; border:3px solid #4ade80; border-radius:12px; margin: 10px auto;">
  <p style="color: #ffffff;">Scan this QR code using any UPI app to complete payment</p>
</div>

        
        <div id="cardSection" style="display:none; margin-top: 15px;">
          <h5>Enter Card Details</h5>
          <input type="text" name="card_number" class="form-control mb-2" placeholder="Card Number">
          <div class="row">
            <div class="col-6">
              <input type="text" name="expiry" class="form-control mb-2" placeholder="MM/YY">
            </div>
            <div class="col-6">
              <input type="text" name="cvv" class="form-control mb-2" placeholder="CVV">
            </div>
          </div>
        </div>
        
        <div id="cashSection" style="display:none; margin-top: 15px;">
          <div class="alert alert-info">
            <i class="bi bi-info-circle"></i> Please pay cash at the turf counter when you arrive.
          </div>
        </div>
      </div>

      <button type="submit" class="btn-pay">
        <i class="bi bi-lock-fill me-2"></i>Confirm & Pay
      </button>
    </form>
  </div>

  <script>
    function formatTime(hour) {
      return `${hour.toString().padStart(2, "0")}:00`;
    }

    function generateSlots(duration) {
      const slotSelect = document.getElementById("slot");
      slotSelect.innerHTML = '<option value="">-- Select Slot --</option>';
      
      for (let hour = 0; hour < 24; hour++) {
        if (hour + duration <= 24) {
          let start = formatTime(hour);
          let end = formatTime((hour + duration) % 24);
          if (hour + duration === 24) end = "00:00";
          
          slotSelect.innerHTML += `<option value="${start}">${start} - ${end} (${duration} hrs)</option>`;
        }
      }
    }

    function calculateAmount(startHour, duration) {
      const hour = parseInt(startHour.split(':')[0]);
      return (hour >= 6 && hour < 18) ? duration * 1000 : duration * 1200;
    }

    document.getElementById("duration").addEventListener("input", function () {
      const duration = parseInt(this.value);
      if (duration > 0) {
        generateSlots(duration);
        document.getElementById("amount").textContent = "0";
      }
    });

    document.getElementById("slot").addEventListener("change", function () {
      const duration = parseInt(document.getElementById("duration").value);
      const startHour = this.value;
      
      if (startHour && !isNaN(duration)) {
        const amount = calculateAmount(startHour, duration);
        document.getElementById("amount").textContent = amount;
      }
    });

    function selectPayment(method) {
      document.querySelectorAll('.payment-option').forEach(opt => opt.classList.remove('selected'));
      event.currentTarget.classList.add('selected');
      document.getElementById("payment_method").value = method;

      document.getElementById("upiSection").style.display = method === "UPI" ? "block" : "none";
      document.getElementById("cardSection").style.display = method === "CARD" ? "block" : "none";
      document.getElementById("cashSection").style.display = method === "CASH" ? "block" : "none";

      if (method === "UPI") {
    	  const amount = document.getElementById("amount").textContent;
    	  if (amount !== "0") {
    	    document.getElementById("qrCode").src = "images/qrcodegenerator.jpg";
    	  }
    	}

    }

    document.getElementById("paymentForm").addEventListener("submit", function (e) {
      const method = document.getElementById("payment_method").value;
      if (!method) {
        e.preventDefault();
        alert("Please select a payment method.");
      }
    });
 // Allow only digits while typing
    document.getElementById("phone").addEventListener("input", function () {
      this.value = this.value.replace(/[^0-9]/g, ""); // remove anything not a digit
    });

  </script>
</body>
</html>