

<%@page import="java.util.List"%>
<%@page import="GeterAndSeter.CategoryDetailes"%>
<%@page import="GeterAndSeter.WordProvider"%>
<%@page import="GeterAndSeter.ProductDetailes"%>
<%@page import="database.DatabaseManager"%>
<%@page import="java.sql.*"%>
<%@page import="database.ConnectionProvider"%>

<!DOCTYPE html>
<html>
    <head>
       
        <title>JSP Page</title>
      
    </head>
    <body> 
       <%@ include file="navbar.jsp"%>
     
       <div class="container-fluid">
           

          
           
       <div class="row"><!--main row -->
         
           <div class="d-none d-sm-block col-sm-3 mt-4">
               <div class="list-group text-center card">
                   <%   
                        int specificProduct=0;
                       String name="all";
                    
                       name=request.getParameter("type");
                     if(name==null||name.equals("all")){    %>
                      <a href="index.jsp" class="text-style list-group-item bg-navbar text-light">ALL</a>
                     
                      <%}else{%>
                    <a href="index.jsp?type=all" class="text-style list-group-item">ALL</a>
                   <%}%>
                  
               
               <%
                                 
                                   for(CategoryDetailes catobj:cd)
                                    {
                                        String cname=catobj.getCname();
                                       
                                      if(name!=null){
                                            if(name.equals(cname))
                                        {
                                             %>
                                                <a href="index.jsp?type=<%= cname %>" class="text-style text-uppercase list-group-item bg-navbar text-light"><%=cname%></a>
                                             <%
                                            continue;
                                        }
                                        
                                      }
                                 %>
                                 <a href="index.jsp?type=<%= cname %>" class="text-style text-uppercase list-group-item"><%=cname%></a>
                                 <%}%>
               </div>
           </div>
           
               
      <!--product display part-->
            <div class="col-sm-9">
               
              
                
                
               <div class="row mt-4">
                <div class="p-0 mx-0 col-12">
                      <div class="card-columns"> 
                           
                       <%
                                   int pageNo=1;
                                   String pNo=(request.getParameter("pno"));
                                   if(pNo!=null){
                                       pageNo=Integer.parseInt(pNo);
                                   }
                                   int productLimit=6;
                                   int start=(pageNo-1)*productLimit;
                                   
                                    //we create the session for product detailes
                                    int flag=0;
                                    ProductDetailes pro[]=(ProductDetailes[])session.getAttribute("products");
                                    //if session is null  so we are conbtact to the server and get data one time
                                    if(pro==null){
                                        System.out.println("session are null");
                                        ProductDetailes p[]=new DatabaseManager(ConnectionProvider.con).getProduct();
                                        //set the data to session
                                        session.setAttribute("products",p);
                                        //and data take to the session
                                        pro=(ProductDetailes[])session.getAttribute("products");
                                        
                                        
                                    }
                                    
                                    if(name==null || name.equals("all"))
                                        { 
                                            for(int i=start;i<(start+productLimit);i++)
                                            {
                                                if(i>=pro.length){
                                                    break;
                                                }
                                              %>
                                            
                                          <!--All  type off product display-->      
                                          <div class="card hover" onclick="pd('<%= pro[i].getPid() %>','<%= request.getParameter("pno") %>','null')">
                                                  <div class="container text-center">
                                                  <img class="p-1 card-img" src="components/img/product/<%= pro[i].getPpic() %>" style="max-height:160px; max-width:100%; width:auto;" alt="" />
                                                  </div>
                                                
                                                  <div class="card-title text-center m-1"><%= WordProvider.getSevenWord(pro[i].getPname()) %></div>
                                                  <div class="card-body pt-0 text-muted"><small><%= WordProvider.getTenWord(pro[i].getPdiscription())%></small></div>
                                                  <div class="card-footer px-0 text-center">
                                                       
                                                      <form action="cartManager.jsp" method="post">
                             
                                                          <%
                                                                String typeName=request.getParameter("type");
                                                                if(typeName==null){
                                                                    typeName="all";
                                                                }
                                                          %>
                                                          <input type="hidden" name="type" value="<%= typeName%>">
                                                             <input type="hidden" name="pn" value="<%= pageNo %>">
                                                          <input type="hidden" name="name" value="<%= pro[i].getPname() %>">
                                                      <input type="hidden" name="id" value="<%= pro[i].getPid() %>">
                                                      <input type="hidden" name="price" value="<%= pro[i].getPprice()-((pro[i].getPdiscount()/100)*pro[i].getPprice()) %>">
                                                      <button type="submit" class="btn btn-primary btn-sm">ADD</button>
                                                      <a class=" btn btn-outline-success btn-sm"><%= (int)(pro[i].getPprice()-((pro[i].getPdiscount()/100)*pro[i].getPprice()))+"/- "%>&nbsp;<small class="text-muted"><%=(int)pro[i].getPprice()+"/- &nbsp;"+(int)pro[i].getPdiscount()+"%off" %></small></a>
                                                      </form>
                                                  </div> 
                                              </div>
                                                 
                                           
                                              
                                              
                                              <%
                                            }
                                         
                                            
                                            
                                        }else{
                                        
                                            ArrayList a=new ArrayList();
                                            for(ProductDetailes obj:pro){
                                                if(obj.getType().equalsIgnoreCase(name)){
                                                    a.add(obj);
                                                }
                                            }
                                            specificProduct=a.size();
                                          for(int i=start;i<(start+productLimit);i++)
                                            {
                                               
                                                if(i>=a.size()){
                                                    break;
                                                }
                                                   ProductDetailes sobj=(ProductDetailes)a.get(i);
                                                //this code specific condition product
                                                  if(!name.equals(sobj.getType()))
                                                  {
                                                      continue;
                                                  }else{
                                                     
                                                      flag=1;//this is identification for product are present are not
                                                     
                                                   
                                                     
                                              %>
                                            
                                               <!-- specific product display -->
                                              <div class="card hover" onclick="pd('<%= sobj.getPid() %>','<%= request.getParameter("pno") %>','<%= name %>' )">
                                                  <div class="container text-center">
                                                    <img class="p-1 card-img" src="components/img/product/<%= sobj.getPpic() %>" style="max-height:160px; max-width:100%; width:auto;" alt="" />
                                                  </div>
                                                  
                                                  <div class="card-title text-center text-style m-1"><%= sobj.getPname() %></div>
                                                  <div class="card-body pt-0 text-muted"><small><%=  WordProvider.getTenWord(sobj.getPdiscription()) %></small></div>
                                                  <div class="card-footer">
                                                      
                                                      <form action="cartManager.jsp" method="post">
                                                          
                                                            <%
                                                                String typeName=request.getParameter("type");
                                                                if(typeName==null){
                                                                    typeName="all";
                                                                }
                                                          %>
                                                          
                                                      <input type="hidden" name="type" value="<%= typeName %>">
                                                      <input type="hidden" name="pn" value="<%= pageNo %>">
                                                      <input type="hidden" name="name" value="<%= sobj.getPname() %>">
                                                      <input type="hidden" name="id" value="<%= sobj.getPid() %>">
                                                      <input type="hidden" name="price" value="<%= sobj.getPprice()-((sobj.getPdiscount()/100)*sobj.getPprice()) %>">
                                                      <button class="btn btn-primary btn-sm">ADD</button>
                                                          <button class=" btn btn-outline-success btn-sm"><%= (int)(sobj.getPprice()-((sobj.getPdiscount()/100)*sobj.getPprice()))+"/- "%>&nbsp;<small class="text-muted"><%=(int)sobj.getPprice()+"/- &nbsp;"+(int)sobj.getPdiscount()+"%off" %></small></button>
                                                      </form>
                                                  </div>
                                              </div>
                                                 
                                           
                                              
                                              
                                              <%
                                                  }
                                            }
                                           if(flag==0){%>
                                           <!--if product not present-->
                                               <h4>Product not present..</h4>
                                               <%
                                           }
                                       }//main else end
                                  
                        %>
                      </div>
                </div>
                           
        </div><!--product display row end-->
        
        <%  if(name==null || name.equals("all") ){   %>
                                            <!-- all product pagination -->
                                                  <ul class="pagination justify-content-center">
              
                                              <%
                                                    int n=pro.length/productLimit;
                                                    if(pageNo!=1){
                                                    %>
                                                    <li class="page-item" ><a href="index.jsp?pno=<%= pageNo-1 %>" class="page-link">&laquo;</a></li>
                                                    <%}else {  %>
                                                     <li class="page-item" ><a class="page-link">&laquo;</a></li>
                                                    <%
                                                    }
                                                    
                                                    for(int i=1;i<=n+1;i++){ 
                                                     if(i==pageNo){%>
                                                         <li class="active page-item"><a class="page-link" href="index.jsp?pno=<%=(int) i %>"><%= (int)i %></a></li>
                                                     <% continue; } %>
                                                    <li class="page-item"><a class="page-link" href="index.jsp?pno=<%=(int) i %>"><%= (int)i %></a></li>
                                                    
                                                    
                                                    <% } if(pageNo!=(n+1)){ %>
                                                    <li class="page-item"><a href="index.jsp?pno=<%= pageNo+1 %>" class="page-link">&raquo;</a></li>
                                                  <%} else {%>
                                                    <li class="page-item"><a class="page-link">&raquo;</a></li>
                                                    <%}%>
                                                  </ul>

       <% }else{  %>
       <!-- specific product pagination -->
                                                  <ul class="pagination justify-content-center">
              
                                              <%
                                                    int n= specificProduct/productLimit;
                                                    if(pageNo!=1){
                                                    %>
                                                    <li class="page-item" ><a href="index.jsp?pno=<%= pageNo-1 %>&type=<%= name %>" class="page-link">&laquo;</a></li>
                                                    <%}else {  %>
                                                     <li class="page-item" ><a class="page-link">&laquo;</a></li>
                                                    <%
                                                    }
                                                    
                                                    for(int i=1;i<=n+1;i++){
                                                         if(i==pageNo){%>
                                                         <li class="active page-item"><a class="page-link" href="index.jsp?type=<%= request.getParameter("type") %>&pno=<%=(int) i %>"><%= (int)i %></a></li>
                                                     <% continue; } %>
                                                     <li class="page-item"><a class="page-link" href="index.jsp?type=<%= request.getParameter("type") %>&pno=<%=(int) i %>"   ><%= (int)i %></a></li>
                                                    <% } if(pageNo!=(n+1)){ %>
                                                    <li class="page-item"><a href="index.jsp?pno=<%= pageNo+1 %>&type=<%= name %>" class="page-link">&raquo;</a></li>
                                                  <%} else {%>
                                                    <li class="page-item"><a class="page-link">&raquo;</a></li>
                                                    <%}%>
                                                  </ul>

       <% } %>
    </div><!--main product display col end-->
  </div><!--main row end-->
</div><!--container fluid end    the main container-->
</body>
</html>
