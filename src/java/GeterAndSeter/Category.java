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
public class Category
{
    String type=null,dis=null;
    public Category(String type,String dis)
    {
        this.type=type;
        this.dis=dis;
    }
    public Category(String type)
    {
        this.type=type;
    }
    public String getCategoryType()
    {
        return type;
    }
    public String getCategorydis()
    {
        return dis;
    }
}
