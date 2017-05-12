<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：statistics101_del.jsp
說明：衛生統計維護
開發者：chmei
開發日期：97.02.18
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  String type = ( String )request.getParameter( "type" );
  String delserno = "";

  if ( type.equals("0") ) {            //整批刪除
	  String[] chk = request.getParameterValues("check");
      if ( chk == null ) { %>
    	  <script>
    	     alert("【您未勾選任何一項】");
    	     window.history.go(-1);
    	  </script>
      <%}else{
    	  for ( int i=0; i<chk.length; i++ ) {
    		  if ( delserno.equals("") )
    			  delserno = chk[i];
    		  else
    			  delserno = delserno + "||" + chk[i];
    	  }
      }
  }else if ( type.equals("1") ) {      //刪除單筆資料
	  delserno = ( String )request.getParameter("serno");
  }  
  
  //刪除檔案
  String path = ( String )request.getParameter( "path" );  
  //取設定檔路徑
  String sysRoot = (String) getServletConfig().getServletContext().getRealPath("");
  String Upload_PATH = sysRoot+"/WEB-INF/uploadpath.properties";
  Properties upload = new Properties();
  upload.load(new FileInputStream(Upload_PATH));
  String uploadpath = "";
  String[] ary_delno = SvString.split(delserno,"||");
  for ( int i=0; i<ary_delno.length; i++ ) {
	  StatisticsData qfile = new StatisticsData();
	  ArrayList qdels = qfile.findBydel("StatisticsFile",ary_delno[i]);	  
	  int delrcount = qfile.getAllrecordCount();
	  if ( qdels != null ) {
		  for ( int d=0; d<delrcount; d++ ) {
			  StatisticsData qdel = ( StatisticsData )qdels.get( d );
			  String flag = qdel.getFlag();
			  if ( flag.equals("doc") ) {
				  uploadpath = upload.getProperty("filepath");
			  }else if ( flag.equals("pic")) {
				  uploadpath = upload.getProperty("picpath");
			  }else if ( flag.equals("media")) {
				  uploadpath = upload.getProperty("mediapath");
			  }
			  String filepath = uploadpath + path;
			  if ( qdel.getServerfile() != null && !qdel.getServerfile().equals("") ) {
				  File df = new File(filepath,qdel.getServerfile());
				  if (df.exists())
					  df.delete();			  
			  }
			  if ( qdel.getSmediafile() != null && !qdel.getSmediafile().equals("") ) {
				  File dm = new File(filepath,qdel.getSmediafile());
				  if (dm.exists())
					  dm.delete();
			  }
			  if ( qdel.getImagemagick() != null && !qdel.getImagemagick().equals("") ) {
				  File di = new File(filepath,qdel.getImagemagick());
				  if (di.exists())
					  di.delete();
			  }
		  }
	  }
  }
  
  //取得修改者IP
  String hostIP = request.getRemoteHost();
    
  StatisticsData obj = new StatisticsData();
  
  boolean rtn = true ;
  String errMsg="0";   
  
  obj.setSerno(delserno);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("D");                  //狀態
  
  //執行動作(修改資料)  
  rtn = obj.remove("StatisticsFile");

  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "刪除失敗！" + errMsg;
  }else{
	  showAlert="刪除成功！";
  }

%>

<form name="mform" action="statistics101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
</form>

 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
 