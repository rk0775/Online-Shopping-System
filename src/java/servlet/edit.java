/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import database.ConnectionProvider;
import database.DatabaseManager;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "edit", urlPatterns = {"/edit"})
public class edit extends HttpServlet {

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
        HttpSession session=request.getSession();
        try {
        String id=request.getParameter("delete");
        
        if(id!=null){
            //to delete the product by id
        if(id.equalsIgnoreCase("deleteProduct")){
            int did=Integer.parseInt(request.getParameter("did"));
            boolean t= new DatabaseManager(ConnectionProvider.con).deleteProduct(did);
            if(t){
                session.setAttribute("msg","product successfully removed from warehouse data");
                session.setAttribute("msgType","success");
                session.setAttribute("msgTitle","Delete Success");
                response.sendRedirect("AdminUser.jsp?type=product");
            }else{
                session.setAttribute("msg","product not deleted....");
                session.setAttribute("msgType","error");
                session.setAttribute("msgTitle","delete Error");
                response.sendRedirect("AdminUser.jsp?type=product");
            }
        }
        }
        
        
        //to chang the order states processing to complate
        String edit=request.getParameter("edit");
        if(edit!=null){
            int editId=Integer.parseInt(request.getParameter("oid"));
            out.println(editId);
            boolean t=new DatabaseManager(ConnectionProvider.con).editStates(editId);
            if(t){
               session.setAttribute("msg","states are changed processing to complate ");
                session.setAttribute("msgType","success");
                session.setAttribute("msgTitle","Order Complate");
                response.sendRedirect("AdminUser.jsp?type=process");
            }else{
                session.setAttribute("msg","states are not changed processing to complate ");
                session.setAttribute("msgType","error");
                session.setAttribute("msgTitle","Somthing Went Wrong");
                response.sendRedirect("AdminUser.jsp?type=process");
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
