<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：pic_upload.jsp
說明：檔案管理(電子報圖片檔案)
開發者：chmei
開發日期：97.03.21
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
     document.backform.action="pic_list.jsp";
     document.backform.method="post";
     document.backform.submit();
  }
  
  function save(path)
  {
     if ( document.fileform.filename1.value == "" && document.fileform.filename2.value == "" && document.fileform.filename3.value == "" )
     {
        alert("【至少需上傳一個圖片檔案】，請選擇！");
        document.fileform.filename1.focus();
        return;
     }
     if ( document.fileform.filename1.value != "" )
     {
        var fn = document.fileform.filename1.value.toUpperCase();
        if( (fn.indexOf(".JPG") < 0) && (fn.indexOf(".JPEG") < 0) && (fn.indexOf(".GIF") < 0) && (fn.indexOf(".PNG") < 0) )
        {
           alert("您所選的圖片之副檔名不是【.JPG 或 .GIF 或 .JPEG 或 .PNG】，請重新選擇！");
           document.fileform.filename1.focus();
           return;
        }  
     }
     if ( (document.fileform.filename1.value != '') && (document.fileform.fileexp1.value == '') )
     {
        alert("【圖片說明】欄位，不可空白，請輸入！");
        document.fileform.fileexp1.focus();
        return;
     }else if ( document.fileform.fileexp1.value.length > 150 ) {
        alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp1.focus();
        return;
     }
     if ( document.fileform.filename2.value != "" )
     {
        var fn = document.fileform.filename2.value.toUpperCase();
        if( (fn.indexOf(".JPG") < 0) && (fn.indexOf(".JPEG") < 0) && (fn.indexOf(".GIF") < 0) && (fn.indexOf(".PNG") < 0 ))
        {
           alert("您所選的圖片之副檔名不是【.JPG 或 .GIF 或 .JPEG 或 .PNG】，請重新選擇！");
           document.fileform.filename2.focus();
           return;
        } 
     }
     if ( (document.fileform.filename2.value != '') && (document.fileform.fileexp2.value == '') )
     {
        alert("【圖片說明】欄位，不可空白，請輸入！");
        document.fileform.fileexp2.focus();
        return;
     }else if ( document.fileform.fileexp2.value.length > 150 ) {
        alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp2.focus();
        return;
     } 
     if ( document.fileform.filename3.value != "" )
     {
        var fn = document.fileform.filename3.value.toUpperCase();
        if( (fn.indexOf(".JPG") < 0) && (fn.indexOf(".JPEG") < 0) && (fn.indexOf(".GIF") < 0) && (fn.indexOf(".PNG") < 0) )
        {
           alert("您所選的圖片之副檔名不是【.JPG 或 .GIF 或 .JPEG 或 .PNG】，請重新選擇！");
           document.fileform.filename3.focus();
           return;
        } 
     }
     if ( (document.fileform.filename3.value != '') && (document.fileform.fileexp3.value == '') )
     {
        alert("【圖片說明】欄位，不可空白，請輸入！");
        document.fileform.fileexp3.focus();
        return;
     }else if ( document.fileform.fileexp3.value.length > 150 ) {
        alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp3.focus();
        return;
     } 
         
     //因上傳元件，需將換行等tag replace
     if ( document.fileform.fileexp1.value != '' )
     {
        var contentStr = document.fileform.fileexp1.value;
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
        document.fileform.mfileexp1.value = contentStr;
        document.fileform.fileexp1.value = "";
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
     
     document.fileform.action="pic_save.jsp?path="+path;
     document.fileform.method="post";
     document.fileform.submit();
  }
</script>

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );

  String path = ( String )request.getParameter( "path" );  
  String languageb = ( String )request.getParameter( "language" );

%>  

<form name="backform">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>
</form>

<body>
<form name="fileform" enctype="multipart/form-data">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/flanguage.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=lang.getPicmanage()%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=path%>')"><%=lang.getSave()%></a>	 
 <a class="md" href="javascript:window.document.menuform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 <a class="md" href="javascript:window.close()"><%=lang.getClose()%></a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr>
    <th colspan="4"><div align="center"><%=lang.getPicupload()%></div></th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getUploadpic1()%></td>
    <td class="T12b">
      <input name="filename1" type="file" class="lInput01" size="20" />
    </td>
    <td class="T12b"><span class="T12red">※</span><%=lang.getExppic1()%></td>
    <td class="T12b">
      <textarea name="fileexp1" cols="48" rows="4" class="lInput01"></textarea>
      <span class="T8-5">    (至多150字）</span>
      <input type="hidden" name="mfileexp1"/>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getUploadpic2()%></td>
    <td class="T12b">
      <input name="filename2" type="file" class="lInput01" size="20" />
    </td>
    <td class="T12b"><span class="T12red">※</span><%=lang.getExppic2()%></td>
    <td class="T12b">
      <textarea name="fileexp2" cols="48" rows="4" class="lInput01"></textarea>
      <span class="T8-5">    (至多150字）</span>
      <input type="hidden" name="mfileexp2">
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getUploadpic3()%></td>
    <td class="T12b">
      <input name="filename3" type="file" class="lInput01" size="20" />
    </td>
    <td class="T12b"><span class="T12red">※</span><%=lang.getExppic3()%></td>
    <td class="T12b">
      <textarea name="fileexp3" cols="48" rows="4" class="lInput01"></textarea>
      <span class="T8-5">    (至多150字）</span>
      <input type="hidden" name="mfileexp3">
    </td>
  </tr>
  <tr>
    <th colspan="4" align="left">
      <span class="T10">(附件大小總共不可超過5M；圖片之副檔名僅可上傳【jpg】【jpeg】【gif】【png】之檔案)</span>
    </th>
  </tr>
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<!-- <p><div align="left"><a class="md" href="#top"><%=lang.getTop()%></a></div> -->

</form>
</body>
</html>

