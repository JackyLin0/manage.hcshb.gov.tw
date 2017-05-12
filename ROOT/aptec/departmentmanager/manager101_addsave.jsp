<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manager101_addsave.jsp
說明：單位管理者維護
開發者：chmei
開發日期：96.12.20
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>雲林縣政府全球資訊網網站後端管理</title>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String punit = ( String )request.getParameter( "punit" );  
  String name = ( String )request.getParameter( "name" );
  String[] ary_punit = SvString.split(punit,"||");
  String[] ary_name = SvString.split(name,"-");

  DepartmentManagerData obj = new DepartmentManagerData();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setManagerunitdn(ary_punit[0]);      
  obj.setManagerunitname(ary_punit[1]);    
  obj.setManagerperdn(ary_name[0]);
  obj.setManagerpername(ary_name[1]);
  obj.setPostname(logincn);
  
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

<form name="mform" action="manager101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  

  
%>  