<%-- 
    Document   : logout
    Created on : Oct 19, 2016, 7:27:31 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Xuất</title>
    </head>
    <body>
        <section>
            <%
                if(session != null){
                    session.removeAttribute("fullname");
                    response.sendRedirect("login.jsp");
                }
            %>
            To login again <a href="login.jsp">Click Here</a>
        </section>
    </body>
</html>
