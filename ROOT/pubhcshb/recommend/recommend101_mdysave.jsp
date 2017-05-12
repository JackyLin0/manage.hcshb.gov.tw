<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：recommend_mdysave.jsp
說明：推薦服務專區
開發者：chmei
開發日期：99.05.27
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>推薦服務專區</title>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  String language = ( String )request.getParameter( "language" );
  String websitedn = ( String )request.getParameter( "websitedn" );
  String websitename = "";
  WebSiteData qwebname = new WebSiteData();
  boolean mrtn = qwebname.load(websitedn,language);
  if ( mrtn )
	  websitename = qwebname.getWebsitename();
  
  //取tablemenu
  String[] ary_websitedn = SvString.split(websitedn,",");
  String table1 = SvString.right(ary_websitedn[0],"=");
  String menutable = table1.substring(0,1).toUpperCase() + table1.substring(1) + "Menu";
  
  String choicemenu = ( String )request.getParameter( "choicemenu" );

  String table = ( String )request.getParameter( "t" );
  String murl = ( String )request.getParameter( "murl" );
  String title = ( String )request.getParameter( "title" );
  String logincn = ( String )session.getAttribute( "logincn" );
  String logindn = ( String )session.getAttribute( "logindn" );
  String pubunitdn = SvString.right(logindn,",");
  String pubunitname = ( String )session.getAttribute( "uname" );

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  RecommendData obj = new RecommendData();
  
  boolean rtn = true ;
  String errMsg="0";     

  obj.setMenuserno(choicemenu);
  obj.setWebsitedn(websitedn);
  obj.setWebsitename(websitename);
  
  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(title);               //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("A");                  //狀態

  //執行動作(新增資料)  
  rtn = obj.create(menutable);
    
  String showAlert = null;
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "新增失敗！" + errMsg;
  }else{
	  showAlert = "新增成功！";
  }

%>

<form name="mform" action="recommend101.jsp" method="post" target="mainFrame">
  <input type="hidden" name="websitedn" value="<%=websitedn%>" />
  <input type="hidden" name="language" value="<%=language%>" />
  <input type="hidden" name="murl" value="<%=murl%>" />
  <input type="hidden" name="t" value="<%=table%>" />
</form>

<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>

</body> 

</html>

