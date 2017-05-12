<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：media_mdy.jsp
說明：檔案管理(影音檔案)
開發者：chmei
開發日期：97.02.15
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
  function back()
  {
     document.backform.action="media_list.jsp";
     document.backform.method="post";
     document.backform.submit();
  }
  
  function save(path)
  {
     if ( document.fileform.filename1.value != "" )
     {
        var fn = document.fileform.filename1.value.toUpperCase();
        if( (fn.indexOf(".JPG") < 0) && (fn.indexOf(".JPEG") < 0) && (fn.indexOf(".GIF") < 0) )
        {
           alert("您所選的預覽圖之副檔名不是【.JPG 或 .GIF 或 .JPEG】，請重新選擇！");
           document.fileform.filename1.focus();
           return;
        } 
     }
     if ( (document.fileform.filename1.value != '') && (document.fileform.fileexp1.value == '') )
     {
        alert("【預覽圖說明】欄位，不可空白，請輸入！");
        document.fileform.fileexp1.focus();
        return;
     }else if ( document.fileform.fileexp1.value.length > 150 ) {
        alert("【預覽圖說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp1.focus();
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
     if ( document.fileform.filename1.value != '' )
        document.fileform.nsfile.value = document.fileform.filename1.value;
     
     if ( document.fileform.filename2.value != "" )
     {
        var fn = document.fileform.filename2.value.toUpperCase();
        if( (fn.indexOf(".WMV") < 0) && fn.indexOf(".WMA") < 0) && (fn.indexOf(".ASF") < 0) && (fn.indexOf(".MP3") < 0) && (fn.indexOf(".MPG") < 0) && (fn.indexOf(".MPEG") < 0) )
        {
           alert("您所選的Media檔案之副檔名不是【.WMV 或 .WMV 或 .ASF 或 .MP3 或 .MPG 或 .MPEG】，請重新選擇！");
           document.fileform.filename2.focus();
           return;
        } 
     }
     if ( (document.fileform.filename2.value != '') && (document.fileform.fileexp2.value == '') )
     {
        alert("【Media檔案說明】欄位，不可空白，請輸入！");
        document.fileform.fileexp2.focus();
        return;
     }else if ( document.fileform.fileexp2.value.length > 150 ) {
        alert("【Media檔案說明】欄位，不可超過150個中文字，請重新輸入！");
        document.fileform.fileexp2.focus();
        return;
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
     if ( document.fileform.filename2.value != '' )
        document.fileform.nsmedia.value = document.fileform.filename2.value;

     document.fileform.action="media_mdysave.jsp?path="+path;
     document.fileform.method="post";
     document.fileform.submit();
  }
</script>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.upload.*" %>

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );

  String serno = ( String )request.getParameter( "serno" );
  int detailno = Integer.parseInt(( String )request.getParameter( "detailno" ));
  String tablename = ( String )request.getParameter( "table" ); 
  String path = ( String )request.getParameter( "path" );
  String languageb = ( String )request.getParameter( "language" );
  
  UploadData query = new UploadData();
  boolean rtn = query.load(tablename,serno,detailno,"media");

%>  

<body>

<form name="backform">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="table" value="<%=tablename%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>
</form>

<form name="fileform" enctype="multipart/form-data">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="table" value="<%=tablename%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>
  <input type="hidden" name="detailno" value="<%=detailno%>"/>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/flanguage.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=lang.getMediamanage()%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=path%>')"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:window.document.menuform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 <a class="md" href="javascript:window.close()"><%=lang.getClose()%></a>

<%
  if ( rtn ) { %>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
	    <tr>
	      <th colspan="4"><div align="center"><%=lang.getMediaupload()%></div></th>
	    </tr>
	    <%
	      String[] ary_exppreview = SvString.split(query.getExpfile(),"|");
	      String[] ary_expmedia = SvString.split(query.getExpmediafile(),"|");
	      String mpreview = "";
	      for( int j=0; j<ary_exppreview.length; j++ ) {
	    	  if ( mpreview.equals("") )
	    		  mpreview = ary_exppreview[j];
	    	  else
	    		  mpreview = mpreview + "\n" + ary_exppreview[j];
	      }
	      String mmedia = "";
	      for( int k=0; k<ary_expmedia.length; k++ ) {
	    	  if ( mmedia.equals("") )
	    		  mmedia = ary_expmedia[k];
	    	  else
	    		  mmedia = mmedia + "\n" + ary_expmedia[k];
	      }%>
	    <tr class="tr">
	      <td class="T12b"><span class="T12red">※</span><%=lang.getPreview()%></td>
	      <td class="T12b">
	        <input name="filename1" type="file" class="lInput01" size="20" />
	        <%
	          if ( query.getServerfile() != null && !query.getServerfile().equals("") ) {  %>
	        	  <br><br><span class="T10">【原預覽圖檔名】：<a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(query.getServerfile(),"UTF-8")%>&flag=media"><%=query.getClientfile()%></a></span>
	          <%}%>	
	          <input type="hidden" name="osfile" value=<%=query.getServerfile()%>> 
	          <input type="hidden" name="ocfile" value=<%=query.getClientfile()%>>  
	      </td>
	      <input type="hidden" name="nsfile"/>
	      <td class="T12b"><span class="T12red">※</span><%=lang.getExppreview()%></td>
	      <td class="T12b">
	        <textarea name="fileexp1" cols="30" rows="3" class="lInput01"><%=mpreview%></textarea>
	        <span class="T8-5">    (至多150字）</span>
	        <input type="hidden" name="mfileexp1"//>
	      </td>
	    </tr>  
	    <tr class="tr">
	      <td class="T12b"><span class="T12red">※</span><%=lang.getMediafile()%></td>
	      <td class="T12b">
	        <input name="filename2" type="file" class="lInput01" size="20" />
	        <%
	          if ( query.getSmediafile() != null && !query.getSmediafile().equals("") ) {  %>
	        	  <br><br><span class="T10">【原Media檔名】：<a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(query.getSmediafile(),"UTF-8")%>&flag=media"><%=query.getCmediafile()%></a></span>
	          <%}%>	
	          <input type="hidden" name="osmedia" value=<%=query.getSmediafile()%>> 
	          <input type="hidden" name="ocmedia" value=<%=query.getCmediafile()%>>  
	      </td>
	      <input type="hidden" name="nsmedia"/>
	      <td class="T12b"><span class="T12red">※</span><%=lang.getExpmedia()%></td>
	      <td class="T12b">
	        <textarea name="fileexp2" cols="30" rows="3" class="lInput01"><%=mmedia%></textarea>
	        <span class="T8-5">    (至多150字）</span>
	        <input type="hidden" name="mfileexp2"/>
	      </td>
	    </tr>  
	    <tr >
	      <th >&nbsp;</th>
	      <th >&nbsp;</th>
	      <th >&nbsp;</th>
	      <th >&nbsp;</th>
	    </tr>
	  </table>
  <%}%> 	

<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2" style="padding-left:10px">
      <span class="T10"><span class="T12red">※</span>影音大小總共不可超過3M；影音之副檔名僅可上傳【WMV】【WMA】【ASF】【MP3】【MPG】【MPEG】之檔案</span>
    </td>
  </tr>
</table>

<!-- <p><div align="left"><a class="md" href="#top"><%=lang.getTop()%></a></div> -->

</form>
</body>
</html>

