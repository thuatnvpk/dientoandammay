<%-- 
    Document   : products
    Created on : Oct 19, 2016, 2:24:59 AM
    Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="com.javaweb.model.Sanpham"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.javaweb.service.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sản Phẩm</title>
        <%@include file="includes/headtag.jsp" %>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="includes/header.jsp" %>
        <br><br>
        <%@include file="includes/danhsachsanpham.jsp" %>
        <%  int pageSize = 10;
            int pageNumber = 1;
            ProductService PS = new ProductService();
            ArrayList<Sanpham> ListSanpham = null;

            if (request.getParameter("pagenumber") != null) {
                session.setAttribute("pagenumber", request.getParameter("pagenumber"));
                pageNumber = Integer.parseInt(request.getParameter("pagenumber"));
            } else {
                session.setAttribute("pagenumber", "1");
            }
            ListSanpham = PS.getAllSanpham(pageSize, pageNumber);
            int pageCount = (PS.usercount / pageSize)
                    + (PS.usercount % pageSize > 0 ? 1 : 0);
            String nextPage = (pageCount > pageNumber
                    ? (pageNumber + 1) : pageNumber) + "";
            String prePage = (pageNumber <= 1 ? 1 : pageNumber - 1) + "";

            String folderupload = getServletContext().getInitParameter("file-upload");

        %>
        <br><br>
        <section class="container">
            <div class="panel panel-default panel-custom">
                <!-- Default panel contents -->
                <div class="panel-heading">
                    <h3 class="text-center">Danh Sách Sản Phẩm</h3>
                    <div class="text-right"><a href="addproduct.jsp"><button type="button" class="btn btn-primary">Add New Product</button></a></div>
                </div>


                <!-- Table -->
                <table class="table table-bordered table-responsive">
                    <thead>
                        <tr>
                            <th>TT</th>                        
                            <th>Sản Phẩm</th>                        
                            <th>Chức Năng</th>                        
                            <th>Giá</th>                        
                            <th>Ghi Chú</th>                       
                            <th class="text-center">Hình Ảnh</th>
                            <th class="text-center">Edit</th>                       
                            <th class="text-center">Delete</th>
                        </tr>

                    </thead>
                    <tbody class="table-inverse" >
                        <%                            for (int i = 0; i < ListSanpham.size(); i++) {
                                Sanpham sp = ListSanpham.get(i);

                        %>
                        <tr>
                            <td><%= i + 1%></td>                        
                            <td><%= sp.getTen()%></td>                        
                            <td><%= sp.getChucnang()%></td>                        
                            <td>
                                <%DecimalFormat formatter = new DecimalFormat("###,###,###");%>
                                <%= formatter.format(sp.getGia()) + " VND"%>
                            </td>                        
                            <td><%= sp.getGhichu()%></td>                       
                            <td class="text-center">
                                <img class="img-thumbnail" src="<%= folderupload%><%= sp.getImage()%>" width="100px" height="80px"/>
                            </td>                       

                            <td class="text-center">
                                <a href="editproduct.jsp?spid=<%=sp.getId()%>"><input type="button" name="edit" value="Edit" /></a>
                            </td>
                            <td class="text-center">
                                <a href="DeleteProductServlet?idsp=<%= sp.getId()%>"><input type="button" name="Del" value="Delete" onclick="return confirm('Bạn có muốn xóa sản phẩm này không?')" /></a>
                            </td>

                        </tr>
                        <%
                            }
                        %>

                    </tbody>
                </table>

                <nav aria-label="Page navigation" class="text-center">
                    <ul class="pagination ">
                        <li><a  aria-label="Previous" href="?pagenumber=<%=prePage%> " > <span aria-hidden="true">&laquo;</span></a></li>
                            <%

                                for (int j = 1; j <= pageCount; j++) {
                                    if (pageNumber == j) {
                            %>
                        <li class="active">
                            <a href="?pagenumber=<%=j%>"><%= j %></a>
                        </li>
                            <%
                            } else {
                            %>                                   
                        <li ><a href="?pagenumber=<%=j%>"><%=j%></a></li>

                        <%
                                }
                            }
                        %>
                        <li ><a aria-label="Next" href="?pagenumber=<%=nextPage%>"><span aria-hidden="true">&raquo;</span></a></li>
                    </ul>
                </nav>
            </div>
        </section>


        <hr>
        <%@include file="includes/footer.jsp" %>
    </body>

</html>
