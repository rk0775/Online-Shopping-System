<%-- 
    Document   : ProductPage
    Created on : Sep 7, 2020, 4:27:45 PM
    Author     : Admin
--%>

<%@page import="GeterAndSeter.WordProvider"%>
<%@page import="GeterAndSeter.ProductDetailes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ include file="navbar.jsp"%>
        <% 
           
            String productId=request.getParameter("shopper");
               if(productId==null){
                response.sendRedirect("index.jsp");
                
            }
            String pageNo=request.getParameter("pno");
            String ptype=request.getParameter("type");
            if(ptype.equalsIgnoreCase("null")){
                ptype="all";
            }
            
            int index=0;
           
            if(pageNo.equals("null")){
                pageNo="1";
            }
         
            int id=Integer.parseInt(productId);
            
            ProductDetailes p[]=(ProductDetailes[])session.getAttribute("products");
            //this for loop for idetifuy the index 
            for(int i=0;i<p.length;i++){
                if(p[i].getPid()==id){
                    index=i;
                }
            }
                
            String type=p[index].getType();
            String brand=p[index].getBrand();
          
        %>
        <!-- perticular part display start -->
        <div class="container-fluid">
        <div class="row" style="margin-top: 100px; margin-bottom: 100px" >
            <div class="col-lg-4 offset-lg-2 col-md-5 offset-md-1 col-sm-6 text-center mt-5">
                <img class="img-fluid" src="components/img/product/<%= p[index].getPpic() %>" style="max-height:300px; max-width:100%; width:auto;">
            </div>
            <div class="m-0 col-lg-4 col-md-5 col-sm-6">
                    <h3 class="text-style"> <%= p[index].getPname() %> </h3>
                    <div class="mt-3 d-flex">
                        <h4><i class="text-muted fa fa-rupee-sign fa-1x"></i> <%= (int)(p[index].getPprice()-((p[index].getPdiscount()/100)*p[index].getPprice())) %>.0</h4>
                    <h6 class="ml-3" style="text-decoration:line-through; "> <%= p[index].getPprice() %> </h6>
                    <h5 class="ml-5 text-success"><%= p[index].getPdiscount() %>% OFF</h5>
                    </div>
                    <h6 class="text-muted"><%= p[index].getPdiscription() %></h6>
                    <h6 class="text-muted">Brand : <%= p[index].getBrand() %></h6>
                   <form action="cartManager.jsp" method="post" class="mt-5">
           
                            <input type="hidden" name="type" value="productPage">
                            <input type="hidden" name="pn" value="<%= p[index].getPid() %>">
                            <input type="hidden" name="name" value="<%= p[index].getPname() %>">
                            <input type="hidden" name="id" value="<%= p[index].getPid() %>">
                            <input type="hidden" name="price" value="<%= p[index].getPprice()-((p[index].getPdiscount()/100)*p[index].getPprice()) %>">
                            <button type="submit" class="btn btn-primary btn-sm">ADD TO CART</button>
                            <a class="btn btn-warning btn-sm" href="index.jsp?pno=<%= pageNo %>&type=<%= ptype %>">Continue Shopping</a>
                   </form>
                           
            </div>
            
        </div>
        </div>
        <!-- perticular product display part end -->
        <div id="Related" class="container-fluid alert-dark">
           <h3 class="mb-1 p-2 text-style text-primary"> Similar products </h3>
           <div class="row m-1 pb-5">
                
         <%
            boolean t=true;
          
            for(int i=0;i<p.length;i++)
            {
                if(type.equalsIgnoreCase(p[i].getType()) && brand.equalsIgnoreCase(p[i].getBrand())){
                    if(i==index)
                        continue;
                    t=false;
                    
                    %>
                    
                    <div class="col-lg-3 col-md-4 col-sm-6" onclick="pd('<%= p[i].getPid() %>','<%= request.getParameter("pno") %>','<%= p[i].getType() %>')">
                        <div id="card" class="card m-1" >
                           
                            <div class="card-header text-center  p-0"> <img class="m-1 image-fluid" src="components/img/product/<%= p[i].getPpic() %>" style="max-height:130px;max-width:100%; width:auto;  "></div>
                           <div class="card-body alert-dark p-0">
                            <div class="name"><%= p[i].getPname() %></div>
                            <div class="dis alert-dark text-muted m-0"><small><%= WordProvider.getTenWord(p[i].getPdiscription())  %></small> </div>
                            <div class="price text-right mx-3"><small class="fa fa-rupee-sign"></small> <%= p[i].getPprice() %></div>
                          
                           </div>
                              <small class="badge-pill mx-2"><%=(int)p[i].getPdiscount()%> %OFF</small>
                        </div>
                            
                    </div>
                    
                    
                    <%
                    
                }else{
                    continue;
                }
                
                
            }
         %>
         <% if(t){%> <script> relatedNull();  </script>   <%}%>
           </div>
        </div>
        
    </body>
</html>
