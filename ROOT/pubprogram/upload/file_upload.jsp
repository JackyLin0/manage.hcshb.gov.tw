<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：file_upload.jsp
說明：檔案管理(文件檔案)
開發者：chmei
開發日期：97.02.15
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
     document.backform.action="file_list.jsp";
     document.backform.method="post";
     document.backform.submit();
  }
  
  function save(path)
  {
     if ( document.fileform.filename1.value == "" && document.fileform.filename2.value == "" && document.fileform.filename3.value == "" )
     {
        alert("【至少需上傳一個檔案】，請選擇！");
        document.fileform.filename1.focus();
        return;
     }
     if ( document.fileform.filename1.value != "" )
     {
        var fn = document.fileform.filename1.value.toUpperCase();
        if( (fn.indexOf(".DOC") < 0) && (fn.indexOf(".PDF") < 0) && (fn.indexOf(".TXT") < 0) && (fn.indexOf(".XLS") < 0) && (fn.indexOf(".PPT") < 0) && (fn.indexOf(".CSV") < 0 ) && (fn.indexOf(".ODT") < 0 ) && (fn.indexOf(".ODS") < 0 ) && (fn.indexOf(".ODP") < 0 ) )
        {
           alert("您所選的檔案(1)之副檔名不是【.DOC 或 .PDF 或 .TXT 或 .XLS 或 .PPT 或 .CSV 或 .ODT 或 .ODS 或 .ODP】，請重新選擇！");
           document.fileform.filename1.focus();
           return;
         } 
     }
     if ( (document.fileform.filename1.value != '') && (document.fileform.fileexp1.value == '') )
     {
        alert("有上傳檔案者，其【檔案說明】欄位，不可空白，請輸入！");
        document.fileform.fileexp1.focus();
        return;
     }else if ( document.fileform.fileexp1.value.length > 150 ) {
        alert("【檔案說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp1.focus();
        return;
     }
     
     if ( document.fileform.filename2.value != "" )
     {
        var fn = document.fileform.filename2.value.toUpperCase();
        if( (fn.indexOf(".DOC") < 0) && (fn.indexOf(".PDF") < 0) && (fn.indexOf(".TXT") < 0) && (fn.indexOf(".XLS") < 0) && (fn.indexOf(".PPT") < 0) && (fn.indexOf(".CSV") < 0 ) && (fn.indexOf(".ODT") < 0 ) && (fn.indexOf(".ODS") < 0 ) && (fn.indexOf(".ODP") < 0 ) )
        {
           alert("您所選的檔案(2)之副檔名不是【.DOC 或 .PDF 或 .TXT 或 .XLS 或 .PPT 或 .CSV 或 .ODT 或 .ODS 或 .ODP】，請重新選擇！");
           document.fileform.filename2.focus();
           return;
         } 
     }
     if ( (document.fileform.filename2.value != '') && (document.fileform.fileexp2.value == '') )
     {
        alert("有上傳檔案者，其【檔案說明】欄位，不可空白，請輸入！");
        document.fileform.fileexp2.focus();
        return;
     }else if ( document.fileform.fileexp2.value.length > 150 ) {
        alert("【檔案說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp2.focus();
        return;
     } 
         
     if ( document.fileform.filename3.value != "" )
     {
        var fn = document.fileform.filename3.value.toUpperCase();
        if( (fn.indexOf(".DOC") < 0) && (fn.indexOf(".PDF") < 0) && (fn.indexOf(".TXT") < 0) && (fn.indexOf(".XLS") < 0) && (fn.indexOf(".PPT") < 0) && (fn.indexOf(".CSV") < 0 ) && (fn.indexOf(".ODT") < 0 ) && (fn.indexOf(".ODS") < 0 ) && (fn.indexOf(".ODP") < 0 ) )
        {
           alert("您所選的檔案(3)之副檔名不是【.DOC 或 .PDF 或 .TXT 或 .XLS 或 .PPT 或 .CSV 或 .ODT 或 .ODS 或 .ODP】，請重新選擇！");
           document.fileform.filename3.focus();
           return;
         } 
     }
     if ( (document.fileform.filename3.value != '') && (document.fileform.fileexp3.value == '') )
     {
        alert("有上傳檔案者，其【檔案說明】欄位，不可空白，請輸入！");
        document.fileform.fileexp3.focus();
        return;
     }else if ( document.fileform.fileexp3.value.length > 150 ) {
        alert("【檔案說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp3.focus();
        return;
     }     
     
     document.fileform.action="file_save.jsp?path="+path;
     document.fileform.method="post";
     document.fileform.submit();
  }
</script>

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );

  String serno = ( String )request.getParameter( "serno" );
  String tablename = ( String )request.getParameter( "table" ); 
  String path = ( String )request.getParameter( "path" );
  String languageb = ( String )request.getParameter( "language" );

%>  

<form name="backform">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="table" value="<%=tablename%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>
</form>

<body>
<form name="fileform" enctype="multipart/form-data">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="table" value="<%=tablename%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/flanguage.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=lang.getFilemanage()%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=path%>')"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:window.document.menuform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 <a class="md" href="javascript:window.close()"><%=lang.getClose()%></a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr>
    <th colspan="4"><div align="center"><%=lang.getFileupload()%></div></th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getUpload1()%></td>
    <td class="T12b">
      <input name="filename1" type="file" class="lInput01" size="20" />
    </td>
    <td class="T12b"><span class="T12red">※</span><%=lang.getExpfile1()%></td>
    <td class="T12b">
      <input name="fileexp1" type="text" class="lInput01" size="25" /><span class="T8-5">    (至多150字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getUpload2()%></td>
    <td class="T12b">
      <input name="filename2" type="file" class="lInput01" size="20" />
    </td>
    <td class="T12b"><span class="T12red">※</span><%=lang.getExpfile2()%></td>
    <td class="T12b">
      <input name="fileexp2" type="text" class="lInput01" size="25" /><span class="T8-5">    (至多150字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getUpload3()%></td>
    <td class="T12b">
      <input name="filename3" type="file" class="lInput01" size="20" />
    </td>
    <td class="T12b"><span class="T12red">※</span><%=lang.getExpfile3()%></td>
    <td class="T12b">
      <input name="fileexp3" type="text" class="lInput01" size="25" /><span class="T8-5">    (至多150字）</span>
    </td>
  </tr>
  <tr>
    <th colspan="4" align="left">
      <span class="T10">(附件大小總共不可超過5M；附件之副檔名僅可上傳【doc】【pdf】【xls】【txt】【ppt】【CSV】【ODT】【ODS】【ODP】之檔案)</span>
    </th>
  </tr>

  <tr>
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

