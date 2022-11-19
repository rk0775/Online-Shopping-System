package GeterAndSeter;

public class WordProvider {
    static public String getTenWord(String dis)
    {
        String tenWordString="";
        
        String s[]=dis.split(" ");
        if(s.length<=10)
        {
            tenWordString=dis;
        }else{
            for(int i=0;i<10;i++)
            {   
                tenWordString+=" "+s[i];
            }
        }
        
        return tenWordString+"....";
    }
    static public String getSevenWord(String dis)
    {
        String sevenWordString="";
        
        String s[]=dis.split(" ");
        if(s.length<=7)
        {
            sevenWordString=dis;
        }else{
             
            for(int i=0;i<7;i++)
            {   
                sevenWordString+=" "+s[i];
            }
        }
        
        return sevenWordString;
    }
    
}
