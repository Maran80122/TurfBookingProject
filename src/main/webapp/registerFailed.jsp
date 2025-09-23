<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registration Failed</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }
    
    body {
      background: linear-gradient(135deg, #200122, #6f0000);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
      color: #fff;
    }
    
    .container {
      max-width: 500px;
      width: 100%;
      background: rgba(255, 255, 255, 0.08);
      backdrop-filter: blur(12px);
      border-radius: 20px;
      padding: 40px 30px;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      text-align: center;
      position: relative;
      overflow: hidden;
      animation: fadeIn 0.8s ease-out;
      border: 1px solid rgba(255, 0, 0, 0.2);
    }
    
    .container::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: linear-gradient(
        45deg,
        transparent, 
        rgba(255, 0, 0, 0.1), 
        rgba(255, 69, 0, 0.2)
      );
      transform: rotate(0deg);
      animation: rotate 10s linear infinite;
      z-index: -1;
    }
    
    .error-icon {
      width: 100px;
      height: 100px;
      background: linear-gradient(135deg, #ff416c, #ff4b2b);
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0 auto 25px;
      animation: shake 0.5s ease-in-out;
      box-shadow: 0 0 30px rgba(255, 0, 0, 0.5);
    }
    
    .error-icon i {
      font-size: 50px;
      color: #fff;
    }
    
    h2 {
      font-size: 32px;
      margin-bottom: 15px;
      font-weight: 600;
      background: linear-gradient(to right, #fff, #ff416c);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      text-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }
    
    .error-message {
      font-size: 18px;
      margin-bottom: 30px;
      color: #ffcccc;
      line-height: 1.6;
      padding: 15px;
      background: rgba(255, 0, 0, 0.1);
      border-radius: 10px;
      border-left: 4px solid #ff416c;
    }
    
    .btn-try-again {
      display: inline-block;
      padding: 14px 35px;
      background: linear-gradient(135deg, #ff416c, #ff4b2b);
      color: #fff;
      text-decoration: none;
      border-radius: 50px;
      font-weight: 600;
      font-size: 18px;
      transition: all 0.3s ease;
      box-shadow: 0 5px 15px rgba(255, 75, 43, 0.4);
      position: relative;
      overflow: hidden;
      border: none;
      cursor: pointer;
    }
    
    .btn-try-again:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(255, 75, 43, 0.6);
    }
    
    .btn-try-again:active {
      transform: translateY(0);
    }
    
    .btn-try-again::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(
        90deg,
        transparent,
        rgba(255, 255, 255, 0.4),
        transparent
      );
      transition: 0.5s;
    }
    
    .btn-try-again:hover::before {
      left: 100%;
    }
    
    .support {
      margin-top: 30px;
      color: #ff9999;
      font-size: 14px;
    }
    
    .error-details {
      margin-top: 20px;
      padding: 15px;
      background: rgba(0, 0, 0, 0.2);
      border-radius: 10px;
      font-size: 14px;
    }
    
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    
    @keyframes shake {
      0% { transform: translateX(0); }
      20% { transform: translateX(-10px); }
      40% { transform: translateX(10px); }
      60% { transform: translateX(-10px); }
      80% { transform: translateX(10px); }
      100% { transform: translateX(0); }
    }
    
    @keyframes rotate {
      from { transform: rotate(0deg); }
      to { transform: rotate(360deg); }
    }
    
    .error-particles {
      position: absolute;
      width: 8px;
      height: 8px;
      background-color: #ff416c;
      border-radius: 50%;
      opacity: 0;
      z-index: -1;
    }
    
    @media (max-width: 768px) {
      .container {
        padding: 30px 20px;
        border-radius: 15px;
      }
      
      h2 {
        font-size: 28px;
      }
      
      .error-message {
        font-size: 16px;
      }
      
      .error-icon {
        width: 80px;
        height: 80px;
      }
      
      .error-icon i {
        font-size: 40px;
      }
      
      .btn-try-again {
        padding: 12px 30px;
        font-size: 16px;
      }
    }
    
    @media (max-width: 480px) {
      h2 {
        font-size: 24px;
      }
      
      .error-icon {
        width: 70px;
        height: 70px;
      }
      
      .error-icon i {
        font-size: 35px;
      }
      
      .btn-try-again {
        padding: 10px 25px;
        font-size: 15px;
      }
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="error-icon">
      <i class="fas fa-times"></i>
    </div>
    
    <h2>Registration Failed</h2>
    
    <div class="error-message">
      <%= request.getAttribute("message") != null ? request.getAttribute("message") : "Something went wrong. Please try again." %>
    </div>
    
    <p>We encountered an issue while processing your registration.</p>
    
    <a href="register.html" class="btn-try-again">
      <i class="fas fa-arrow-left"></i> Try Again
    </a>
    
    <div class="support">
      <p>Need help? Contact support@example.com</p>
    </div>
    
    <div class="error-details">
      <p><i class="fas fa-lightbulb"></i> Tip: Check if all required fields are filled correctly</p>
    </div>
  </div>

  <script>
    // Create error particles effect
    document.addEventListener('DOMContentLoaded', function() {
      const colors = ['#ff416c', '#ff4b2b', '#ff0000', '#8b0000'];
      
      for (let i = 0; i < 30; i++) {
        setTimeout(() => {
          const particle = document.createElement('div');
          particle.className = 'error-particles';
          particle.style.left = Math.random() * 100 + 'vw';
          particle.style.top = Math.random() * 100 + 'vh';
          particle.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
          document.body.appendChild(particle);
          
          // Animate particles
          setTimeout(() => {
            particle.style.transition = 'opacity 1s, transform 2s';
            particle.style.opacity = '0.7';
            particle.style.transform = 'translateY(-40px)';
            
            // Remove particles after animation
            setTimeout(() => {
              particle.style.opacity = '0';
              setTimeout(() => particle.remove(), 1000);
            }, 2000);
          }, 10);
        }, i * 200);
      }
    });
  </script>
</body>
</html>