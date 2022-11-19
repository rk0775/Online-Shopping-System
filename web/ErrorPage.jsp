<%-- 
    Document   : ErrorPage
    Created on : Aug 17, 2020, 4:25:44 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error page</title>
        <link href="components/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body style="background-color: darkslateblue">
        <div class="text-center" style="margin-top:100px">
            <p style="font-size:50px" class="m-0 p-0 text-light text-center">Oops !</p>
            <h2 class="m-0 p-0 text-light">Something went wrong </h2> 
            <h5 class="m-0 p-0 text-danger">Error  :  <%= exception %></h5>
            <img  src="components/img/bear.png" alt="" style="max-height: 500px; max-width:100%;width:auto "  />
        
          
        </div>
    </body>
</html>
