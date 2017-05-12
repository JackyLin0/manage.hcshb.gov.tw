<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 駕駛人員休假、值班 - 修改
Programming File: drive101_add.jsp
Copyright © SYSTEX B17E By Peilun 2012-04-06
-->

<html>
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
  String language = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );
  String mdate = ( String )request.getParameter( "mdate" );
  
  int pagesize = 15;
  String intpage1 = ( String )request.getParameter( "intpage" );

  if ( intpage1 == null || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);
  
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  DriveData query = new DriveData();    
  ArrayList qlists = query.findByDriver( "Driver", "" );  
  int rcount = query.getAllrecordCount();
  
  //計算總頁數
  int maxpage=0;
  
  //取餘數
  maxpage=rcount%pagesize;               
  if (maxpage==0)
     maxpage=rcount/pagesize;
  else
     maxpage=(rcount/pagesize)+1;
  
  String role = ( String )session.getAttribute("role");

%>  

<script>
  function back() {
     document.mform.action="drive102.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
</script>

<body>
<form id="mform" name="mform" method="post" action="drive102_mdysave.jsp">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="mdate" value="<%=mdate %>"/>
  <input type="hidden" name="language" value="<%=language %>"/>
  
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p>
 <input type="submit" class="button_add" value="修改"/>
 <input type="button" class="button_default" value="回上頁" onclick="javascript:back()" />
</p>	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="3%">&nbsp;</th>
    <th width="20%">駕駛姓名</th>
    <th width="8%">性別</th>
    <th width="16%">聯絡電話</th>
    <th width="16%">行動電話</th>
    <th width="22%">電子信箱</th>
    <th width="15%">狀態</th>
  </tr>
   <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	DriveData qlist = ( DriveData )qlists.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center">
    	    <%=qlist.getName()%>
    	    <input type="hidden" name="serno" value="<%=qlist.getSerno() %>"/>
    	    <input type="hidden" name="name" value="<%=qlist.getName() %>"/>
		    <input type="hidden" name="punit" value="<%=qlist.getPubunitdn()%>"/>
		    <input type="hidden" name="pubunitname" value="<%=qlist.getPubunitname()%>"/>
    	  </td>
    	  <td align="center"><%=(qlist.getSex().equals("M")?"男":"女")%></td>
    	  <td align="center"><%=qlist.getTel()%></td>
    	  <td align="center"><%=qlist.getMobile() %>&nbsp;</td>
    	  <td align="left"><%=qlist.getEmail()%></td>
    	  <td align="center">
    	  <%
    	    DriveData querystate = new DriveData(); 
    	    boolean rtn = querystate.loadDriverState(table, mdate, qlist.getSerno());
    	  %>
    	    <select name="state">
    	    <% 
    	      if (rtn) { %>
    	      	<option value="0" <% if (querystate.getState().equals("0") ) out.print("selected"); %>>上班</option>
    	      	<option value="1" <% if (querystate.getState().equals("1") ) out.print("selected"); %>>休假</option>
    	      	<option value="2" <% if (querystate.getState().equals("2") ) out.print("selected"); %>>值班</option>
    	    <%
    	      } else { %>
	  	      	<option value="0" selected>上班</option>
	  	      	<option value="1">休假</option>
	  	      	<option value="2">值班</option>
    	    <%
    	      } %>
    	    </select>
    	  </td>    	  
    	</tr> 
    <%}%>
    	
    <input type="hidden" name="page"/> 
    <input type="hidden" name="intpage" value="<%=intpage%>"/> 
    <!-- 分頁 -->
    <tr class="tr01">
      <th colspan="11">
        <jsp:include page="../../pubprogram/page.jsp">
            <jsp:param name="startpage" value="<%=startpage%>"/>
            <jsp:param name="pagesize" value="<%=pagesize%>"/>
            <jsp:param name="intpage" value="<%=intpage%>"/>
            <jsp:param name="maxpage" value="<%=maxpage%>"/>
            <jsp:param name="endpage" value="<%=endpage%>"/>
            <jsp:param name="rcount" value="<%=rcount%>"/>
            <jsp:param name="formname" value="mform"/>
        </jsp:include>
      </th>
    </tr>  
  
</table>

<p>
<input type="button" class="button_default" value="回頁首" onclick="location.href='#top'"/>
</p>

<div id="page"><span class="T8-5">頁數:</span> <span class="T8-5c"> <%=intpage%> / <%=maxpage%> </span><span class="T8-5">； 資料每頁以15筆展現；共有</span><span class="T8-5c"> <%=rcount%> </span> <span class="T8-5">筆資料</span></div>


</form>
</body>
</html>
