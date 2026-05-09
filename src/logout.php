<?php
session_start();

$_SESSION = array();

session_destroy();

foreach ($_COOKIE as $key => $value) {
    if ($key !== 'remember_username') {
        setcookie($key, '', time() - 3600, '/'); // Expire all other cookies
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Logout Successful - NoteApp</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  
  <!-- Font Awesome for icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
  
  <!-- jQuery and Bootstrap JS -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Poppins', sans-serif;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .logout-container {
      width: 100%;
      max-width: 450px;
      padding: 0 15px;
    }
    
    .logout-card {
      border-radius: 15px;
      border: none;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      overflow: hidden;
      animation: fadeIn 0.5s ease;
    }
    
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    
    .logout-header {
      background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
      color: white;
      padding: 2rem;
      text-align: center;
    }
    
    .logout-title {
      font-weight: 600;
      margin-bottom: 0;
    }
    
    .logout-body {
      padding: 2rem;
      text-align: center;
    }
    
    .timer-circle {
      width: 70px;
      height: 70px;
      border-radius: 50%;
      background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      font-weight: 600;
      margin: 1.5rem auto;
      box-shadow: 0 5px 15px rgba(106, 17, 203, 0.3);
    }
    
    .btn-login {
      background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
      border: none;
      border-radius: 8px;
      padding: 0.75rem 2rem;
      font-weight: 500;
      transition: all 0.3s ease;
      color: white;
      margin-top: 1rem;
    }
    
    .btn-login:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(106, 17, 203, 0.3);
    }
    
    .logout-icon {
      font-size: 3rem;
      color: #6a11cb;
      margin-bottom: 1rem;
    }
    
    .logout-message {
      color: #495057;
      margin-bottom: 1.5rem;
    }
    
    .login-link {
      color: #6a11cb;
      text-decoration: none;
      transition: color 0.3s ease;
      font-weight: 500;
    }
    
    .login-link:hover {
      color: #2575fc;
      text-decoration: underline;
    }
    
    #timer {
      font-weight: 600;
      color: #6a11cb;
    }
  </style>
  
  <script>
    let timeLeft = 10;
    function countdown() {
      if (timeLeft > 0) {
        document.getElementById("timer").innerText = timeLeft;
        timeLeft--;
        setTimeout(countdown, 1000);
      } else {
        window.location.href = "login.php";
      }
    }
    window.onload = countdown;
  </script>
</head>

<body>
  <div class="logout-container">
    <div class="card logout-card">
      <div class="logout-header">
        <h3 class="logout-title">NoteApp</h3>
        <p class="mb-0">You've been logged out</p>
      </div>
      
      <div class="logout-body">
        <i class="fas fa-sign-out-alt logout-icon"></i>
        
        <h4>Logout Successful</h4>
        
        <p class="logout-message">Your account has been securely logged out. Thank you for using NoteApp.</p>
        
        <div class="timer-circle">
          <span id="timer">10</span>
        </div>
        
        <p>You will be redirected to login in <span id="text-timer">10</span> seconds</p>
        
        <a href="login.php" class="btn btn-login">
          <i class="fas fa-sign-in-alt mr-2"></i> Login Again
        </a>
        
        <p class="mt-3">
          Don't have an account? <a href="signup.php" class="login-link">Sign up here</a>
        </p>
      </div>
    </div>
  </div>

  <script>
    // Update text timer as well
    let textTimeLeft = 10;
    function textCountdown() {
      if (textTimeLeft > 0) {
        document.getElementById("text-timer").innerText = textTimeLeft;
        textTimeLeft--;
        setTimeout(textCountdown, 1000);
      }
    }
    window.onload = function() {
      countdown();
      textCountdown();
    };
  </script>
</body>
</html>