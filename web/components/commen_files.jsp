<%@page import="database.DatabaseManager"%>
<%@page import="GeterAndSeter.CategoryDetailes"%>
<%@page import="database.ConnectionProvider"%>
<%@page import="GeterAndSeter.Information"%>
<%@page import="GeterAndSeter.selectedProduct"%>
<%@page import="java.util.ArrayList"%>
<!--css files-->
<link href="components/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="components/css/sweetalert2.min.css" rel="stylesheet" type="text/css"/>
<link href="components/font/css/all.css" rel="stylesheet" type="text/css"/>
<link href="components/style.css" rel="stylesheet" type="text/css"/>
<!--Scripts -->
<script src="components/font/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="components/popper.js" type="text/javascript"></script>
<script src="components/js/bootstrap.min.js" type="text/javascript"></script>
<script src="components/sweetalert2.min.js" type="text/javascript"></script>
<!--<script src="components/script.js" type="text/javascript"></script>-->

<!-- password hide and show function -->
<script>
    
   $(document).ready(function(){
      
       $(".hide").click(function(){
           
           $(this).toggleClass("fa-eye-slash fa-eye");
           var input=$("#hideShowPassword");
           if(input.attr("type")=="password")
           {
               input.attr("type","text");
           }else{
               input.attr("type","password");
           }
           
       }); 
       
   });
</script>
<!-- password hide and show function end -->

<!--sidebar show and hide action-->
<script>
    $(document).ready(function (){
        $("#sideOpen,#sideClose").click(function() {
            $(".sidebar").toggleClass("activeSidebar");
        });
    });
</script>
<!-- sidebar bar show and hide action end -->


<!-- all cart management   -->
<script>
    function cartA(){        
        <%
           
ArrayList cartData=(ArrayList)session.getAttribute("cart");
String ridString=(request.getParameter("id")); 
    if(ridString!=null){
        
        int rid=Integer.parseInt(ridString);
       for(int i=0 ;i<cartData.size();i++){ 
                selectedProduct cart=(selectedProduct)cartData.get(i);
                if(cart.getPid()==rid){
                    cartData.remove(i);
                    session.setAttribute("swal","rp");
                    
                 %>  
                swal.fire({
                toast:"true",
                background:"#0056b3",
                html:"<h6 class='text-light'>Product are Remove from cart... </h6>",
                position:"bottom",
                showConfirmButton:false,
                timer:"1500",
                timerProgressBar:true,
            })
                <%   
                }
       }
        
    }
           
           int num=0;
           boolean empty=true;
           float totalPrice=0;

if(cartData!=null && cartData.size()!=0){
 num=cartData.size();
 empty=false;
}
%>      
         $(".cart-num").html("( <%= num %> )");
         <% if(empty){ %>
           $(".cart-body").html("Your cart is empty...");
            $(".check-btn").addClass("disabled");
         <% }else { %>
          table=`
        
        <table class="table table-hover  ">
            <tr class="text-style alert-secondary">
              
                <th>Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Cahrge price</th>
                <th>Action</th>
               
            </tr>  `;
        
       <% for(Object cartObj: cartData){ 
                selectedProduct cart=(selectedProduct)cartObj;
       %>
      
            table+=`
                <tr>
                    
                    <td><small><%= cart.getPname() %></small></td>
                    <td><small><%= cart.getPprice() %></small></td>
                    <td><small><%= cart.getPquantity() %></small></td>
                    <td><small><%= cart.getPprice()*cart.getPquantity()  %></small></td>
                   
                    <td>
                        <form action="" method="post">
                        <input type="hidden" name="id" value="<%= cart.getPid() %>">
                        <button class="btn btn-danger btn-sm" type="submit" >Remove</a>
                        </form>
                    </td>
                   
                    
                </tr>
            
            `;
            <%  totalPrice+= cart.getPprice()*cart.getPquantity(); %>
            
       <% } %>
        
        table=table+`  
               <tr>
                    <td colspan='5' class='text-right'>Total Price : <%= totalPrice %> </td>
                </tr>
                </table> `;
      $(".cart-body").html(table);
       $(".check-btn").removeClass("disabled");
              <% } %>    
    }
</script>
<!-- all cart management end  -->


<!-- referesh page to load to the cart -->
<script>
   $(document).ready(function(){
    cartA();
});
</script>
<!-- cart loding part end -->



<!-- proper message display on page gegarding to product -->
<%   
        String s=(String)session.getAttribute("swal");
        if(s!=null){
            if(s.equalsIgnoreCase("fp")){
             
                %>
                <script>
                 swal.fire({
             toast:"true",
             background:"#0056b3",
             html:"<h6 class='text-light'>First Product Added To Cart</h6>",
             position:"bottom",
             
             showConfirmButton:false,
             timer:"1000",
             timerProgressBar:true,
         })
              </script>
                
                <%
            }else if(s.equalsIgnoreCase("qi")){
               
                %>
              <script>
          swal.fire({
             toast:"true",
             background:"#0056b3",
             html:"<h6 class='text-light'>Product Quantity Increased.. </h6>",
             position:"bottom",
             
             showConfirmButton:false,
             timer:"1000",
             timerProgressBar:true,
         })
        
              </script>
                <%
                
            }else if(s.equalsIgnoreCase("np")){
              %>
        <script>
          swal.fire({
             toast:"true",
             background:"#0056b3",
             html:"<h6 class='text-light'>New Product Are Added.. </h6>",
             position:"bottom",
             
             showConfirmButton:false,
             timer:"1000",
             timerProgressBar:true,
            })
        
         </script>
                <%
            } 
            
            session.removeAttribute("swal");
        }

%>
<!-- proper message display on page gegarding to product section end -->



<!-- side bar part form mobile screen  -->
            <div class="d-sm-none sidebar">
               <div class="text-right mr-3">
                   <a class=" d-sm-none" id="sideClose"><span class="sidenav">&laquo;</span></a>
               </div>
     
                <div class="list ml-2">
                        <a href="index.jsp" class=" text-light">HOME</a>
                        <a href="#" class="text-light">PRODUCTS</a>
                        <a href="#" class="text-light">ABOUT</a>
                        <a href="#" class="text-light">CONTACT</a>
                          <%     
                             Information info=(Information)session.getAttribute("login");
                       
                            if(info==null)
                            {
                            %>
                            
                            
                            <a href="login.jsp" class="nav-link text-light">LOGIN</a>
                            <a href="register.jsp" class="nav-link text-light">REGISTER</a>
                                
                            <%
                                        
                            }else{
                            
                            %>
                            
                            
                             <a href="<% if(info.getType().equalsIgnoreCase("admin")){%>AdminUser.jsp<%}else{ %>NormalUser.jsp <% } %>" class="nav-link text-light"><h4 class="mb-0"><%= info.getName() %></h4></a>
                             <a href="LogoutServlet" class="mt-1 nav-link text-light">LOGOUT</a>
                               
                           <%  } %>
                </div>
                  
             <div class=" dropdown">
                 <button id="category" class="text-uppercase text-light btn bg-navbar dropdown-toggle" data-toggle="dropdown">Category </button>
               <div class="dropdown-menu bg-navbar">
                
                   <%
                                    if(ConnectionProvider.con==null)
                                    {
                                        ConnectionProvider.con=new ConnectionProvider().getConnection();
                                    }
                                    
                                    CategoryDetailes cd[]=(CategoryDetailes[])session.getAttribute("category");
                                    if(cd==null){
                                        CategoryDetailes c[]=new DatabaseManager(ConnectionProvider.con).getCategory();
                                        session.setAttribute("category",c);
                                        cd=(CategoryDetailes[])session.getAttribute("category");
                                    }
                                    for(CategoryDetailes cobj:cd)
                                    {
                   %>
                   
                   <a class="dropdown-item" href="index.jsp?type=<%= cobj.getCname()  %>"><%= cobj.getCname() %></a>
                   <%}%>
                   <a href="index.jsp?type=all" class=" dropdown-item">all</a>
               </div>
           </div>         
       </div>
<!-- side bar part form mobile screen end  -->


<script>
    
    function pd(i,pn,typ){
       window.location.replace("ProductPage.jsp?shopper="+i+"&pno="+pn+"&type="+typ);
    }
</script>
<script>
    //this function for nor order empty
    function relatedNull(){
        $("#Related").html("");
    }
    function noOrder(){
        //alert("hahha");
        $("#htable").html("<h6 class='text-muted'>processing Order are not Present in this time so please check later</h6>");
        $(".check").html("");
    }
    
    // this function for get permision to cancel the order
    function orderD(oid){
        swal.fire({
            icon:"warning",
            text:"Are you sure to cancel the order completly..",
            title:"Cancelation Warning",
            confirmButtonText:"YES",
            showCancelButton:"true",
        }).then((result)=>{
            if(result.value){
                window.location.replace("OrderProduct?oid="+oid)
            }
        })
    }
    function productD(pid){
        swal.fire({
            icon:"warning",
            text:"Are you sure to delete the this product..",
            title:"deletion Warning",
            confirmButtonText:"YES",
            showCancelButton:"true",
        }).then((result)=>{
            if(result.value){
                window.location.replace("edit?delete=deleteProduct&did="+pid)
               
            }
        })
    }
    function complete(oid){
        swal.fire({
            icon:"warning",
            text:"Are you sure to coplete this oredr ...",
            title:"Confirmation",
            confirmButtonText:"Order complete",
            showCancelButton:"true",
            cancelButtonText:"Not Yet!",
        }).then((result)=>{
            if(result.value){
                window.location.replace("edit?edit=edit&oid="+oid)
               
            }
        })
    }
  
</script>

