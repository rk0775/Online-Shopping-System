/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;
import database.ConnectionProvider;
import database.DatabaseManager;
import javax.servlet.http.*;
import java.io.*;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
@MultipartConfig
public class ProductServlet extends HttpServlet 
{
  
    public void doPost(HttpServletRequest req,HttpServletResponse res)throws IOException,ServletException
    {
        Random rand=new Random();
        int n=rand.nextInt();
        res.setContentType("text/html");
        PrintWriter out=res.getWriter();
        String id=req.getParameter("id");
        HttpSession s=req.getSession();
        
        System.out.println("Product servlet can call");
        if(id.equalsIgnoreCase("product"))
        {
            String pname=req.getParameter("pname");
            String brand=req.getParameter("pbname");
            float price=Float.parseFloat(req.getParameter("pprice"));
            float discount=Float.parseFloat(req.getParameter("pdis"));
            String type=req.getParameter("type");
            String discription=req.getParameter("pdiscription");
            Part part=req.getPart("pic");
            
            
            if(type.equalsIgnoreCase("Select the product Category"))
            {
                s.setAttribute("msg","please select valid type of product");
                s.setAttribute("msgType","warning");
                s.setAttribute("msgTitle","somthing went wrong");
                res.sendRedirect("AdminUser.jsp");
                
            }else if(discount>100){
                s.setAttribute("msg","Please enter less than 100% off discount");
                s.setAttribute("msgType","warning");
                s.setAttribute("msgTitle","somthing went wrong");
                res.sendRedirect("AdminUser.jsp");
            }else{
                String picName=type+n+".png";   
                String path="D:\\programs\\netbeans\\projects\\E-commerce\\web\\components\\img\\product"+File.separator+picName;
                try{
                 boolean action= new  DatabaseManager(ConnectionProvider.con).saveProductData(pname, price, discount, type,picName, discription,brand);
                FileOutputStream fos=new FileOutputStream(path);
                InputStream is=part.getInputStream();
                byte []data=new byte[is.available()];
                is.read(data);
                fos.write(data);
                fos.close();
                out.println("File save");
                if(action){
                s.setAttribute("msg","Product added Successfully....");
                s.setAttribute("msgType","success");
                s.setAttribute("msgTitle","Add Product");
                s.removeAttribute("products");
                res.sendRedirect("AdminUser.jsp");
                
                }else{
                    s.setAttribute("msg","Product not added");
                    s.setAttribute("msgType","error");
                    s.setAttribute("msgTitle","Addition Failed");
                    res.sendRedirect("AdminUser.jsp");
                }
                }catch(Exception e)
                {
                    s.setAttribute("msg",""+e.getMessage());
                    s.setAttribute("msgType","error");
                    s.setAttribute("msgTitle","Error");
                    res.sendRedirect("AdminUser.jsp");
                    e.printStackTrace();
                }
             
             
                
            }  
        
        }else if(id.equalsIgnoreCase("category"))
        {
            String cname=req.getParameter("cname");
            String dis=req.getParameter("cdis");
            
            int action=new DatabaseManager(ConnectionProvider.con).saveCategoryData(cname, dis);
            if(action==1)
            {
                s.setAttribute("msg","Category added Successfully....");
                s.setAttribute("msgType","success");
                s.setAttribute("msgTitle","Add Catagory");
                s.removeAttribute("category");
                res.sendRedirect("AdminUser.jsp");
            }else if(action==2)
            {
                s.setAttribute("msg","Category Alredy Present ");
                s.setAttribute("msgType","warning");
                s.setAttribute("msgTitle","Adition Failed..");
                 res.sendRedirect("AdminUser.jsp");
            }else{
                s.setAttribute("msg","Category Not Added ");
                s.setAttribute("msgType","error");
                s.setAttribute("msgTitle","Adition Failed..");
                res.sendRedirect("AdminUser.jsp");
            }
        }else if(id.equalsIgnoreCase("editProduct")){
            String pname=req.getParameter("pname");
            String brand=req.getParameter("pbname");
            float price=Float.parseFloat(req.getParameter("pprice"));
            float discount=Float.parseFloat(req.getParameter("pdis"));
            String type=req.getParameter("type");
            String discription=req.getParameter("pdiscription");
            int eid=Integer.parseInt(req.getParameter("eid"));
            
            
            out.println(eid+"<br>"+pname+"<br>"+brand+"<br>"+price+"<br>"+discount+"<br>"+type+"<br>"+discription);
            boolean t= new DatabaseManager(ConnectionProvider.con).editProduct(eid, pname, brand, price,discount,type,discription);
            if(t){
                s.setAttribute("msg"," Update data add Successfully to server ....");
                s.setAttribute("msgType","success");
                s.setAttribute("msgTitle","Upadate");
                   s.removeAttribute("products");
                res.sendRedirect("AdminUser.jsp?type=product");
            }else{
                s.setAttribute("msg","Data not update....");
                s.setAttribute("msgType","error");
                s.setAttribute("msgTitle","Upadate Error");
                res.sendRedirect("AdminUser.jsp?type=product");
            }
        }else if(id.equalsIgnoreCase("editCategory")){
            String cname=req.getParameter("cname");
            String dis=req.getParameter("cdis");
            boolean t=new DatabaseManager(ConnectionProvider.con).editCategoryDicription(dis,cname);
             if(t){
                s.setAttribute("msg"," Update data add Successfully to server ....");
                s.setAttribute("msgType","success");
                s.setAttribute("msgTitle","Upadate");
                   s.removeAttribute("products");
                res.sendRedirect("AdminUser.jsp?type=category");
            }else{
                s.setAttribute("msg","Data not update....");
                s.setAttribute("msgType","error");
                s.setAttribute("msgTitle","Upadate Error");
                res.sendRedirect("AdminUser.jsp?type=category");
            }
        }
        
    }
}
