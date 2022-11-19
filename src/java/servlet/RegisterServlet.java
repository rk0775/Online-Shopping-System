package servlet;
import database.ConnectionProvider;
import database.DatabaseManager;
import javax.servlet.http.*;
import java.io.*;
public class RegisterServlet extends HttpServlet
{
    @Override
    public void doPost(HttpServletRequest req,HttpServletResponse res)throws IOException
    {
       res.setContentType("text/html");
       PrintWriter out=res.getWriter();
       out.println("Register servlet is active");
       String name=req.getParameter("name");
       String email=req.getParameter("email");
       String phon=req.getParameter("phon");
       String password=req.getParameter("password");
       String addr=req.getParameter("addr");
       String ck=req.getParameter("check");
       HttpSession s=req.getSession();
       //out.println(name+"<br>"+email+"<br>"+phon+"<br>"+password+"<br>"+addr+"<br>"+ck);
       
       if(ConnectionProvider.con==null)
       {
           
          new ConnectionProvider().getConnection();
          System.out.println("connection is newlay created  "+ConnectionProvider.con );
          
           int action= new DatabaseManager(ConnectionProvider.con).saveRegisteredData(name, email, phon, password, addr);
       
            if(action==1)
            {
                s.setAttribute("msg","Registration successfully completed");
                s.setAttribute("msgType","success");
                s.setAttribute("msgTitle","Success");

            }else
            {
                   s.setAttribute("msg","Registration Failed... try with another e-mail ");
                s.setAttribute("msgType","error");
                s.setAttribute("msgTitle","Registration Failed");
            }
            res.sendRedirect("register.jsp");
            
       }else
        {
       
        System.out.println("Old connection  "+ConnectionProvider.con );
        int  action= new DatabaseManager(ConnectionProvider.con).saveRegisteredData(name, email, phon, password, addr);
            
            if(action==1)
            {
                s.setAttribute("msg","Registration successfully completed");
                s.setAttribute("msgType","success");
                s.setAttribute("msgTitle"," Success ");

            }else
            {
                s.setAttribute("msg","Registration Failed... try with another e-mail ");
                s.setAttribute("msgType","error");
                s.setAttribute("msgTitle","Registration Failed ");
            }
            res.sendRedirect("register.jsp");
        }

    }
}
