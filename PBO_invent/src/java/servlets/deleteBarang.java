/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import classes.JDBC;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author athal
 */
@WebServlet(name = "deleteBarang", urlPatterns = {"/deleteBarang"})
public class deleteBarang extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JDBC db = new JDBC();
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        String idBarang = request.getParameter("idBarang"); // Ambil parameter idBarang dari form

        if (db.isCon) {
            try {
                // Validasi bahwa idBarang tidak kosong atau null
                if (idBarang != null && !idBarang.trim().isEmpty()) {
                    // Jalankan query DELETE
                    db.runQuery("DELETE FROM barang WHERE idbarang = " + idBarang);
                }
            } catch (Exception e) {
                e.printStackTrace(); // Log error untuk debugging
            } finally {
                db.disconnect();
            }
        }

        // Redirect sesuai dengan role
        if ("User".equals(role)) {
            response.sendRedirect("userUI.jsp");
        } else {
            response.sendRedirect("adminUI.jsp");
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
