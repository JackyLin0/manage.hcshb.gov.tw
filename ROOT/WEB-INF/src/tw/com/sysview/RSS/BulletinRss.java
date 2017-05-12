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

public class BulletinRss extends HttpServlet {

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try{
			response.setContentType("text/xml;charset=utf-8");              
            StringBuffer rss = new StringBuffer();
            
            String mlink = "http://www.hcshb.gov.tw/home.jsp?mserno=200802220002&serno=200802220015&menudata=HcshbMenu";
            String mlinkmore = mlink + "&contlink=hcshb/ap/news.jsp";
            
            rss.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
               .append("<rss version=\"2.0\">\n")
               .append("<channel>")
               .append("<title>新竹縣衛生局最新消息</title>\n")
               .append("<link><![CDATA[" + mlinkmore + "]]></link>\n")
               .append("<title>新竹縣衛生局最新消息</title>\n")
               .append("<link><![CDATA["+ mlinkmore + "]]></link>\n")
               .append("<description>新竹縣衛生局</description>\n")
               .append("<language>zh-tw</language>\n")
               .append("<category>類別</category>\n");
            
            String flag = ( String )request.getParameter( "flag" );
            if ( flag == null || flag.equals("null") ) {
            	flag = "";
            }
            RssData qhbulletin = new RssData();
            ArrayList<Object> qbulletins = qhbulletin.findBybulletin(flag);
            int bulletinrcount = qhbulletin.getAllrecordCount();
            
            if( bulletinrcount == 0 ){
                rss.append("<ttl>1</ttl> \n") ; 
            }
            else{
               rss.append("<ttl>"+bulletinrcount+"</ttl> \n") ; 
            }
            
            if ( qbulletins != null ) {
            	for ( int i=0; i<bulletinrcount; i++ ) {
            		RssData qbulletin = ( RssData )qbulletins.get( i );
            		
            		rss.append("<item><type>"+qbulletin.getMclassname()+"</type>\n")
            		   .append("<title note='true'><![CDATA["+qbulletin.getSubject()+"]]></title>\n")
            		   .append("<publisher>"+qbulletin.getPubunitname()+"</publisher>\n")
            		   .append("<datetime>"+qbulletin.getPosterdate().substring(0,4)+"-"+qbulletin.getPosterdate().substring(4,6)+"-"+qbulletin.getPosterdate().substring(6,8)+"</datetime>\n");
            		String mlinkdetail = mlink + "&contlink=hcshb/ap/news_view.jsp&dataserno=" + qbulletin.getSerno();
                    rss.append("<link><![CDATA[" + mlinkdetail +"]]></link> \n");
                    if ( qbulletin.getContent() != null && !qbulletin.getContent().equals("null") && !qbulletin.getContent().equals("") )
                    	rss.append("<description><![CDATA["+qbulletin.getContent()+"]]></description>\n");
                    if ( qbulletin.getRelateurl() != null && !qbulletin.getRelateurl().equals("null") && !qbulletin.getRelateurl().equals("") && !qbulletin.getRelateurl().equals("http://") )
                    	rss.append("<link><![CDATA["+qbulletin.getRelateurl()+"]]></link>\n");
                    rss.append("<title><![CDATA["+qbulletin.getSubject()+"]]></title>\n")
                       .append("<creator>新竹縣衛生局</creator>\n")
                       .append("<subject>"+qbulletin.getSubject()+"</subject>\n");
                    if ( qbulletin.getSecsubject() != null && !qbulletin.getSecsubject().equals("null") )
                    	rss.append("<description><![CDATA["+qbulletin.getSecsubject()+"]]></description>\n");
                    //圖片
                    /*
                    RssData qmpic = new RssData();
                    ArrayList<Object> qpics = qmpic.findByday("BulletinFile", qbulletin.getSerno(), "pic", "");
                    int rcount = qmpic.getAllrecordCount();
                    if ( qpics != null ) {
                    	rss.append("<images>\n");
                    	//for ( int p=0; p<rcount; p++ ) {
                    	//	RssData qpic = ( RssData )qpics.get( p );
                    	//	rss.append("<image>http://www.hcshb.gov.tw/downfile/media/pubhcshb/bulletin/" + qpic.getServerfile() + "</image>\n");
                    	//}
                    	rss.append("</images>\n");
                    }
                    //video
                    RssData qmvideo = new RssData();
                    ArrayList<Object> qvideos = qmvideo.findByday("BulletinFile", qbulletin.getSerno(), "media", "mpg");
                    if ( qvideos != null ) {
                    	for ( int v=0; v<1; v++ ) {
                    		RssData qvideo = ( RssData )qvideos.get( v );
                    		rss.append("<video isfull='false'>ftp://www.hcshb.gov.tw/downfile/media/pubhcshb/bulletin/" + qvideo.getServerfile() + "</video>\n");
                    	}
                    }
                    //video
                    RssData qmvideo1 = new RssData();
                    ArrayList<Object> qvideos1 = qmvideo1.findByday("BulletinFile", qbulletin.getSerno(), "media", "mp3");
                    if ( qvideos1 != null ) {
                    	for ( int v=0; v<1; v++ ) {
                    		RssData qvideo1 = ( RssData )qvideos1.get( v );
                    		rss.append("<audio>http://www.hcshb.gov.tw/downfile/pubhcshb/bulletin/" + qvideo1.getServerfile() + "</audio>\n");
                    	}
                    }
                    */
                    rss.append("<contributor>新竹縣衛生局"+qbulletin.getPubunitname()+"</contributor>\n")
                       .append("<type>最新消息</type>\n")
                       .append("<language>中文</language>\n")
                       .append("<publisher>新竹縣衛生局</publisher>\n")
                       .append("<date>"+qbulletin.getPosterdate().subSequence(0,4)+"-"+qbulletin.getPosterdate().subSequence(4,6)+"-"+qbulletin.getPosterdate().subSequence(6,8)+"</date>\n");
                    //OID編碼方式(新竹縣政府-單位-一般公告-序號)
                    String munitdn = qbulletin.getPubunitdn();
                    String[] ary_unitdn = SvString.split(munitdn,",");
                    String munit1 = SvString.right(ary_unitdn[0],"=");
                    String munit2 = SvString.right(ary_unitdn[1],"=");
                    rss.append("<identifier>"+munit2+"-"+munit1+"-"+"Bulletin"+"-"+qbulletin.getSerno()+"</identifier>\n")
                       .append("<category.theme>100</category.theme>\n")
                       .append("<category.cake>100</category.cake>\n")
                       .append("<category.service>I00</category.service>\n")
                       .append("</item>\n");
            	}
            	
            }else{
            	rss.append("<item><title>目前無最新消息資料 </title>\n")
                   .append("<link>" + mlink + "</link> \n")
                   .append("<description>新竹縣衛生局最新消息</description>  \n")
                   .append("</item>\n"); 
            	
            }
            rss.append("</channel>\n\n")
               .append("</rss>");
            
            PrintWriter out = response.getWriter();
            out.print(rss.toString());
            
		}catch(Exception e){
			
		}
	}

}
