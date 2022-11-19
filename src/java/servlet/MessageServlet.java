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
public class MessageServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        HttpSession s=request.getSession();
        try {
          
            Information obj=(Information)s.getAttribute("login");
           String type = request.getParameter("msgsender");
           String message= request.getParameter("message");
            if(type.equalsIgnoreCase("user")){
                //user sent the message to admin
                if(obj.getType().equalsIgnoreCase("normal")){
                    
                    
                   boolean action=new DatabaseManager(ConnectionProvider.con).saveMessage(message,"User Responce...",1,obj.getId());
                    if(action){
                        s.setAttribute("msg","Message is send seccessfully");
                        s.setAttribute("msgType","success");
                        s.setAttribute("msgTitle","Send Message");
                        response.sendRedirect("NormalUser.jsp");
                    }else{
                        s.setAttribute("msg","Message is not sent");
                        s.setAttribute("msgType","error");
                        s.setAttribute("msgTitle","Failed");
                        response.sendRedirect("NormalUser.jsp");
                    }
                    
                }else{
                    
                s.setAttribute("msg","Message Can not sent...");
                s.setAttribute("msgType","error");
                s.setAttribute("msgTitle","somthing went wrong");
                response.sendRedirect("login.jsp");
                }
                
            }else if(type.equalsIgnoreCase("admin")){
                //admin send the message for user
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
