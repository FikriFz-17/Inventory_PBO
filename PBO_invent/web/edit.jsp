<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.JDBC"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="vh-100 d-flex justify-content-center align-items-center bg-light">
        <%
            String id = (request.getParameter("id"));
            String username = "";
            JDBC db = new JDBC();
            if(db.isCon){
                ResultSet rs = db.getData("select * from user where id = " + id);
                if(rs.next()){
                    username = rs.getString("username");
                }
            }
        %>
        <form method="post" action="/editUser?id= <%=id%>" class="bg-white p-4 rounded shadow-sm" style="width: 100%; max-width: 400px;">
            <h3 class="test-center mb-4 text-primary">Edit User</h3>
            
            <div class="mb-3">
                <label for="username" class="form-label">username</label>
                <input type="text" value ="<%= username %>" id="username" name="username" class="form-control" placeholder="Masukkan Username" required>
            </div>
            <div class="text-center">
                <button type="submit" id="submit-btn" class="btn btn-warning w-100">Edit</button>
            </div>
        </form>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</html>