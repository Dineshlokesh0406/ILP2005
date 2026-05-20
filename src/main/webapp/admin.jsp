<%@ page import="java.sql.*" %>
<%@ page import="lms.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userId") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp?msg=Please login as admin");
        return;
    }

    String search = request.getParameter("search");
    if (search == null) {
        search = "";
    }

    String editId = request.getParameter("editId");
    String editTitle = "";
    String editDescription = "";
    String editLink = "";

    Connection con = DBConnection.getConnection();
    if (editId != null) {
        PreparedStatement editPs = con.prepareStatement("select * from learning where id=?");
        editPs.setInt(1, Integer.parseInt(editId));
        ResultSet editRs = editPs.executeQuery();
        if (editRs.next()) {
            editTitle = editRs.getString("title");
            editDescription = editRs.getString("description");
            editLink = editRs.getString("link");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f6f8; margin: 0; color: #222; }
        .top { background: #263238; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .top a { color: white; margin-left: 15px; text-decoration: none; }
        .container { width: 92%; margin: 20px auto; }
        .section { background: white; padding: 18px; margin-bottom: 18px; border-radius: 6px; box-shadow: 0 0 8px #ddd; }
        input, textarea, button { padding: 9px; margin: 6px 0; box-sizing: border-box; }
        input, textarea { width: 100%; }
        textarea { height: 80px; }
        button { background: #2c7be5; color: white; border: 0; cursor: pointer; }
        .delete { background: #dc3545; }
        .edit { background: #28a745; padding: 8px 12px; color: white; text-decoration: none; }
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
        <div>Admin Dashboard - Welcome <%= session.getAttribute("name") %></div>
        <div>
            <a href="admin.jsp">Home</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="container">
        <p class="msg"><%= request.getParameter("msg") == null ? "" : request.getParameter("msg") %></p>

        <div class="section">
            <h3><%= editId == null ? "Add Learning" : "Update Learning" %></h3>
            <form action="LearningServlet" method="post">
                <input type="hidden" name="action" value="<%= editId == null ? "add" : "update" %>">
                <% if (editId != null) { %>
                    <input type="hidden" name="id" value="<%= editId %>">
                <% } %>
                <input type="text" name="title" placeholder="Learning Title" value="<%= editTitle %>" required>
                <textarea name="description" placeholder="Description" required><%= editDescription %></textarea>
                <input type="text" name="link" placeholder="Learning Link" value="<%= editLink %>">
                <button type="submit"><%= editId == null ? "Add Learning" : "Update Learning" %></button>
                <% if (editId != null) { %>
                    <a href="admin.jsp">Cancel</a>
                <% } %>
            </form>
        </div>

        <div class="section">
            <h3>Search Learning</h3>
            <form class="search" action="admin.jsp" method="get">
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
                    <th>Action</th>
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
                    <td>
                        <a class="edit" href="admin.jsp?editId=<%= rs.getInt("id") %>">Edit</a>
                        <form action="LearningServlet" method="post" style="display:inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                            <button class="delete" type="submit">Delete</button>
                        </form>
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
