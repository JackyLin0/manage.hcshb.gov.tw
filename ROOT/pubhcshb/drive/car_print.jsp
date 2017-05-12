<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 列印派車單
Programming File: car_print.jsp
Copyright © SYSTEX B17E By Peilun 2012-04-24
-->

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  
  String table = ( String )request.getParameter( "t" );
  String serno = ( String )request.getParameter( "serno" );
  
  CarData query = new CarData(); 
  boolean rtn = query.load(table, serno);

%>  

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=Generator content="Microsoft Word 14 (filtered)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:新細明體;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:新細明體;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:標楷體;
	panose-1:3 0 5 9 0 0 0 0 0 0;}
@font-face
	{font-family:"\@標楷體";
	panose-1:3 0 5 9 0 0 0 0 0 0;}
@font-face
	{font-family:"\@新細明體";
	panose-1:2 2 5 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Calibri","sans-serif";}
 /* Page Definitions */
 @page WordSection1
	{size:595.3pt 841.9pt;
	margin:36.0pt 36.0pt 36.0pt 36.0pt;
	layout-grid:18.0pt;}
div.WordSection1
	{page:WordSection1;}
-->
</style>

</head>

<body lang=ZH-TW style='text-justify-trim:punctuation'>

<div class=WordSection1 style='layout-grid:18.0pt'>

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:16.0pt;font-family:標楷體'>新竹縣政府衛生局派車<span lang=EN-US>(</span>借車<span
lang=EN-US>)</span>單<span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></b><span style='font-family:"新細明體","serif"'>申請日期</span><span
lang=EN-US>:</span></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none'>
 <tr style='height:69.85pt'>
  <td width=701 colspan=4 style='width:526.1pt;border:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:69.85pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-size:14.0pt;font-family:"新細明體","serif"'>申請人</span><span
  lang=EN-US style='font-size:14.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=query.getName() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-size:14.0pt;font-family:"新細明體","serif"'>申</span><span
  style='font-size:14.0pt'> </span><span style='font-size:14.0pt;font-family:
  "新細明體","serif"'>請</span><span style='font-size:14.0pt'> </span><span
  style='font-size:14.0pt;font-family:"新細明體","serif"'>單</span><span
  style='font-size:14.0pt'> </span><span style='font-size:14.0pt;font-family:
  "新細明體","serif"'>位</span><span style='font-size:14.0pt'> </span><span
  style='font-size:14.0pt;font-family:"新細明體","serif"'>主</span><span
  style='font-size:14.0pt'> </span><span style='font-size:14.0pt;font-family:
  "新細明體","serif"'>管</span></p>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US style='font-size:14.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>簽章</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>簽章</span></p>
  </td>
 </tr>
 <tr style='height:56.1pt'>
  <td width=158 style='width:118.8pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:56.1pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>使</span><span lang=EN-US>&nbsp; &nbsp;</span><span
  style='font-family:"新細明體","serif"'>用</span><span lang=EN-US>&nbsp;&nbsp; </span><span
  style='font-family:"新細明體","serif"'>時</span><span lang=EN-US>&nbsp;&nbsp; </span><span
  style='font-family:"新細明體","serif"'>間</span></p>
  </td>
  <td width=543 colspan=3 style='width:407.3pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:56.1pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;&nbsp;<%=query.getUsesdate().substring(0,4) %>&nbsp;&nbsp; </span><span
  style='font-family:"新細明體","serif"'>年</span><span lang=EN-US>&nbsp;&nbsp;<%=query.getUsesdate().substring(4,6) %>&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>月</span><span lang=EN-US>&nbsp;&nbsp;<%=query.getUsesdate().substring(6,8) %>&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>日</span><span lang=EN-US>&nbsp;
  </span><span style='font-family:"新細明體","serif"'></span><span lang=EN-US>&nbsp;&nbsp;<%=query.getUsestime().substring(0,2) %>&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>時</span><span lang=EN-US>&nbsp;&nbsp;<%=query.getUsestime().substring(2,4) %>&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>分</span></p>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>至</span></p>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;&nbsp;<%=query.getUseedate().substring(0,4) %>&nbsp;&nbsp; </span><span
  style='font-family:"新細明體","serif"'>年</span><span lang=EN-US>&nbsp;&nbsp;<%=query.getUseedate().substring(4,6) %>&nbsp;&nbsp;</span><span
  style='font-family:"新細明體","serif"'>月</span><span lang=EN-US>&nbsp;&nbsp;<%=query.getUseedate().substring(6,8) %>&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>日</span><span lang=EN-US>&nbsp;
  </span><span style='font-family:"新細明體","serif"'></span><span lang=EN-US>&nbsp;&nbsp;<%=query.getUseetime().substring(0,2) %>&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>時</span><span lang=EN-US>&nbsp;&nbsp;<%=query.getUseetime().substring(2,4) %>&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>分</span></p>
  </td>
 </tr>
 <tr style='height:35.65pt'>
  <td width=158 style='width:118.8pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:35.65pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>事</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>由</span></p>
  </td>
  <td width=543 colspan=3 valign=top style='width:407.3pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.65pt'>
  <p class=MsoNormal><span lang=EN-US>&nbsp;</span><%=query.getSubject() %></p>
  </td>
 </tr>
 <tr style='height:16.8pt'>
  <td width=158 rowspan=2 style='width:118.8pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:16.8pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>擬</span><span lang=EN-US>&nbsp;&nbsp; </span><span
  style='font-family:"新細明體","serif"'>住</span><span lang=EN-US>&nbsp;&nbsp; </span><span
  style='font-family:"新細明體","serif"'>地</span><span lang=EN-US>&nbsp;&nbsp; </span><span
  style='font-family:"新細明體","serif"'>點</span></p>
  </td>
  <td width=543 colspan=3 valign=top style='width:407.3pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:16.8pt'>
  <p class=MsoNormal><span style='font-family:"新細明體","serif"'>起</span><span
  lang=EN-US>:</span>&nbsp;<%=query.getLocationstart() %></p>
  </td>
 </tr>
 <tr style='height:20.45pt'>
  <td width=543 colspan=3 valign=top style='width:407.3pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:20.45pt'>
  <p class=MsoNormal><span style='font-family:"新細明體","serif"'>迄</span><span
  lang=EN-US>:</span>&nbsp;<%=query.getLocationend() %></p>
  </td>
 </tr>
 <tr style='height:37.45pt'>
  <td width=701 colspan=4 style='width:526.1pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0cm 5.4pt 0cm 5.4pt;height:37.45pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>車輛調度</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>行政室主任</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>秘書</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>局長</span></p>
  </td>
 </tr>
 <tr style='height:42.25pt'>
  <td width=158 style='width:118.8pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:42.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>指</span><span lang=EN-US>&nbsp; </span><span
  style='font-family:"新細明體","serif"'>派</span><span lang=EN-US>&nbsp; </span><span
  style='font-family:"新細明體","serif"'>駕</span><span lang=EN-US>&nbsp; </span><span
  style='font-family:"新細明體","serif"'>駛</span><span lang=EN-US>&nbsp; </span><span
  style='font-family:"新細明體","serif"'>人</span></p>
  </td>
  <td width=189 style='width:5.0cm;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:42.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span><% if ( query.getDriver() == null ) out.print(""); else out.print(query.getDriver()); %></p>
  </td>
  <td width=151 style='width:4.0cm;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:42.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>備</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>註</span></p>
  </td>
  <td width=203 style='width:152.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:42.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span><%=query.getNote() %></p>
  </td>
 </tr>
 <tr style='height:49.25pt'>
  <td width=158 style='width:118.8pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:49.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>借</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>車</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>人</span></p>
  </td>
  <td width=189 style='width:5.0cm;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:49.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span><%=query.getName() %></p>
  </td>
  <td width=151 style='width:4.0cm;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:49.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>車</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>號</span></p>
  </td>
  <td width=203 style='width:152.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:49.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span><%=query.getLicenseplate() %></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:16.0pt;font-family:標楷體'>行車紀錄表</span></b></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
 style='border-collapse:collapse;border:none'>
 <tr style='height:43.65pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:43.65pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>車牌號碼</span></p>
  </td>
  <td width=104 style='width:77.95pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:43.65pt'>
  <p class=MsoNormal><span lang=EN-US>&nbsp;&nbsp;&nbsp; </span><span
  style='font-family:"新細明體","serif"'>－</span></p>
  </td>
  <td width=95 style='width:70.9pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:43.65pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>駕</span> <span style='font-family:"新細明體","serif"'>駛</span>
  <span style='font-family:"新細明體","serif"'>人</span><span lang=EN-US> </span></p>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>姓</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>名</span></p>
  </td>
  <td width=132 style='width:99.2pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:43.65pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=278 colspan=2 style='width:208.85pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0cm 5.4pt 0cm 5.4pt;height:43.65pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>行</span> <span style='font-family:"新細明體","serif"'>車</span>
  <span style='font-family:"新細明體","serif"'>紀</span> <span style='font-family:
  "新細明體","serif"'>錄</span> <span style='font-family:"新細明體","serif"'>由</span> <span
  style='font-family:"新細明體","serif"'>乘</span> <span style='font-family:"新細明體","serif"'>車</span>
  <span style='font-family:"新細明體","serif"'>人</span> <span style='font-family:
  "新細明體","serif"'>簽</span> <span style='font-family:"新細明體","serif"'>證</span> <span
  style='font-family:"新細明體","serif"'>明</span></p>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>乘車人</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span
  style='font-family:"新細明體","serif"'>簽章</span></p>
  </td>
 </tr>
 <tr style='height:35.05pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:35.05pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>開出時間</span></p>
  </td>
  <td width=104 style='width:77.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.05pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>到達時間</span></p>
  </td>
  <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:35.05pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>行經地點</span></p>
  </td>
  <td width=274 colspan=2 style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.05pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>路</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>碼</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>表</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>紀</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>錄</span></p>
  </td>
  <td width=137 style='width:102.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.05pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>行</span><span lang=EN-US>&nbsp; </span><span
  style='font-family:"新細明體","serif"'>駛</span><span lang=EN-US>&nbsp; </span><span
  style='font-family:"新細明體","serif"'>公</span><span lang=EN-US>&nbsp; </span><span
  style='font-family:"新細明體","serif"'>里</span></p>
  </td>
 </tr>
 <tr style='height:35.55pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:35.55pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=104 style='width:77.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.55pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:35.55pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>起</span><span lang=EN-US>:</span></p>
  </td>
  <td width=274 colspan=2 style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.55pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>自</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>至</span></p>
  </td>
  <td width=137 style='width:102.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.55pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-family:"新細明體","serif"'>公里</span></p>
  </td>
 </tr>
 <tr style='height:34.7pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:34.7pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=104 style='width:77.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.7pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:34.7pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>迄</span><span lang=EN-US>:</span></p>
  </td>
  <td width=274 colspan=2 style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.7pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>自</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>至</span></p>
  </td>
  <td width=137 style='width:102.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.7pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-family:"新細明體","serif"'>公里</span></p>
  </td>
 </tr>
 <tr style='height:35.2pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:35.2pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=104 style='width:77.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.2pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:35.2pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>起</span><span lang=EN-US>:</span></p>
  </td>
  <td width=274 colspan=2 style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.2pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>自</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>至</span></p>
  </td>
  <td width=137 style='width:102.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.2pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-family:"新細明體","serif"'>公里</span></p>
  </td>
 </tr>
 <tr style='height:34.25pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:34.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=104 style='width:77.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:34.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>迄</span><span lang=EN-US>:</span></p>
  </td>
  <td width=274 colspan=2 style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.25pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>自</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>至</span></p>
  </td>
  <td width=137 style='width:102.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.25pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-family:"新細明體","serif"'>公里</span></p>
  </td>
 </tr>
 <tr style='height:34.75pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:34.75pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=104 style='width:77.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.75pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:34.75pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>起</span><span lang=EN-US>:</span></p>
  </td>
  <td width=274 colspan=2 style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.75pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>自</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>至</span></p>
  </td>
  <td width=137 style='width:102.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.75pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-family:"新細明體","serif"'>公里</span></p>
  </td>
 </tr>
 <tr style='height:34.6pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:34.6pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=104 style='width:77.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.6pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  lang=EN-US>&nbsp;</span></p>
  </td>
  <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;
  height:34.6pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>迄</span><span lang=EN-US>:</span></p>
  </td>
  <td width=274 colspan=2 style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.6pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>自</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>至</span></p>
  </td>
  <td width=137 style='width:102.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:34.6pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-family:"新細明體","serif"'>公里</span></p>
  </td>
 </tr>
 <tr style='height:35.55pt'>
  <td width=92 style='width:69.2pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0cm 5.4pt 0cm 5.4pt;height:35.55pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>消耗汽油</span></p>
  </td>
  <td width=198 colspan=2 style='width:148.85pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.55pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-family:"新細明體","serif"'>公升</span></p>
  </td>
  <td width=274 colspan=2 style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.55pt'>
  <p class=MsoNormal style='text-align:justify;text-justify:inter-ideograph'><span
  style='font-family:"新細明體","serif"'>行</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>駛</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>公</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>里</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>總</span><span lang=EN-US>&nbsp;&nbsp;&nbsp;
  </span><span style='font-family:"新細明體","serif"'>計</span></p>
  </td>
  <td width=137 style='width:102.5pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:35.55pt'>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-family:"新細明體","serif"'>公里</span></p>
  </td>
 </tr>
 <tr height=0>
  <td width=92 style='border:none'></td>
  <td width=104 style='border:none'></td>
  <td width=95 style='border:none'></td>
  <td width=132 style='border:none'></td>
  <td width=142 style='border:none'></td>
  <td width=137 style='border:none'></td>
 </tr>
</table>

<p class=MsoNormal><span lang=EN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
style='font-family:"新細明體","serif"'>管理人</span><span lang=EN-US>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span><span style='font-family:"新細明體","serif"'>駕駛人</span><span lang=EN-US>:</span></p>

</div>

</body>

</html>



