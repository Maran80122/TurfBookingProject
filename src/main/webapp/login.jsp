<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <% 
        String error = request.getParameter("error");
        if ("1".equals(error)) {
    %>
        <p class="error">❌ Invalid email or password!</p>
    <% 
        }
    %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Turf Booking - Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

  <style>
    body {
      margin:0; font-family:'Poppins',sans-serif; height:100vh;
      display:flex; align-items:center; justify-content:center;
      overflow:hidden;
    }
    .bg-slide {
      position:fixed; top:0; left:0; width:100%; height:100%;
      background-size:cover; background-position:center;
      opacity:0; transform:scale(1);
      transition:opacity 2s ease-in-out, transform 8s ease;
      z-index:-1;
    }
    .bg-slide.active { opacity:1; transform:scale(1.1); }

    .auth-card {
      width:100%; max-width:400px;
      background:rgba(0,0,0,0.55);
      padding:20px; border-radius:15px; color:#fff;
      backdrop-filter:blur(10px);
      box-shadow:0 8px 30px rgba(0,0,0,0.6);
      animation: floatUp 1s ease-out forwards;
    }
    @keyframes floatUp {
      from {opacity:0; transform:translateY(40px);}
      to {opacity:1; transform:translateY(0);}
    }

    .auth-card h2 { text-align:center; margin-bottom:12px; font-weight:700; color:#00ffae; }
    .input-group-text { background:rgba(0,0,0,0.1); border:none; color:#00ffae; }
    .form-control { border-radius:30px; background:rgba(255,255,255,0.1); color:#fff; transition:0.3s; }
    .form-control:focus { box-shadow:0 0 12px #00ffae; transform:scale(1.03); }
    .btn-custom { width:100%; border-radius:30px; background:linear-gradient(45deg,#00ffae,#00a86b); color:#fff; font-weight:600; transition:0.3s; }
    .btn-custom:hover { background:linear-gradient(45deg,#00a86b,#00774f); transform:scale(1.07); box-shadow:0 0 15px #00ffae; }
    .toggle-link { display:block; text-align:center; margin-top:10px; color:#00ffae; cursor:pointer; transition:0.3s; }
    .toggle-link:hover { color:#fff; text-shadow:0 0 10px #00ffae; letter-spacing:1px; }
    .hidden { display:none; }

    /* ✅ Responsive for mobile view */
    @media (max-width: 768px) {
      body {
        padding: 20px;
        align-items: flex-start;
      }
      .auth-card {
        max-width: 100%;
        margin-top: 60px;
        padding: 15px;
      }
      .auth-card h2 {
        font-size: 1.4rem;
      }
      .form-control {
        font-size: 0.9rem;
      }
      .btn-custom {
        font-size: 0.9rem;
        padding: 8px;
      }
    }

    /* ✅ Large desktop optimization */
    @media (min-width: 1200px) {
      .auth-card {
        max-width: 450px;
        padding: 30px;
      }
      .auth-card h2 {
        font-size: 2rem;
      }
      .form-control {
        font-size: 1rem;
      }
      .btn-custom {
        font-size: 1rem;
        padding: 12px;
      }
    }
</style>

</head>
<body>
  <!-- Background slides -->
  <div class="bg-slide" style="background-image:url('https://wallpapers.com/images/featured/football-players-hd-emqpbm760h1avxrx.jpg')"></div>
  <div class="bg-slide" style="background-image:url('https://i.pinimg.com/1200x/bc/9c/cf/bc9ccf9190df25d134722842046691b7.jpg')"></div>
  <div class="bg-slide" style="background-image:url('https://wallpaperaccess.com/full/1884497.jpg')"></div>
  <div class="bg-slide" style="background-image:url('https://i.pinimg.com/1200x/12/53/50/125350cbb25384010054cb95962975ba.jpg')"></div>
  <div class="bg-slide" style="background-image:url('https://i.pinimg.com/736x/d1/a1/61/d1a1617521aa6453eb9005f20dbbd5dd.jpg')"></div>

  <div class="auth-card">
    <h2 id="formTitle">User Login</h2>

    <!-- User Login Form -->
    <form action="LoginServlet" method="post">

      <div class="mb-2 input-group">
        <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
        <input type="email" name="email" class="form-control" placeholder="User Email" required>
      </div>
      <div class="mb-2 input-group">
        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
        <input type="password" name="password" class="form-control" placeholder="Password" required>
      </div>
      <button type="submit" class="btn btn-custom">Login</button>
    </form>

    <!-- Admin Login Form (hidden by default) -->
    <form id="admin" class="hidden" action="adminlogin" method="post">
      <div class="mb-2 input-group">
        <span class="input-group-text"><i class="bi bi-person-badge-fill"></i></span>
        <input type="text" name="username" class="form-control" placeholder="Admin Username" required>
      </div>
      <div class="mb-2 input-group">
        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
        <input type="password" name="password" class="form-control" placeholder="Admin Password" required>
      </div>
      <button type="submit" class="btn btn-custom">Admin Login</button>
    </form>


   <!-- Toggle Links -->
<a class="toggle-link" href="adminlogin.html">Admin Login</a>
<a href="register.html" class="toggle-link">Don’t have an account? Register</a>

  </div>

  <script>
    // Background slideshow
    document.addEventListener("DOMContentLoaded", () => {
      const slides = document.querySelectorAll(".bg-slide");
      let current = 0;
      slides[current].classList.add("active");
      setInterval(() => {
        slides[current].classList.remove("active");
        current = (current + 1) % slides.length;
        slides[current].classList.add("active");
      }, 6000);
    });

    // Toggle between User and Admin login
    const toggleAdmin = document.getElementById("toggleAdmin");
    const userForm = document.getElementById("userForm");
    const adminForm = document.getElementById("adminForm");
    const formTitle = document.getElementById("formTitle");

    toggleAdmin.addEventListener("click", () => {
      if (adminForm.classList.contains("hidden")) {
        userForm.classList.add("hidden");
        adminForm.classList.remove("hidden");
        formTitle.innerText = "Admin Login";
        toggleAdmin.innerText = "Back to User Login";
      } else {
        adminForm.classList.add("hidden");
        userForm.classList.remove("hidden");
        formTitle.innerText = "User Login";
        toggleAdmin.innerText = "Admin Login";
      }
    });
  </script>
</body>
</html>
