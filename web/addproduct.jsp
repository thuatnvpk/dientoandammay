<%-- 
    Document   : addproduct
    Created on : Oct 19, 2016, 11:20:17 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm Sản Phẩm</title>
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
                width: 300px;
                height: 200px;
            }
            
        </style>
    </head>
    <body>
        <%@include file="includes/header.jsp" %>
        <br>
        <%@include file="includes/danhsachsanpham.jsp" %>
        <br>
        <section class="container">
            <div class="row">
                <div class="col-md-2">
                    
                </div>
                
                <div class="col-md-8">
                    
                    <div id="boxshadow" class="jumbotron jumbotron-custom-edituser">
                        <form class="form-horizontal form-edit-user text-center" action="AddproductServlet" method="post" enctype="multipart/form-data">
                            <h3>Add New Product</h3>
                            <div class="form-group fullname-custom">
                                <label class="control-label col-md-2" for="tensanpham">Tên Sản Phẩm</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" name="tensanpham" id="tensanpham" placeholder="Nhập tên sản phẩm" required="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="chucnang">Chức Năng</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" name="chucnang" id="chucnang" placeholder="Nhập chức năng sản phẩm" required="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="gia">Giá</label>
                                <div class="col-md-10">
                                    <input type="number" class="form-control" name="gia" id="gia" placeholder="Nhập giá sản phẩm" required="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="mota">Ghi Chú</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" name="mota" id="mota" placeholder="Mô tả sản phẩm">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-2" for="photo">Image</label>
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
                            <button style="font-weight: bold" type="submit" class="btn btn-info"><span class="glyphicon glyphicon-plus"></span> Add Product</button>
                            <div class="form-group">
                                <%                                
                                    if (session.getAttribute("errormsg") != null) {
                                %>
                                <label class="text-danger">
                                    <%= session.getAttribute("errormsg")%>
                                </label>
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
                            
        
        <br>
        <%@include file="includes/footer.jsp" %>
    </body>
</html>
