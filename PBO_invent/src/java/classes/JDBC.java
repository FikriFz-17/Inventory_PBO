/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package classes;
import java.sql.*;

/**
 *
 * @author fikri
 */
public class JDBC {
    Connection con;
    Statement stmt;
    public boolean isCon;
    public String msg;
    
    public JDBC(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(
           "jdbc:mysql://localhost:3306/tubes_pbo","root","root123");
            stmt = con.createStatement();
            isCon = true;
            msg = "DB connected";
        } catch(Exception e) {
            isCon = false;
            msg = e.getMessage();
        }
    }
    
    public void runQuery(String query) {
        try {
            int result = stmt.executeUpdate(query);
            msg = "info: " + result + " rows affected";
        } catch (Exception e) {
            msg = e.getMessage();
        }
   }
    
    public ResultSet getData(String query) {
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery(query);
        } catch (Exception e) {
            msg = e.getMessage();
        }
        return rs;
   }
    
    public void disconnect() {
        try {
            stmt.close();
            con.close();
            msg = "DB disconnected";
        } catch (Exception e) {
            msg = e.getMessage();
        }
    }
            
}
