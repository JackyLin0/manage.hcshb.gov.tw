<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 派車系統管理 - 修改
Programming File: car102_mdy.jsp
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
  String serno = ( String )request.getParameter( "serno" );
  String mdate = ( String )request.getParameter( "mdate" );
  //自session取得登入者的資料
  String logincn = ( String )session.getAttribute( "logincn" );
  
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  DriveData qdrive = new DriveData();
  ArrayList qlists = qdrive.findByDriverStateNone( "DriverState", mdate );
  
  DriveData qdrives = new DriveData();    
  ArrayList qlistdrive = qdrives.findByDriver( "Driver", "" );  
  
  CarData query = new CarData(); 
  boolean rtn = query.load(table, serno);
  
  //找尋車輛
  VehicleData vquery = new VehicleData();    
  ArrayList vqlists = vquery.findByData( "VehicleData", "" );  
  int rcount = vquery.getAllrecordCount();

%>  

<script>
  function back()
  {
     document.mform.action="car102.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function del() {
	     x=window.confirm("確定刪除此筆資料嗎?")
	     if(x) {
	        document.mform.action="car102_del.jsp?type=1";
	        document.mform.method="post";
	        document.mform.submit();
	     } 
  }
  
  function print()
  {
	  document.mform.target = "_blank";
	  document.mform.action = "car_print.jsp";
	  document.mform.method = "post";
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
<form id="mform" name="mform" method="post" action="car102_mdysave.jsp">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=mlanguage %>"/>
  <input type="hidden" name="serno" value="<%=serno %>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p>
 <input type="submit" class="button_add" value="<%=lang.getMdy() %>"/>
 <input type="button" class="button_cancel" value="<%=lang.getCancel()%>" onclick="javascript:window.document.mform.reset()"/>
 <input type="button" class="button_del" value="<%=lang.getDel()%>" onclick="javascript:del()"/>
 <% 
   if ( query.getState().equals("1") ) { %>
  	 <input type="button" class="button_default" value="列印派車單" onclick="javascript:print()"/>
 <%
   } %>
 <input type="button" class="button_default" value="<%=lang.getBack() %>" onclick="javascript:back()"/>
</p>	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr>
    <td class="T12b">單位</td>
    <td colspan="3"><%=query.getPubunitname()%>
    <input type="hidden" name="punit" value="<%=query.getPubunitdn()%>"/>
    <input type="hidden" name="pubunitname" value="<%=query.getPubunitname()%>"/> 
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">申請人</td>
    <td colspan="3"><%=query.getName() %></td>
  </tr>
  <tr>
    <td class="T12b">部門</td>
    <td colspan="3"><%=query.getDepartment() %>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>事由</td>
    <td colspan="3"><%=query.getSubject() %>
      <input type="hidden" name="subject" value="<%=query.getSubject() %>"/>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>使用時間</td>
    <td colspan="3">
      <%=query.getUsesdate().substring(0,4) %>-<%=query.getUsesdate().substring(4,6) %>-<%=query.getUsesdate().substring(6,8) %>&nbsp;
      <%=query.getUsestime().substring(0,2) %>時&nbsp;<%=query.getUsestime().substring(2,4) %>分&nbsp;&nbsp;(起)
      <br/>
	  <%=query.getUseedate().substring(0,4) %>-<%=query.getUseedate().substring(4,6) %>-<%=query.getUseedate().substring(6,8) %>&nbsp;
      <%=query.getUseetime().substring(0,2) %>時&nbsp;<%=query.getUseetime().substring(2,4) %>分&nbsp;&nbsp;(迄)
    </td>
  </tr> 
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>地點</td>
    <td colspan="3"><%=query.getLocationstart() %>&nbsp;(起)<br/><%=query.getLocationend() %>&nbsp;(迄)</td>
  </tr>
  <tr>
    <td class="T12b">車輛狀態</td>
    <td colspan="3"><%=query.getCar() %></td>
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
            	  <option value="<%=vqlist.getLicenseplate() %>" <% if (query.getLicenseplate().equals(vqlist.getLicenseplate())) out.print("selected"); %>><%=vqlist.getLicenseplate() %></option>            	  
        <%
        	  }
          } %>
      </select>
    </td>
  </tr>
  <tr>
    <td class="T12b">乘坐人數</td>
    <td colspan="3"><%=query.getRide() %></td>
  </tr>
  <tr class="tr">
    <td class="T12b">加班狀態</td>
    <td colspan="3"><%=query.getWork() %></td>
  </tr>
  <tr>
    <td valign="top" class="T12b">備註</td>
    <td colspan="3"><%=query.getNote() %></td>
  </tr>
  <tr class="tr">
    <td valign="top" class="T12b">指派駕駛人員</td>
    <td colspan="3">
      <select name="driver">
        <option value="">--請選擇--</option>
      <%
        if (qlists != null && qlists.size() > 0) {
        	for (int i=0; i<qlists.size(); i++) { 
        	   DriveData qlist = ( DriveData )qlists.get( i ); 
        	     if (!qlist.getState().equals("1")) { %>
        	    	 <option value="<%=qlist.getName() %>" <% if ( query.getDriver().equals(qlist.getName()) ) out.print("selected");%>><%=qlist.getName() %></option>
        	   <% 
        	     } %>
        		
      <%  	}
        } else {
        	for (int j=0; j<qlistdrive.size(); j++) {
        		DriveData qlistall = ( DriveData)qlistdrive.get( j ); %>
        		 <option value="<%=qlistall.getName() %>"><%=qlistall.getName() %></option>
      <%  	}
        }
      %>
      </select>
    </td>
  </tr>
  <tr>
    <td valign="top" class="T12b">派車狀態</td>
    <td colspan="3">
      <select name="state">
        <option value="0" <% if (query.getState().equals("0")) out.print("selected"); %>>--請選擇--</option>
        <option value="1" <% if (query.getState().equals("1")) out.print("selected"); %>>已分派</option>
        <option value="2" <% if (query.getState().equals("2")) out.print("selected"); %>>無司機</option>
        <option value="3" <% if (query.getState().equals("3")) out.print("selected"); %>>無車可派</option>
        <option value="4" <% if (query.getState().equals("4")) out.print("selected"); %>>無車可借</option>
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

<p>
<input type="button" class="button_default" value="回頁首" onclick="location.href='#top'"/>
</p>

</form>
</body>
</html>
