<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：menu.jsp
說明：選單目錄管理
開發者：chmei
開發日期：97.02.18
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<body>
<form name="menuform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<%
  String tablename = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  String websitedn = (String)request.getParameter("websitedn"); //metatTag
  String table2 = (String)request.getParameter("t2"); //metatTag
  
  //取Menu圖片上傳路徑，位於各局室img folder 之下
  String webdn1 = ( String )session.getAttribute("webdn");
  String[] ary_webdn1 = SvString.split(webdn1,",");
  String webfolder = SvString.right(ary_webdn1[2],"=");
  
  String imgpath = "/" + webfolder + "/img";

  //取設定檔路徑
  String sysRoot = (String) getServletConfig().getServletContext().getRealPath(""); 
  MenuItemTree t = MenuItemTree.getInstance(sysRoot);

%>

<script>
   function add()
   {
      document.menuform.action="menu_add.jsp";
      document.menuform.method="post";
      document.menuform.submit();
   }

   function mdy(serno)
   {
      document.menuform.serno.value=serno;
      document.menuform.source.value="menu";
      document.menuform.action="menu_mdy.jsp";
      document.menuform.method="post";
      document.menuform.submit();
   } 

   /*參數說明
     serno：序號
     path：程式所在路徑(EX：/pubhsinchu/downfile)
     language：語系
   */
   function img(serno)
   {
      window.open('pic_mdy.jsp?serno='+serno+'&t=<%=tablename%>&path=<%=imgpath%>&language=<%=language%>','down','width=900,height=450,scrollbars=yes,left=90,top=90');
   }  
</script>


<input type="hidden" name="t" value="<%=tablename%>"/>
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="websitedn" value="<%=websitedn%>"/> <!-- metatTag -->
<input type="hidden" name="t2" value="<%=table2%>"/> <!-- metaTag -->
<input type="hidden" name="serno"/>
<input type="hidden" name="source"/>


<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<p></p>

<a class="md" href="javascript:add()">新增</a>
   	  	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th>&nbsp;</th>
  </tr>
  <tr>
    <td class="T11b">
      <table width="8%" border="0" cellspacing="0" cellpadding="0" align="left">
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="70%" border="0" cellspacing="0" cellpadding="0" align="left">
        <tr>
          <td>
            <%
              String html = t.getSitemapHash().get(tablename);
              out.println(html);
            %>
          </td>
        </tr>
      </table>
    </td>
  </tr> 
  <tr align="center">
    <th>&nbsp;</th>
  </tr>

</table>

<p></p>
<a class="md" href="#top">回頁首</a>

</form>
</body>

</html>

