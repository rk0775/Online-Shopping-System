<%-- 
    Document   : login
    Created on : Aug 14, 2020, 10:56:34 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="ErrorPage.jsp"  %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
    </head>
    <body>
        <!--for including the navbar-->
        <%@include file="navbar.jsp" %>
        <div class="container-fluid">
        <div class="row mt-3">
            <div class="col-sm-8 offset-sm-2 col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header p-1 text-light text-center text-style bg-navbar">
                        <h3>LOGIN HERE</h3>
                    </div>
                    <div class="card-body bg-navbar2 pb-0" style="border: 1px solid black; border-top: none">
                        <form action="LoginServlet" method="post">
                            <div class="form-group">
                                 <label class=" m-0">Enter E-mail : </label>
                                        <div class="input-group">
                                            <input name="loginEmail"  type="email" pattern="[A-Za-z0-9._%+-]+@gmail.com" class="bg-support my-input form-control" placeholder="Enter your register email" required/>
                                            <div class="input-group-append">
                                                <span class="input-group-text fa fa-eye " style="opacity:0"></span>
                                            </div>
                                        </div>
                                        <div class="form-group mt-2">
                                        <label class="m-0">Enter Password :</label>
                                        <div class="input-group">

                                            <input name="loginPassword" type="password" id="hideShowPassword" pattern="[0-9a-zA-z#@$%^&*]{5,}" class="my-input form-control bg-support " placeholder="Enter your register password" required/>
                                            <div class="input-group-append ">
                                               <span class="btn input-group-text fa fa-eye-slash hide mt-1 bg-support" style="border:none; "></span>
                                            </div>
                                        </div>
                                    </div>
                                
                            </div>
                   
                     <div class="text-center">
                            <small class="text-success ">forget password?</small><br>
                            <button type="submit" class="m-1 btn btn-outline-dark">Login</button>
                            <button type="reset" class="m-1 btn btn-outline-dark">Reset</button>
                     </div>
                    </form>
                   </div>
            </div>
        </div>
            
          
        </div>
        </div>
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
