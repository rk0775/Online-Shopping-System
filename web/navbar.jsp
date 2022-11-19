<%@page import="GeterAndSeter.Information"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="components/commen_files.jsp"%>
    </head>
    <body>
        <!--mobile screen navbar -->
        <nav class="d-sm-none p-0 m-0 navbar navbar-expand navbar-dark bg-navbar fixed-top" style="opacity:0.9;">
            <!--container for center-->
            <div class="container">
                <!--navbar brand-->
                 <a id="sideOpen" class="d-sm-none"><span class="sidenav navbar-toggler-icon"></span></a>
                 <div class="text-center">
                <div class="navbar-brand p-0"><b class="s-style">S</b><i class="text-style">hopper</i>
                </div></div>
                <ul class="navbar-nav ml-auto">
                      
                       
                             <li class="nav-item" data-toggle="modal" data-target="#cartmodal"><a class=" nav-link text-light"><span class="text-small fa fa-cart-plus px-1" style="font-size: 20px"></span><spna class="cart-num"></spna></a></li>
                       
                    </ul>
            </div>
        </nav>
      <!--mobile screen navbar end -->
      <!--The main navbar -->
      
        <nav class="d-none d-sm-block p-0 m-0 navbar navbar-expand-md navbar-dark bg-navbar fixed-top">
           
            <!--container for center-->
            <div class="container">
               
                <!--navbar brand-->
                <div class="navbar-brand p-0"><b class="s-style">S</b><i class="text-style">hopper</i>
                </div>
                <!--navbar-togger-->
                <button class="navbar-toggler" data-toggle="collapse" data-target="#nav123">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <!--Navbar list-->
                <div id="nav123" class="collapse navbar-collapse text-light text-style text-center">
                    <ul class="d-none d-sm-flex navbar-nav ml-2">
                        <li class="nav-item"><a href="index.jsp" class="nav-link text-light">HOME</a></li>
                        <li class="nav-item"><a href="#" class="nav-link text-light">PRODUCTS</a></li>
                        <li class="nav-item"><a href="#" class="nav-link text-light">ABOUT</a></li>
                        <li class="nav-item"><a href="#" class="nav-link text-light">CONTACT</a></li>
                    </ul>
                    
               
                    <ul class="navbar-nav ml-auto">
                      
                       
                             <li class="nav-item" data-toggle="modal" data-target="#cartmodal"><a class=" nav-link text-light"><span class=" fa fa-cart-plus px-1" style="font-size: 20px"></span><spna class="cart-num"></spna></a></li>
                           <%     
                            
                       
                            if(info==null)
                            {
                            %>
                            
                            
                            <li class="nav-item"><a href="login.jsp" class="nav-link text-light">LOGIN</a></li>
                            <li class="nav-item"><a href="register.jsp" class="nav-link text-light">REGISTER</a></li>
                                
                            <%
                                        
                            }else{
                            
                            %>
                            
                            
                            <li class="nav-item"><a href="<% if(info.getType().equalsIgnoreCase("admin")){%>AdminUser.jsp<%}else{ %>NormalUser.jsp <% } %>" class="nav-link text-light"><h4 class="mb-0"><%= info.getName() %></h4></a></li>
                             <li class="nav-item">  <a href="LogoutServlet" class="mt-1 nav-link text-light">LOGOUT</a></li>
                               
                           <%  } %>
                        
                       
                        
                       
                    </ul>
                </div>
            </div>
        </nav>
          <!--The main navbar end -->                  
      <!--Cart modal--> 
      <div id="cartmodal" class="modal fade">
          <div class="modal-dialog modal-lg">
              <div class="modal-content">
                  <div class="modal-header bg-navbar text-light style-text">Your Cart
                      <span data-dismiss="modal">&times;</span>
                  </div>
                  <div class="modal-body cart-body pb-0">
                      
                  </div>
                  <div class="modal-footer mt-0">
                      <a href="<% if(info==null){
                          
                      %>login.jsp
                      <% }else{ if(info.getType().equalsIgnoreCase("admin")){%>AdminUser.jsp<%}else{ %>NormalUser.jsp <% } }%>" class="btn btn-outline-primary check-btn">Check Out</a>
                      <button class="btn btn-dark" data-dismiss="modal">Close</button>
                  </div>
              </div>
          </div>
      </div>  
      <!--Cart modal end-->   
    </body>
</html>
