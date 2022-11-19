

<%@page import="java.sql.*"%>
<%-- 
    Document   : NormalUser
    Created on : Aug 15, 2020, 2:13:46 PM
    Author     : Admin
--%>

<%@page import="GeterAndSeter.Information"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Information ob=(Information)session.getAttribute("login");
    if(ob==null)
    {
        response.sendRedirect("login.jsp");
        return;
    }else if(!ob.getType().equalsIgnoreCase("Normal"))
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
          <div class="container my-5">
              <div class="row mt-3">
                  
                  <div class="col-sm-5">
                      <div class="card p-1 hover-cart-border">
                          
                          <div class="card-header">Information</div>
                      <!--for name display-->
                      <div class="input-group">
                          <div class="input-group-append">
                              <span class="input-group-text bg-support" style="border:none;">Name :&nbsp;&nbsp;&nbsp; </span>
                          </div>
                          <label class="text-muted form-control my-label bg-support"><%= ob.getName()%></label>
                      </div>
                      <!--for email display-->
                      <div class="input-group">
                          <div class="input-group-append">
                              <span class=" input-group-text bg-support" style="border:none;">E-mail :&nbsp;&nbsp; </span>
                          </div>
                          <label class="text-muted form-control my-label bg-support"><%= ob.getEmail() %></label>
                      </div>
                      <!--for mobile display-->
                      <div class="input-group">
                          <div class="input-group-append">
                              <span class="input-group-text bg-support" style="border:none;">Contact : </span>
                          </div>
                          <label class="text-muted form-control my-label bg-support"><%= ob.getPhon() %></label>
                      </div>
                      <!--for Address display-->
                      <div class="input-group">
                          <div class="input-group-append">
                              <span class="input-group-text bg-support" style="border:none;">Address : </span>
                          </div>
                          <label class="text-muted form-control my-label bg-support"><%= ob.getaddr() %></label>
                      </div>
                      
                      
                       <div class="card-footer text-muted text-right">
                           <!--button class="btn btn-sm btn-outline-warning" onclick="word()">Edit</button>
                            <button class="btn btn-sm btn-outline-danger">Delete Account</button -->
                           <small>All right reserved. </small>
                       </div>
                  </div>
                      <div class="card mt-3 hover-cart-border">
                          <div class="card-header">Order Now...</div>
                          <form action="OrderProduct" method="post">
                          <div class="card-body">
                              <input type="hidden" name="uid" value="<%= ob.getId() %>">
                                <div class="input-group">
                                     <div class="input-group-append">
                                        <span class="input-group-text bg-support" style="border:none;">Address : </span>
                                     </div>
                                     <input name="addr" class="form-control my-input" value="<%= ob.getaddr() %>" placeholder="Enter address for delivery">
                                </div>
                                
                                <div class="input-group">
                                     <div class="input-group-append">
                                        <span class="input-group-text bg-support" style="border:none;">Contact : </span>
                                     </div>
                                     <input name="contact" class="form-control my-input" value="<%= ob.getPhon() %>" placeholder="Enter contact number for anny issue">
                                </div>
                                <label class="mt-2">Payment by</label>
                                <select name="pay" class="form-control">
                                    <option> Paypal </option>
                                    <option> Cash On Delivery </option>
                                    <option> Net banking </option>
                                    <option> Goggle Bank </option>
                                    <option> Bank Transaction </option>
                                    
                                </select>
                                
                            
                          </div>
                                <div class="card-footer text-right">
                                     <a class="btn btn-outline-info btn-sm check-btn2" data-toggle="modal" data-target="#message" >Message</a>
                                     <button type="submit" class="btn btn-outline-success btn-sm check-btn2">Order Products</button>
                               
                               
                                </div>
                                
                          </form>

                      </div>
                      
                  </div><!--user info col end-->
                  
                  
                  
                  
                  <div class="col-sm-7">
                      <div class="card" style="height:75vh;">
                          <div class="card-header">
                              Your selected products
                          </div>
                         
                              <div class="cart-body data" style="overflow: auto;"></div>
                         
                             
                          
                      </div>
                  </div>
                 
              </div>
          </div>
                               
                               
                              <!--message modal is here-->
                              <div id="message" class="modal fade">
                                  <div class="modal-dialog">
                                      <div class="modal-content">
                                          <div class="modal-header text-light bg-navbar">
                                              Message Area
                                          </div>
                                          <form action="MessageServlet" method="post">
                                            <div class="modal-body">
                                                <input name="msgsender" type="hidden" value="user">
                                                <textarea name="message" rows="4" class="form-control" placeholder="Enter your message in short..."></textarea>
                                            </div>
                                         
                                          <div class="modal-footer">
                                              <button type="submit" class="btn btn-outline-primary">Send Message</button>
                                              <button data-dismiss="modal" class="btn btn-dark">Close</button>
                                          </div>
                                          </form>
                                      </div>
                                          
                                  </div>
                                      
                              </div>
                              
                             <div class=" px-lg-3 p-xmd-2 px-sm-1 my-3">
                                 
                              <%
                                boolean flag=true;
                               
                                String Query="select * from orders where states='processing' and uid="+ob.getId();
                                Statement st=ConnectionProvider.con.createStatement();
                                Statement st2=ConnectionProvider.con.createStatement();
                                ResultSet rs=st.executeQuery(Query);
                                
                                while(rs.next()){
                                    float total=0,charge=0;
                                    %>
                                    <div id="Related" class=" p-md-3 p-sm-2 p-1 p-lg-4 jumbotron alert-dark mt-1" >
                                      
                                        
                                    <table class="table table-responsive-sm table-hover table-bordered table-sm">
                                     <div class=" text-dark my-2">
                                         <h6 class="m-0">Order ID : <%= rs.getInt("oid") %> <a class="ml-5 rounded btn alert-info btn-sm m-1"><%= rs.getString("states") %></a><a onclick="orderD(<%= rs.getInt("oid") %>)" class="btn alert-danger btn-sm">Cancel Order</a></h6>
                                        <small class="mt-2"> Name : <%= ob.getName() %> </small><br>
                                        <small> Shiping Addres  : <%= rs.getString("addr") %> </small><br>
                                        <small> Contact No : <%= rs.getString("contact")%> </small><br>
                                        <small> Payment Type : <%= rs.getString("payment") %>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Charge : <%= rs.getString("charge")+"/- product" %>    </small>
                                     
                                     </div>
                                     
                                     <thead class="alert-secondary text-center">
                                            <td>Product Name</td>
                                            <td>product Price</td>
                                            <td>Quantity</td>
                                            <td>Cost</td>
                                            <td>Order Date</td>
                                           
                                            <td>Action</td>
                                      </thead>
                                    <%
                                      String q="select * from orderdata where oid="+rs.getInt("oid");
                                      ResultSet rs2=st2.executeQuery(q);
                                while(rs2.next()){
                                  
                                  
                                   
                                    flag=false;
                                    total+=rs2.getFloat("pprice")*rs2.getInt("pqun");
                                    charge+=rs.getInt("charge");
                                    
                                    %>
                                        <tr>
                                            <td><%= rs2.getString("pname") %></td>
                                            <td><%= rs2.getFloat("Pprice") %></td>
                                            <td><%= rs2.getInt("pqun") %></td>
                                            <td><%=  rs2.getFloat("pprice")*rs2.getInt("pqun") %>
                                            <td><%= rs.getString("time")%></td>
                                          
                                            <td class="text-center">
                                               
                                                <a onclick="orderD(<%= rs.getInt("oid") %>)" class="btn btn-danger btn-sm mt-1">Cancel</a>
                                            </td>
                                           
                                        </tr>
                                       
                                        
                                    
                                    <%
                                }
                              
                              %>
                              <tr>
                                  <td colspan="6" class="text-right">Total bill(charge + bill) : <%= total+charge %> </td>
                                      
                              </tr>
                                </table>
                                 </div>
                                  
                              <% } %>
                             </div>
                                
                                    <% if(flag){%> <script> relatedNull();  </script> <%} %>
       
                                    
                                    
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
