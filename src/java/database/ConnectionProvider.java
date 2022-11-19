/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

/**
 *
 * @author Admin
 */
import java.sql.*;
public class ConnectionProvider
{
   public static Connection con=null;
    public Connection getConnection()
    {
       
        if(con==null)
        {
            System.out.println("Create new connection");
            try{
                
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/e-commerce","root","");
            
            }catch(Exception e)
            {
                System.out.println("@@@@ Connection provider Generate error :  " );
                e.printStackTrace();
            }
        }
        //7vu2uth//4mytivl
       
        return con;
    }
}
