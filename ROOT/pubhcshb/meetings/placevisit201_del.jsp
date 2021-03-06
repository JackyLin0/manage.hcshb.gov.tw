<%@page import="tw.com.sysview.dba.meeting.MeetingData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：place101_del.jsp
說明：場地維護(適用單站台)
開發者：yclai
開發日期：103.08.26
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>
<%@page import="tw.com.sysview.dba.meeting.PlaceData"%>

<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String language = ( String )request.getParameter( "language" );
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  String logindn = ( String )request.getParameter( "logindn" );
  String place = ( String )request.getParameter( "place" );
  
  String logincn = ( String )session.getAttribute( "logincn" );
  
  String y1 = (String) request.getParameter("y1");
  String m1 = (String) request.getParameter("m1");

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
    
  MeetingData obj = new MeetingData();  
  
  boolean rtn = true ;
  String errMsg="0";   
  
  obj.setSerno(delserno);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table1);             //table名稱
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

<form name="mform" action="place.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="place" value="<%=place%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="y1" value="<%=y1%>"/>
  <input type="hidden" name="m1" value="<%=m1%>"/>
</form>

 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
 