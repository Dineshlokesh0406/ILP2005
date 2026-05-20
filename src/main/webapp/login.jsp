<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LMS Login</title>
    <style>
        body { font-family: Arial, sans-serif; background: #eef2f3; margin: 0; }
        .box { width: 360px; margin: 80px auto; background: white; padding: 25px; border-radius: 6px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; color: #2c3e50; }
        input, button { width: 100%; padding: 10px; margin: 8px 0; box-sizing: border-box; }
        button { background: #2c7be5; color: white; border: 0; cursor: pointer; }
        a { color: #2c7be5; text-decoration: none; }
        .msg { color: #c0392b; text-align: center; }
    </style>
</head>
<body>
    <div class="box">
        <h2>Learning Management System</h2>
        <p class="msg"><%= request.getParameter("msg") == null ? "" : request.getParameter("msg") %></p>

        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>

        <p>New user? <a href="register.jsp">Register here</a></p>
    </div>
</body>
</html>
