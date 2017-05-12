<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 派車系統管理 - 新增
Programming File: car101_add.jsp
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
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String mlanguage = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );
  String mdate = ( String )request.getParameter( "mdate" );

  //自session取得登入者的資料
  String logincn = ( String )session.getAttribute( "logincn" );
  String uname = ( String )session.getAttribute( "uname" );
  if ( uname.length() >3 ) {
	  uname = uname.substring(9);
  }
  
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  //找尋車輛
  VehicleData vquery = new VehicleData();    
  ArrayList vqlists = vquery.findByData( "VehicleData", "" );  
  int rcount = vquery.getAllrecordCount();


%>  

<script>
  function back()
  {
     document.mform.action="car101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
</script>
<style type="text/css">
<!--
label.error { color: red; font-size: 0.8em;}
input:focus { border: 1px dotted black; }
input.error { border: 1px dotted red; }
-->
</style>
<script type="text/javascript" src="../../js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../../js/jquery.validate.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#mform").validate({
		rules: {
			punit: {
				required: true
			},
			subject: {
				required: true,
				maxlength: 255
			},
			locationstart: {
				required: true,
				maxlength: 500
			},
			locationend: {
				required: true,
				maxlength: 500
			},
			licenseplate: {
				maxlength: 10
			},
			ride: {
				maxlength: 2,
				number: true
			}
		},
		messages: {
			punit: {
				required: "請選擇發佈單位"
			},
			subject: {
				required: "請輸入事由",
				maxlength: "事由欄位長度，不可超過255字"
			},
			locationstart: {
				required: "請輸入起始地點",
				maxlength: "起始地點欄位長度，不可超過500字"
			},
			locationend: {
				required: "請輸入到達地點",
				maxlength: "到達地點欄位長度，不可超過500字"
			},
			licenseplate: {
				maxlength: "車號欄位長度，不可超過10字"
			},
			ride: {
				maxlength: "乘坐人數欄位長度，不可超過2字",
				number: "請輸入數字"
			}
		},
		errorPlacement: function(error, element) {
		       error.appendTo( element.parent());
		}
	});
});
</script>

<body>
<form id="mform" name="mform" method="post" action="car101_addsave.jsp">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="name" value="<%=logincn %>"/>
  <input type="hidden" name="department" value="<%=uname %>"/>
  <input type="hidden" name="language" value="<%=mlanguage %>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p>
 <input type="submit" class="button_add" value="<%=lang.getSave() %>"/>
 <input type="button" class="button_cancel" value="<%=lang.getCancel()%>" onclick="javascript:window.document.mform.reset()"/>
 <input type="button" class="button_default" value="<%=lang.getBack() %>" onclick="javascript:back()"/>
</p>	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">

  <tr>
    <td class="T12b">單位</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
      </jsp:include>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">申請人</td>
    <td colspan="3"><%=logincn %></td>
  </tr>
  <tr>
    <td class="T12b">部門</td>
    <td colspan="3"><%=uname %>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>事由</td>
    <td colspan="3">
      <input id="subject" name="subject" type="text" class="lInput01" size="85" />
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>使用時間</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="usesdate"/>
          <jsp:param name="colname" value="usesdate"/>
          <jsp:param name="colnameview" value="usesdateview"/>
          <jsp:param name="datevalue" value="<%=mdate%>" />
      </jsp:include>&nbsp;
      <jsp:include page="../../pubprogram/choicetime.jsp">
          <jsp:param name="hcolname" value="carshour"/>
          <jsp:param name="mcolname" value="carsminute"/>
          <jsp:param name="timevalue" value=""/>
      </jsp:include>
      (起)
      <br/>
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="useedate"/>
          <jsp:param name="colname" value="useedate"/>
          <jsp:param name="colnameview" value="useedateview"/>
          <jsp:param name="datevalue" value="<%=mdate%>" />
      </jsp:include>&nbsp;
      <jsp:include page="../../pubprogram/choicetime.jsp">
          <jsp:param name="hcolname" value="carehour"/>
          <jsp:param name="mcolname" value="careminute"/>
          <jsp:param name="timevalue" value=""/>
      </jsp:include>
      (迄)
    </td>
  </tr> 
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>地點</td>
    <td colspan="3">
      <input id="locationstart" name="locationstart" type="text" class="lInput01" size="85" />&nbsp;(起)<br/>
      <input id="locationend" name="locationend" type="text" class="lInput01" size="85" />&nbsp;(迄)
    </td>
  </tr>
  <tr>
    <td class="T12b">車輛狀態</td>
    <td colspan="3">
      <input type="radio" id="car" name="car" value="派車" checked/>派車&nbsp;
      <input type="radio" id="car" name="car" value="借車" />借車
    </td>
  </tr> 
  <tr class="tr">
    <td class="T12b">車號</td>
    <td colspan="3">
      <select id="licenseplate" name="licenseplate">
        <option value="">--請選擇--</option>
        <%
          if ( vqlists.size() > 0 && vqlists != null ) {
              for ( int v=0; v<vqlists.size(); v++ ) { 
              	VehicleData vqlist = ( VehicleData )vqlists.get( v ); %>
            	  <option value="<%=vqlist.getLicenseplate() %>"><%=vqlist.getLicenseplate() %></option>            	  
        <%
        	  }
          } %>
      </select>
    </td>
  </tr>
  <tr>
    <td class="T12b">乘坐人數</td>
    <td colspan="3">
      <input id="rdie" name="ride" type="text" class="lInput01" size="5" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">加班狀態</td>
    <td colspan="3">
      <input type="radio" id="work" name="work" value="否" checked/>否&nbsp;
      <input type="radio" id="work" name="work" value="是" />是
    </td>
  </tr>
  <tr>
    <td valign="top" class="T12b">備註</td>
    <td colspan="3">
      <textarea id="note" name="note" cols="65" rows="6"></textarea>
    </td>
  </tr>

  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<p>
<input type="button" class="button_default" value="回頁首" onclick="location.href='#top'"/>
</p>

</form>
</body>
</html>


