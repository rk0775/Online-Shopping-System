function swal(){
     swal.fire({
             toast:"true",
             background:"#0056b3",
             html:"<h6 class='text-light'>First Product Added To Cart</h6>",
             position:"bottom",
             
             showConfirmButton:false,
             timer:"1000",
             timerProgressBar:true,
         })
}


function addToCart(pid,pname,pprice){
     cart=localStorage.getItem("cart");
     if(cart==null){
          products=[];
         product={id:pid,name:pname,price:pprice,count:1};
         products.push(product);
         localStorage.setItem("cart",JSON.stringify(products));
         swal.fire({
             toast:"true",
             background:"#0056b3",
             html:"<h6 class='text-light'>First Product Added To Cart</h6>",
             position:"bottom",
             
             showConfirmButton:false,
             timer:"1000",
             timerProgressBar:true,
         })
     }else{
          pcart=JSON.parse(cart);
          oldcart=pcart.find((item)=> item.id==pid);
         if(oldcart){
             
             pcart.map((item)=>{ 
                     
               if(item.id == oldcart.id){
                          item.count++;
                }
             })
                
              localStorage.setItem("cart",JSON.stringify(pcart));
             
               swal.fire({
             toast:"true",
             background:"#0056b3",
             html:"<h6 class='text-light'>Product Quantity Incresed ...</h6>",
             position:"bottom",
             
             showConfirmButton:false,
             timer:"1000",
             timerProgressBar:true,
         })
          
         }else{
            p={id:pid,name:pname,price:pprice,count:1};
            pcart.push(p);
            localStorage.setItem("cart",JSON.stringify(pcart));
           
            swal.fire({
             toast:"true",
             background:"#0056b3",
             html:"<h6 class='text-light'>New Product Added To Cart</h6>",
             position:"bottom",
             
             showConfirmButton:false,
             timer:"1000",
             timerProgressBar:true,
         })
         }
    }
    cartAction();
}




function cartAction(){
    
    cart=JSON.parse(localStorage.getItem("cart"));
    if(cart==null){
        
        
        $(".cart-num").html("(0)");
        $(".cart-body").html("Your cart is empty...");
        $(".data").html("Select the Disire product for buy ....");
        $(".check-btn").addClass("disabled");
        $(".check-btn2").addClass("d-none");
    }else{
        
        $(".cart-num").html(`(  ${cart.length}   )`);
        $(".check-btn").removeClass("disabled");
        $(".check-btn2").removeClass("d-none");
        
        
        table=`
        
        <table class="table table-hover">
            <tr class="text-style">
              
                <th>Name</th>
                <th>Price</th>
                <th>Quaantity</th>
                <th>Cahrge price</th>
                <th>Action</th>
               
            </tr>
        
        `;
        
        
       var totalPrice=0;
        cart.map((item)=>{
 
 
 
            table+=`
                <tr>
                    
                    <td><small>${item.name}</small></td>
                    <td><small>${item.price}</small></td>
                    <td><small>${item.count}</small></td>
                    <td><small>${item.price*item.count}</small></td>
                   
                    <td>
                        <button class="btn btn-danger btn-sm" onclick="removeProduct(${item.id})">Remove</button>
                    </td>
                   
                    
                </tr>
            
            `;
            totalPrice+=item.price * item.count;
            
        })
        
        
        
        
        table=table+`  
               <tr>
                    <td colspan='5' class='text-right'>Total Price : ${totalPrice} </td>
                </tr>
                </table>
       
        
        `;
        $(".cart-body").html(table);
        
    }




}



function removeProduct(pid){
    cart=JSON.parse(localStorage.getItem("cart"));
    updatecart=cart.filter((item)=> item.id!=pid);
    n=`${updatecart.length}`;
    localStorage.setItem("cart",JSON.stringify(updatecart));
    if(n==0){
    localStorage.removeItem("cart");
    }
    cartAction();
     swal.fire({
             toast:"true",
             background:"#0056b3",
             html:"<h6 class='text-light'>Product Remove To Cart </h6>",
             position:"bottom",
             
             showConfirmButton:false,
             timer:"1000",
             timerProgressBar:true,
         })
}

function dataSave(){
    cart=localStorage.getItem("cart");
    if(cart!=null){
 
       $.ajax({
           url:"jspFileName.jsp",
           type:"POST",
           data:{cart:cart},
           success: function(data){
               
           }
           
       });
}
}




$(document).ready(function(){
    cartAction();
    dataSave();
});



