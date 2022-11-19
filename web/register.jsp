<%-- 
    Document   : register
    Created on : Aug 14, 2020, 7:04:47 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <%@include file="navbar.jsp"%>
       <div class="container-fluid">
       <div class="row mt-3">
           <div class="col-sm-8 offset-sm-2 col-md-6 offset-sm-3">
               <div class="card " >
                   <div class="card-header text-center p-1 bg-navbar text-light style-text">
                       <h4>Register here</h4>
                   </div>
                   <div class="card-body bg-navbar2" style="border: 1px solid black; border-top: none">
                       <form action="RegisterServlet" method="post" class="was-validated">
                           <div class="form-group">
                               
                               <!--name field-->
                               <div class="input-group mb-0">
                                    <div class=" input-group-prepend"><span style="border:none" class="pt-3 text-info input-group-text bg-support fa fa-user"></span></div>
                                    <input name="name" pattern="[A-Za-z ]{3,}" type="text" required class="my-input bg-support form-control" placeholder="Enter the your name"/>
                                    <small class="invalid-feedback">name must be greter than 3 charcter</small>
                                    <small class="valid-feedback">name accepted</small>
                               </div>
                            
                               <!--E-mail field-->
                               <div class="input-group">
                                    <div class="input-group-prepend"><span style="border:none" class="pt-3  text-info input-group-text bg-support fa fa-tablet"></span></div>
                               <input name="email"  pattern="[A-Za-z0-9._%+-]+@gmail.com" type="email" required class="my-input bg-support form-control" placeholder="Enter the E-mail"/>
                               <small class="invalid-feedback">e-mail enter in sequence</small>
                               <small class="valid-feedback">valid pattern</small>
                               </div>
                            
                               <!--contact field-->
                               <div class="input-group">
                                    <div class="input-group-prepend"><span style="border:none" class="pt-3 text-info input-group-text bg-support fa fa-mobile"></span></div>
                               <input name="phon" pattern="[0-9]{10}" type="text" required class="my-input bg-support form-control" placeholder="Enter the Contact number"/>
                               <small class="invalid-feedback">Enter valid contact</small>
                                <small class="valid-feedback">accepted contact</small>
                               </div>
                                
                               <!--password filed-->
                               
                               <div class="input-group">
                                    <div class="input-group-prepend"><span style="border:none" class="pt-3 text-info input-group-text bg-support fa fa-lock"></span></div>
                                   
                               <input name="password" id="hideShowPassword" type="password" pattern="[0-9a-zA-z#@$%^&*]{5,}" required class="my-input bg-support form-control" placeholder="Enter the Password"/>
                               <div class="input-group-append "><span class="btn hide input-group-text fa fa-eye-slash bg-support mt-2" style="border:none; border-bottom:1px solid red ;"></div> 
                               <small class="invalid-feedback">password greter than five character</small>
                                <small class="valid-feedback">Valid pattern password</small>
                               </div>
                               

                               <!--text area-->
                               <label class="mt-3 mb-0"> Address : </label>
                               <textarea  name="addr" required class="bg-support form-control" placeholder="enter the Adress" ></textarea>
                               
                               <!--term and conditions-->
                               <small class=" text-dark"><input name="check" required type="checkbox"> Accept the term and conditions </small>
                            
                               <div class="text-center mt-3">
                               <button type="submit" class="btn btn-outline-dark">Submit</button>
                               <button type="reset" class="btn btn-outline-dark">Reset</button>
                            </div>
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
