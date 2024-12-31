<%@ page import="java.sql.*" %>
<%@page import="classes.JDBC, java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>User Management</title>
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <% 
            JDBC db = new JDBC(); 
            
            // Ambil session
            session = request.getSession(false);
            String username = "";
            String role = "";
            if (session == null || session.getAttribute("username") == null) {
                // Jika tidak ada session, redirect ke halaman login
                response.sendRedirect("login.jsp");
            } else {
                // Ambil data dari session
                username = (String) session.getAttribute("username");
                role = (String) session.getAttribute("role");
                if (session != null && !role.equals("Admin")){
                    response.sendRedirect("userUI.jsp");
                }
            }
        %>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
                <a class="navbar-brand" href="userUI.jsp">Inventori Barang</a>
                <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#">
                    <i class="fas fa-bars"></i>
                </button>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-user fa-fw"></i>
                        </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="Logout.php">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Menu</div>
                            <a class="nav-link" href="adminUI.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Kelola Barang
                            </a>
                            <a class="nav-link" href="kelolaUser.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Kelola User
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as: <%= username%></div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid">
                        <h1 class="mt-4">KELOLA USER</h1>
                        <div class="card-header">
                                <!-- The Modals -->
                                <div class="modal fade" id="myModal">
                                    <div class="modal-dialog">
                                    <div class="modal-content">
                                    
                                        <!-- Modal Header -->
                                        <div class="modal-header">
                                        <h4 class="modal-title">Tambah User</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>
                                        
                                        <!-- Modal body -->
                                        <form method="post" action="/addUser">
                                            <div class="modal-body">
                                                <input type="text" name="username" placeholder="username" class="form-control my-3" required>
                                                <input type="password" name="password" placeholder="password" class="form-control my-3" required>
                                                <select class="form-control mb-3" aria-label="Default select example" name="role">
                                                    <option   option value="User" selected>User</option>
                                                    <option value="Admin">Admin</option>
                                                </select>
                                                <button type="submit" class="btn btn-primary my-3" name="add">Add</button>
                                            </div>
                                        </form>
                                        
                                        <!-- Modal footer -->
                                        <div class="modal-footer">
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                        </div>
                                        
                                    </div>
                                    </div>
                                </div>

                            </div>
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Role</th>
                                                <th>Aksi</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                if(db.isCon){
                                                    ResultSet rs = db.getData("select * from user");
                                                    while(rs.next()){
                                                        int id = rs.getInt("id");
                                                        out.print("<tr>");
                                                        out.print("<td>" + id + "</td>");
                                                        out.print("<td>" + rs.getString("username") + "</td>");
                                                        out.print("<td>" + rs.getString("role") + "</td>");
                                                        out.print("<td>");
                                                        out.print("<a href='edit.jsp?id=" + id + "' class='btn btn-warning btn-sm me-2'>Edit</a>");
                                                        out.print("<a href='edit.jsp?id=" + id + "' class='btn btn-danger btn-sm me-1'>Delete</a>");
                                                    }
                                                }
                                            %>
                                            
<!--                                                    <tr>
                                                        <td><?= htmlspecialchars($username); ?></td>
                                                        <td><?= htmlspecialchars($role); ?></td>
                                                        <td>
                                                            <button type="button" class="btn btn-warning btn-sm my-1" data-toggle="modal" data-target="#edit<?= $id; ?>">Edit</button>
                                                            <button type="button" class="btn btn-danger btn-sm my-1" data-toggle="modal" data-target="#delete<?= $id; ?>">Delete</button>
                                                        </td>
                                                    </tr>-->

                                                    <!--  Edit Modals-->
<!--                                                        <div class="modal fade" id="edit<?=$id;?>">
                                                            <div class="modal-dialog">
                                                            <div class="modal-content">
                                                            
                                                                 Modal Header 
                                                                <div class="modal-header">
                                                                <h4 class="modal-title">Edit User</h4>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                </div>-->
                                                                
                                                                <!-- Modal body -->
<!--                                                                <form method="post">
                                                                    <div class="modal-body">
                                                                        <input type="text" name="username" value="<?= htmlspecialchars($username); ?>" class="form-control my-3" required>
                                                                        <input type="password" name="pass" placeholder="Password" class="form-control my-3">
                                                                        <select class="form-control mb-3" aria-label="Default select example" name="role">
                                                                            <option value="User" <?= $role === 'User' ? 'selected' : ''; ?>>User</option>
                                                                            <option value="Admin" <?= $role === 'Admin' ? 'selected' : ''; ?>>Admin</option>
                                                                        </select>
                                                                        <button type="submit" class="btn btn-warning my-3" name="updateUser">Edit</button>
                                                                        <input type="hidden" name="id" value="<?=$id;?>">
                                                                    </div>
                                                                </form>-->
<!--                                                            </div>
                                                            </div>
                                                        </div>-->
                                                    
                                                     <!--  Delete Modals-->
                                                     <div class="modal fade" id="delete<?=$id;?>">
                                                            <div class="modal-dialog">
                                                            <div class="modal-content">
                                                            
                                                                <!-- Modal Header -->
                                                                <div class="modal-header">
                                                                <h4 class="modal-title">Hapus User</h4>
                                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                </div>
                                                                
                                                                <!-- Modal body -->
                                                                <form method="post">
                                                                    <div class="modal-body">
                                                                        Hapus user dengan username <?= htmlspecialchars($username); ?>?
                                                                        <input type="hidden" name="id" value="<?=$id;?>">
                                                                        <br>
                                                                        <button type="submit" class="btn btn-danger my-3" name="hapusUser">Delete</button>
                                                                    </div>
                                                                </form>
                                                                
                                                            </div>
                                                            </div>
                                                        </div>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2020</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/datatables-demo.js"></script>
    </body>
</html>