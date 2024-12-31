/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import classes.JDBC;
import java.io.IOException;
import java.sql.ResultSet;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author fikri
 */
@WebServlet(name = "register", urlPatterns = {"/register"})
public class register extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    JDBC db = new JDBC();
    if (db.isCon) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String cfmPass = request.getParameter("confirmPassword");
        String role = "User";

        try {
            // Periksa apakah username sudah ada
            ResultSet rs = db.getData("SELECT * FROM user WHERE username = '" + username + "'");
            if (rs.next()) {
                // Jika username sudah ada, redirect ke halaman register dengan status error
                response.sendRedirect("register.jsp?status=usernameExists");
            } else {
                // Validasi password
                if (password.equals(cfmPass)) {
                    // Tambahkan user ke database
                    db.runQuery("INSERT INTO user (username, password, role) VALUES ('" + username + "', '" + password + "', '" + role + "')");
                    response.sendRedirect("register.jsp?status=success");
                } else {
                    // Password dan konfirmasi tidak cocok
                    response.sendRedirect("register.jsp?status=passwordMismatch");
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log error ke server
            response.sendRedirect("register.jsp?status=error");
        }
    }
}


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
