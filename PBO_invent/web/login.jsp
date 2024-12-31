<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - InventoriBarang</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .header {
            position: fixed;
            top: 0%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 30px;
            background: linear-gradient(90deg, #4b6cb7, #182848); 
            color: white;
            width: 100%;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .header img {
            height: 50px;
        }

        .header h1 {
            font-size: 28px;
            color: white;
        }
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #fff;
            animation: fadeInBg 0.5s ease-out;
        }
        
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            height: 100%; 
            min-height: 100%;
            background: inherit; 
            filter: blur(3px); 
            z-index: -1; 
        }

        .login-container {
            background: rgba(255, 255, 255, 0.85);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 400px;
            width: 100%;
            animation: zoomIn 1s ease-out;
        }

        .login-container h1 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            font-weight: 500;
            color: #333;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .btn-login {
            background-color: #4b6cb7;
            color: white;
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background-color: #182848;
            transform: scale(1.05);
        }

        .forgot-password {
            margin-top: 15px;
            font-size: 14px;
            color: #4b6cb7;
            cursor: pointer;
            text-decoration: none;
        }

        .forgot-password:hover {
            color: #182848;
        }

        .error-message {
            color: red;
            margin-top: 15px;
            font-size: 14px;
        }

        @keyframes fadeInBg {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <% 
        String status = request.getParameter("status");
    %>
    <div class="login-container">
        <h1>Login</h1>
        <% if ("error".equals(status)){%>
                <div class="alert alert-danger" role="alert">
                    Kredensial Error : Harap Masukkan Kredensial Dengan Benar
                </div>
                <script>
                setTimeout(() => {
                    window.location.href = 'login.jsp';
                }, 1500);
            </script>
        <%    } %>
        <form method="post" action="/login">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <!-- Dropdown for user type selection -->
            <div class="form-group">
                <label for="userType">User Type</label>
                <select id="userType" name="userType" required>
                    <option value="User">User</option>
                    <option value="Admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="btn-login">Login</button>
        </form>
        <a href="register.jsp" class="change-pass">Don't Have Account? Register</a>
    </div>
</body>
</html>