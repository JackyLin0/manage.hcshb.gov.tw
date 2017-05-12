<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manual101_send.jsp
說明：手動派送新聞稿
開發者：chmei
開發日期：97.03.22
修改者：
修改日期：
版本：ver1.0
-->
<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 

<%
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");

  String serno = ( String )request.getParameter( "serno" ); 
  String path = request.getParameter( "path" );
  String sendemail = request.getParameter( "emails" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String table2 = ( String )request.getParameter( "t2" );
  
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );
  String qptdate = ( String )request.getParameter( "qptdate" );
  String qdldate = ( String )request.getParameter( "qdldate" );
  String webdn = ( String )request.getParameter( "webdn" );
  
 
 if ( !sendemail.equals("") ) {%>
   <script>
      window.open('../sendbulletin.jsp?sendemail=<%=sendemail%>&serno=<%=serno%>&path=<%=path%>','','width=300,height=200,scrollbars=yes,resizable=yes,left=90,top=90');
      document.mform.submit();
   </script>
  <%}
%>
 <form name="mform" action="mailmenu102.jsp" method="post" >
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="t2" value="<%=table2%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
  <input type="hidden" name="qptdate" value="<%=qptdate%>"/>
  <input type="hidden" name="qdldate" value="<%=qdldate%>"/>
  <input type="hidden" name="webdn" value="<%=webdn%>"/>
</form>

