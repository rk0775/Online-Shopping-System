/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package GeterAndSeter;

/**
 *
 * @author Admin
 */
public class ProductDetailes
{
    int pid;
    float price,discount;
    String pname,discription,pic,brand;
    String type;
    public ProductDetailes(int pid,String pname,float price,float discount,String pic,String discription,String type,String brand)
    {
        this.pid=pid;
        this.pname=pname;
        this.price=price;
        this.discount=discount;
        this.pic=pic;
        this.discription=discription;
        this.type=type;
        this.brand=brand;
    }
    
    
    public int getPid()
    {
        return pid;
    }
    
    public String getPname()
    {
        return pname;
    }
    public String getBrand()
    {
        return brand;
    }
    
    public String getType()
    {
        return type;
    }
    
    public float getPprice()
    {
        return price;
    }
    
    public float getPdiscount()
    {
        return discount;
    }
    
    public String getPpic()
    {
        return pic;
    }
    
    public String getPdiscription()
    {
        return discription;
    }
}
