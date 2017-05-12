<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：leaf_upd.jsp
說明：人員組織設定
開發者：chmei
開發日期：2017.03.08
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人員組織設定</title>

<link href="../../css/text.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
  function save() {
	  if ( document.treeform.cn.value == '' ) {
		  alert( "【姓名】欄位不能空白，請輸入!! " );
		  document.treeform.cn.focus();
		  return;
	  }
	  if ( document.treeform.carlicense.value != '' ) {
		  if ( !id_check(document.treeform.carlicense) ) {
			  document.treeform.carlicense.focus();
	          return;
	      }
	  }
	  if ( document.treeform.email.value != '' ) {
		  var m = document.treeform.email.value;
		  if (m.indexOf("@") =="-1" ||
			  m.indexOf("@@") !="-1" ||
			  m.indexOf("@.") !="-1" ||
			  m.indexOf(".@") !="-1" ||
			  m.indexOf(".") =="-1" ||
			  m.substring(m.length-1,m.length) =="." ||
			  m.substring(m.length-1,m.length) =="@") {
			  alert("【電子信箱】格式錯誤，請重新輸入!!");
			  document.treeform.email.focus();
			  return;
		  }
	  }
	  
	  document.treeform.action = "leaf_updsave.jsp";
	  document.treeform.method = "post";
	  document.treeform.submit();
  }	

  function del() {
	  x = window.confirm("確定刪除該人員資料嗎?");
	  if ( x ) {
		  document.treeform.action = "leaf_del.jsp";
		  document.treeform.method = "post";
		  document.treeform.submit();
	  }	  		  
  }

  //檢核輸入的身分證號
  function id_check(obj) {
	  var pid=obj.value;
	  pid = pid.toUpperCase();
	  
	  if(pid.length!=10) {
		  alert("【身分證號】長度錯誤，請重新輸入！");
		  return false;
	  }
	  
	  var arr = new Array('A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','X','Y','W','Z','I','O');
	  sum= new Number(0);
	  for(var i=0;i<=25;i++){
		  if (pid.substring(0,1)==arr[i]){
			  sum=parseInt(sum+((10+i)%10)*9+(10+i)/10, 10);
		  }
	  }
	  for (var i=2;i<=9;i++){
		  n=new Number(pid.substring(i-1,i));
		  sum=parseInt(sum+n*(10-i),10);
	  }
	  sum=10-parseInt(sum%10);
	  c = new String(sum);
	  sum2=c.substring(c.length-1,c.length);
	  sum3=pid.substring(pid.length-1,pid.length);
	  if ( sum2 != sum3 ){
		  alert("【身分證號】編碼錯誤，請重新輸入！");
		  return false;
	  }
	  return true;	
  }
</script>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String title = ( String )session.getAttribute( "title" );
  String userdn = ( String )request.getParameter( "userdn" );
  String muid = ( String )request.getParameter( "muid" );
  
  UsersTree query = new UsersTree();
  ArrayList<DSItem> qlists = query.getUsers(userdn);
  
%>

<form name="treeform">
<input type="hidden" name="userdn" value="<%=userdn%>" />

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>人員組織設定</h2>
</div>

<br>

<div style="padding-left:12px;height:30px">
  <input type="button" class="btn" value=" 儲存  " onclick="javascript:save()">
  <input type="button" class="btn" value=" 重填 " onclick="javascript:window.document.treeform.reset()">
  <input type="button" class="btn" value=" 刪除 " onclick="javascript:del()">
</div>


<table width="95%" cellpadding="0" cellspacing="0" border="0" class="table01">
  <%
    if ( qlists != null && qlists.size() > 0 ) {
    	for ( int i=0; i<qlists.size(); i++ ) {    		
    		DSItem qlist = ( DSItem )qlists.get( i ); %>
    		<tr align="center">
    		  <th colspan="2"><%=qlist.getCn()%>--基本資料設定</th>
    		</tr>
    		<tr class="tr">
    		  <td width="34%" class="T12b"><span class="T12red">※</span>使用者帳號</td>
    		  <td width="66%">
    		    <input type="text" name="muid" class="lInput01" size="20" maxlength="20" value="<%=qlist.getMuid()%>" readonly />
    		  </td>
    		</tr>
    		<tr>
    		  <td class="T12b"><span class="T12red">※</span>姓　　　名</td>
    		  <td>
    		    <input type="text" name="cn" class="lInput01" size="20" maxlength="10" value="<%=qlist.getCn()%>" />
    		  </td>
    		</tr>
    		<tr class="tr">
    		  <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>身分證字號</td>
    		  <td colspan="3">
    		    <input name="carlicense" type="text" class="lInput01" size="20" maxlength="10" value="<%=qlist.getPid()%>" />
    		  </td>
    		</tr>
    		<tr>
    		  <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>E-mail</td>
    		  <td>
    		    <input type="text" name="email" class="lInput01" size="50" maxlength="60" value="<%=qlist.getEmail()%>" />
    		  </td>
    		</tr>
    	<%}
    }%>
</table>


</form>

</body>
</html>

