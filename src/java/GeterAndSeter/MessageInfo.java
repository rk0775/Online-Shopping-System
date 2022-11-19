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
public class MessageInfo 
{
    String msg,msgTitle,date;
    int to,from;
    public MessageInfo(String msg,String title,String date,int to,int from){
        this.msg=msg;
        this.msgTitle=title;
        this.date=date;
        this.to=to;
        this.from=from;
    }
    public String getMessage()
    {
        return msg;
    }
    public String getMessageTitle()
    {
        return msgTitle;
    }
    public String getMessageDate()
    {
        return date;
    }
    public int getTo()
    {
        return to;
    }
    public int getFrom(){
        return from;
    }
    
}
