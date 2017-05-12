<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：pic_mdysave.jsp
說明：Menu圖片上傳
開發者：chmei
開發日期：97.02.19
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局服務網後端管理系統</title>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="sysview.zhiren.servlet.mime.SvMultipartRequest" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  String imgpath = ( String )request.getParameter( "path" );
  
  //取設定檔路徑
  String sysRoot1 = (String) getServletConfig().getServletContext().getRealPath("");
  //判斷OS版本
  String Menu_PATH = "";
  if ( sysRoot1.indexOf("/") == -1 )
	  Menu_PATH = sysRoot1 + "\\WEB-INF\\menu.properties";
  else
	  Menu_PATH = sysRoot1 + "/WEB-INF/menu.properties";

  Properties mess = new Properties();
  mess.load(new FileInputStream(Menu_PATH) );
  String menupath = mess.getProperty("menupath"); 
  String filepath = menupath + imgpath;

  //目錄不存在時，建立目錄
  File f = new File(filepath);  
  if (!f.exists()) 
     f.mkdirs();

  //接受上一頁Form內的所有欄位值
  SvMultipartRequest req = new SvMultipartRequest(request);  
  
  int size = 52428800;
  if ( !req.process(filepath,size) )
  { 
	 System.out.println(req.getErrorMsg());
     session.setAttribute("AlertMessage", "檔案無法上傳！");
     response.sendRedirect("pic_mdy.jsp");
     return;
  }
  
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
  String ndate = fmt.format(Calendar.getInstance().getTime());

  MenuData obj = new MenuData();  
  
  boolean rtn = true ;
  String errMsg="0"; 
  
  //URL 參數
  String serno = ( String )req.getParameter( "serno", "" );
  String table = ( String )req.getParameter( "table", "" );  
 
  File[] reqfile = req.getFiles();  
  //取得上傳檔案的個數 
  int num = reqfile.length;    
  
  //宣告陣列
  String filename[] = new String[4];  
  String originfile[] = new String[4];
  for (int i=0; i<num; i++)
  {
	  filename[i] = reqfile[i].getName();      
	  originfile[i] = req.getOriginFile(filename[i]);
	  if ( i==0 ) {
		  String subfile = SvString.right(filename[i],'.');
		  String filename2 = ndate + i + "." + subfile;
		  File oldfile = new File(filepath + "/" + filename[i]);
		  File newfile = new File(filepath + "/" + filename2);
		  
		  obj.setServerfile2(filename[i]);
		  if ( oldfile.renameTo(newfile) )
			  obj.setServerfile2(filename2);
		  obj.setClientfile2(originfile[i]);
	  }else if ( i==1 ) {
		  String subfile = SvString.right(filename[i],'.');
		  String filename3 = ndate + i + "." + subfile;
		  File oldfile = new File(filepath + "/" + filename[i]);
		  File newfile = new File(filepath + "/" + filename3);
		  obj.setServerfile3(filename[i]);
		  if ( oldfile.renameTo(newfile) )
			  obj.setServerfile3(filename3);
		  obj.setClientfile3(originfile[i]);
	  }else if ( i==2 ) {
		  String subfile = SvString.right(filename[i],'.');
		  String filename4 = ndate + i + "." + subfile;
		  File oldfile = new File(filepath + "/" + filename[i]);
		  File newfile = new File(filepath + "/" + filename4);
		  obj.setServerfile4(filename[i]);
		  if ( oldfile.renameTo(newfile) )
			  obj.setServerfile4(filename4);		  
		  obj.setClientfile4(originfile[i]);
	  }else if ( i==3 ) {
		  String subfile = SvString.right(filename[i],'.');
		  String filename5 = ndate + i + "." + subfile;
		  File oldfile = new File(filepath + "/" + filename[i]);
		  File newfile = new File(filepath + "/" + filename5);
		  obj.setServerfile5(filename[i]);
		  if ( oldfile.renameTo(newfile) )
			  obj.setServerfile5(filename5);
		  obj.setClientfile5(originfile[i]);
	  } 
  }
  
  String nsfile2 = ( String )req.getParameter( "nsfile2", "" );
  String osfile2 = ( String )req.getParameter( "osfile2", "" );  
  String ocfile2 = ( String )req.getParameter( "ocfile2", "" );
  if ( nsfile2.equals("") ) {
	  obj.setServerfile2(osfile2);
	  obj.setClientfile2(ocfile2);
  }else{
	  if (!osfile2.equals("")) {
		  File d2 = new File(filepath,osfile2);
          if (d2.exists()) {
        	  d2.delete();
          } 
      }
  }
  
  String nsfile3 = ( String )req.getParameter( "nsfile3", "" );
  String osfile3 = ( String )req.getParameter( "osfile3", "" );  
  String ocfile3 = ( String )req.getParameter( "ocfile3", "" );
  if ( nsfile3.equals("") ) {
	  obj.setServerfile3(osfile3);
	  obj.setClientfile3(ocfile3);
  }else{
	  if (!osfile3.equals("")) {
		  File d3 = new File(filepath,osfile3);
          if (d3.exists()) {
        	  d3.delete();
          } 
      }
  }
  
  String nsfile4 = ( String )req.getParameter( "nsfile4", "" );
  String osfile4 = ( String )req.getParameter( "osfile4", "" );  
  String ocfile4 = ( String )req.getParameter( "ocfile4", "" );
  if ( nsfile4.equals("") ) {
	  obj.setServerfile4(osfile4);
	  obj.setClientfile4(ocfile4);
  }else{
	  if (!osfile4.equals("")) {
		  File d4 = new File(filepath,osfile4);
          if (d4.exists()) {
        	  d4.delete();
          } 
      }
  }
  
  String nsfile5 = ( String )req.getParameter( "nsfile5", "" );
  String osfile5 = ( String )req.getParameter( "osfile5", "" );  
  String ocfile5 = ( String )req.getParameter( "ocfile5", "" );
  if ( nsfile5.equals("") ) {
	  obj.setServerfile5(osfile5);
	  obj.setClientfile5(ocfile5);
  }else{
	  if (!osfile5.equals("")) {
		  File d5 = new File(filepath,osfile5);
          if (d5.exists()) {
        	  d5.delete();
          } 
      }
  }

  String logincn = ( String )session.getAttribute("logincn");
  String language = ( String )req.getParameter( "language", "" );
  String expfile2 = ( String )req.getParameter( "mfileexp2", "" );
  String expfile3 = ( String )req.getParameter( "mfileexp3", "" );
  String expfile4 = ( String )req.getParameter( "mfileexp4", "" );
  String expfile5 = ( String )req.getParameter( "mfileexp5", "" );

  obj.setSerno(serno);
  obj.setPostname(logincn);
  obj.setExpfile2(expfile2);
  obj.setExpfile3(expfile3);
  obj.setExpfile4(expfile4);
  obj.setExpfile5(expfile5);

  //執行動作(儲存資料)  
  rtn = obj.storeimg(table);   
  
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "儲存失敗！" + errMsg;
  }else{
	  showAlert="儲存成功！";
  }

 %>

<form name="mform" action="pic_mdy.jsp" method="post">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="path" value="<%=imgpath%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>
