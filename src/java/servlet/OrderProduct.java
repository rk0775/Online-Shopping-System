/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import GeterAndSeter.ProductDetailes;
import GeterAndSeter.selectedProduct;
import database.ConnectionProvider;
import database.DatabaseManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "OrderProduct", urlPatterns = {"/OrderProduct"})
public class OrderProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Calendar cal=Calendar.getInstance();
        String date=""+cal.get(Calendar.YEAR)+"/"+(cal.get(Calendar.MONTH)+1)+"/"+cal.get(Calendar.DATE);
        Random rand=new Random();
        int oid=rand.nextInt(10000);
        HttpSession session=request.getSession();
        PrintWriter out = response.getWriter();
        
        String oidnum=request.getParameter("oid");
      
        if(oidnum!=null){
            try{
             int oInt=Integer.parseInt(oidnum);
              Statement st=ConnectionProvider.con.createStatement();
              st.executeUpdate("delete from orders where oid="+oInt);
              st.executeUpdate("delete from orderdata where oid="+oInt);
               
              session.setAttribute("msgType","success");
               session.setAttribute("msgTitle","Order Cancel");
               session.setAttribute("msg","Your order is succefully cancled.. ");
               response.sendRedirect("NormalUser.jsp");
              
            }catch(Exception e){
                e.printStackTrace();
            }
        }else{
        int charg=0;
        try {
           String addr=request.getParameter("addr");
           String contact=request.getParameter("contact");
           String payment=request.getParameter("pay");
           int uid=Integer.parseInt(request.getParameter("uid"));
           out.println("addr :"+addr+"<br> contact : "+contact+"<br> payment : "+payment);
           ArrayList array=(ArrayList)session.getAttribute("cart");
           
           if(payment.equalsIgnoreCase("Cash On Delivery")){
               charg=150;
           }
           if(array==null || array.size()==0){
               
               session.setAttribute("msgType","error");
               session.setAttribute("msgTitle","Cart Empty");
               session.setAttribute("msg","please select the product ");
               response.sendRedirect("NormalUser.jsp");
                  
           }else{
            boolean t= new DatabaseManager(ConnectionProvider.con).saveOrder(oid,date,uid,contact, addr, payment,charg);
           if(t){
               for(Object obj:array){
                        selectedProduct o=(selectedProduct)obj;
                        new DatabaseManager(ConnectionProvider.con).saveOrderData(oid,o.getPname(), o.getPprice() , o.getPquantity());
                       }
                session.setAttribute("msgType","success");
               session.setAttribute("msgTitle","Order Success");
               session.setAttribute("msg","you Order is successfully acesspted ... ANY ISSUE PLEASE MESSAGE");
               session.removeAttribute("cart");
               response.sendRedirect("NormalUser.jsp");
           }else{
               session.setAttribute("msgType","error");
               session.setAttribute("msgTitle","Somthing went wrong");
               session.setAttribute("msg","the data provited is twisted generate errror");
               response.sendRedirect("NormalUser.jsp");
           }
           }
            
        } finally {
            out.close();
        }
        }
       
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
