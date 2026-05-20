<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>LMS Register</title>
    <style>
        body { font-family: Arial, sans-serif; background: #eef2f3; margin: 0; }
        .box { width: 380px; margin: 60px auto; background: white; padding: 25px; border-radius: 6px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; color: #2c3e50; }
        input, select, button { width: 100%; padding: 10px; margin: 8px 0; box-sizing: border-box; }
        button { background: #28a745; color: white; border: 0; cursor: pointer; }
        a { color: #2c7be5; text-decoration: none; }
        .msg { color: #c0392b; text-align: center; }
    </style>
</head>
<body>
    <div class="box">
        <h2>Register</h2>
        <p class="msg"><%= request.getParameter("msg") == null ? "" : request.getParameter("msg") %></p>

        <form action="RegisterServlet" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <select name="role" required>
                <option value="student">Student</option>
                <option value="admin">Admin</option>
            </select>
            <button type="submit">Register</button>
        </form>

        <p>Already registered? <a href="login.jsp">Login here</a></p>
    </div>
</body>
</html>
