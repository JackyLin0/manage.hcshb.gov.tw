/*
 * 撰寫日期：2007/3/18
 * 程式名稱：menudowndoc.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.downdoc;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class menudowndoc extends HttpServlet {
	  public void doGet(HttpServletRequest	request,HttpServletResponse response) throws ServletException, IOException
	  {
		try{
			request.setCharacterEncoding("UTF-8");
			ServletContext application = getServletContext();
	    	String uriString=request.getParameter("file");
			
			System.out.println();
			String sysRoot=(String) application.getRealPath("");
			sysRoot = sysRoot.replace('\\','/');
			   
			//判斷OS版本
			String Menu_PATH = "";
			if ( sysRoot.indexOf("/") == -1 )
				Menu_PATH = sysRoot+"\\WEB-INF\\menu.properties";	
			else
				Menu_PATH = sysRoot+"/WEB-INF/menu.properties";	

			Properties menu = new Properties();
			menu.load(new FileInputStream(Menu_PATH)) ;
	        String filefolder=menu.getProperty("menupath");
	        
			String parameter1=svURLDecoder.decode(uriString,"UTF8");
			String parameter2=svURLDecoder.decode(uriString,"Big5");				
			String parameter=svList.isCharsetBig5(parameter1)?parameter1:parameter2;		
			int ptr1=parameter.lastIndexOf('/');
			parameter=new String(uriString.getBytes("8859_1"),"UTF-8");
			String dirPath=parameter;

			String filename=parameter.substring(ptr1+1);		
			
	        if(filename!=null){
				InputStream in = new FileInputStream(svList.replace(filefolder,"\\","/")+dirPath);
							
		        response.setHeader("Content-Disposition","attachment;filename=" + new String(filename.getBytes(),"ISO-8859-1") );
				ServletOutputStream outStream=response.getOutputStream();
				byte[] buf = new byte[2048];
				int count=-1;
				while(true) {
				   count=in.read(buf);
					if(count==-1)
						break;
					else
						outStream.write(buf,0,count);
				}
				in.close(); 
			}		
			
		}catch(NullPointerException npe){
			response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();	
		    out.println("<script>");
		    out.println("alert(\"您的瀏覽器未送出Cookie。請確定Cookie的設定已打開!\");");
		    out.println("</script>");
		}catch(StringIndexOutOfBoundsException sioobe){
			response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.println("<script>");
		    out.println("alert(\"下載檔案時,所傳遞的參數不正確!\");");
		    out.println("</script>");
	   }catch(Exception fnfe){
		   response.setContentType("text/html; charset=UTF-8");
		   PrintWriter out = response.getWriter();
		   out.println("<script>");
		   out.println("alert(\"欲下載的檔案不存在!\");");
		   out.println("</script>");
	   }
	  }
}
