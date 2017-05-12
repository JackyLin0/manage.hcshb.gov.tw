<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities103_mdysave.jsp
說明：欄位維護
開發者：chmei
開發日期：98.10.15
修改者：
修改日期：
版本：ver1.0
-->


<%@ page import="tw.com.sysview.dba.*" %>

<%
  String serno = ( String )request.getParameter( "serno" );
  String fieldflag = ( String )request.getParameter( "fieldflag" );

  //參數
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );;
  
  String logincn = ( String )session.getAttribute( "logincn" );

  ActivityColumnData obj = new ActivityColumnData();  
  
  boolean rtn = true ;
  String errMsg="0";     
  
  obj.setSerno(serno);
  obj.setPostname(logincn);
  obj.setFieldflag(fieldflag);
  
  //執行動作(修改資料)  
  rtn = obj.storefield();  
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

%>


<form name="mform" action="activities103.jsp" method="post">
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  

