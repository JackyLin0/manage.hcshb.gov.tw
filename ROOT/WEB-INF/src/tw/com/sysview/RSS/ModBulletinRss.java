/*
 * 撰寫日期：2011/1/31
 * 程式名稱：BulletinRss.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.RSS;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sysview.zhiren.function.SvString;
import tw.com.sysview.dba.RssData;

public class ModBulletinRss extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try{
			response.setContentType("text/xml;charset=utf-8");              
            StringBuffer rss = new StringBuffer();
            
            rss.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
               .append("<rss version=\"2.0\">\n")
               .append("<channel>")
               .append("<title>新竹縣衛生局最新消息</title>\n");

            String flag = ( String )request.getParameter( "flag" );
            if ( flag == null || flag.equals("null") ) {
            	flag = "";
            }
            
            RssData qhbulletin = new RssData();
            ArrayList<Object> qbulletins = qhbulletin.findBybulletin(flag);
            int bulletinrcount = qhbulletin.getAllrecordCount();
            
            if ( qbulletins != null ) {
            	for ( int i=0; i<bulletinrcount; i++ ) {
            		RssData qbulletin = ( RssData )qbulletins.get( i );
            		
            		//是否為重要資料
            		String notetype = qbulletin.getNoteflag();
            		if (notetype == null || notetype.equals("null") || notetype.equals("")) {
            			notetype = "false";
            		} else if (notetype.equals("Y")) {
            			notetype = "true";
            		} else if (notetype.equals("N")) {
            			notetype = "false";
            		}
            		
            		rss.append("<item><type>"+qbulletin.getMclassname()+"</type>\n")
            		   .append("<title note=\"" + notetype + "\"><![CDATA["+qbulletin.getSubject()+"]]></title>\n")
            		   .append("<publisher>"+qbulletin.getPubunitname()+"</publisher>\n");
            		
            		   
                    if ( qbulletin.getContent() != null && !qbulletin.getContent().equals("null") && !qbulletin.getContent().equals("") )
                    	rss.append("<description><![CDATA["+qbulletin.getContent()+"]]></description>\n");
                    
                    rss.append("<datetime>"+qbulletin.getPosterdate().substring(0,4)+"-"+qbulletin.getPosterdate().substring(4,6)+"-"+qbulletin.getPosterdate().substring(6,8)+"</datetime>\n");
                        
 
                    //圖片
                    RssData qmpic = new RssData();
                    ArrayList<Object> qpics = qmpic.findByday("BulletinFile", qbulletin.getSerno(), "pic", "");
                    int rcount = qmpic.getAllrecordCount();
                    
                    if ( qpics != null ) {
                    	rss.append("<images>\n");
                    	for ( int p=0; p<rcount; p++ ) {
                    		RssData qpic = ( RssData )qpics.get( p );
                    		rss.append("<image>http://www.hcshb.gov.tw/downfile/pic/pubhcshb/bulletin/" + qpic.getServerfile() + "</image>\n");
                    	}
                    	rss.append("</images>\n");
                    } else {
                    	rss.append("<images></images>\n");
                    }

                    
                    //video
                    RssData qmvideo = new RssData();
                    ArrayList<Object> qvideos = qmvideo.findByday("BulletinFile", qbulletin.getSerno(), "media", "mpg");
                    if ( qvideos != null ) {
                    	for ( int v=0; v<1; v++ ) {
                    		RssData qvideo = ( RssData )qvideos.get( v );
                    		rss.append("<video isfull=\"true\">http://www.hcshb.gov.tw/downfile/media/pubhcshb/bulletin/" + qvideo.getServerfile() + "</video>\n");
                    	}
                    } else {
                    	rss.append("<video></video>\n");
                    }
                    //audio
                    RssData qmvideo1 = new RssData();
                    ArrayList<Object> qvideos1 = qmvideo1.findByday("BulletinFile", qbulletin.getSerno(), "media", "mp3");
                    if ( qvideos1 != null ) {
                    	for ( int v=0; v<1; v++ ) {
                    		RssData qvideo1 = ( RssData )qvideos1.get( v );
                    		rss.append("<audio>http://www.hcshb.gov.tw/downfile/media/pubhcshb/bulletin/" + qvideo1.getServerfile() + "</audio>\n");
                    	}
                    } else {
                    	rss.append("<audio></audio>\n");
                    }

                    rss.append("</item>\n");
            	}
            	
            }else{
            	
            }
            rss.append("</channel>\n\n")
               .append("</rss>");
            
            PrintWriter out = response.getWriter();
            out.print(rss.toString());
            
		}catch(Exception e){
			
		}
	}

}
