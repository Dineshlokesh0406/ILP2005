package lms;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LearningServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp?msg=Please login as admin");
            return;
        }

        String action = request.getParameter("action");

        try {
            Connection con = DBConnection.getConnection();

            if ("add".equals(action)) {
                PreparedStatement ps = con.prepareStatement(
                        "insert into learning(title, description, link) values(?,?,?)");
                ps.setString(1, request.getParameter("title"));
                ps.setString(2, request.getParameter("description"));
                ps.setString(3, request.getParameter("link"));
                ps.executeUpdate();
            }

            if ("update".equals(action)) {
                PreparedStatement ps = con.prepareStatement(
                        "update learning set title=?, description=?, link=? where id=?");
                ps.setString(1, request.getParameter("title"));
                ps.setString(2, request.getParameter("description"));
                ps.setString(3, request.getParameter("link"));
                ps.setInt(4, Integer.parseInt(request.getParameter("id")));
                ps.executeUpdate();
            }

            if ("delete".equals(action)) {
                PreparedStatement ps = con.prepareStatement("delete from learning where id=?");
                ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                ps.executeUpdate();
            }

            con.close();
            response.sendRedirect("admin.jsp?msg=Learning record saved");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?msg=Learning operation failed");
        }
    }
}
