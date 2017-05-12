<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities102_del.jsp
說明：線上報名表欄位編輯
開發者：chmei
開發日期：97.12.04
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>

  
<%
  //接收查詢條件
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );  
  String murl = ( String )request.getParameter( "murl" );
  String title = ( String )request.getParameter( "title" );
  String language = ( String )request.getParameter( "language" );

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
  
  ActivityColumnData obj = new ActivityColumnData();
  
  boolean rtnweb = true ;
  String errMsg="0";   
  
  obj.setSerno(delserno);

  //執行動作(修改資料)  
  rtnweb = obj.remove();

  String showAlert = null;  
  if ( rtnweb == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "刪除失敗！" + errMsg;
  }else{
	  showAlert="刪除成功！";
  }

%>

<form name="mform" action="activities102.jsp" method="post">
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
