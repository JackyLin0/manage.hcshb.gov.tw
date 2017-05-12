<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 駕駛人員維護 - 刪除
Programming File: drive101_del.jsp
Copyright © SYSTEX B17E By Peilun 2012-04-24
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  
  //參數
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );

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
  

  //取得修改者IP
  String hostIP = request.getRemoteHost();
    
  CarData obj = new CarData();
  
  boolean rtnweb = true ;
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
  rtnweb = obj.remove();  

  String showAlert = null;
  String program = "car101.jsp";
  if ( rtnweb == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "刪除失敗！" + errMsg;
  }else{
	  showAlert="刪除成功！";
  }

%>

<form name="mform" action="<%=program%>" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>

 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
 