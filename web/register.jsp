<%-- 
    Document   : register
    Created on : Oct 19, 2016, 7:26:58 AM
    Author     : Nguyễn Chí Tuấn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Ký</title>
        <%@include file="includes/headtag.jsp" %>
        <link href="css/style-register.css" rel="stylesheet" type="text/css"/>
        <script>
            var loadFile = function (event) {
                var reader = new FileReader();
                reader.onload = function () {
                    var output = document.getElementById('output');
                    output.src = reader.result;
                };
                reader.readAsDataURL(event.target.files[0]);
            };// code hiển thị hình ảnh trước khi upload
        </script>
        <style>
            #output{
                width: 200px;
                height: 200px;
            }
        </style>
    </head>
    <body>
        <%@include file="includes/header.jsp" %>
        <hr>

        <section class="container">
            <div class="row">
                <div class="col-md-2">

                </div>
                <div class="col-md-8">
                    <div id="boxshadow" class="jumbotron jumbotron-custom-edituser">
                        <form action="RegisterServlet" method="post" class="form-horizontal form-edit-user text-center" enctype="multipart/form-data">
                            <div class="form-group fullname-custom">
                                <label class="control-label col-md-2" for="fullname">FullName</label>
                                <div class="col-md-10">
                                    <input type="text" name="fullname" class="form-control" required id="username" placeholder="Nhập tên đầy đủ">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="email">Email address</label>
                                <div class="col-md-10">
                                    <input type="email" name="email" class="form-control" required id="email" placeholder="Nhập Email">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="username">Username</label>
                                <div class="col-md-10">
                                    <input type="text" name="username" class="form-control" required id="username" placeholder="Nhập tên đăng nhập">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="pwd">Password</label>
                                <div class="col-md-10">
                                    <input type="password" name="pwd" class="form-control" required id="pwd" placeholder="Nhập mật khẩu">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="repwd">Retype Password</label>
                                <div class="col-md-10">
                                    <input type="password" name="repwd" class="form-control" required id="repwd" placeholder="Nhập lại mật khẩu">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="gioitinh">Gender</label>
                                <div class="col-md-10">
                                    <input type="text" name="gioitinh" class="form-control" required id="gioitinh" placeholder="Nhập giới tính">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="photo">Avatar</label>
                                <div class="col-md-10">
                                    <input type="file" name="photo" accept="image/*" onchange="loadFile(event)">
                                </div>
                            </div>
                            <div class="container">
                                <div class="row">
                                    <div id="imageOut"><img class="img-thumbnail" id="output"/></div>
                                </div>
                            </div>
                            <br>
                            <button style="font-weight: bold" type="submit" class="btn btn-info btn-lg">Register</button>
                            <div class="form-group">
                                <%                                    
                                    if (session.getAttribute("errormsg") != null) {
                                %>
                                <br>
                                <label class="text-danger">
                                    <%= session.getAttribute("errormsg")%>
                                </label>
                                <br>
                                <%
                                        session.removeAttribute("errormsg");
                                    }
                                %>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="col-md-2">  

                </div>
            </div>
        </section>

        <hr>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
