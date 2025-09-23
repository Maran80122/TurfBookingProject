<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <!-- Show error if exists -->
    <%
        String errorMsg = (String) request.getAttribute("errorMsg");
        if (errorMsg != null) {
    %>
        <p style="color:red;"><%= errorMsg %></p>
    <% } %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Turf Booking - Register</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<style>
  /* 🔥 Your styles remain unchanged */
  body {
    margin:0;
    font-family:'Poppins',sans-serif;
    height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    overflow:hidden;
    position:relative;
    background:#111;
  }
  .bg-slide { position: fixed; top: 0; left: 0; width: 100%; height: 100%;
    background-size: cover; background-position: center; z-index: -1; opacity: 0;
    transform: scale(1); transition: opacity 2s ease-in-out, transform 20s ease; }
  .bg-slide.active { opacity: 1; transform: scale(1.1); }
  .auth-card { width:100%; max-width:400px; padding:30px 25px; border-radius:20px;
    background: rgba(255,255,255,0.1); backdrop-filter: blur(15px);
    box-shadow: 0 8px 32px rgba(0, 255, 174, 0.2); color:#fff; z-index:10;
    position:relative; border: 1px solid rgba(0,255,174,0.3);
    transition: transform 0.3s ease, box-shadow 0.3s ease; }
  .auth-card:hover { transform: translateY(-5px); box-shadow: 0 12px 40px rgba(0,255,174,0.4); }
  .auth-card h2 { text-align:center; margin-bottom:20px; font-weight:700;
    font-size:28px; color:#00ffae; text-shadow: 0 0 8px rgba(0,255,174,0.8); }
  .input-group-text { background:rgba(255,255,255,0.2); border:none; color:#00ffae; }
  .form-control { border-radius:30px; background: rgba(255,255,255,0.15); color:#fff;
    border: 1px solid rgba(0,255,174,0.3); transition: border 0.3s ease, box-shadow 0.3s ease; }
  .form-control:focus { border: 1px solid #00ffae; box-shadow: 0 0 10px #00ffae;
    outline:none; background: rgba(255,255,255,0.2); }
  .btn-custom { width:100%; border-radius:30px;
    background: linear-gradient(45deg,#00ffae,#00a86b); color:#fff; font-weight:600;
    transition: transform 0.3s ease, box-shadow 0.3s ease; }
  .btn-custom:hover { background: linear-gradient(45deg,#00a86b,#00774f);
    transform: translateY(-3px); box-shadow: 0 6px 20px rgba(0,255,174,0.5); }
  .toggle-link { display:block; text-align:center; margin-top:12px;
    color:#00ffae; cursor:pointer; transition: color 0.3s ease, text-shadow 0.3s ease; }
  .toggle-link:hover { color:#fff; text-shadow:0 0 10px #00ffae; }
  #passwordStrength { height:8px; border-radius:4px; margin-bottom:15px;
    transition: width 0.3s, background-color 0.3s; }
  #particles { position: fixed; top:0; left:0; width:100%; height:100%;
    pointer-events:none; z-index:5; }
  .particle { position:absolute; width:10px; height:10px; background: rgba(0,255,174,0.7);
    border-radius:50%; box-shadow: 0 0 10px rgba(0,255,174,0.7); animation: float 6s linear infinite; }
  @keyframes float { 0% { transform: translateY(0) translateX(0); opacity:1;}
    50% { transform: translateY(-50px) translateX(20px); opacity:0.7;}
    100% { transform: translateY(0) translateX(-20px); opacity:1;} }
  body::after { content:''; position: fixed; top:0; left:0; width:100%; height:100%;
    background: rgba(0,0,0,0.35); z-index: -1; }
</style>
</head>
<body>

<!-- Background slides -->
<div class="bg-slide" style="background-image:url('https://i.pinimg.com/736x/b3/fa/82/b3fa82b2585372b958b3d7ea7a9cd6ca.jpg');"></div>
<div class="bg-slide" style="background-image:url('https://i.pinimg.com/1200x/e2/b9/a5/e2b9a5c6a7daaa1943947b93e291b8c1.jpg');"></div>
<div class="bg-slide" style="background-image:url('https://i.pinimg.com/1200x/d8/72/c9/d872c9b7f38e2a68ad62f0ec44a75d9d.jpg');"></div>
<div class="bg-slide" style="background-image:url('https://i.pinimg.com/736x/0d/59/5b/0d595b7a6bf16171c27a58a4b23dd855.jpg');"></div>

<div class="auth-card">
  <h2>Register</h2>

  <!-- ✅ updated: form submits to backend -->
<form id="registerForm" action="register" method="post">


    <div class="mb-2 input-group">
      <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
      <input type="text" name="name" class="form-control" placeholder="Full Name" required>
    </div>
    <div class="mb-2 input-group">
      <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
      <input type="tel" name="phone" class="form-control" placeholder="Phone Number" required>
    </div>
    <div class="mb-2 input-group">
      <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
      <input type="email" name="email" id="email" class="form-control" placeholder="Email" required>
    </div>
    <div class="mb-2 input-group">
      <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
    <input type="password" name="password" id="password" class="form-control" placeholder="password" required>
   

    </div>

    <div id="passwordStrength"></div>

    <div class="mb-2 input-group">
      <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
      <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm Password" required>
    </div>
    <button type="submit" class="btn btn-custom">Register</button>
    <a href="login.html" class="toggle-link">Already have an account? Login</a>
  </form>
  <div id="particles"></div>
</div>

<script>
window.addEventListener('DOMContentLoaded', () => {
  // Background slideshow
  const slides = document.querySelectorAll('.bg-slide');
  let current = 0;
  slides[current].classList.add('active');
  setInterval(() => {
    slides[current].classList.remove('active');
    current = (current + 1) % slides.length;
    slides[current].classList.add('active');
  }, 7000);

  // Password strength
  const passwordInput = document.getElementById("password");
  const strengthBar = document.getElementById("passwordStrength");
  passwordInput.addEventListener("input", function() {
    const val = passwordInput.value;
    let score = 0;
    if(/[a-z]/.test(val)) score++;
    if(/[A-Z]/.test(val)) score++;
    if(/\d/.test(val)) score++;
    if(/[@$!%*?&]/.test(val)) score++;
    let width = (score/4)*100 + "%";
    let color = "#ff4c4c";
    if(score === 1) color = "#ff6b6b";
    if(score === 2) color = "#ffdd00";
    if(score >= 3) color = "#00ffae";
    strengthBar.style.width = width;
    strengthBar.style.backgroundColor = color;
  });

  // Client-side validation before submit
  document.getElementById("registerForm").addEventListener("submit", function(e){
    const pass = passwordInput.value;
    const confirm = document.getElementById("confirmPassword").value;
    const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;
    if(!regex.test(pass)){
      e.preventDefault();
      alert("❌ Password must be at least 8 characters, include uppercase, lowercase, number, and special character!");
      return;
    }
    if(pass !== confirm){
      e.preventDefault();
      alert("❌ Passwords do not match!");
      return;
    }
  });

  // Particle effect
  const particlesContainer = document.getElementById("particles");
  for(let i=0;i<30;i++){
    const p = document.createElement("div");
    p.classList.add("particle");
    p.style.left = Math.random()*100 + "%";
    p.style.top = Math.random()*100 + "%";
    p.style.width = 5 + Math.random()*10 + "px";
    p.style.height = 5 + Math.random()*10 + "px";
    p.style.animationDuration = 4 + Math.random()*4 + "s";
    particlesContainer.appendChild(p);
  }
});
</script>
</body>
</html>