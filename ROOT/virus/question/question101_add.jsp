<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="java.io.*" %>

<!--
程式名稱：question101_add.jsp
說明：問題反應
開發者：hank
開發日期：98.07.31
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%
  String hcshb = PropertiesBean.getBundle("tw.com.econcord.properties.project", "hcshb", Locale.TAIWAN);

  String logincn = ( String )session.getAttribute("logincn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );

  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());
  
  String logindn = ( String )session.getAttribute("logindn");
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  if ( pubunitdn.equals(hcshb) )
	  pubunitdn = "";
  
  String qpunit = ( String )request.getParameter( "mqpunit" );
  if ( qpunit == null )
	  qpunit = pubunitdn;
%>  

<script>
function back(){
	document.mform.method = "post";
	document.mform.action = "question101.jsp";
	document.mform.submit();
}

function save(){
	if(document.mform.mqpunit.value == ''){
    	alert("【隸屬單位】欄位，不可空白，請選擇！");
        document.mform.mqpunit.focus();
        return; 
    }
    
	if(document.mform.mschName.value == ''){
    	alert("【學校名稱】欄位，不可空白，請選擇！");
        document.mform.mschName.focus();
        return;
    } 
    
	if(document.mform.question.value == ''){
    	alert("【問題內容】欄位，不可空白，請選擇！");
        document.mform.question.focus();
        return;     
	}  
 
    document.mform.action = "question101_addsave.jsp";
    document.mform.method = "post";
    document.mform.submit();
} 

function cha(){
	document.mform.action="question101_add.jsp";
    document.mform.method="post";
    document.mform.submit();
}
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="loginuid" value="<%=logincn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  
<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>問題反應</h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料新增</th>
  </tr>

  <tr>
    <td class="T12b"><span class="T12red">※</span>隸屬單位</td>
    <td colspan="3">
      <jsp:include page="../qunit.jsp">
        <jsp:param name="colname" value="mqpunit"/>
        <jsp:param name="language" value="ch"/>
        <jsp:param name="datavalue" value="<%=qpunit%>"/>
        <jsp:param name="onchange" value="cha"/>
      </jsp:include>
      <span class="T11b">學校名稱</span>
      <jsp:include page="../../pubprogram/qschool.jsp">
        <jsp:param name="colname" value="mschName"/>
        <jsp:param name="datavalue" value="<%=qpunit%>"/>
        <jsp:param name="schName" value="<%=""%>"/>
      </jsp:include>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>問題內容</td>
    <td colspan="3">
      <textarea name="question" cols="76" rows="10"></textarea>
      <br/><span class="T10">(不可超過1000個中文字）</span>
    </td>
  </tr>
  
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">‧問‧題‧解‧答‧</th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>問題解答</td>

    <td colspan="3">
      <textarea name="answer" cols="76" rows="10"></textarea>
      <br/><span class="T10">(不可超過1000個中文字）</span>
    </td>
  </tr>
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

