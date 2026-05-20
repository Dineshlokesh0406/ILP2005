<%@ page import="java.sql.*" %>
<%@ page import="lms.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userId") == null || !"student".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?msg=Please login as student");
        return;
    }

    String search = request.getParameter("search");
    if (search == null) {
        search = "";
    }

    Connection con = DBConnection.getConnection();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f8; margin: 0; color: #222; }
        .top { background: #263238; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .top a { color: white; margin-left: 15px; text-decoration: none; }
        .container { width: 92%; margin: 20px auto; }
        .section { background: white; padding: 18px; margin-bottom: 18px; border-radius: 6px; box-shadow: 0 0 8px #ddd; }
        input, button { padding: 9px; margin: 6px 0; box-sizing: border-box; }
        input { width: 100%; }
        button { background: #2c7be5; color: white; border: 0; cursor: pointer; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; vertical-align: top; }
        th { background: #e9ecef; }
        .msg { color: #0a7f32; }
        .search input { width: 82%; }
        .search button { width: 16%; }
    </style>
</head>
<body>
    <div class="top">
        <div>Student Dashboard - Welcome <%= session.getAttribute("name") %></div>
        <div>
            <a href="student.jsp">Home</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="container">
        <p class="msg"><%= request.getParameter("msg") == null ? "" : request.getParameter("msg") %></p>

        <div class="section">
            <h3>Search Learning</h3>
            <form class="search" action="student.jsp" method="get">
                <input type="text" name="search" placeholder="Search by title or description" value="<%= search %>">
                <button type="submit">Search</button>
            </form>
        </div>

        <div class="section">
            <h3>View Learning</h3>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Link</th>
                </tr>
                <%
                    PreparedStatement ps = con.prepareStatement(
                        "select * from learning where title like ? or description like ? order by id desc");
                    ps.setString(1, "%" + search + "%");
                    ps.setString(2, "%" + search + "%");
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td>
                        <% if (rs.getString("link") != null && !rs.getString("link").equals("")) { %>
                            <a href="<%= rs.getString("link") %>" target="_blank">Open</a>
                        <% } %>
                    </td>
                </tr>
                <% } con.close(); %>
            </table>
        </div>

        <div class="section">
            <h3>Edit Profile</h3>
            <form action="ProfileServlet" method="post">
                <input type="text" name="name" value="<%= session.getAttribute("name") %>" required>
                <input type="email" name="email" value="<%= session.getAttribute("email") %>" required>
                <input type="password" name="password" placeholder="New or same password" required>
                <button type="submit">Update Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
