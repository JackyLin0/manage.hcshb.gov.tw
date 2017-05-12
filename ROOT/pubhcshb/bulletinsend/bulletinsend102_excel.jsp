<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：bulletinsend102_excel.jsp
說明：縣府新聞統計查詢
開發者：chmei
開發日期：96.11.11
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局全球資訊網網站後端管理</title>
</head>

<%-- <%@ page contentType="application/vnd.ms-excel;charset=utf-8" %> --%>

<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  response.setHeader("Content-disposition","attachment; filename=news.xls");
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());
  String table2 = ( String )request.getParameter( "t2" );
  
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );
  
  if ( intpage1 == null || intpage1.equals("") )
  	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);
  
  //接收查詢條件
  String myear = ( String )request.getParameter( "myear" );
  if ( myear == null || myear.equals("null") ) 
  	  myear = ndate.substring(0,4);
  
  String month = ( String )request.getParameter( "month" );
  if ( month == null || month.equals("null") || month.equals("") )
  	  month = ndate.substring(4,6);
  
  String startmonth = "";
  String endmonth = "";
  if ( month == null || month.equals("null") || month.equals("") ) {
  	  startmonth = ndate.substring(0, 6) +"01";
  	  endmonth =  ndate.substring(0, 6) +"31";
  } else {
  	  startmonth = myear + month +"01";
  	  endmonth =  myear + month +"31";
  }

 
  BulletinSendData query = new BulletinSendData();  
  query.setTablename(table2);
  ArrayList qlists = query.findBymonth(startmonth, endmonth);
  int rcount = query.getAllrecordCount();

%>

<body>
<form name="mform">
  <div id="title">
    <h2><center>新聞稿統計查詢</center></h2>
  </div>
  
  <table width="100%" border="1" cellpadding="0" cellspacing="0">
    <tr align="center">
      <td width="5%">&nbsp;</td>
      <%
        String subject = "年度／月別";
      %>
      <td width="30%"><%=subject%></td>
      <td width="30%">單位名稱</td>
      <td width="30%">新聞稿發佈件數</td>
    </tr>
    <%
      for ( int i=0; i<rcount; i++ )  {
    	  BulletinSendData qlist = (BulletinSendData)qlists.get( i ); %>
    	  <tr>
    	    <td align="center"><%=i+1%></td>
    	     <td align="center"><%=Integer.parseInt(myear.substring(0,4)) - 1911%>年度&nbsp;<%=month%>月份</td>
             <td align="center"><%=qlist.getPubunitname()%></td>   	       
    	     <td align="center"><%=qlist.getPosterCount()%></td> 
    	  </tr> 
      <%}%>
    </table>
</form>
</body>
</html>
 
  