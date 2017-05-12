<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：piclibrary101_mdy.jsp
說明：圖庫管理
開發者：chmei
開發日期：97.06.07
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
     document.backform.action="piclibrary101.jsp";
     document.backform.method="post";
     document.backform.submit();
  }
  
  function save(path)
  {
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
        
     document.fileform.action="piclibrary101_mdysave.jsp?path="+path;
     document.fileform.method="post";
     document.fileform.submit();
  }
</script>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.upload.*" %>

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );

  String serno = ( String )request.getParameter( "serno" );
  int detailno = Integer.parseInt(( String )request.getParameter( "detailno" ));
  String table = ( String )request.getParameter( "t" ); 
  String path = ( String )request.getParameter( "path" );
  String languageb = ( String )request.getParameter( "language" );
  
  PicLibraryFileData query = new PicLibraryFileData();
  boolean rtn = query.load(table,serno,detailno,"pic");

%>  

<form name="backform">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>
</form>

<body>
<form name="fileform" enctype="multipart/form-data">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>
  <input type="hidden" name="detailno" value="<%=detailno%>"/>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/flanguage.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=lang.getPiclibrary()%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=path%>')"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:window.document.menuform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>

<%
  if ( rtn ) { %>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
	    <tr>
	      <th colspan="2"><div align="center"><%=lang.getPicupload()%></div></th>
	    </tr>
	    <%
	      String[] ary_exppic = SvString.split(query.getExpfile(),"|");
	      String mexppic = "";
	      for( int j=0; j<ary_exppic.length; j++ ) {
	    	  if ( mexppic.equals("") )
	    		  mexppic = ary_exppic[j];
	    	  else
	    		  mexppic = mexppic + "\n" + ary_exppic[j];
	      }%>
	    <tr class="tr">
	      <td class="T12b"><span class="T12red">※</span><%=lang.getUploadpic1()%></td>
	      <td class="T12b">
	        <input name="filename1" type="file" class="lInput01" size="20" />
	        <%
	          String msfile = query.getServerfile();
	          if ( query.getImagemagick() != null && !query.getImagemagick().equals("null") && !query.getImagemagick().equals("") )
	        	  msfile = query.getImagemagick();
	          if ( query.getImagemagick() != null && !query.getImagemagick().equals("null") && !query.getImagemagick().equals("") ) {  %>
	        	  <br><br><span class="T10" valign="center"><img src="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic" alt="<%=query.getExpfile()%>" border="0"/>&nbsp;&nbsp;【原圖片檔名】：<a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(query.getServerfile(),"UTF-8")%>&flag=pic"><%=query.getClientfile()%></a></span>
	          <%}else{%>
	        	  <br><br><span class="T10" valign="center"><img src="../../showimage?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic&w=170&h=200" alt="<%=query.getExpfile()%>" border="0"/>&nbsp;&nbsp;【原圖片檔名】：<a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(query.getServerfile(),"UTF-8")%>&flag=pic"><%=query.getClientfile()%></a></span>
	          <%}%>	
	          <input type="hidden" name="osfile" value="<%=query.getServerfile()%>"/>
	          <input type="hidden" name="ocfile" value="<%=query.getClientfile()%>"/>
	          <input type="hidden" name="oimagemagick" value="<%=query.getImagemagick()%>"/>
	      </td>
	      <input type="hidden" name="nsfile"/>
	    </tr>  
	    <tr class="tr">
	      <td class="T12b"><span class="T12red">※</span><%=lang.getExpfile1()%></td>
	      <td class="T12b">
	        <textarea name="fileexp1" cols="30" rows="3" class="lInput01"><%=mexppic%></textarea>
	        <span class="T8-5">    (至多150字）</span>
	        <input type="hidden" name="mfileexp1">
	      </td>
	    </tr>
	    <tr>
	      <th colspan="2" align="left">
	        <span class="T10">(附件大小總共不可超過5M；圖片之副檔名僅可上傳【jpg】【jpeg】【gif】【png】之檔案)</span>
	      </th>
	    </tr>
	    <tr >
	      <th >&nbsp;</th>
	      <th >&nbsp;</th>
	    </tr>
	  </table>
  <%}%> 	

<!-- <p><div align="left"><a class="md" href="#top"><%=lang.getTop()%></a></div> -->

</form>
</body>
</html>

