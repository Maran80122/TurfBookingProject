<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful</title>
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
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: #fff;
        }
        
        .container {
            max-width: 600px;
            width: 100%;
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
            border: 1px solid rgba(255, 255, 255, 0.1);
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
                rgba(0, 255, 174, 0.1), 
                rgba(0, 255, 174, 0.2)
            );
            transform: rotate(0deg);
            animation: rotate 10s linear infinite;
            z-index: -1;
        }
        
        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #00ffae, #00cc8b);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 25px;
            animation: scaleIn 0.5s ease-out;
            box-shadow: 0 0 30px rgba(0, 255, 174, 0.5);
        }
        
        .success-icon i {
            font-size: 50px;
            color: #fff;
        }
        
        h2 {
            font-size: 32px;
            margin-bottom: 15px;
            font-weight: 600;
            background: linear-gradient(to right, #fff, #00ffae);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        p {
            font-size: 18px;
            margin-bottom: 30px;
            color: #e0e0e0;
            line-height: 1.6;
        }
        
        .login-btn {
            display: inline-block;
            padding: 14px 35px;
            background: linear-gradient(135deg, #00ffae, #00cc8b);
            color: #111;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 18px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 255, 174, 0.4);
            position: relative;
            overflow: hidden;
        }
        
        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 255, 174, 0.6);
        }
        
        .login-btn:active {
            transform: translateY(0);
        }
        
        .login-btn::before {
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
        
        .login-btn:hover::before {
            left: 100%;
        }
        
        .features {
            display: flex;
            justify-content: space-around;
            margin: 40px 0 30px;
            flex-wrap: wrap;
        }
        
        .feature {
            flex-basis: 30%;
            padding: 15px;
            min-width: 150px;
        }
        
        .feature i {
            font-size: 30px;
            color: #00ffae;
            margin-bottom: 10px;
        }
        
        .feature p {
            font-size: 14px;
            margin: 0;
        }
        
        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background-color: #00ffae;
            opacity: 0;
            z-index: -1;
        }
        
        footer {
            margin-top: 30px;
            color: #aaa;
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
        
        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                border-radius: 15px;
            }
            
            h2 {
                font-size: 28px;
            }
            
            p {
                font-size: 16px;
            }
            
            .success-icon {
                width: 80px;
                height: 80px;
            }
            
            .success-icon i {
                font-size: 40px;
            }
            
            .features {
                flex-direction: column;
                align-items: center;
            }
            
            .feature {
                margin-bottom: 20px;
            }
            
            .login-btn {
                padding: 12px 30px;
                font-size: 16px;
            }
        }
        
        @media (max-width: 480px) {
            h2 {
                font-size: 24px;
            }
            
            .success-icon {
                width: 70px;
                height: 70px;
            }
            
            .success-icon i {
                font-size: 35px;
            }
            
            .login-btn {
                padding: 10px 25px;
                font-size: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">
            <i class="fas fa-check"></i>
        </div>
        
        <h2>Registration Successful!</h2>
        <p>Your account has been created successfully. You can now access all features.</p>
        
        <div class="features">
            <div class="feature">
                <i class="fas fa-user-shield"></i>
                <p>Secure Account</p>
            </div>
            <div class="feature">
                <i class="fas fa-bolt"></i>
                <p>Instant Access</p>
            </div>
            <div class="feature">
                <i class="fas fa-headset"></i>
                <p>24/7 Support</p>
            </div>
        </div>
        
        <a href="login.jsp" class="login-btn">
            <i class="fas fa-sign-in-alt"></i> Login Now
        </a>
        
        <footer>
            <p>Need help? Contact support@example.com</p>
        </footer>
    </div>

    <script>
        // Create confetti effect
        document.addEventListener('DOMContentLoaded', function() {
            const colors = ['#00ffae', '#f39c12', '#e74c3c', '#3498db', '#9b59b6'];
            
            for (let i = 0; i < 50; i++) {
                setTimeout(() => {
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
                    }, 10);
                }, i * 100);
            }
        });
    </script>
</body>
</html>