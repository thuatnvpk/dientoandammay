<%-- 
    Document   : edituser
    Created on : Oct 19, 2016, 9:07:34 AM
    Author     : Nguyễn Chí Tuấn
--%>

<%@page import="com.javaweb.model.Users"%>
<%@page import="com.javaweb.service.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit User</title>
        <%@include file="includes/headtag.jsp" %>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script>
            var loadFile = function (event) {
                var reader = new FileReader();
                reader.onload = function () {
                    var output = document.getElementById('output');
                    output.src = reader.result;
                };
                reader.readAsDataURL(event.target.files[0]);
            };// code hiện thị hình ảnh trước khi load
        </script>
        <style>
            
            #output{
                width: 200px;
                height: 200px;
            }

        </style>
    </head>
    <body>
        <header class="container">
            <div class="row">
                <nav class="navbar navbar-default navbar-fixed-top">
                    <div class="container">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span> 
                            </button>
                            <a class="navbar-brand" href="trangchu.jsp">
                                <img src="images/logo4.png" alt=""/>
                            </a>
                        </div>

                        <div class="collapse navbar-collapse nav-custom" id="myNavbar">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a style="color:#0095da" href="trangchu.jsp">
                                        <span class="glyphicon glyphicon-home"></span> Home
                                    </a>
                                </li>
                                <li>
                                    <a style="color:#0095da" href="gioithieu.jsp">
                                        <span class="glyphicon glyphicon-info-sign"></span> Introduce
                                    </a>
                                </li>
                                <li>
                                    <a style="color:#0095da" href="products.jsp">
                                        <span class="glyphicon glyphicon-list-alt"></span> Products
                                    </a>
                                </li> 
                                <li>
                                    <a style="color:#0095da" href="usermanagement.jsp">
                                        <span class="glyphicon glyphicon-user"></span> User Management
                                    </a>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <%
                                    if (session.getAttribute("fullname") != null) {
                                %>
                                <li><a style="color:red" href="#">Hello: <%= session.getAttribute("fullname")%></a></li>
                                <li><a style="color:#0095da" href="logout.jsp"><span class="glyphicon glyphicon-log-in"></span>  Đăng Xuất</a></li>
                                    <%
                                    } else {
                                    %>
                                <li>
                                    <a style="color:#0095da" href="register.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a>
                                </li>
                                <li>
                                    <a style="color:#0095da" href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a>
                                </li>
                                <%
                                    }
                                %>

                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </header>
        <%
            
            UserService us = new UserService();
            
            Users user = null;
            String IdUser = request.getParameter("IdUser");
            user = us.GetUserByIdUser(IdUser);
        %>
        
        
        <br>
        <section class="container">
            <div class="row">
                <div class="col-md-2">
                    
                </div>
                <div class="col-md-8">
                    <div id="boxshadow" class="jumbotron">
                        <form class="form-horizontal form-edit-user text-center" action="EditUserServlet" method="post" enctype="multipart/form-data">
                            <h3>Edit User</h3>
                            <input style="display: none;" name="IdUser" value="<%= user.getIdUser()%>" />
                            <div class="form-group fullname-custom">
                                <label class="control-label col-md-2" for="Fullname">Full Name:</label>
                                <div class="col-sm-10">
                                    <input type="text" name="Fullname" value="<%= user.getFullName()%>" class="form-control" required id="Fullname">
                                </div>
                            </div>
                            <div class="form-group ">
                                <label class="control-label col-md-2" for="email">Email address:</label>
                                <div class="col-sm-10">
                                    <input type="email" name="email" value="<%= user.getEmail()%>" class="form-control" required="" id="email">
                                </div>
                            </div>
                            <div class="form-group ">
                                <label class="control-label col-md-2" for="username">Username:</label>
                                <div class="col-sm-10">
                                    <input type="text" name="username" value="<%= user.getUserName()%>" class="form-control" required id="username">
                                </div>
                            </div>
                            <div class="form-group ">

                                <label class="control-label col-md-2" for="Gender">GenDer:</label>
                                <div class="col-sm-10">
                                    <input type="text" name="Gender" value="<%= user.getGender()%>" class="form-control"  id="Gender">
                                </div>
                            </div>
                                
                            <div class="form-group img-responsive">
                                <div class="col-md-6">
                                    <h3>Image</h3>
                                    <br>
                                        <%
                                            if (user.getAvatar()!= null) {
                                                String folderupload = getServletContext().getInitParameter("file-upload");
                                        %>
                                    <img class="img-thumbnail" src="<%=folderupload%><%= user.getAvatar()%>" width="200px" height="200px" />
                                    <%
                                        }
                                    %>
                                    
                                </div>
                                    <div class="col-md-6">
                                        <h3>New Image</h3>
                                        <br>
                                        <div id="imageOut"><img class="img-thumbnail" id="output"/></div>
                                    </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="control-label col-md-2" for="photo">Change Image</label>
                                <div class="col-md-10">
                                    <input type="file" name="photo" accept="image/*" onchange="loadFile(event)" />
                                </div>
                            </div>        
                                    
                            <div class="form-group">
                                <a  href="/changepassword.jsp" class="text-info">Change password</a>
                                <br><br>
                                <button style="font-weight: bold" type="submit" class="btn btn-info"><span class="glyphicon glyphicon-edit"></span> Update</button>
                                
                            </div>
                        </form>
                        <div class="form-group text-center">
                            <a href="usermanagement.jsp">
                                <button style="font-weight: bold" class="btn btn-info"><span class="glyphicon glyphicon-arrow-left"></span> Cancel</button>
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-2">
                    
                </div>
            </div>
        </section>
        
    </body>
</html>
