/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import classes.JDBC;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Faiz
 */
@WebServlet(name = "searchBarang", urlPatterns = {"/searchBarang"})
public class searchBarang extends HttpServlet {

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
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String searchValue = request.getParameter("search[value]");
            int draw = Integer.parseInt(request.getParameter("draw"));
            int start = Integer.parseInt(request.getParameter("start"));
            int length = Integer.parseInt(request.getParameter("length"));

            // Get sorting information
            String orderColumn = request.getParameter("order[0][column]");
            String orderDir = request.getParameter("order[0][dir]");
            
            // Define column names for sorting
            String[] columns = {"kode", "namabarang", "name", "jenisbarang", "stock"};
            
            JDBC db = new JDBC();
            JSONArray data = new JSONArray();
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");
            int id = (int) session.getAttribute("userId");
            String query;
            String countQuery;
            String searchCondition = "";
            
            String orderBy = "";
            if (orderColumn != null && orderDir != null) {
                int columnIndex = Integer.parseInt(orderColumn);
                if (columnIndex < columns.length) {
                    orderBy = " ORDER BY " + columns[columnIndex] + " " + orderDir;
                }
            }
            
            if (role.equals("Admin")) {
                // Base query
                String baseQuery = "SELECT * FROM barang";

                if (searchValue != null && !searchValue.isEmpty()) {
                    searchCondition = " WHERE kode LIKE '%" + searchValue + "%' OR " +
                                    "namabarang LIKE '%" + searchValue + "%' OR " +
                                    "name LIKE '%" + searchValue + "%' OR " +
                                    "jenisbarang LIKE '%" + searchValue + "%'";
                }

                // Count total records
                countQuery = "SELECT COUNT(*) as total FROM barang" + searchCondition;
                ResultSet countRs = db.getData(countQuery);
                int totalRecords = 0;
                if (countRs.next()) {
                    totalRecords = countRs.getInt("total");
                }

                // Get filtered data
                query = baseQuery + searchCondition + orderBy + " LIMIT " + start + ", " + length;
                ResultSet rs = db.getData(query);
                
                while (rs.next()) {
                    JSONArray row = new JSONArray();
                    row.add(rs.getString("kode"));
                    row.add(rs.getString("namabarang"));
                    row.add(rs.getString("name"));
                    row.add(rs.getString("jenisbarang"));
                    row.add(rs.getInt("stock"));

                    // Create action buttons
                    String actions = "<button type='button' class='btn btn-warning my-3' data-toggle='modal' data-target='#edit" + 
                                   rs.getInt("idbarang") + "'>Edit</button> " +
                                   "<button type='button' class='btn btn-danger my-3' data-toggle='modal' data-target='#delete" + 
                                   rs.getInt("idbarang") + "'>Delete</button>";
                    row.add(actions);

                    data.add(row);
                }
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("draw", draw);
                jsonResponse.put("recordsTotal", totalRecords);
                jsonResponse.put("recordsFiltered", totalRecords);
                jsonResponse.put("data", data);
                out.print(jsonResponse.toString());
            } else {
                // Base query
                String baseQuery = "SELECT * FROM barang WHERE owner_id = " + id;

                if (searchValue != null && !searchValue.isEmpty()) {
                    searchCondition = " AND (kode LIKE '%" + searchValue + "%' OR " +
                                     "namabarang LIKE '%" + searchValue + "%' OR " +
                                     "jenisbarang LIKE '%" + searchValue + "%')";
                }

                // Count total records
                countQuery = "SELECT COUNT(*) as total FROM barang WHERE owner_id = " + id;
                if (!searchCondition.isEmpty()) {
                    countQuery += searchCondition;
                }
                
                ResultSet countRs = db.getData(countQuery);
                int totalRecords = 0;
                if (countRs.next()) {
                    totalRecords = countRs.getInt("total");
                }

                // Get filtered data
                query = baseQuery;
                if (!searchCondition.isEmpty()) {
                    query += searchCondition;
                }
                query += orderBy + " LIMIT " + start + ", " + length;

                ResultSet rs = db.getData(query);
                
                while (rs.next()) {
                    JSONArray row = new JSONArray();
                    row.add(rs.getString("kode"));
                    row.add(rs.getString("namabarang"));
                    row.add(rs.getString("jenisbarang"));
                    row.add(rs.getInt("stock"));

                    // Create action buttons
                    String actions = "<button type='button' class='btn btn-warning my-3' data-toggle='modal' data-target='#edit" + 
                                   rs.getInt("idbarang") + "'>Edit</button> " +
                                   "<button type='button' class='btn btn-danger my-3' data-toggle='modal' data-target='#delete" + 
                                   rs.getInt("idbarang") + "'>Delete</button>";
                    row.add(actions);

                    data.add(row);
                }
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("draw", draw);
                jsonResponse.put("recordsTotal", totalRecords);
                jsonResponse.put("recordsFiltered", totalRecords);
                jsonResponse.put("data", data);
                out.print(jsonResponse.toString());
            }

            

            
            db.disconnect();

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": \"" + e.getMessage() + "\"}");
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
