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
public class selectedProduct
{
    String pname;
    int pid;
    int pquantity;
    float pprice;
    
  public selectedProduct(String n,int i,int q,float p){
        pname=n;
        pid=i;
        pquantity=q;
        pprice=p;
        
    }
  public  String getPname(){
      return pname;
  }
  public int getPid(){
      return pid;
  }
  public int getPquantity(){
      return pquantity;
  }
  public  float getPprice(){
      return pprice;
  }
  public void setQuantity(int n){
      pquantity=n;
  }
   @Override
  public String toString(){
      return "SP[pid = "+pid+ ", name = "+pname+", quantity= "+pquantity+", price = "+ pprice +" ]";
  }
}
