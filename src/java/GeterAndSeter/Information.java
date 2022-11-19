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
public class Information 
{
    String name,email,password,phon,addr,type;
    int id;
    public Information(String name,String email,String password,String phon,String addr,int id,String type)
    {
        this.name=name;
        this.email=email;
        this.password=password;
        this.phon=phon;
        this.addr=addr;
        this.id=id;
        this.type=type;
        
    }
    
    public String getName()
    {
        return name;
    }
    public String getEmail()
    {
        return email;
    }
    public String getPassword()
    {
        return password;
    }
    public String getPhon()
    {
        return phon;
    }
    public String getaddr()
    {
        return addr;
    }
    public int getId()
    {
        return id;
    }
    public String getType()
    {
        return type;
    }
    
}
