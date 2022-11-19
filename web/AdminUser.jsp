<%-- 
    Document   : AdminUser
    Created on : Aug 15, 2020, 2:13:15 PM
    Author     : Admin
--%>

<%@page import="GeterAndSeter.CategoryDetailes"%>
<%@page import="java.sql.*"%>
<%@page import="database.DatabaseManager"%>
<%@page import="database.ConnectionProvider"%>
<%@page import="GeterAndSeter.Information"%>
<%@page errorPage="ErrorPage.jsp"  %>
<%
    Information o=(Information)session.getAttribute("login");
    if(o==null)
    {
        response.sendRedirect("login.jsp");
      
    }else if(!o.getType().equalsIgnoreCase("admin"))
    {
        session.setAttribute("msg","You are not access this page..");
        session.setAttribute("msgType","error");
        session.setAttribute("msgTitle","Invalid User");
        
       response.sendRedirect("login.jsp");
    }




%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ include file="navbar.jsp"%>
        <div class="container adj">
        <% String type=request.getParameter("type");  
            if(type==null || type.equalsIgnoreCase("dashbord")){
        %>  
         
            <div class="row mt-3">
                <div class="col-sm-4 text-center p-0">
                    <div class="card card-hover">
                    <div class="card-body text-center p-0">
                        <img src="components/img/user.png" style="max-height:150px;max-width:150px;width:auto;" class=" card-img"  />
                        <h4>Users</h4>
                        <h4>
                            <%
                              int no=new DatabaseManager(ConnectionProvider.con).getUserCount();
                          
                            %>
                           <%= no %>
                        </h4>
                    
                    </div>
                    </div>
                </div>
                <div class="col-sm-4 text-center p-0">
                    <div class="card card-hover">
                    <div class="card-body text-center p-0">
                       
                        <img class="card-img" style="max-height:150px;max-width:150px;width:auto;" src="components/img/product.png" alt=""/>
                        <h4>Products</h4>
                        <h4>
                            <%
                              int no1=new DatabaseManager(ConnectionProvider.con).getProductCount();
                          
                            %>
                           <%= no1 %>
                        </h4>
                    
                    </div>
                    </div>
                </div>
                <div class="col-sm-4 p-0">
                    <div class="card card-hover">
                    <div class="card-body text-center p-0">
                        <img src="components/img/category.png" style="max-height:150px;max-width:150px;width:auto;" class="mt-3 card-img" alt=""/>
                        <h4>Category</h4>
                        <h4> <%
                              int no2=new DatabaseManager(ConnectionProvider.con).getCategoryCount();
                          
                            %>
                           <%= no2 %></h4>
                    
                    </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-sm-6 p-0 m-0" data-toggle="modal" data-target="#addproduct" >
                    <div class="card card-hover" >
                        <div class="card-body text-center p-0">
                            <img class="card-img" src="components/img/add.png" style="max-height:150px;max-width:150px;width:auto;" alt=""/>
                            <br><small class="text-muted"> Add the new product for selling </small>
                            <h4>Add Product</h4>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 p-0 m-0">
                    <div class="card card-hover" data-toggle="modal"  data-target="#addcategory">
                        <div class="card-body text-center p-0">
                            <img src="components/img/addcate.png" class="mt-3 card-img" style="max-height:150px;max-width:150px;width:auto;" alt=""/>
                             <br><small class="text-muted"> Add the new product category </small>
                            <h4>Add Category</h4>
                        </div>
                    </div>
                </div>
            </div>
                  </div>                 
                   
        <!--Add product modal-->
        <div id="addproduct" class="modal fade">
            <div class="modal-dialog modal-lg">
                <div class="modal-content" style="border:1px solid #0056b3;border-top:none;">
                    <div class="modal-header text-style text-light bg-navbar">
                        <h4>Add Products</h4>
                        <h4 class="btn" data-dismiss="modal">&times;</h4>
                    </div>
                    <div class="modal-body" >
                        <form action="ProductServlet" method="post" enctype="multipart/form-data">
                                 <input name="id" type="hidden" value="product"/>
                            <!-- product name -->
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-gift  bg-support" style="border:none"></span>
                                    </div>
                                    <input required name="pname" class="text-uppercase bg-support my-input form-control" placeholder="Product Name">
                                </div>

                                 <!--product price-->
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info bg-support pr-3 " style="border:none">$</span>
                                    </div>
                                    <input pattern="[0-9]{1,}" required name="pprice" class="bg-support my-input form-control" placeholder="Price">
                                </div>

                                 <!--product discount-->
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info  bg-support pl-1 " style="border:none">$D</span>
                                    </div>
                                    <input pattern="[0-9]{}" required name="pdis" class="bg-support my-input form-control" placeholder="Discount">
                                </div>
                                 
                                 <!--select category-->
                                 <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-list  bg-support pr-2 " style="border:none"></span>
                                    </div>
                                     <select name="type" required class="form-control bg-support my-input">
                                     <option selected>Select the product Category</option>
                                 <%
                                    CategoryDetailes cat[]=(CategoryDetailes[])session.getAttribute("category");
                                    if(cat==null){
                                        CategoryDetailes ca[]=new DatabaseManager(ConnectionProvider.con).getCategory();
                                        session.setAttribute("category",ca);
                                        cat=(CategoryDetailes[])session.getAttribute("category");
                                    }
                                    for(CategoryDetailes c:cat)
                                    {
                                        String cname=c.getCname();
                                 %>
                                    <option><%=cname%></option>
                                 <%}%>
                                 </select>
                                </div>
                                 
                                  <!-- brand name -->
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-gift  bg-support" style="border:none"></span>
                                    </div>
                                    <input required name="pbname" class="text-uppercase bg-support my-input form-control" placeholder="Brand Title">
                                </div>
                                 
                                 <!-- product pic -->
                                <div class="input-group mt-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-camera  bg-support pr-2 " style="border:none"></span>
                                    </div>
                                    <input required name="pic" type="file" class="bg-support my-input form-control">
                                </div>
                                 
                                <!-- product discripton -->
                                 <label class="mt-3">Product Discription : </label>
                                 <textarea required name="pdiscription" class="form-control"   placeholder="Enter the product disription"></textarea>

                             <div class="modal-footer pb-0 mt-1 pt-3">
                                 <button type="submit" class="btn btn-outline-success">Add Product</button>
                                 <button class="btn btn-outline-dark" data-dismiss="modal">Close</button>
                             </div>
                                 
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--Add product modal end-->
        
        
        <!--add category modal-->
        <div id="addcategory" class="modal fade">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="bg-navbar text-light modal-header">
                        <h4 class="text-style">Add Category</h4>
                         <h4 class="btn" data-dismiss="modal">&times;</h4>
                    </div>
                    <form action="ProductServlet" method="post">
                        <div class="modal-body">
                            <input name="id" type="hidden" value="category"/>
                             <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-gift  bg-support" style="border:none"></span>
                                    </div>
                                 <input required name="cname" class="bg-support my-input form-control text-uppercase" placeholder="Category Name">
                             </div>
                                <label class="mt-3">Category Discription : </label>
                                <textarea required="" name="cdis" class="form-control"   placeholder="Enter the category disription"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-outline-success">Add Category</button>
                            <button class=" btn btn-outline-dark" data-dismiss="modal">Close</button>
                        </div>
                    </form>
                </div>        
            </div>
        </div>
        <!--add category modal end-->
       
       
        <%} else
  //##################################################################################################################
                if(type.equalsIgnoreCase("users")){
           //in this part show the user detailes
                 Statement st=ConnectionProvider.con.createStatement();
          %>
          <form class="mb-5" action="AdminUser.jsp?type=users" method="post">
              <div class="justify-content-end input-group">
              <input required name="search" placeholder="Find the specific user by ID" type="text" class="form-control"/>
              <div class="input-group-append ">
                  <button type="submit" onclick="hideTable()" class="input-group-text fa fa-search"></button>
              </div>
              </div>
               <% String search=request.getParameter("search");
                if(search!=null){
                    int id=Integer.parseInt(search);
                    String q="select * from user where uid="+id;
                    ResultSet r=st.executeQuery(q);
                    if(r.next()){%>
                   <table id="htable" class="alert-info table table-responsive-md table-responsive-sm">
            <tr>
                <td>ID</td>
                <td>Name</td>
                <td>Email</td>
                <td>Phone</td>
                <td>Address</td>
                <td><a href="AdminUser.jsp?type=users" class="pt-0">X</a> </td>
                
            </tr>
            <tr class="alert-info">
                <td><%= r.getInt("uid") %></td>
                <td><%= r.getString("uname") %></td>
                <td><%= r.getString("uemail") %></td>
                <td><%= r.getString("uphon") %></td>
                <td><%= r.getString("uaddr") %></td>
            </tr>
                   </table>
                    <%}else{
                        session.setAttribute("msgType","error");
                        session.setAttribute("msgTitle","Invalid ID");
                        session.setAttribute("msg","Somthing went wrong please enter valid ID ..");
                    }
                            
                }
          %>
          </form>
          <h4 class="text-style">USER DETAILES</h4>
          <table id="htable" class="table table-responsive-md table-responsive-sm">
            <tr class="alert-dark">
                <td>ID</td>
                <td>Name</td>
                <td>Email</td>
                <td>Phone</td>
                <td>Address</td>
                
            </tr>
            <%
            int pageno=1;
             int limit=5;
            String pagenoString=request.getParameter("page");
            if(pagenoString!=null){
                pageno=Integer.parseInt(pagenoString);
            }
            int offset=((pageno - 1)*limit);
            String query="select * from user limit "+limit+" offset "+offset;
           
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){
                %>
                
                <tr >
                    
                    <td> <%= rs.getString("uid")%></td> 
                    <td> <%= rs.getString("uname")%></td> 
                    <td> <%= rs.getString("uemail")%></td> 
                    <td> <%= rs.getString("uphon")%></td> 
                    <td> <%= rs.getString("uaddr")%></td> 
                     
                </tr>
               
                
                
                <%
            }%>
             </table>
             
            <!-- user info pagination  code -->
              <ul class="pagination justify-content-end">
             <% int totalUser=new DatabaseManager(ConnectionProvider.con).getUserCount();
                int totalPage=totalUser/limit;
                totalPage+=1;
                if(pageno==1){
                     %>
                     <li class="page-item "><a class="page-link">&laquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=users&page=<%= pageno-1 %>" class="page-link">&laquo;</a></li>
                    <%
                }
            for(int i=1; i<=totalPage;i++){
                if(pageno==i){
                    %>
                    <li class="page-item active "><a class="page-link"><%= i %></a></li>
                    <%
                }else{
                   %>
                    <li class="page-item"><a href="AdminUser.jsp?type=users&page=<%= i %>" class="page-link"><%= i %></a></li>
                    <%
                }    
                
                 }
                if(pageno==totalPage){
                     %>
                     <li class="page-item "><a class="page-link">&raquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=users&page=<%= pageno+1 %>" class="page-link">&raquo;</a></li>
                    <%
                }%>
              </ul>   
            <!-- user info pagination end -->
            <%
        } else
    //####################################################################################################################
            if(type.equalsIgnoreCase("product")){
           //in this part show the user detailes
                 Statement st=ConnectionProvider.con.createStatement();
          %>
          <form class="mb-5" action="AdminUser.jsp?type=product" method="post">
              <div class="justify-content-end input-group">
              <input required name="search" placeholder="Find the product user by ID" type="text" class="form-control"/>
              <div class="input-group-append ">
                  <button type="submit" onclick="hideTable()" class="input-group-text fa fa-search"></button>
              </div>
              </div>
               <% String search=request.getParameter("search");
                if(search!=null){
                    int id=Integer.parseInt(search);
                    String q="select * from product where pid="+id;
                    ResultSet r=st.executeQuery(q);
                    if(r.next()){%>
                   <table id="htable" class="alert-info table table-responsive-md table-responsive-sm">
            <tr>
                <td>ID</td>
                <td>Name</td>
                <td>Price</td>
                <td>Discount</td>
                <td>Brand</td>
                <td>Action</td>
                <td><a href="AdminUser.jsp?type=product" class="pt-0">X</a> </td>
                
            </tr>
            <tr class="alert-info">
                <td><%= r.getInt("pid") %></td>
                <td><%= r.getString("pname") %></td>
                <td><%= r.getString("price") %></td>
                <td><%= r.getString("discount") %></td>
                <td><%= r.getString("brand") %></td>
                <td> <a  href="AdminUser.jsp?type=product&eid=<%= r.getInt("pid") %>&action=edit" class="btn-sm btn btn-warning">Edit</a><a onclick="productD(<%= r.getInt("pid") %>)" class="ml-2 text-light btn btn-danger btn-sm">Delete</a> </td>
            </tr>
                   </table>
                    <%}else{
                        session.setAttribute("msgType","error");
                        session.setAttribute("msgTitle","Invalid ID");
                        session.setAttribute("msg","Somthing went wrong please enter valid ID ..");
                    }
                            
                }
          %>
          </form>
          <h4 class="text-style">PRODUCT&nbsp; DETAILES</h4>
          <table id="htable" class="table table-responsive-md table-responsive-sm">
            <tr class="alert-dark">
               <td>ID</td>
                <td>Name</td>
                <td>Price</td>
                <td>Discount</td>
                <td>Brand</td>
                <td>Action</td>
                
            </tr>
            <%
            int pageno=1;
             int limit=5;
            String pagenoString=request.getParameter("page");
            if(pagenoString!=null){
                pageno=Integer.parseInt(pagenoString);
            }
            int offset=((pageno - 1)*limit);
            String query="select * from product limit "+limit+" offset "+offset;
           
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){
                %>
                
                <tr >
                    
                    <td> <%= rs.getString("pid")%></td> 
                    <td> <%= rs.getString("pname")%></td> 
                    <td> <%= rs.getString("price")%></td> 
                    <td> <%= rs.getString("discount")%></td> 
                    <td> <%= rs.getString("brand")%></td>
                    <td> <a  href="AdminUser.jsp?type=product&eid=<%= rs.getInt("pid") %>&action=edit" class="btn-sm btn btn-warning">Edit</a><a onclick="productD(<%= rs.getInt("pid") %>)" class="ml-2 text-light btn btn-danger btn-sm">Delete</a> </td>
                     
                </tr>
               
                
                
                <%
            }%>
             </table>
             
            <!-- product info pagination  code -->
              <ul class="pagination justify-content-end">
             <% int totalUser=new DatabaseManager(ConnectionProvider.con).getProductCount();
                int totalPage=totalUser/limit;
                 totalPage+=1;
                if(pageno==1){
                     %>
                     <li class="page-item "><a class="page-link">&laquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=product&page=<%= pageno-1 %>" class="page-link">&laquo;</a></li>
                    <%
                }
            for(int i=1; i<=(totalPage);i++){
                if(pageno==i){
                    %>
                    <li class="page-item active "><a class="page-link"><%= i %></a></li>
                    <%
                }else{
                   %>
                    <li class="page-item"><a href="AdminUser.jsp?type=product&page=<%= i %>" class="page-link"><%= i %></a></li>
                    <%
                }    
                
                 }
                if(pageno==totalPage){
                     %>
                     <li class="page-item "><a class="page-link">&raquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=product&page=<%= pageno+1 %>" class="page-link">&raquo;</a></li>
                    <%
                }%>
              </ul>   
            <!-- product info pagination end -->
            <%
              // for edit the product  
              String action=request.getParameter("action");
                if(action!=null){
                   int eid=Integer.parseInt(request.getParameter("eid"));
                   String q2="select * from product where pid="+eid;
                   ResultSet r2=st.executeQuery(q2);
                   if(r2.next()){
                     %>
                           <!--edit product card-->
        
        
                <div style="margin:100px 0 100px 0; border:1px solid #0056b3;border-top:none;" class="card">
                    <div class="card-header text-style text-light bg-navbar">
                        <h5>Edit Products</h5>
                    </div>
                    <div class="card-body" >
                        <form action="ProductServlet" method="post">
                                 <input name="id" type="hidden" value="editProduct"/>
                                 <input name="eid" type="hidden" value="<%= r2.getInt("pid") %>">
                            <!-- product name -->
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-gift  bg-support" style="border:none"></span>
                                    </div>
                                    <input required name="pname" value="<%= r2.getString("pname") %>" class="text-uppercase bg-support my-input form-control" placeholder="Product Name">
                                </div>

                                 <!--product price-->
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info bg-support pr-3 " style="border:none">$</span>
                                    </div>
                                    <input value="<%= r2.getFloat("price") %>" pattern="[0-9.]{1,}" required name="pprice" class="bg-support my-input form-control" placeholder="Price">
                                </div>

                                 <!--product discount-->
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info  bg-support pl-1 " style="border:none">$D</span>
                                    </div>
                                    <input value="<%= r2.getInt("discount") %>" pattern="[0-9]{}" required name="pdis" class="bg-support my-input form-control" placeholder="Discount">
                                </div>
                                 
                                 <!--select category-->
                                 <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-list  bg-support pr-2 " style="border:none"></span>
                                    </div>
                                     <select name="type" required class="form-control bg-support my-input">
                                         <option selected><%= r2.getString("cname") %></option>
                                 <%
                                    CategoryDetailes cat[]=(CategoryDetailes[])session.getAttribute("category");
                                    if(cat==null){
                                        CategoryDetailes ca[]=new DatabaseManager(ConnectionProvider.con).getCategory();
                                        session.setAttribute("category",ca);
                                        cat=(CategoryDetailes[])session.getAttribute("category");
                                    }
                                    for(CategoryDetailes c:cat)
                                    {
                                        String cname=c.getCname();
                                 %>
                                    <option><%=cname%></option>
                                 <%}%>
                                 </select>
                                </div>
                                 
                                  <!-- brand name -->
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-gift  bg-support" style="border:none"></span>
                                    </div>
                                    <input value="<%= r2.getString("brand") %>" required name="pbname" class="text-uppercase bg-support my-input form-control" placeholder="Brand Title">
                                </div>
                                
                                <label class="mt-3">Discription </label>
                                    <textarea name="pdiscription" rows="6" class=" form-control"><%= r2.getString("discription") %></textarea>
                               
                            
                             <div class="card-footer text-right pb-0 mt-1 pt-3">
                                 <button type="submit" class="btn btn-outline-success">Save Update</button>
                                 <a href="AdminUser.jsp?type=product" class="btn btn-dark">Cancel</a>
                             </div>
                                 
                        </form>
                    </div>
                </div>
            <!--edit product card end-->
                       <%
                   }
                }
                
        }else
   //################################################################################################################             
               if(type.equalsIgnoreCase("process")){
           //in this part show the user detailes
                 Statement st=ConnectionProvider.con.createStatement();
          %>
          <form class="mb-5" action="AdminUser.jsp?type=process" method="post">
              <div class="justify-content-end input-group">
              <input required name="search" placeholder="Find the specific order by ID" type="text" class="form-control"/>
              <div class="input-group-append ">
                  <button type="submit" class="input-group-text fa fa-search"></button>
              </div>
              </div>
               <% String search=request.getParameter("search");
                if(search!=null){
                    int id=Integer.parseInt(search);
                    String q="select * from orders where states='processing' and oid="+id;
                    ResultSet r=st.executeQuery(q);
                    if(r.next()){%>
                   <table id="htable" class="alert-info table table-responsive-md table-responsive-sm">
            <tr>
                <td>ID</td>
                <td>Time</td>
                <td>Address</td>
                <td>Contact</td>
                <td>Payment</td>
                <td>Change States</td>
                <td>products</td>
                <td><a href="AdminUser.jsp?type=process" class="pt-0">X</a> </td>
                
            </tr>
            <tr class="alert-info">
                <td><%= r.getInt("oid") %></td>
                <td><%= r.getString("time") %></td>
                <td><%= r.getString("addr") %></td>
                <td><%= r.getString("contact") %></td>
                <td><%= r.getString("payment") %></td>
                  <td> <a onclick="complete(<%= r.getInt("oid")%>)" class="btn btn-sm btn-outline-primary">Turn To Complete</a> </td>
                  <td> <a  href="AdminUser.jsp?type=process&oid=<%= r.getInt("oid") %>&action2=see"  class="btn alert-primary btn-sm">See Detailes</a>  </td>
                  </tr>
                   </table>
                    <%}else{
                        session.setAttribute("msgType","error");
                        session.setAttribute("msgTitle","Invalid ID");
                        session.setAttribute("msg","Somthing went wrong please enter valid ID ..");
                    }
                            
                }
          %>
          </form>
          <h4 class="text-style">PROCESSING-ORDER &nbsp; DETAILES</h4>
          <table id="htable" class="table table-responsive-md table-responsive-sm">
            <tr class="alert-dark">
                <td>ID</td>
                <td>Time</td>
                <td>Address</td>
                <td>Contact</td>
                <td>Payment</td>
                <td>Change States</td>
                <td>products</td>
                
            </tr>
            <%
            int pageno=1;
             int limit=5;
             int d=0;//this d for check order is yes or no
            String pagenoString=request.getParameter("page");
            if(pagenoString!=null){
                pageno=Integer.parseInt(pagenoString);
            }
            int offset=((pageno - 1)*limit);
            String query="select * from orders where states='processing' limit "+limit+" offset "+offset;
           
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){
                d=1;
                %>
                
                <tr >
                    
                <td><%= rs.getInt("oid") %></td>
                <td><%= rs.getString("time") %></td>
                <td><%= rs.getString("addr") %></td>
                <td><%= rs.getString("contact") %></td>
                <td><%= rs.getString("payment") %></td>
                <td> <a onclick="complete(<%= rs.getInt("oid")%>)" class="btn btn-sm btn-outline-primary">Turn To Complete</a> </td>
                <td> <a  href="AdminUser.jsp?type=process&oid=<%= rs.getInt("oid") %>&action2=see"  class="btn alert-primary btn-sm">See Detailes</a>  </td>
                </tr>
               
                
                
                <%
            } 
               
                %>
             </table>
             
            <!-- user info pagination  code -->
              <ul class="pagination justify-content-end check"><!--check class is check to oredr are present or not-->
             <% int totalUser=new DatabaseManager(ConnectionProvider.con).getOrderProcessCount();
                int totalPage=totalUser/limit;
                totalPage+=1;
                if(pageno==1){
                     %>
                     <li class="page-item "><a class="page-link">&laquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=users&page=<%= pageno-1 %>" class="page-link">&laquo;</a></li>
                    <%
                }
            for(int i=1; i<=totalPage;i++){
                if(pageno==i){
                    %>
                    <li class="page-item active "><a class="page-link"><%= i %></a></li>
                    <%
                }else{
                   %>
                    <li class="page-item"><a href="AdminUser.jsp?type=users&page=<%= i %>" class="page-link"><%= i %></a></li>
                    <%
                }    
                
                 }
                if(pageno==totalPage){
                     %>
                     <li class="page-item "><a class="page-link">&raquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=users&page=<%= pageno+1 %>" class="page-link">&raquo;</a></li>
                    <%
                }%>
              </ul>   
            <!-- user info pagination end -->
            <%
                //if no active order present
                 if(d==0){
                    %>
                    <script>
                        noOrder();
                    </script>
                    <%
                }
                 
                 
                 //if view the purcular order products product
                 String action2=request.getParameter("action2");
                 if(action2!=null){
                     int viewId=Integer.parseInt(request.getParameter("oid"));
                     String query2="select * from orderdata,orders where orderdata.oid=orders.oid and orderdata.oid="+viewId;
                     ResultSet rs2 =st.executeQuery(query2);
                     float total=0;
                     %>
                     <div  style="margin:100px 0px 100px 0px;border:1px solid #0099ff" class="p-3">
                         <h4 class="text-right"><a href="AdminUser.jsp?type=process">X</a></h4>
                         <h3>Order Detailes </h3>
                <table class="table  table-responsive-md table-responsive-sm">
                <tr class="alert-">
                    <td>Order ID</td>
                    <td>Product Name</td>
                    <td>Price</td>
                    <td>Quantity</td>
                    <td>Charge</td>
                    <td>User ID </td>
                  
               </tr>
                     <%
                     while(rs2.next()){
                         total+=rs2.getFloat("pprice")*rs2.getInt("pqun")+rs2.getInt("charge");
                     %>
                     <tr>
                         <td><%= rs2.getInt("oid") %></td>
                         <td><%= rs2.getString("pname") %></td>
                         <td><%= rs2.getString("pprice") %></td>
                         <td><%= rs2.getString("pqun") %></td>
                         <td><%= rs2.getInt("charge") %></td>
                         <td><%= rs2.getString("uid") %></td>
                     </tr>
                             
                    
                     
                     
                     
                     
                     <%
                     }//while loop end
                     %>
                     <tr class="text-right">
                         <td colspan="6">Total Bill (<small>including charge </small>) :&nbsp;&nbsp;<%= total %></td>
                     </tr>
                </table>
                     </div>
                     <%
                 }//if action loop end
                 
        }else
//###########################################################################################################
           if(type.equalsIgnoreCase("complate")){
           //in this part show the complate order detailes
                 Statement st=ConnectionProvider.con.createStatement();
          %>
          <form class="mb-5" action="AdminUser.jsp?type=complate" method="post">
              <div class="justify-content-end input-group">
              <input required name="search" placeholder="Find the specific order by ID" type="text" class="form-control"/>
              <div class="input-group-append ">
                  <button type="submit" class="input-group-text fa fa-search"></button>
              </div>
              </div>
               <% String search=request.getParameter("search");
                if(search!=null){
                    int id=Integer.parseInt(search);
                    String q="select * from orders where states='complate' and oid="+id;
                    ResultSet r=st.executeQuery(q);
                    if(r.next()){%>
                   <table id="htable" class="alert-info table table-responsive-md table-responsive-sm">
            <tr>
                <td>ID</td>
                <td>Time</td>
                <td>Address</td>
                <td>Contact</td>
                <td>Payment</td>
                <td>States</td>
                <td>products</td>
                <td><a href="AdminUser.jsp?type=complate" class="pt-0">X</a> </td>
                
            </tr>
            <tr class="alert-info">
                <td><%= r.getInt("oid") %></td>
                <td><%= r.getString("time") %></td>
                <td><%= r.getString("addr") %></td>
                <td><%= r.getString("contact") %></td>
                <td><%= r.getString("payment") %></td>
                <td> Complete </td>
                <td> <a  href="AdminUser.jsp?type=complate&wid=<%= r.getInt("oid") %>&action3=see"  class="btn alert-primary btn-sm">See Detailes</a>  </td>
                  </tr>
                   </table>
                    <%}else{
                        session.setAttribute("msgType","error");
                        session.setAttribute("msgTitle","Invalid ID");
                        session.setAttribute("msg","Somthing went wrong please enter valid ID ..");
                    }
                            
                }
          %>
          </form>
          <h4 class="text-style">COMPLATED-ORDER &nbsp; DETAILES</h4>
          <table id="htable" class="table table-responsive-md table-responsive-sm">
            <tr class="alert-dark">
                <td>ID</td>
                <td>Time</td>
                <td>Address</td>
                <td>Contact</td>
                <td>Payment</td>
                <td>States</td>
                <td>products</td>
                
            </tr>
            <%
            int pageno=1;
             int limit=5;
             int d=0;//this d for check order is yes or no
            String pagenoString=request.getParameter("page");
            if(pagenoString!=null){
                pageno=Integer.parseInt(pagenoString);
            }
            int offset=((pageno - 1)*limit);
            String query="select * from orders where states='complate' limit "+limit+" offset "+offset;
           
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){
                d=1;
                %>
                
                <tr >
                    
                <td><%= rs.getInt("oid") %></td>
                <td><%= rs.getString("time") %></td>
                <td><%= rs.getString("addr") %></td>
                <td><%= rs.getString("contact") %></td>
                <td><%= rs.getString("payment") %></td>
                <td>Complete</td>
                <td> <a  href="AdminUser.jsp?type=complate&wid=<%= rs.getInt("oid") %>&action3=see"  class="btn alert-primary btn-sm">See Detailes</a>  </td>
                </tr>
               
                
                
                <%
            } 
               
                %>
             </table>
             
            <!-- user info pagination  code -->
             <ul class="pagination justify-content-end check"><!--check class is check to oredr are present or not-->
                 <% int totalUser=new DatabaseManager(ConnectionProvider.con).getOrderComplateCount();
                int totalPage=totalUser/limit;
                totalPage+=1;
                if(pageno==1){
                     %>
                     <li class="page-item "><a class="page-link">&laquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=complate&page=<%= pageno-1 %>" class="page-link">&laquo;</a></li>
                    <%
                }
            for(int i=1; i<=totalPage;i++){
                if(pageno==i){
                    %>
                    <li class="page-item active "><a class="page-link"><%= i %></a></li>
                    <%
                }else{
                   %>
                    <li class="page-item"><a href="AdminUser.jsp?type=complate&page=<%= i %>" class="page-link"><%= i %></a></li>
                    <%
                }    
                
                 }
                if(pageno==totalPage){
                     %>
                     <li class="page-item "><a class="page-link">&raquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=complate&page=<%= pageno+1 %>" class="page-link">&raquo;</a></li>
                    <%
                }%>
              </ul>   
            <!-- user info pagination end -->
            <%
                //if no active order present
                 if(d==0){
                    %>
                    <script>
                        noOrder();
                    </script>
                    <%
                }
                 
                 
                 //if view the purcular order products product
                 String action2=request.getParameter("action3");
                 if(action2!=null){
                     int viewId=Integer.parseInt(request.getParameter("wid"));
                     String query2="select * from orderdata,orders where orderdata.oid=orders.oid and orderdata.oid="+viewId;
                     ResultSet rs2 =st.executeQuery(query2);
                     float total=0;
                     %>
                     <div  style="margin:100px 0px 100px 0px;border:1px solid #0099ff" class="p-3">
                         <h4 class="text-right"><a href="AdminUser.jsp?type=complate">X</a></h4>
                         <h3>Order Detailes </h3>
                <table class="table  table-responsive-md table-responsive-sm">
                <tr class="alert-">
                    <td>Order ID</td>
                    <td>Product Name</td>
                    <td>Price</td>
                    <td>Quantity</td>
                    <td>Charge</td>
                    <td>User ID </td>
                  
               </tr>
                     <%
                     while(rs2.next()){
                         total+=rs2.getFloat("pprice")*rs2.getInt("pqun")+rs2.getInt("charge");
                     %>
                     <tr>
                         <td><%= rs2.getInt("oid") %></td>
                         <td><%= rs2.getString("pname") %></td>
                         <td><%= rs2.getString("pprice") %></td>
                         <td><%= rs2.getString("pqun") %></td>
                         <td><%= rs2.getInt("charge") %></td>
                         <td><%= rs2.getString("uid") %></td>
                     </tr>
                             
                    
                     
                     
                     
                     
                     <%
                     }//while loop end
                     %>
                     <tr class="text-right">
                         <td colspan="6">Total Bill (<small>including charge </small>) :&nbsp;&nbsp;<%= total %></td>
                     </tr>
                </table>
                     </div>
                     <%
                 }//if action loop end
                 
        }else
//####################################################################################################################
            if(type.equalsIgnoreCase("me")){
           //in this part show the user detailes
           Statement st=ConnectionProvider.con.createStatement();
          %>
          <form class="mb-5" action="AdminUser.jsp?type=category" method="post">
              <div class="justify-content-end input-group">
              <input required name="search" placeholder="Find the specific Category..." type="text" class="form-control"/>
              <div class="input-group-append ">
                  <button type="submit" onclick="hideTable()" class="input-group-text fa fa-search"></button>
              </div>
              </div>
               <% String search=request.getParameter("search");
                if(search!=null){
                    
                    String q="select * from category where cname='"+search+"'";
                    ResultSet r=st.executeQuery(q);
                    if(r.next()){%>
                   <table id="htable" class="alert-info table table-responsive-md table-responsive-sm">
            <tr>
                <td>Category Name</td>
                <td>Category Discription</td>
                <td>Action</td>
                <td><a href="AdminUser.jsp?type=category" class="pt-0">X</a> </td>
                
            </tr>
            <tr class="alert-info">
                <td><%= r.getString("cname") %></td>
                <td><%= r.getString("cdiscription") %></td>
                <td><a href="AdminUser.jsp?type=category&cname=<%= r.getString("cname") %>&action4=category" class="btn-sm btn btn-warning">Edit</a></td>
            </tr>
                   </table>
                    <%}else{
                        session.setAttribute("msgType","error");
                        session.setAttribute("msgTitle","Invalid ID");
                        session.setAttribute("msg","Somthing went wrong please enter valid ID ..");
                    }
                            
                }
          %>
          </form>
          <h4 class="text-style">CATEGORY&nbsp; DETAILES</h4>
          <table id="htable" class="table table-responsive-md table-responsive-sm">
            <tr class="alert-dark">
              <td>Category Name</td>
              <td>Category Discription</td>
              <td>Action</td>  
                
            </tr>
            <%
            int pageno=1;
             int limit=5;
            String pagenoString=request.getParameter("page");
            if(pagenoString!=null){
                pageno=Integer.parseInt(pagenoString);
            }
            int offset=((pageno - 1)*limit);
            String query="select * from category limit "+limit+" offset "+offset;
           
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){
                %>
                
                <tr>
                    
                <td><%= rs.getString("cname") %></td>
                <td><%= rs.getString("cdiscription") %></td>
                <td><a href="AdminUser.jsp?type=category&cname=<%= rs.getString("cname") %>&action4=category" class="btn-sm btn btn-warning">Edit</a></td>
                </tr>
               
                
                
                <%
            }%>
             </table>
             
            <!-- product info pagination  code -->
              <ul class="pagination justify-content-end">
             <% int totalUser=new DatabaseManager(ConnectionProvider.con).getCategoryCount();
                int totalPage=totalUser/limit;
                 totalPage+=1;
                if(pageno==1){
                     %>
                     <li class="page-item "><a class="page-link">&laquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=category&page=<%= pageno-1 %>" class="page-link">&laquo;</a></li>
                    <%
                }
            for(int i=1; i<=(totalPage);i++){
                if(pageno==i){
                    %>
                    <li class="page-item active "><a class="page-link"><%= i %></a></li>
                    <%
                }else{
                   %>
                    <li class="page-item"><a href="AdminUser.jsp?type=category&page=<%= i %>" class="page-link"><%= i %></a></li>
                    <%
                }    
                
                 }
                if(pageno==totalPage){
                     %>
                     <li class="page-item "><a class="page-link">&raquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?typy=category&page=<%= pageno+1 %>" class="page-link">&raquo;</a></li>
                    <%
                }%>
              </ul>   
            <!-- product info pagination end -->
            <%
            //edit category discription
            String c=request.getParameter("action4");
                if(c!=null){
                    String category=request.getParameter("cname");
                    String Query="select * from category where cname='"+category+"'";
                    ResultSet rs3=st.executeQuery(Query);
                    if(rs3.next()){
                        %>
                        
                   <!-- edit category card-->
                <div class="card" style="margin:100px 0px 100px 0px; border:1px solid #0056b3">
                    <div class="bg-navbar text-light card-header">
                        <h4 class="text-style">Edit Category</h4>
                    </div>
                    <form action="ProductServlet" method="post">
                        <div class="card-body">
                            <input name="id" type="hidden" value="editCategory"/>
                            <input name="cname" type="hidden" value="<%= rs3.getString("cname") %>">
                             <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-gift  bg-support" style="border:none"></span>
                                    </div>
                                 <input disabled value="<%= rs3.getString("cname") %>" required class="bg-support my-input form-control text-uppercase" placeholder="Category Name">
                             </div>
                                <label class="mt-3">Category Discription : </label>
                                <textarea required="" name="cdis" class="form-control"   placeholder="Enter the category disription"><%= rs3.getString("cdiscription") %></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-outline-success">Save Updates</button>
                            <a href="AdminUser.jsp?type=category" class=" btn btn-outline-dark">Close</a>
                        </div>
                    </form>
                </div>        
                  <!--edit category card end--> 
                        <%
                    }  
                }// c!=null if end   
          }else   //category discription end
                
                 if(type.equalsIgnoreCase("category")){
           //in this part show the user detailes
                 Statement st=ConnectionProvider.con.createStatement();
          %>
          <form class="mb-5" action="AdminUser.jsp?type=category" method="post">
              <div class="justify-content-end input-group">
              <input required name="search" placeholder="Find the specific Category..." type="text" class="form-control"/>
              <div class="input-group-append ">
                  <button type="submit" onclick="hideTable()" class="input-group-text fa fa-search"></button>
              </div>
              </div>
               <% String search=request.getParameter("search");
                if(search!=null){
                    
                    String q="select * from category where cname='"+search+"'";
                    ResultSet r=st.executeQuery(q);
                    if(r.next()){%>
                   <table id="htable" class="alert-info table table-responsive-md table-responsive-sm">
            <tr>
                <td>Category Name</td>
                <td>Category Discription</td>
                <td>Action</td>
                <td><a href="AdminUser.jsp?type=category" class="pt-0">X</a> </td>
                
            </tr>
            <tr class="alert-info">
                <td><%= r.getString("cname") %></td>
                <td><%= r.getString("cdiscription") %></td>
                <td><a href="AdminUser.jsp?type=category&cname=<%= r.getString("cname") %>&action4=category" class="btn-sm btn btn-warning">Edit</a></td>
            </tr>
                   </table>
                    <%}else{
                        session.setAttribute("msgType","error");
                        session.setAttribute("msgTitle","Invalid ID");
                        session.setAttribute("msg","Somthing went wrong please enter valid ID ..");
                    }
                            
                }
          %>
          </form>
          <h4 class="text-style">CATEGORY&nbsp; DETAILES</h4>
          <table id="htable" class="table table-responsive-md table-responsive-sm">
            <tr class="alert-dark">
              <td>Category Name</td>
              <td>Category Discription</td>
              <td>Action</td>  
                
            </tr>
            <%
            int pageno=1;
             int limit=5;
            String pagenoString=request.getParameter("page");
            if(pagenoString!=null){
                pageno=Integer.parseInt(pagenoString);
            }
            int offset=((pageno - 1)*limit);
            String query="select * from category limit "+limit+" offset "+offset;
           
            ResultSet rs=st.executeQuery(query);
            while(rs.next()){
                %>
                
                <tr>
                    
                <td><%= rs.getString("cname") %></td>
                <td><%= rs.getString("cdiscription") %></td>
                <td><a href="AdminUser.jsp?type=category&cname=<%= rs.getString("cname") %>&action4=category" class="btn-sm btn btn-warning">Edit</a></td>
                </tr>
               
                
                
                <%
            }%>
             </table>
             
            <!-- product info pagination  code -->
              <ul class="pagination justify-content-end">
             <% int totalUser=new DatabaseManager(ConnectionProvider.con).getCategoryCount();
                int totalPage=totalUser/limit;
                 totalPage+=1;
                if(pageno==1){
                     %>
                     <li class="page-item "><a class="page-link">&laquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?type=category&page=<%= pageno-1 %>" class="page-link">&laquo;</a></li>
                    <%
                }
            for(int i=1; i<=(totalPage);i++){
                if(pageno==i){
                    %>
                    <li class="page-item active "><a class="page-link"><%= i %></a></li>
                    <%
                }else{
                   %>
                    <li class="page-item"><a href="AdminUser.jsp?type=category&page=<%= i %>" class="page-link"><%= i %></a></li>
                    <%
                }    
                
                 }
                if(pageno==totalPage){
                     %>
                     <li class="page-item "><a class="page-link">&raquo;</a></li>
                    <%
                }else{
                     %>
                     <li class="page-item  "><a href="AdminUser.jsp?typy=category&page=<%= pageno+1 %>" class="page-link">&raquo;</a></li>
                    <%
                }%>
              </ul>   
            <!-- product info pagination end -->
            <%
            //edit category discription
            String c=request.getParameter("action4");
                if(c!=null){
                    String category=request.getParameter("cname");
                    String Query="select * from category where cname='"+category+"'";
                    ResultSet rs3=st.executeQuery(Query);
                    if(rs3.next()){
                        %>
                        
                   <!-- edit category card-->
                <div class="card" style="margin:100px 0px 100px 0px; border:1px solid #0056b3">
                    <div class="bg-navbar text-light card-header">
                        <h4 class="text-style">Edit Category</h4>
                    </div>
                    <form action="ProductServlet" method="post">
                        <div class="card-body">
                            <input name="id" type="hidden" value="editCategory"/>
                            <input name="cname" type="hidden" value="<%= rs3.getString("cname") %>">
                             <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text text-info fa fa-gift  bg-support" style="border:none"></span>
                                    </div>
                                 <input disabled value="<%= rs3.getString("cname") %>" required class="bg-support my-input form-control text-uppercase" placeholder="Category Name">
                             </div>
                                <label class="mt-3">Category Discription : </label>
                                <textarea required="" name="cdis" class="form-control"   placeholder="Enter the category disription"><%= rs3.getString("cdiscription") %></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-outline-success">Save Updates</button>
                            <a href="AdminUser.jsp?type=category" class=" btn btn-outline-dark">Close</a>
                        </div>
                    </form>
                </div>        
                  <!--edit category card end--> 
                        <%
                    }  
                }// c!=null if end   
          }
                
       %>
        
        
       
       
       <!-- admin dashboard sidebar -->
        <div class="sidebar2 text-center">
           
            <div class="p-2" >
                <a href="AdminUser.jsp?type=dashbord"><span class="text-light fas fa-poll "></span> </a><br>
            </div>
            <div class="p-2">
                <a href="AdminUser.jsp?type=users"><span class="text-light fas fa-users "></span> </a><br>
            </div>
            <div class="p-2">
                <a href="AdminUser.jsp?type=complate"><span class=" text-light fas fa-clipboard-check"></span> </a><br>
            </div>
            <div class="p-2">
                <a href="AdminUser.jsp?type=process"><span class=" text-light fas fa-shipping-fast"></span> </a><br>
            </div>
            <div class="p-2">
                <a href="AdminUser.jsp?type=category"><span class=" text-light fas fa-boxes"></span> </a><br>
            </div>
            <div class="p-2">
                <a href="AdminUser.jsp?type=product"><span class="text-light fas fa-warehouse"></span> </a><br>
            </div>
            <div class="p-2">
                <a href="AdminUser.jsp?type=message"><span class="text-light fas fa-envelope"></span> </a><br>
            </div>
        </div>
        <!-- admin dashboard sidebar end -->
        
        
        
        <%
        String msgType=(String)session.getAttribute("msgType");
        String msgTitle=(String)session.getAttribute("msgTitle");
        String msg= (String)session.getAttribute("msg");
       
        if(msgType!=null)
        {
        %>
          <script>
           swal.fire({
               title:'<%= msgTitle %>',
               text:'<%= msg   %>',
               icon:'<%= msgType %>',
               
               
           })     
        
        
         </script>
         <%
        }
        session.removeAttribute("msgType");
        session.removeAttribute("msg");
        session.removeAttribute("msgTitle");

        %>
        
    </body>
</html>
