<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：piclibrary_list.jsp
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
  function save(){
     document.fileform.action = "piclibrary_save.jsp";
     document.fileform.method = "post";
     document.fileform.submit();
  }
  
  function cancel(){
     document.fileform.action = "piclibrary_cancel.jsp";
     document.fileform.method = "post";
     document.fileform.submit();
  }
</script>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.upload.*" %>

<%
  String table = ( String )request.getParameter( "table" );
  String path = ( String )request.getParameter( "path" );
 
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );

  if ( intpage1 == null || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);
  
  String dataserno = ( String )request.getParameter( "serno" );
  
  //尋找是否有引用圖庫
  PicLibraryFileData query = new PicLibraryFileData();
  boolean rtn = query.load(table,dataserno);
  String serverfile = "";
  if ( rtn )
	  serverfile = query.getServerfile();
  
  PicLibraryFileData qupload = new PicLibraryFileData();
  ArrayList qfiles = qupload.findByday("PicLibraryFile");
  int rcount = qupload.getAllrecordCount();

  //計算總頁數
  int maxpage=0;
  
  //取餘數
  maxpage=rcount%pagesize;
  if (maxpage==0)
     maxpage=rcount/pagesize;
  else
     maxpage=(rcount/pagesize)+1;
%>

<body>
<form name="fileform">

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/flanguage.jsp"%>

<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="intpage" value="<%=intpage%>"/>
<input type="hidden" name="table" value="<%=table%>"/>
<input type="hidden" name="path" value="<%=path%>"/>
<input type="hidden" name="dataserno" value="<%=dataserno%>"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=lang.getPiclibrary()%></h2>
</div>
<br/>
<a class="md" href="javascript:save()"><%=lang.getSave()%></a>
<%
  if ( rtn ) {%>
	  <a class="md" href="javascript:cancel()"><%=lang.getCancelpiclibrary()%></a>
  <%}%>

<a class="md" href="javascript:window.close()"><%=lang.getClose()%></a>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
     <th width="50%" align="center"><%=lang.getPicname()%></th>
    <th width="40%" align="left"><%=lang.getPicexp()%></th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	PicLibraryFileData qfile = ( PicLibraryFileData )qfiles.get( i ); %>
    	<tr>
    	  <td colspan="3">&nbsp;</td>
    	</tr>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>    	  
    	  <%
    	    String filedata = qfile.getSerno() + "||" + qfile.getDetailno();
    	    String[] ary_exppic = SvString.split(qfile.getExpfile(),"|");
    	    String mexppic = "";
    	    for( int j=0; j<ary_exppic.length; j++ ) {
    	    	if ( mexppic.equals("") )
    	    		mexppic = ary_exppic[j];
    	    	else
    	    		mexppic = mexppic + "<br>" + ary_exppic[j];
    	    }
    	    
    	    String msfile = qfile.getServerfile();
    	    if ( qfile.getImagemagick() != null && !qfile.getImagemagick().equals("null") && !qfile.getImagemagick().equals("") )
    	    	msfile = qfile.getImagemagick();
    	    String isSelected = "";
    	    if ( qfile.getServerfile().equals(serverfile) )
    	    	isSelected = "checked"; %>
    	  <td align="center"><input type="radio" name="piclibrary" value="<%=filedata%>" <%=isSelected%>/></td>
    	  <td align="center">
    	    <%
    	      if ( qfile.getImagemagick() != null && !qfile.getImagemagick().equals("null") && !qfile.getImagemagick().equals("") ) {  %>
    	    	  <img src="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic" alt="<%=qfile.getExpfile()%>" border="0"/>
    	      <%}else{%>
    	    	  <img src="../../showimage?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic&w=160&h=200" alt="<%=qfile.getExpfile()%>" border="0"/>
    	      <%}%>
    	  </td>      
    	  <td align="left"><%=mexppic%></td>
    	</tr>
    	<tr>
    	  <td colspan="3">&nbsp;</td>
    	</tr>
    <%}%>
    	
    <input type="hidden" name="page"/> 
    <input type="hidden" name="intpage" value="<%=intpage%>"/> 
    
    <!-- 分頁 -->
    <tr class="tr01">
      <th colspan="11">
        <jsp:include page="../../pubprogram/page.jsp">
            <jsp:param name="startpage" value="<%=startpage%>"/>
            <jsp:param name="pagesize" value="<%=pagesize%>"/>
            <jsp:param name="intpage" value="<%=intpage%>"/>
            <jsp:param name="maxpage" value="<%=maxpage%>"/>
            <jsp:param name="endpage" value="<%=endpage%>"/>
            <jsp:param name="rcount" value="<%=rcount%>"/>
            <jsp:param name="formname" value="fileform"/>
        </jsp:include>
      </th>
    </tr>  
  
</table>

<p>
<a class="md" href="#top">回頁首</a>

<div id="page"><span class="T8-5">頁數:</span> <span class="T8-5c"> <%=intpage%> / <%=maxpage%> </span><span class="T8-5">； 資料每頁以15筆展現；共有</span><span class="T8-5c"> <%=rcount%> </span> <span class="T8-5">筆資料</span></div>

</form>
</body>
</html>
