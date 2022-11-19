<%-- 
    Document   : product
    Created on : Sep 4, 2020, 9:05:31 AM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="GeterAndSeter.selectedProduct"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
     
        <%
        float price=Float.parseFloat(request.getParameter("price"));
        String name=request.getParameter("name");
        int id=Integer.parseInt(request.getParameter("id"));
        String type=request.getParameter("type");
        String pno=request.getParameter("pn");
        if(pno==null){
            pno="1";
        }
             
            
         
        if (name!=null){
       ArrayList array=(ArrayList)session.getAttribute("cart");
      
       
       out.println(array +"<br><br>");
               if(array==null){
                   ArrayList<selectedProduct> Cart=new ArrayList<selectedProduct>();
                   selectedProduct obj=new selectedProduct(name,id,1,price);
                   Cart.add(obj);
                   session.setAttribute("cart",Cart);
                   //"first product"
                   session.setAttribute("swal","fp");
                  
                   if(type.equalsIgnoreCase("all") || type==null){
                   response.sendRedirect("index.jsp?pno="+pno);
                   }else if(type.equalsIgnoreCase("productPage")){
                       response.sendRedirect("ProductPage.jsp?shopper="+pno+"&pno=null&type=null");
                   }else{
                       response.sendRedirect("index.jsp?type="+type);
                      
                           
                   }
                   
               }else{
                   boolean action=true;
                   for(Object cartData:array)
                   {
                       selectedProduct data=(selectedProduct)cartData;
                       if(data.getPid()==id){
                           
                           data.setQuantity(data.getPquantity()+1);
                           action=false;
                           //Quantity increased..
                           session.setAttribute("swal","qi");
                         
                           if(type==null || type.equalsIgnoreCase("all")){
                             response.sendRedirect("index.jsp?pno="+pno);
                           }else if(type.equalsIgnoreCase("productPage")){
                             response.sendRedirect("ProductPage.jsp?shopper="+pno+"&pno=null&type=null");
                            }else{
                             response.sendRedirect("index.jsp?type="+type);
                                }    
                   
                            break;
                       }
                   }
                   
                   if(action){
                   
                   selectedProduct obj=new selectedProduct(name,id,1,price);
                   array.add(obj);
                   session.setAttribute("cart",array);
                   //new Product
                    session.setAttribute("swal","np");
                           if(type==null || type.equalsIgnoreCase("all")){
                             response.sendRedirect("index.jsp?pno="+pno);
                           }else  if(type.equalsIgnoreCase("productPage")){
                                 response.sendRedirect("ProductPage.jsp?shopper="+pno+"&pno=null&type=null");
                            }else{
                             response.sendRedirect("index.jsp?type="+type);
                                }    
                    
                }
             }
             }
        %>
    </body>
</html>
