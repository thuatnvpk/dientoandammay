<%-- 
    Document   : editproduct
    Created on : Oct 19, 2016, 3:18:21 PM
    Author     : Nguyễn Chí Tuấn
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="com.javaweb.model.Sanpham"%>
<%@page import="com.javaweb.service.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Product</title>
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
            };// code display image upload
        </script>
        <style>

            #output{
                width: 200px;
                height: 120px;
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
            ProductService PS = new ProductService();
            Sanpham sp = null;
            String Id = request.getParameter("spid");
            sp = PS.GetSanPhamByID(Id);
        %>


        <section class="container">
            <div class="row">
                <div class="col-md-2">

                </div>

                <div class="col-md-8">
                    <div id="boxshadow" class="jumbotron jumbotron-custom-edituser">
                        <form class="form-horizontal form-edit-user text-center" action="EditProductServlet" method="post" enctype="multipart/form-data">
                            <h3>Edit Product</h3>
                            <input style="display: none;" name="idsp" value="<%= sp.getId()%>" />

                            <div class="form-group fullname-custom">
                                <label class="control-label col-md-2" for="tensanpham">Tên Sản Phẩm</label>
                                <div class="col-sm-10">
                                    <input type="text" name="tensanpham" value="<%= sp.getTen()%>" class="form-control" required id="tensanpham">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2" for="chucnang">Chức Năng</label>
                                <div class="col-sm-10">
                                    <input type="text" name="chucnang" value="<%= sp.getChucnang()%>" class="form-control" required id="chucnang">
                                </div> 
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2" for="gia">Giá</label>
                                <div class="col-sm-10">
                                    <input type="number" name="gia" value="1000" class="form-control" required id="gia">
                                </div> 
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-2" for="mota">Ghi Chú</label>
                                <div class="col-sm-10">
                                    <input type="mota" name="mota" value="<%= sp.getGhichu()%>" class="form-control"  id="mota">
                                </div> 
                            </div>    

                            <div class="form-group">
                                <div class="col-md-6">
                                    <h3>Image</h3>
                                    <br>
                                        <%
                                            if (sp.getImage() != null) {
                                                String folderupload = getServletContext().getInitParameter("file-upload");
                                        %>
                                    <img class="img-thumbnail" src="<%=folderupload%><%= sp.getImage()%>" width="200px" height="180px" />
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
                                <a href="/changepassword.jsp" class="text-info">Change password</a>
                            </div>
                            <button style="font-weight: bold" type="submit" class="btn btn-info"><span class="glyphicon glyphicon-edit"></span> Update</button>

                        </form>
                        <br>
                        <div class="form-group text-center">
                            <a href="products.jsp">
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
