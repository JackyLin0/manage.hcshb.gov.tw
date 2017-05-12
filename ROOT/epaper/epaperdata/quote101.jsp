<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：quote101.jsp
說明：資料引用主網話說健康
開發者：chmei
開發日期：97.03.01
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
  function back()
  {
     document.mform.action="epaperdata101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function qry()
  {
    document.mform.action = "quote101_qry.jsp";
    document.mform.method="post";
    document.mform.submit();
  }

  function save()
  {
     if ( document.mform.classdata.value == '' )
     {
        alert("【分類名稱】欄位，不可空白，請選擇！");
        document.mform.classdata.focus();
        return;
     }
     document.mform.action = "quote101_save.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  String table = ( String )request.getParameter( "t" );
  
  //尋找電子報類別
  ClassData qmclass = new ClassData();
  ArrayList qclasss = qmclass.findByday("EpaperClass");
  int crcount = qmclass.getAllrecordCount();
  
  //尋找未被引用話說健康資料
  EpaperData query = new EpaperData();
  query.setTablename("TalkHealth");
  ArrayList qlists = query.findByday();
  int rcount = query.getAllrecordCount();
  
%>  

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>引用話說健康資料</h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:qry()">查詢</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料引用</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="15%"><span class="T12red">※</span>分類名稱</td>
    <td colspan="3">
      <%
        if ( qclasss != null ) { %>
        	<select name="classdata">
        	   <option value="">--- 請選擇 ---</option>
        	   <%
        	     for ( int c=0; c<crcount; c++ ) {
        	    	 ClassData qclass = ( ClassData )qclasss.get( c );
        	    	 String datavalue = qclass.getSerno() + "||" + qclass.getClassname(); %>
        	    	 <option value="<%=datavalue%>"><%=qclass.getClassname()%></option>
        	     <%}%>
        	</select>
        <%}%>
    </td>
  </tr> 
  <tr>
    <td class="T12b" width="15%"><span class="T12red">※</span>標題</td>
    <td colspan="3">
      <table border="0" width="100%">
        <%
          if ( qlists != null ) {
        	  for ( int i=0; i<rcount; i++ ) {
        		  EpaperData qlist = ( EpaperData )qlists.get( i ); %>
        		  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
        		    <td width="5%" align="left"><%=i+1%></td>
        		    <td width="5%" align="left"><input type="checkbox" name="check" value=<%=qlist.getSerno()%>></td>
        		    <td align="left"><a href="#" title="<%=qlist.getContent()%>"><%=qlist.getSubject()%></a></td>
        		  </tr>  
        	  <%}
          }%>
      </table>
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
