<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../fonran.jsp" %>
<%
	String message = "" ;
	ResultSet employee ;
	
	if( session.getAttribute("session_login") == "1" )
	{
		f.employee_log_1("登出", "登出") ;
		
		session.setAttribute("session_login","0") ;
	}
	
	if( request.getParameter("uid") != null )
	{
		employee = f.query("SELECT sn , uid , limit_group_sn , full_name FROM employee WHERE uid = '"+f.sql_string(request.getParameter("uid"))+"' AND pwd = '"+f.sql_string(request.getParameter("pwd"))+"'") ;
		
		if( employee.next() )
		{
			session.setAttribute("session_login","1") ;
			session.setAttribute("session_limit_group_sn",employee.getInt("limit_group_sn")) ;
			session.setAttribute("session_update_user",employee.getString("full_name")) ;
			session.setAttribute("session_employee_sn",employee.getInt("sn")) ;
			
			f.employee_log_1("登入", "登入") ;
			
			response.sendRedirect("index.jsp?Time=" + f.urlencode(f.now()));
		}
		else
		{
			message = "登入失敗" ;
		}
	}
	
	String system_title = f.get_parameter("system_title") ;
%>
<html>
<head>
<TITLE>登入 - <%=system_title%></TITLE>
<script type="text/javascript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>

<link href="body2.css" rel="stylesheet" type="text/css">
</head>

<body onLoad="MM_preloadImages('images/index_r2_c42.gif','images/index_r3.jpg','images/index1_012.gif')">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="400" border="0" align="center" cellpadding="2" cellspacing="0">
<form name="form1" method="POST">
  <tr>
    <td align="center">
      <table width="261" border="0" align="center" cellpadding="3" cellspacing="0">
        <tr>
          <td width="29%" align="right" class="td">帳　號：</td>
          <td width="46%">
          
         	<%
				employee = f.query("select uid , full_name from employee order by full_name") ;
			%>
          	<select name="uid" style="width:115px">
           	 	<% while( employee.next() ) { %><option value='<%=employee.getString("uid")%>'><%=employee.getString("full_name")%></option><% } %>
            </select>
          </td>
          <td width="25%" rowspan="2"><a href="javascript:form1.submit();" tabindex="3" onMouseOut="MM_swapImgRestore()" onBlur="MM_swapImgRestore()" onFocus="MM_swapImage('Image11','','images/index1_012.gif',1)"onMouseOver="MM_swapImage('Image11','','images/index1_012.gif',1)"><img src="images/index1_011.gif" alt="登入" name="Image11" width="45" height="45" border="0"></a><a href="dindex.html" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','images/index1_11.gif',1)"></a></td>
        </tr>
        <tr>
          <td align="right" class="td">密　碼：</td>
          <td>
          <input name="pwd" type="password" id="pwd" size="15" tabindex="2"/></td>
        </tr>
        <tr>
          <td colspan="3" align="right">&nbsp;</td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="center" class="td">建議使用 IE6.0 以上版本、螢幕解析度 1024*768 使用本系統</td>
  </tr>
  <tr>
    <td align="center" class="td">30210 新竹縣竹北市光明七街一號<br> 
    TEL:03-5518160(總機)</td>
  </tr>
  <tr>
    <td align="center" class="td">本系統由<A href="http://www.fonran.com.tw" target="_blank">風然資訊有限公司</A>開發設計</td>
  </tr>
    </form>
</table>
</body>
</html>