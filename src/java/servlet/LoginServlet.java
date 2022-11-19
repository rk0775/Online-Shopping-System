/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import GeterAndSeter.Information;
import database.ConnectionProvider;
import database.DatabaseManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        PrintWriter out = res.getWriter();
        
        try {
            
            
            HttpSession s=req.getSession();
            String email=req.getParameter("loginEmail");
            String password=req.getParameter("loginPassword");
            if(ConnectionProvider.con==null)
            {
                System.out.println("Connection newly created....");
                new ConnectionProvider().getConnection();
                 Information obj = new DatabaseManager(ConnectionProvider.con).getDataByEmailAndPassword(email, password);
              if(obj==null)
              {
                //access not granted so jump to the login page
                s.setAttribute("msg","Something went wrong... tyr with another ");
                s.setAttribute("msgType","error");
                s.setAttribute("msgTitle","Login Failed");
                  
                 res.sendRedirect("login.jsp"); 
                  
              }else{
                  // if access granted to check user type and jump to the page
                  
                 if(obj.getType().equalsIgnoreCase("admin"))
                 {
                     s.setAttribute("login",obj);
                     res.sendRedirect("AdminUser.jsp");
                 }
                 else if(obj.getType().equalsIgnoreCase("normal"))
                 {
                     s.setAttribute("login",obj);
                     res.sendRedirect("NormalUser.jsp");
                 }
              }
              return;
            }
            else
            {
                System.out.println("USe OLD Connection");
              Information obj = new DatabaseManager(ConnectionProvider.con).getDataByEmailAndPassword(email, password);
              if(obj==null)
              {
                //access not granted so jump to the login page
                s.setAttribute("msg","Something went wrong... tyr with another ");
                s.setAttribute("msgType","error");
                s.setAttribute("msgTitle","Login Failed");
                  
                 res.sendRedirect("login.jsp"); 
                  
              }else{
                  // if access granted to check user type and jump to the page
                  
                 if(obj.getType().equalsIgnoreCase("admin"))
                 {
                     s.setAttribute("login",obj);
                     res.sendRedirect("AdminUser.jsp");
                 }
                 else if(obj.getType().equalsIgnoreCase("normal"))
                 {
                     s.setAttribute("login",obj);
                     res.sendRedirect("NormalUser.jsp");
                 }
              }
            
            
            }
           
         } finally {
            out.close();
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
