<%-- 
    Document   : header
    Created on : Oct 18, 2016, 8:51:05 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            if(session.getAttribute("fullname") != null){
                                %>
                                <li><a style="color:red" href="#">Hello: <%= session.getAttribute("fullname") %></a></li>
                                    <li><a style="color:#0095da" href="logout.jsp"><span class="glyphicon glyphicon-log-in"></span>  Đăng Xuất</a></li>
                                <%
                            }else{
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
<section class="container text-center img-responsive">
            <div class="row">
                <div class="col-md-12">
                    <!-- Start WOWSlider.com BODY section -->
                    <div id="wowslider-container1">
                        <div class="ws_images"><ul>
                                <li><img src="data1/images/imgslider1.jpg" alt="" title="" id="wows1_0"/></li>
                                <li><img src="data1/images/imgslider2.jpg" alt="" title="" id="wows1_1"/></li>
                                <li><a href="http://wowslider.com"><img src="data1/images/imgslider3.jpg" alt="wowslider.com" title="" id="wows1_2"/></a></li>
                                <li><img src="data1/images/imgslider4.jpg" alt="" title="" id="wows1_3"/></li>
                            </ul></div>
                        <div class="ws_bullets"><div>
                                <a href="#" title=""><span><img src="data1/tooltips/imgslider1.jpg" alt=""/>1</span></a>
                                <a href="#" title=""><span><img src="data1/tooltips/imgslider2.jpg" alt=""/>2</span></a>
                                <a href="#" title=""><span><img src="data1/tooltips/imgslider3.jpg" alt=""/>3</span></a>
                                <a href="#" title=""><span><img src="data1/tooltips/imgslider4.jpg" alt=""/>4</span></a>
                            </div></div>
                        <div class="ws_shadow"></div>
                    </div>	
                    <script type="text/javascript" src="engine1/wowslider.js"></script>
                    <script type="text/javascript" src="engine1/script.js"></script>
                    <!-- End WOWSlider.com BODY section -->
                </div>
            </div>
        </section>
