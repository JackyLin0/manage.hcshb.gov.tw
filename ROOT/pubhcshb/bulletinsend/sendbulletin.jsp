<%@page import="tw.com.sysview.upload.UploadData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 
<%@ page import="sysview.zhiren.mail.SvMail" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String allemail = "yclai@econcord.com.tw";
  String serno = ( String )request.getParameter( "serno" );
  String path = ( String )request.getParameter( "path" );
  String sendemail = ( String )request.getParameter( "sendemail" );
  if ( sendemail != null && !sendemail.equals("null") && !sendemail.equals("") ) {
   allemail = sendemail;
  } 
  
  //自web.xml檔讀取mailserver變數
  String mailserver = ( String )application.getInitParameter( "MailServer" );

  //尋找縣府新聞資料
  BulletinSendData qdata = new BulletinSendData();
  boolean rtn = qdata.load("Bulletinsend", serno);  

  String mcontent = "";
  
  if ( mcontent.equals("") ) {
   mcontent = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/><title>新竹縣衛生局新聞稿</title></head>";
  }
  mcontent = mcontent + "<body><div class=WordSection1><table width='100%' border='1' cellpadding='1' cellspacing='1' style='font-size:14px;font-family:新細明體'>";
  mcontent = mcontent + "<thead><tr align='center' height='40'><td colspan='6'><font size='5'>新竹縣政府"+qdata.getPubunitname()+"新聞稿</font></td></tr><tr align='center'>";
  mcontent = mcontent + "<td colspan='1' width='10%' align='center'><font size='4'>日期</font><td colspan='1' width='20%' align='center'>" + tw.com.sysview.function.Datestr.date_chinese(qdata.getPosterdate(),"") + "</td>";
  mcontent = mcontent + "<td colspan='1' width='15%' align='center'><font size='4'>撰稿單位</font></td><td colspan='1' width='15%' align='center'>" + qdata.getLiaisonunit() + "</td>";
  mcontent = mcontent + "<td colspan='1' width='15%' align='center'><font size='4'>聯絡人</font></td><td colspan='1' width='15%' align='center'>" + qdata.getLiaisonper() + "</td></tr>";
  mcontent = mcontent + "<tr align='center' height='45'><td colspan='1' align='left' align='center'><font size='4'>標 題</font></td><td colspan='5' align='left'><font size='4'>" + qdata.getSubject() + "</font></td></tr>";
  
  mcontent = mcontent + "<tr align='center' height='45'><td colspan='1' align='left' align='center'><font size='4'>公告<br>方式</font></td>";
  mcontent = mcontent + "<td colspan='5' align='left'><font size='5'>□</font><font size='4'>本局網頁</font><font size='5'>□</font><font size='4'>新聞稿 </font></td></tr></thead></table>";
  
 if ( qdata.getContent() != null && !qdata.getContent().equals("null") ) {
    mcontent = mcontent + "<p >" + qdata.getContent().replaceAll("\n","<br>").replaceAll(" ","&nbsp;")+"</p>";
 }

 if ( qdata.getRelateurl() != null && !qdata.getRelateurl().equals("null") && !qdata.getRelateurl().equals("") && !qdata.getRelateurl().equals("http://") ) {
    mcontent = mcontent + "<br>相關資訊連結：<a href='"+qdata.getRelateurl()+"'>"+qdata.getRelatename()+"</a>";
 }
 
//相關附件
 UploadData qupload = new UploadData();    
 ArrayList qfiles = qupload.findByday("BulletinsendFile",serno,"doc");
 int rcount = qupload.getAllrecordCount();

 if ( rcount > 0 ) {
    mcontent = mcontent + "<tr><td colspan='2' align='left' valign='top'><table width='100%' border='0' cellspacing='0' cellpadding='0'>";
    mcontent = mcontent + "<tr><td width='2%' align='left' valign='middle'><img src='http://www.hcshb.gov.tw/common/img/icon3.gif' alt='*' width='19' height='15' align='absmiddle' /></td>";
    mcontent = mcontent + "<td colspan='2' align='left' valign='top'><span> 相關附件：</span></td></tr>";
    for ( int i=0; i<rcount; i++ ) {
      UploadData qfile = ( UploadData )qfiles.get( i ); 
      String msfile = qfile.getServerfile();
      mcontent = mcontent + "<tr><td align='left' valign='middle'>&nbsp;</td><td width='2%' align='left' valign='top' >&nbsp;</td>";
      mcontent = mcontent + "<td width='96%' align='left' valign='top' >》<a href='http://www.hcshb.gov.tw/uploaddowndoc?file="+path+"/"+java.net.URLEncoder.encode(msfile,"UTF-8") + "&flag=doc' title='" +qfile.getClientfile() + "(您將開啟附件新視窗)' target='_blank'>"+qfile.getClientfile()+"</a><br/></td></tr>";
      
      mcontent = mcontent + "<tr><td align='left' valign='middle'>&nbsp;</td><td width='2%' align='left' valign='top' >&nbsp;</td>";
      mcontent = mcontent + "<tr><td align='left' valign='middle'>&nbsp;</td><td width='2%' align='left' valign='top' >&nbsp;</td>";
    }         
  mcontent = mcontent + "</table></td></tr><tr><td colspan='2' align='left' valign='top' background='http://www.hcshb.gov.tw/img/line.gif'>&nbsp;</td></tr>";
 }
 
 
 //相關圖片    
 UploadData qupload1 = new UploadData();
 ArrayList qfiles1 = qupload1.findByday("BulletinsendFile",serno,"pic");
 
 int rcount1 = qupload1.getAllrecordCount();
 
 //取出預設縮圖之寬及高
 String sysRoot = (String) application.getRealPath("");
 sysRoot = sysRoot.replace('\\','/');
 String PRO_PATH = sysRoot+"/WEB-INF/uploadpath.properties";	
 Properties p = new Properties();
 p.load(new FileInputStream(PRO_PATH));
 
 if ( rcount1 > 0 ) {
  mcontent = mcontent + "<table><tr><td colspan='2' align='left' valign='top'><table width='80%' border='1' cellspacing='1' cellpadding='1'><tr><td width='2%' align='left' valign='middle'><img src='http://www.hcshb.gov.tw/common/img/icon3.gif' alt='*' width='19' height='15' align='absmiddle' /></td><td colspan='5' align='left' valign='top'><span >相關圖檔：</span></td></tr>";
  int k = 0;
  for ( int i=0; i<rcount1; i++ ) {	        	  
	 UploadData qfile1 = ( UploadData )qfiles1.get( i );
	 String msfile = qfile1.getServerfile();
	 k = k + 1;
	 if ( k > 3 ) {
		k = 1;
	 }
	 if ( k == 1 ) {
		 mcontent = mcontent + "<tr>";
	 }
	 mcontent = mcontent + "<td colspan='2'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td align='center' valign='top'><table width='100%' border='0' cellpadding='0' cellspacing='0' class='imagebox'><tr><td align='center' valign='top' >";
	 if ( qfile1.getImagemagick() != null && !qfile1.getImagemagick().equals("null") && !qfile1.getImagemagick().equals("") ) {
		 mcontent = mcontent + "<a href='http://www.hcshb.gov.tw/pubprogram/upload/imgprview.jsp?file="+path+"/"+java.net.URLEncoder.encode(qfile1.getServerfile(),"UTF-8")+"&flag=pic&tablename=BulletinsendFile&serno="+serno+"&detailno="+qfile1.getDetailno()+"' title='您將開啟圖檔新視窗' target='_blank'><img src='http://www.hcshb.gov.tw/uploaddowndoc?file="+path+"/"+java.net.URLEncoder.encode(msfile,"UTF-8")+"&flag=pic' alt='"+qfile1.getExpfile()+"' width='170' height='200' border='0'/></a>";
    }else{
	     mcontent = mcontent + "<a href='http://www.hcshb.gov.tw/pubprogram/upload/imgprview.jsp?file="+path+"/"+java.net.URLEncoder.encode(qfile1.getServerfile(),"UTF-8")+"&flag=pic&tablename=BulletinsendFile&serno="+serno+"&detailno="+qfile1.getDetailno()+"' title='您將開啟圖檔新視窗' target='_blank'><img src='http://www.hcshb.gov.tw/uploaddowndoc?file="+path+"/"+java.net.URLEncoder.encode(msfile,"UTF-8")+"&flag=pic' alt='"+qfile1.getExpfile()+"' width='170' height='200' border='0'/></a>";
    }
	 mcontent = mcontent + "</td></tr></table></td></tr><tr><td align='center' valign='top' >"+qfile1.getExpfile()+"</td></tr></table></td>";
  }	  
  mcontent = mcontent + "</tr></table></td></tr></table>";
 }
 
  
  mcontent = mcontent + "<br><table width='100%' border='1' cellpadding='1' cellspacing='1' style='font-size:14px;font-family:新細明體'>";
  mcontent = mcontent + "<tr align='center' height='40'>";
  mcontent = mcontent + "<td width='10%'><font size='4'>承辦人 </font></td>";
  mcontent = mcontent + "<td width='10%' align='center'> </td>";
  mcontent = mcontent + "<td width='10%'><font size='4'> 科長 </font></td>";
  mcontent = mcontent + "<td width='10%' align='center'> </td>";
  mcontent = mcontent + "<td width='10%'><font size='4'>秘書</font></td>";
  mcontent = mcontent + "<td width='10%' align='center'> </td>";
  mcontent = mcontent + "<td width='10%'><font size='4'>副局長 </font></td>";
  mcontent = mcontent + "<td width='10%' align='center'> </td>";
  mcontent = mcontent + "<td width='10%'><font size='4'>局長 </font></td>";
  mcontent = mcontent + "<td width='10%' align='center'> </td></tr></table>";
  
  

  

  if ( !allemail.equals("") ) {
   String[] ary_email = SvString.split(allemail,";");
   for ( int i=0; i<ary_email.length; i++ ) {
    SvMail mail = new SvMail();
    boolean rtn1 = mail.sendHtml( mailserver, "epaper@hchg.gov.tw", ary_email[i], "", "", qdata.getSubject(), mcontent);
   }
  }
  //SvMail mail = new SvMail();
  //boolean rtn1 = mail.sendHtml( mailserver, "epaper@hchg.gov.tw", "chmei@sysview.com.tw", "", "", subject, mcontent);  
 
  if ( sendemail != null && !sendemail.equals("null") && !sendemail.equals("") ) {%>
   <script>
      alert("手動派送成功");
      window.close();
   </script>
  <%}%>

