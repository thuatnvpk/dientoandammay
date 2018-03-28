<%-- 
    Document   : usermanagement
    Created on : Oct 19, 2016, 2:25:37 AM
    Author     : Nguyễn Chí Tuấn
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.javaweb.service.UserService"%>
<%@page import="com.javaweb.model.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lý Người Dùng</title>
        <%@include file="includes/headtag.jsp" %>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="includes/header.jsp" %>
        <%
            request.setCharacterEncoding("UTF-8");
            ArrayList<Users> ListUser = null;
            UserService us = new UserService();
            ListUser = us.GetAllUsers();
            
            String folderupload = getServletContext().getInitParameter("file-upload");
        %>
        <hr>
        
        <section class="container">
            <div class="panel panel-default panel-custom">
                <!-- Default panel contents -->
                <div class="panel-heading text-center">
                    <h3>Danh Sách Người Dùng</h3>
                </div>

                <!-- Table -->
                <table class="table table-responsive table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>TT</th>                        
                            <th>FullName</th>                        
                            <th>Email</th>                        
                            <th>Username</th>                        
                            <th>Password</th>                       
                            <th>GenDer</th>                       
                            <th class="text-center">Avatar</th>
                            <th class="text-center">Edit</th>                       
                            <th class="text-center">Delete</th>
                        </tr>

                    </thead>
                    <tbody class="table-inverse" >
                        <%
                            for(int i = 0; i < ListUser.size(); i++){
                                Users users = ListUser.get(i);
                            
                        %>
                        <tr>
                            <td><%= i + 1 %></td>                        
                            <td><%= users.getFullName() %></td>                        
                            <td><%= users.getEmail() %></td>                        
                            <td><%=  users.getUserName() %></td>                        
                            <td><%=  users.getPwd() %></td>                       
                            <td class="text-center"><%=  users.getGender() %></td>                       
                            <td class="text-center avatar-custom">
                                <img class="img-thumbnail" src="<%= folderupload%><%= users.getAvatar()%>"/>
                            </td>
                            <td class="text-center">
                                <a href="edituser.jsp?IdUser=<%= users.getIdUser()%>"><input type="button" name="edit" value="Edit" /></a>
                            </td>
                            <td class="text-center">
                                <a href="DeleteUserServlet?IdUser=<%= users.getIdUser() %>"><input type="button" name="Del" value="Delete" onclick="return confirm('Bạn có muốn xóa người dùng này không?')" /></a>
                            </td>

                        </tr>
                        <%
                            }
                        %>
                        
                    </tbody>
                </table>
                        
                <ul class="pager">
                    <li><a href="#">Previous</a></li>
                    <li style="padding-left: 40px"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li style="padding-right: 50px"><a href="#">5</a></li>
                    <li><a href="#">Next</a></li>
                </ul>
            </div>
        </section>
        
        <hr>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
