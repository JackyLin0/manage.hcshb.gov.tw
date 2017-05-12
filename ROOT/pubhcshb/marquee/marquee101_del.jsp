<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：marquee101_del.jsp
說明：跑馬燈維護
開發者：chmei
開發日期：99.05.23
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>跑馬燈維護</title>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

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
      if ( chk != null ) {
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
  
  if ( delserno.equals("") ) { %>
	  <script>
	    alert("【您未勾選任何一項】");
	    window.history.go(-1);
	  </script>
  <%}else{
	  //取得修改者IP
	  String hostIP = request.getRemoteHost();
	    
	  MarqueeData obj = new MarqueeData();
	  
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
	  rtn = obj.remove();

	  String showAlert = null;  
	  if ( rtn == false ) {
		  errMsg = obj.getErrorMsg();
		  showAlert = "刪除失敗！" + errMsg;
	  }else{
		  showAlert="刪除成功！";
	  }

	%>

	<form name="mform" action="marquee101.jsp" method="post">
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
  <%}%>

</body>
</html>
