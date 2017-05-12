<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：filessharebanner101_del.jsp
說明：右側檔案分享管理 (刪除功能)
開發者：Leo Zeng
開發日期：2017.03.03
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String websitedn = ( String )request.getParameter( "websitedn" );
  String language = ( String )request.getParameter( "language" );
  if ( language.equals("ch") )
	  language = "chinese";
  else if ( language.equals("en") )
	  language = "english";
  else if ( language.equals("en") )
	  language = "japan";
  
  String title = ( String )request.getParameter( "mtitle" );
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
  
  //取系統路徑
  String sysRoot1 = (String) application.getRealPath("");
  
  //判斷OS版本
  String Upload_PATH = "";
  if ( sysRoot1.indexOf("/") == -1 )
	  Upload_PATH = sysRoot1+"\\WEB-INF\\uploadpath.properties";
  else
	  Upload_PATH = sysRoot1+"/WEB-INF/uploadpath.properties";

  Properties upload = new Properties();
  upload.load(new FileInputStream(Upload_PATH) );
  String filepath = upload.getProperty("filessharebannerpath");  

  
  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  //暫時先使用別的 DAO，因為伺服器要重新開啟才能讀取新增的 JavaBean 或 DAO Object， 以後再另做處理 2017.03.07 (Leo 紀錄)
  //FilesShareBannerData obj = new FilesShareBannerData();
  BannerRightData obj = new BannerRightData();
  
  
  
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
  rtn = obj.remove(filepath);  

  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "刪除失敗！" + errMsg;
  }else{
	  showAlert="刪除成功！";
  }

%>

<form name="mform" action="filessharebanner101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
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
 