<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperdata.jsp
說明：抓取未被電子報引用資料
開發者：chmei
開發日期：97.03.18
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.util.*"%> 
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
  function save(rcount,num) {
    var content = "";
    var mthisform = "";
    var datavalue = "";
    
    for ( i=0; i<rcount; i++ ) {
       thisform = "document.epaperform.check"+i;       
       if ( eval(thisform).checked ) {
          datavalue = "Y";
          mcontent = eval(thisform).value;
          if ( content == "" ) {
             content = mcontent;
          }else{
             content = content + "&" + mcontent;
          }
       }       
    }
    
    if ( datavalue == '' ) {
       alert("您未勾選任何資料，請勾選！");
       document.epaperform.check0.focus();
       return;
    }
    var contentStr = content;
    while (contentStr.indexOf("&") != -1) {
       contentStr = contentStr.replace("&","\n");
    }
    
    while (contentStr.indexOf("||") != -1) {
       contentStr = contentStr.replace("||","　");
    }
    
    thisform = "document.mform.textarea" + num;
    window.opener.eval(thisform).value = contentStr;
    window.close();
  }
</script>

<%
  String mserno = ( String )request.getParameter( "mserno" );
  String num = ( String )request.getParameter( "num" );
  String eserno = ( String )request.getParameter( "eserno" );
  
  String[] ary_eserno = null;
  if ( eserno != null && !eserno.equals("null") )
	  ary_eserno = SvString.split(eserno,"||");
  String serno = ( String )request.getParameter( "serno" );
   
  //尋找類別名稱
  EpaperEditData query1 = new EpaperEditData();
  boolean mrtn = query1.loadclass(mserno);
  String mclassname = "";
  if ( mrtn )
	  mclassname = query1.getMclassname();
  
  ArrayList qlists = null;
  int rcount = 0;
  
  if ( eserno != null && !eserno.equals("null") ) {
	  EpaperEditData query = new EpaperEditData();
	  qlists = query.findBydetail1(mserno,eserno);	  
	  rcount = query.getAllrecordCount();
  }else{
	  EpaperEditData query = new EpaperEditData();
	  qlists = query.findByday(mserno);
	  rcount = query.getAllrecordCount();
  }
  
  
%>

<div id="title">
  <h2><img src="../img/addedit.png" width="48" height="48" align="middle"/><%=mclassname%>資料</h2>
</div>
<br>

<body>
<a class="md" href="javascript:save('<%=rcount%>','<%=num%>')">確定</a>

<form name="epaperform">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th align="left">標題</th>
  </tr>
  <%
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) {
    		EpaperEditData qlist = ( EpaperEditData )qlists.get( i );
    		String datavalue = qlist.getSerno() + "||" + qlist.getSubject();
    		String isSelected = "";
    		if ( eserno != null && !eserno.equals("null") ) {
    			if ( SvString.contain(ary_eserno,qlist.getSerno()) )
    				isSelected = "checked";
    		}  %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td align="center"><%=i+1%></td>
    		  <td align="center"><input type="checkbox" name="check<%=i%>" value="<%=datavalue%>" <%=isSelected%>></td>
    		  <td align="left"><%=qlist.getSubject()%></td>
    		</tr>
    	<%}
    }else{%>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
		  <td colspan="3" align="center">目前查無資料</td>
		</tr>
    <%}%>
</table>

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>

