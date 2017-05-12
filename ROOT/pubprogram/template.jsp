<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：template.jsp
說明：選單目錄管理(網頁內容版型)
開發者：chmei
開發日期：96.02.12
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%
  String mlink = ( String )request.getParameter( "mlink" );
%>

<script>
   function choice()
   {
      for ( i=0; i<12; i++ ) {
         if ( document.tform.template[i].checked ) {
            var mvalue = "<%=mlink%>/content/pagelayout_"+(i+1)+".jsp";
         }
      }
      window.location.href = "templatecopy.jsp?fpath="+mvalue;
      w = 300;
      h = 180;
      window.resizeTo(300,200);
      window.moveTo(370,170);
   }
</script>

<body>

<div id="title">
  <h2><img src="../img/addedit.png" width="48" height="48" align="middle"/>網頁內容版型</h2>
</div>
<br>

<center>
<a class="md" href="javascript:choice()">確　定</a>
<form name="tform">
<table width="50%" border="0" cellpadding="0" cellspacing="0" class="table01" align="center">
  <tr>
    <th colspan="2"><a href="#">網頁內容版型</a></th>
  </tr>
  <tr class="tr01" align="left">
    <td class="T12b"><input name="template" type="radio" value="1"/>1.文章型<!-- pagelayout_1.jsp--></td>
    <td class="T12b"><input name="template" type="radio" value="2"/>2.文章型<!-- pagelayout_2.jsp--></td>
  </tr>
  <tr >
    <td class="T12b"><span class="T12red"><img src="../img/pageLayout01_text.jpg" alt="文字型" width="180" height="240"/></span></td>
    <td class="T12b"><img src="../img/pageLayout04_ article.jpg" width="180" height="240"/></td>
  </tr>
  <tr class="tr01" align="left">
    <td class="T12b"><input name="template" type="radio" value="3"/>3.目錄文章型<!--pagelayout_3.jsp--></td>
    <td class="T12b"><input name="template" type="radio" value="4"/>4.文章型<!--pagelayout_4.jsp--></td>
  </tr>
  <tr >
    <td class="T12b"><img src="../img/pageLayout04_catalog.jpg" width="180" height="240" /></td>
    <td class="T12b"><img src="../img/pageLayout06_article.jpg" width="180" height="240" /></td>
  </tr>
  <tr  class="tr01" align="left">
    <td class="T12b"><input name="template" type="radio" value="5"/>照片目錄型<!--pagelayout_5.jsp--></td>
    <td class="T12b"><input name="template" type="radio" value="6"/>一文一圖型<!--pagelayout_6.jsp--></td>
  </tr>
  <tr>
    <td class="T12b"><img src="../img/pageLayout03_catalog.jpg" width="180" height="240"/></td>
    <td class="T12b"><img src="../img/pageLayout02_1pic.jpg" width="180" height="240"/></td>
  </tr>
  <tr  class="tr01" align="left">
    <td class="T12b"><input name="template" type="radio" value="7"/>照片目錄型<!--pagelayout_7.jsp--></td>
    <td class="T12b"><input name="template" type="radio" value="8"/>一文多圖型<!--pagelayout_8.jsp--></td>
  </tr>
  <tr>
    <td class="T12b"><img src="../img/pageLayout02_2pic.jpg" width="180" height="240" /></td>
    <td class="T12b"><img src="../img/pageLayout04_ 2article.jpg" width="180" height="240" /></td>
  </tr>
  <tr  class="tr01" align="left">
    <td class="T12b"><input name="template" type="radio" value="9"/>表格目錄型<!--pagelayout_9.jsp--></td>
    <td class="T12b"><input name="template" type="radio" value="10"/>表格照片型<!--pagelayout_10.jsp--></td>
  </tr>
  <tr>
    <td class="T12b"><img src="../img/pageLayout09.jpg" width="180" height="240" /></td>
    <td class="T12b"><img src="../img/pageLayout10.jpg" width="180" height="240" /></td>
  </tr>
  <tr  class="tr01" align="left">
    <td class="T12b"><input name="template" type="radio" value="11"/>照片目錄型<!--pagelayout_11.jsp--></td>
    <td class="T12b"><input name="template" type="radio" value="12"/>多文多圖型<!--pagelayout_12.jsp--></td>
  </tr>
  <tr>
    <td class="T12b"><img src="../img/pageLayout11.jpg" width="180" height="240" /></td>
    <td class="T12b"><img src="../img/pageLayout12.jpg" width="180" height="240" /></td>
  </tr>  
  <tr >
    <th colspan="2" >&nbsp;</th>
  </tr>
</table>

<p>
<a class="md" href="javascript:choice()">確　定</a>
</form>
</center>
</body>
</html>
