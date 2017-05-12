<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：inforclass101_addsave.jsp
說明：公開資訊分類
開發者：chmei
開發日期：99.05.23
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公開資訊分類</title>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );

  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String logincn = ( String )session.getAttribute( "logincn" );
  
  String logindn = ( String )session.getAttribute( "logindn" );
  String unitdn = SvString.right(logindn,",");
  String uname = ( String )session.getAttribute( "uname" );

  //form值
  String classname = ( String )request.getParameter( "classname" );
  
  //取得修改者IP
  String hostIP = request.getRemoteHost();
    
  PublicInforClassData obj = new PublicInforClassData();  
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setClassname(classname);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(unitdn);            //發布單位DN
  obj.setPubunitname(uname);           //發布單位名稱
  obj.setSubject(classname);           //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("A");                  //狀態
  
  //執行動作(新增資料)  
  rtn = obj.create();  
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "新增失敗！" + errMsg;
  }else{
	  showAlert="新增成功！";
  }

 %>

<form name="mform" action="inforclass101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  


</body>
</html>

