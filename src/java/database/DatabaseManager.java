package database;
import GeterAndSeter.Category;
import GeterAndSeter.CategoryDetailes;
import GeterAndSeter.Information;
import GeterAndSeter.ProductDetailes;
import java.sql.*;
public class DatabaseManager 
{
    Connection con;
    
    public DatabaseManager(Connection con)
    {
      this.con=con;  
    }
    
    
    public int saveRegisteredData(String name,String email,String phon,String password,String addr)
    {
        int a=0;
        try{
            String Query="insert into user(uname,uemail,uphon,upassword,uaddr,utype) values('"+name+"','"+email+"','"+phon+"','"+password+"','"+addr+"' , 'normal')";
            System.out.println(Query);
            Statement st=con.createStatement();
            st.executeUpdate(Query);
            a=1;
            
            
        }catch(Exception e)
        {
            System.out.println("@@@ SaveRegisteredData generate error : ");
            e.printStackTrace();
        }
        
        return a;
    }
    
    
    
    public Information getDataByEmailAndPassword(String lemail,String lpassword)
    {
       Information obj=null;
        
        try{
            String Query="select * from user where uemail='"+lemail+"' and upassword='"+lpassword +"'";
            Statement st =con.createStatement();
            ResultSet rs=st.executeQuery(Query);
            if(rs.next() )
            {
                int id=rs.getInt("uid");
                String name=rs.getString("uname");
                String email=rs.getString("uemail");
                String phon=rs.getString("uphon");
                String password=rs.getString("upassword");
                String addr=rs.getString("uaddr");
                String type=rs.getString("utype");
                obj=new Information(name,email,password,phon,addr,id,type); 
            }
         }catch(Exception e)
            {
                e.printStackTrace();
            }
        return obj;
    }
    
    public int getUserCount()
    {
       
        int count=0;
        try{
            
            String Query="select count(uid) from user";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(Query);
            if(rs.next())
            {
                count=rs.getInt("count(uid)");
            }
            
        }catch(Exception e)
        {
          System.out.println("User Count generate error : "+e.getMessage());
        }
        return count;
    }
    
    public int getProductCount()
    {
        
        int count=0;
        try{
            
            String Query="select count(pid) from product";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(Query);
            if(rs.next())
            {
             count=rs.getInt("count(pid)");
            }
            
        }catch(Exception e)
        {
            System.out.println("Product Count generate error : "+e.getMessage());
        }
        return count;
    }
    
    public int getCategoryCount()
    {
       
        int count=0;
        try{
            
            String Query="select count(cname) from category";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(Query);
            if(rs.next())
            {
             count=rs.getInt("count(cname)");
            }
            
        }catch(Exception e)
        {
            System.out.println("Category Count generate error : "+e.getMessage());
        }
        return count;
    }
    
    public int getOrderProcessCount()
    {
       
        int count=0;
        try{
            
            String Query="select count(oid) from orders where states='processing'";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(Query);
            if(rs.next())
            {
             count=rs.getInt("count(oid)");
            }
            
        }catch(Exception e)
        {
            System.out.println("Category Count generate error : "+e.getMessage());
        }
        return count;
    }
    
    public int getOrderComplateCount()
    {
       
        int count=0;
        try{
            
            String Query="select count(oid) from orders where states='complate'";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(Query);
            if(rs.next())
            {
             count=rs.getInt("count(oid)");
            }
            
        }catch(Exception e)
        {
            System.out.println("Category complate Count generate error : "+e.getMessage());
        }
        return count;
    }
    
    public int saveCategoryData(String cname,String cdis )
    {
        int a=0;
        try
        {
            String Query="insert into category values('"+cname+"','"+cdis+"')";
            Statement st=con.createStatement();
            st.executeUpdate(Query);
            a=1;
            
        }catch(Exception e)
        {
            System.out.println("save Category Generate error :  "+ e.getMessage());
            a=2;
           
        }
        return a;
    }
    
   public boolean saveProductData(String pname,float price,float discount,String type,String location,String discription,String brand)
   {
       boolean a=false;
       try{
           
           String Query="insert into product(pname,price,discount,pic,discription,cname,brand) values('"+pname+"',"+price+","+discount+",'"+location+"','"+discription+"','"+type+"','"+brand+"')";;
           Statement st=con.createStatement();
           st.executeUpdate(Query);
           a=true;
           
       }catch(Exception e)
       {
             System.out.println("save product Generate error :  "+ e.getMessage());
       }
       return a;
   }
   
    public ProductDetailes[] getProduct()
    {
        ProductDetailes pobj[]=null;
        try{
            System.out.println("getProduct fuction are called");
            String Query="select * from product";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(Query);
            int i=0;
            pobj=new ProductDetailes[getProductCount()];
            while(rs.next())
            {
                int pid=rs.getInt("pid");
                String pname=rs.getString("pname");
                String dis=rs.getString("discription");
                float price=rs.getFloat("price");
                float discount=rs.getFloat("discount");
                String cname=rs.getString("cname");
                String location=rs.getString("pic");
                String brand=rs.getString("brand");
                pobj[i]=new ProductDetailes(pid,pname,price,discount,location,dis,cname,brand);
                i++;
            }
            
            
        }catch(Exception e)
        {
             System.out.println("getproduct Generate error :  "+ e.getMessage());
        }
        return pobj;
    }
    public CategoryDetailes[] getCategory()
    {
        CategoryDetailes obj[]=null;
        try{
            System.out.println("getCategory fuction are called");
            String Query="Select * from category";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(Query);
            int i=0;
            obj=new CategoryDetailes[getCategoryCount()];
            while(rs.next())
            {
                
                System.out.println("Category data Caletd ***********************************");
                String cname=rs.getString("cname");
                String dis=rs.getString("cdiscription");
                obj[i]=new CategoryDetailes(cname,dis);
                i++;
            }
        
        }catch(Exception e)
            {
              System.out.println("getCategory Generate error :  "+ e.getMessage());
            }
        return obj;
    }
    
    public boolean saveMessage(String msg,String title,int to ,int from){
        boolean a=false;
        try{
        
            String Query="insert into message values('"+msg+"',"+ to +","+from+",now(),'"+title+"')";
            Statement st=con.createStatement();
            st.executeUpdate(Query);
            a=true;
    }catch(Exception e){
            e.printStackTrace();
            }
        return a;
    }
   
    public boolean saveOrder(int id,String date,int uid,String contact,String addr,String pay,int charge){
        boolean a=false;
        try{
            String Query="insert into orders values("+id+",'"+date+"','processing',"+uid+",'"+addr+"','"+contact+"','"+pay+"',"+charge+")";
            Statement st=con.createStatement();
            st.executeUpdate(Query);
                    a=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return a;
    }
    public boolean saveOrderData(int id,String pname,float price,int qun){
         boolean a=false;
        try{
            String Query="insert into orderdata values("+id+",'"+pname+"','"+price+"','"+qun+"')";
            Statement st=con.createStatement();
            st.executeUpdate(Query);
            a=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return a;
    }
    
    public boolean editProduct(int eid,String pname,String brand,float price ,float dis,String cname,String discription){
        boolean t=false;
        try{
            String query="update product set pname='"+pname+"', price="+price+", discount="+dis+",cname='"+cname+"',brand='"+brand+"',discription='"+discription+"' where pid="+eid;
            Statement st=con.createStatement();
            st.executeUpdate(query);
            t=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return t;
    }
    
    public boolean deleteProduct(int did){
        boolean t=false;
        try{
            
            String query="delete from product where pid="+did;
            Statement st=con.createStatement();
            st.executeUpdate(query);
            t=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return t;
    }
    public boolean editStates(int oid){
        boolean t=false;
        try{
            String query="update orders set states='complate' where oid="+oid;
            Statement st=con.createStatement();
            st.executeUpdate(query);
            t=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return t;
    }
    public boolean editCategoryDicription(String dis,String cname){
        boolean t=false;
        try{
            String query="update category set cdiscription='"+dis+"' where cname='"+cname+"'";
            Statement st=con.createStatement();
            st.executeUpdate(query);
            t=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return t;
    }
   
}
