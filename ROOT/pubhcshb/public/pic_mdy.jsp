<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：pic_mdy.jsp
說明：Menu圖片上傳
開發者：chmei
開發日期：97.02.19
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function save(path)
  {
     if ( document.fileform.fileexp2.value == '' )
     {
        alert("【圖片說明(1)】欄位，不可空白，請輸入！");
        document.fileform.fileexp2.focus();
        return;
     }else if ( document.fileform.fileexp2.value.length > 150 ) {
        alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp2.focus();
        return;
     }      
     if ( document.fileform.filename2.value != '' )
        document.fileform.nsfile2.value = document.fileform.filename2.value;
        
     if ( document.fileform.fileexp3.value == '' )
     {
        alert("【圖片說明(2)】欄位，不可空白，請輸入！");
        document.fileform.fileexp3.focus();
        return;
     }else if ( document.fileform.fileexp3.value.length > 150 ) {
        alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp3.focus();
        return;
     }
     if ( document.fileform.filename3.value != '' )
        document.fileform.nsfile3.value = document.fileform.filename3.value;
        
     if ( window.fileexp4 ) 
     {
        if ( document.fileform.fileexp4.value == '' )
        {
           alert("【圖片說明(3)】欄位，不可空白，請輸入！");
           document.fileform.fileexp4.focus();
           return;
        }else if ( document.fileform.fileexp4.value.length > 150 ) {
           alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
           document.fileform.fileexp4.focus();
           return;
        }      
        if ( document.fileform.filename4.value != '' )
           document.fileform.nsfile4.value = document.fileform.filename4.value;
     }  
     
     if ( window.fileexp5 )
     {
        if ( document.fileform.fileexp5.value == '' )
        {
           alert("【圖片說明(4)】欄位，不可空白，請輸入！");
           document.fileform.fileexp5.focus();
           return;
        }else if ( document.fileform.fileexp5.value.length > 150 ) {
           alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
           document.fileform.fileexp5.focus();
           return;
        }
        if ( document.fileform.filename5.value != '' )
           document.fileform.nsfile5.value = document.fileform.filename5.value;
     }
     
     //因上傳元件，需將換行等tag replace
     if ( document.fileform.fileexp2.value != '' )
     {
        var contentStr = document.fileform.fileexp2.value;
        while (contentStr.indexOf("\n") != -1)
        {
           contentStr = contentStr.replace("\n", "|");
        }
        while (contentStr.indexOf("\r") != -1)
        {
           contentStr = contentStr.replace("\r", "");
        }
        while (contentStr.indexOf("\t") != -1)
        {
           contentStr = contentStr.replace("\t", "");
        }
        document.fileform.mfileexp2.value = contentStr;
        document.fileform.fileexp2.value = "";
     }
        
     //因上傳元件，需將換行等tag replace
     if ( document.fileform.fileexp3.value != '' )
     {
        var contentStr = document.fileform.fileexp3.value;
        while (contentStr.indexOf("\n") != -1)
        {
           contentStr = contentStr.replace("\n", "|");
        }
        while (contentStr.indexOf("\r") != -1)
        {
           contentStr = contentStr.replace("\r", "");
        }
        while (contentStr.indexOf("\t") != -1)
        {
           contentStr = contentStr.replace("\t", "");
        }
        document.fileform.mfileexp3.value = contentStr;
        document.fileform.fileexp3.value = "";
     }
     
     if ( window.fileexp4 )
     {
        //因上傳元件，需將換行等tag replace
        if ( document.fileform.fileexp4.value != '' )
        {
           var contentStr = document.fileform.fileexp4.value;
           while (contentStr.indexOf("\n") != -1)
           {
              contentStr = contentStr.replace("\n", "|");
           } 
           while (contentStr.indexOf("\r") != -1)
           {
              contentStr = contentStr.replace("\r", "");
           }
           while (contentStr.indexOf("\t") != -1)
           {
              contentStr = contentStr.replace("\t", "");
           }
           document.fileform.mfileexp4.value = contentStr;
           document.fileform.fileexp4.value = "";
        }
     }
     
     if ( window.fileexp5 )
     {
        //因上傳元件，需將換行等tag replace
        if ( document.fileform.fileexp5.value != '' )
        {
           var contentStr = document.fileform.fileexp5.value;
           while (contentStr.indexOf("\n") != -1)
           {
              contentStr = contentStr.replace("\n", "|");
           } 
           while (contentStr.indexOf("\r") != -1)
           {
              contentStr = contentStr.replace("\r", "");
           }
           while (contentStr.indexOf("\t") != -1)
           {
              contentStr = contentStr.replace("\t", "");
           }
           document.fileform.mfileexp4.value = contentStr;
           document.fileform.fileexp4.value = "";
        }
     }
     
     document.fileform.action = "pic_mdysave.jsp?path="+path;
     document.fileform.method="post";
     document.fileform.submit();
  }
</script>

</head>

<%@ page import="tw.com.sysview.dba.*" %>

<%
  String serno = ( String )request.getParameter( "serno" );
  String tablename = ( String )request.getParameter( "t" );
  String path = ( String )request.getParameter( "path" );

  MenuData query = new MenuData();  
  boolean rtn = query.load(tablename,serno);

%>  

<body>
<form name="fileform" enctype="multipart/form-data">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="table" value="<%=tablename%>"/>
  <input type="hidden" name="path"/>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/flanguage.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=lang.getPicmanage()%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=path%>')"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:window.document.menuform.reset()"><%=lang.getCancel()%></a>
 <a class="md" href="javascript:window.close()"><%=lang.getClose()%></a>
 
<%
  String oclientfile2 = query.getClientfile2();
  if ( oclientfile2 == null )
	  oclientfile2 = "";
  String oserverfile2 = query.getServerfile2();
  if ( oserverfile2 == null )
	  oserverfile2 = "";
  String oexpfile2 = query.getExpfile2();
  if ( oexpfile2 == null )
	  oexpfile2 = "";
  String oclientfile3 = query.getClientfile3();
  if ( oclientfile3 == null )
	  oclientfile3 = "";
  String oserverfile3 = query.getServerfile3();
  if ( oserverfile3 == null )
	  oserverfile3 = "";
  String oexpfile3 = query.getExpfile3();
  if ( oexpfile3 == null )
	  oexpfile3 = "";
  String oclientfile4 = query.getClientfile4();  
  if ( oclientfile4 == null )
	  oclientfile4 = "";
  String oserverfile4 = query.getServerfile4();
  if ( oserverfile4 == null )
	  oserverfile4 = "";
  String oexpfile4 = query.getExpfile4();
  if ( oexpfile4 == null )
	  oexpfile4 = "";
  String oclientfile5 = query.getClientfile5();
  if ( oclientfile5 == null )
	  oclientfile5 = "";
  String oserverfile5 = query.getServerfile5();
  if ( oserverfile5 == null )
	  oserverfile5 = "";
  String oexpfile5 = query.getExpfile5();
  if ( oexpfile5 == null )
	  oexpfile5 = "";
%>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr>
    <th colspan="4"><div align="center"><%=lang.getPicupload()%></div></th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="15%"><span class="T12red">※</span><%=lang.getUploadpic1()%></td>
    <td class="T12b">
      <input name="filename2" type="file" class="lInput01" size="20" />
      <%
        if ( !oserverfile2.equals("") ) { %>
        	<<br /><<br /><span class="T10">【原圖片檔名】：<br><a href="../../menudowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile2,"UTF-8")%>&flag=menupath"><%=oclientfile2%></a></span>
        <%}%>	
        <input type="hidden" name="osfile2" value="<%=oserverfile2%>"/> 
        <input type="hidden" name="ocfile2" value="<%=oclientfile2%>"/>  	
    </td>
    <input type="hidden" name="nsfile2">
    <td class="T12b"><span class="T12red">※</span><%=lang.getExppic1()%></td>
    <td class="T12b" width="15%">
      <textarea name="fileexp2" cols="48" rows="4" class="lInput01"><%=oexpfile2%></textarea>
      <span class="T8-5">    (至多150字）</span>
      <input type="hidden" name="mfileexp2">
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getUploadpic2()%></td>
    <td class="T12b">
      <input name="filename3" type="file" class="lInput01" size="20" />
      <%
        if ( !oserverfile3.equals("") ) { %>
        	<br><br><span class="T10">【原圖片檔名】：<br><a href="../../menudowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile3,"UTF-8")%>&flag=menupath"><%=oclientfile3%></a></span>
        <%}%>	
        <input type="hidden" name="osfile3" value="<%=oserverfile3%>"/> 
        <input type="hidden" name="ocfile3" value="<%=oclientfile3%>"/>  	
    </td>
    <input type="hidden" name="nsfile3">
    <td class="T12b"><span class="T12red">※</span><%=lang.getExppic2()%></td>
    <td class="T12b">
      <textarea name="fileexp3" cols="45" rows="5" class="lInput01"><%=oexpfile3%></textarea>
      <span class="T8-5">    (至多150字）</span>
      <input type="hidden" name="mfileexp3">
    </td>
  </tr>
  <%
    if ( tablename.equals("NosmokingMenu") ) { %>
    	<tr class="tr">
    	  <td class="T12b" width="15%"><span class="T12red">※</span><%=lang.getUploadpic3()%></td>
    	  <td class="T12b">
    	    <input name="filename4" type="file" class="lInput01" size="20" />
    	    <%
    	      if ( !oserverfile4.equals("") ) { %>
    	    	  <br><br><span class="T10">【原圖片檔名】：<br><a href="../../menudowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile4,"UTF-8")%>&flag=menupath"><%=oclientfile4%></a></span>
    	      <%}%>	
    	      <input type="hidden" name="osfile4" value="<%=oserverfile4%>"/> 
    	      <input type="hidden" name="ocfile4" value="<%=oclientfile4%>"/>  	
    	  </td>
    	  <input type="hidden" name="nsfile4">
    	  <td class="T12b"><span class="T12red">※</span><%=lang.getExppic3()%></td>
    	  <td class="T12b" width="15%">
    	    <textarea name="fileexp4" cols="48" rows="4" class="lInput01"><%=oexpfile4%></textarea>
    	    <span class="T8-5">    (至多150字）</span>
    	    <input type="hidden" name="mfileexp4">
    	  </td>
    	</tr>
    	<tr class="tr">
    	  <td class="T12b"><span class="T12red">※</span><%=lang.getUploadpic4()%></td>
    	  <td class="T12b">
    	    <input name="filename5" type="file" class="lInput01" size="20" />
    	    <%
    	      if ( !oserverfile5.equals("") ) { %>
    	    	  <br><br><span class="T10">【原圖片檔名】：<br><a href="../../menudowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile5,"UTF-8")%>&flag=menupath"><%=oclientfile5%></a></span>
    	      <%}%>
    	      <input type="hidden" name="osfile5" value="<%=oserverfile5%>"/> 
    	      <input type="hidden" name="ocfile5" value="<%=oclientfile5%>"/>  	
    	  </td>
    	  <input type="hidden" name="nsfile5">
    	  <td class="T12b"><span class="T12red">※</span><%=lang.getExppic4()%></td>
    	  <td class="T12b">
    	    <textarea name="fileexp5" cols="45" rows="5" class="lInput01"><%=oexpfile5%></textarea>
    	    <span class="T8-5">    (至多150字）</span>
    	    <input type="hidden" name="mfileexp5">
    	  </td>
    	</tr>
    <%}%>
  <tr>
    <th colspan="4" align="left">
      <span class="T10">(附件大小總共不可超過2M；圖片之副檔名僅可上傳【jpg】【jpeg】【gif】【png】之檔案)</span>
    </th>
  </tr>
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<br>

<table border="0" align="center">
  <tr>
    <%
      if ( !oserverfile2.equals("") ) { %>
    	  <td align="center">
    	    <img src="../../menudowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile2,"UTF-8")%>&flag=menupath" alt="<%=oexpfile2%>" border="0">
    	  </td>
    	  <td>&nbsp;</td>
      <%}
      if ( !oserverfile3.equals("") ) { %>
    	  <td>&nbsp;</td>
    	  <td align="center">
    	    <img src="../../menudowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile3,"UTF-8")%>&flag=menupath" alt="<%=oexpfile3%>" border="0">
    	  </td>
      <%}%>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <%
      if ( !oserverfile4.equals("") ) { %>
    	  <td align="center">
    	    <img src="../../menudowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile4,"UTF-8")%>&flag=menupath" alt="<%=oexpfile4%>" border="0">
    	  </td>
    	  <td>&nbsp;</td>
      <%}
      if ( !oserverfile5.equals("") ) { %>
    	  <td>&nbsp;</td>
    	  <td align="center">
    	    <img src="../../menudowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile5,"UTF-8")%>&flag=menupath" alt="<%=oexpfile5%>" border="0">
    	  </td>
      <%}%>    
  </tr>
</table>

</form>
</body>
</html>

