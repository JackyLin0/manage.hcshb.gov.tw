<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities105.jsp
說明：報名資料維護
開發者：chmei
開發日期：98.10.16
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }

  String role = ( String )session.getAttribute("role");
  if ( role != null && !role.equals("null") && !role.equals("") )
	  pubunitdn = "";

  //尋找已新增報名表
  ActivityExcelData query = new ActivityExcelData();
  ArrayList qlists = query.findByday(pubunitdn);
  int rcount = query.getAllrecordCount();
  
  String msubject = ( String )request.getParameter( "msubject" );
  String[] activityserno = null;
  if ( msubject != null && !msubject.equals("null") && !msubject.equals("") ) {
	  activityserno = SvString.split(msubject,"||");
  }
  
%>  

<script>
  function mdy()
  {
     document.mform.action = "activities105_mdy.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }
</script>

<body>
<form name="mform">
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">&nbsp;</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="20%"><span class="T12red">※</span>活動訊息標題</td>
    <td colspan="3">
      <select name="msubject" onchange="mdy()">
        <option value="">--- 請選擇 ---</option>
        <%
          if ( qlists != null ) {
        	  for ( int i=0; i<rcount; i++ ) {
        		  ActivityExcelData qlist = ( ActivityExcelData )qlists.get( i );
        		  String datavalue = qlist.getSerno() + "||" + qlist.getSubject();
        		  String isSelected = "";
        		  if ( msubject != null && !msubject.equals("null") ) {
        			  if ( qlist.getSerno().equals(activityserno[0]) )
        				  isSelected = "selected";
        		  }%>
        		  <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getSubject()%></option>
        	  <%}
          }%>
      </select> 
    </td>
  </tr>    

  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
  
</table>  

</form>
</body>
</html>

