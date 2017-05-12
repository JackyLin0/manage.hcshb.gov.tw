<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：metadata101_mdysave.jsp
說明：分類檢索共用欄位維護
開發者：chmei
開發日期：99.06.27
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局服務網後端管理系統</title>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="tw.com.sysview.metatag.*" %>

<body>

<%
  String pubunitdn = ( String )session.getAttribute("logindn");
  String pubunitname = ( String )session.getAttribute("uname");
  String logincn = ( String )session.getAttribute("logincn");
  String websitedn = ( String )request.getParameter( "websitedn" );
  String language = ( String )request.getParameter( "language" );
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String menudata = ( String )request.getParameter( "menudata" );
  String murl = ( String )request.getParameter( "murl" );
  String mserno = ( String )request.getParameter( "mserno" );

  String mtitle = ( String )request.getParameter( "mtitle" );
  String creator = ( String )request.getParameter( "creator" );
  String publisher = ( String )request.getParameter( "publisher" );
  String contributor = ( String )request.getParameter( "contributor" );
  String mtype = ( String )request.getParameter( "mtype" );
  String mformat = ( String )request.getParameter( "mformat" );
  String identifier = ( String )request.getParameter( "identifier" );
  String relation = ( String )request.getParameter( "relation" );
  String source = ( String )request.getParameter( "source" );
  String languagetype = ( String )request.getParameter( "languagetype" );
  String rights = ( String )request.getParameter( "rights" );
  String theme = ( String )request.getParameter( "theme" );
  String cake = ( String )request.getParameter( "cake" );
  String service = ( String )request.getParameter( "service" );

  //取得修改者IP
  String hostIP = request.getRemoteHost();

  boolean rtn = true ;
  String errMsg="0"; 
  
  MetaTagData obj = new MetaTagData();
  
  obj.setWebsitedn(websitedn);
  obj.setWebsitename(mtitle);
  obj.setMenudata(menudata);
  obj.setTitle(mtitle);
  obj.setSubject(mtitle);
  obj.setCreator(creator);
  obj.setPublisher(publisher);
  obj.setContributor(contributor);
  obj.setMtype(mtype);
  obj.setMformat(mformat);
  obj.setIdentifier(identifier);
  obj.setRelation(relation);
  obj.setSource(source);
  obj.setLanguagetype(languagetype);
  obj.setRights(rights);
  obj.setThemeclass(theme);
  obj.setCakeclass(cake);  
  obj.setServiceclass(service);

  //網站維運統計共用參數(WebSiteLog)
  obj.setSerno(mserno);
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(mtitle);              //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setStatus("U");                  //狀態
  
  //執行動作(新增資料)  
  rtn = obj.create();  
  
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>


<form name="mform" action="metadata101_mdy.jsp" method="post">
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="murl" value="<%=murl%>" />
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>

</body>
</html>
