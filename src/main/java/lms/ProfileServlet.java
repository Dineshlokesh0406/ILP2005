package lms;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp?msg=Please login first");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = (String) session.getAttribute("role");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "update users set name=?, email=?, password=? where id=?");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setInt(4, userId);
            ps.executeUpdate();
            con.close();

            session.setAttribute("name", name);
            session.setAttribute("email", email);

            if ("admin".equals(role)) {
                response.sendRedirect("admin.jsp?msg=Profile updated");
            } else {
                response.sendRedirect("student.jsp?msg=Profile updated");
            }
        } catch (Exception e) {
            e.printStackTrace();
            if ("admin".equals(role)) {
                response.sendRedirect("admin.jsp?msg=Profile update failed");
            } else {
                response.sendRedirect("student.jsp?msg=Profile update failed");
            }
        }
    }
}
