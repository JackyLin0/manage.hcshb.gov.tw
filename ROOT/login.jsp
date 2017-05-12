<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：login.jsp
說明：與GIP驗證
開發者：chmei
開發日期：96.04.01
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String SID = ( String )request.getParameter( "SID" );
  String UID = ( String )request.getParameter( "uid" );
  session.setAttribute("SID",SID);
  session.setAttribute("UID",UID);
  
  String gipurl = "http://gip.hchg.gov.tw/EIP/extauth.php?SID=" + SID + "&uid=" + UID;
  //String gipurl = "http://gip.hchg.gov.tw/EIP/extauth.php?SID=fedade0ae4fde96e2a9f8bd3a1eb1c29&uid=9665162";

  GIPData qdata = new GIPData();
  boolean rtn = qdata.GIP(gipurl);
  System.out.println("rtn="+rtn);
  String loginap = "";
  String passwd = "";
  String dataok = "";
  if ( rtn ){
	  String[] gipdata = SvString.split(qdata.getResponse(),"&");
	  loginap = SvString.right(gipdata[1],"=");
	  passwd = SvString.right(gipdata[1],"=");
	  dataok = "Y";
  }else{%>
      <script>
        window.location.href="http://gip.shinchu.gov.tw";
      </script>
  <%}%>
  
 
<form name="mform" action="login1.jsp" method="post">
   <input type="hidden" name="loginap" value="<%=loginap%>"/>
   <input type="hidden" name="passwd" value="<%=loginap%>"/>
</form>

<%
  if ( dataok.equals("Y") ) { %>
	  <script>
	     document.mform.submit();
	  </script>	 
  <%}%>  
 