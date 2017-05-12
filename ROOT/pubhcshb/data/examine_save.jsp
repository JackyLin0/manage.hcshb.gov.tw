<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：examine_save.jsp
說明：接收資料審核
開發者：chmei
開發日期：97.03.08
修改者：chmei
修改日期：96.12.19
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>


<%
  //查詢條件
  String qap = ( String )request.getParameter( "qap" );
  String qexamine = ( String )request.getParameter( "qexamine" );

  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String tablename = ( String )request.getParameter( "tablename" );
  String mserno = ( String )request.getParameter( "mserno" );
  String website = ( String )request.getParameter( "website" );
  String poster = ( String )request.getParameter( "poster" );
  String examine = ( String )request.getParameter( "examine" );
  String language = ( String )request.getParameter( "language" );
  String murl = ( String )request.getParameter( "murl" );

  String logincn = ( String )session.getAttribute( "logincn" );

  ExamineData obj = new ExamineData();   
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setWebsiteexam(examine);
  obj.setSerno(mserno);
  obj.setWebsitedn(website);
  obj.setPostname(logincn);

  //執行動作(審核資料)  
  rtn = obj.store(poster);    
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "審核失敗！" + errMsg;
  }else{
	  showAlert="審核成功！";
  }

 %>

<form name="mform" action="examine.jsp" method="post">
  <input type="hidden" name="website" value="<%=website%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="mserno" value="<%=mserno%>"/>
  <input type="hidden" name="tablename" value="<%=tablename%>"/>
  <input type="hidden" name="qap" value="<%=qap%>"/>
  <input type="hidden" name="qexamine" value="<%=qexamine%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>  
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
