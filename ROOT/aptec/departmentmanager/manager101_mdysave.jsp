<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manager101_mdysave.jsp
說明：單位管理者維護
開發者：chmei
開發日期：96.12.20
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>雲林縣政府全球資訊網網站後端管理</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );

  //參數
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String punitdn = ( String )request.getParameter( "punit" );
  String punitname = ( String )request.getParameter( "punitname" );
  String name = ( String )request.getParameter( "name" );
  String[] ary_name = SvString.split(name,"-");
  
  String serno = ( String )request.getParameter( "serno" );

  DepartmentManagerData obj = new DepartmentManagerData();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setSerno(serno);
  obj.setManagerunitdn(punitdn);
  obj.setManagerunitname(punitname);
  obj.setManagerperdn(ary_name[0]);
  obj.setManagerpername(ary_name[1]);
  obj.setPostname(logincn);
  
  //執行動作(修改資料)   
  rtn = obj.store();
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="manager101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
