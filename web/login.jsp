<%-- 
    Document   : login
    Created on : Oct 19, 2016, 6:08:26 AM
    Author     : Nguyễn Chí Tuấn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Nhập</title>
        <%@include file="includes/headtag.jsp"%>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="includes/header.jsp"%>
        <hr>
        <section class="container">
            <div class="row row-custom">
                <div class="col-md-3">
                    
                </div>
                <div class="col-md-6">
                    <div id="boxshadow" class="jumbotron jumbotron-custom-edituser">
                        <form action="LoginServlet" method="post" class="form-horizontal form-edit-user text-center">
                            <div class="form-group fullname-custom">
                                <label class="control-label col-md-2" for="email">Email:</label>
                                <div class="col-md-10">
                                    <input type="text" required="" name="youremail" class="form-control" id="email">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="pwd">Password:</label>
                                <div class="col-md-10">
                                    <input type="password" required="" name="yourpwd" class="form-control" id="pwd">
                                </div>
                            </div>
                            <button style="font-weight: bold" type="submit" class="btn btn-info">
                                <span class="glyphicon glyphicon-log-in"></span> Login
                            </button>
                            <br>
                            <%                        
                                if (session.getAttribute("errormsg") != null) {
                            %>
                            <br>
                            <div class="text-danger"><%=session.getAttribute("errormsg")%></div>
                            <br>
                            <%
                                }
                            %>
                        </form>
                    </div>
                </div>
                <div class="col-md-3">
                    
                </div>
            </div>
        </section>
        <hr>
        <%@include file="includes/footer.jsp"%>
    </body>
</html>
