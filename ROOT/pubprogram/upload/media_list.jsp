<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：media_list.jsp
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
  function upload(){
     document.fileform.action = "media_upload.jsp";
     document.fileform.method = "post";
     document.fileform.submit();
  }
  
  function mdy(detailno){
     document.fileform.detailno.value = detailno;
     document.fileform.action = "media_mdy.jsp";
     document.fileform.method = "post";
     document.fileform.submit();
  }
          
  function del()
  {
     x=window.confirm("確定執行整批刪除嗎?")
     if(x)
     {
        document.fileform.action="media_del.jsp";
        document.fileform.method="post";
        document.fileform.submit();
     } 
  }      
</script>

</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.upload.*" %>

<%  
  String serno = ( String )request.getParameter( "serno" );
  String tablename = ( String )request.getParameter( "table" ); 
  String path = ( String )request.getParameter( "path" );
 
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );

  if ( intpage1 == null || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);
  
  UploadData qupload = new UploadData();    
  ArrayList qfiles = qupload.findByday(tablename,serno,"media");
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
<input type="hidden" name="serno" value="<%=serno%>"/>
<input type="hidden" name="table" value="<%=tablename%>"/>
<input type="hidden" name="path" value="<%=path%>"/>
<input type="hidden" name="detailno"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=lang.getMediamanage()%></h2>
</div>
<br/>
<a class="md" href="javascript:upload()"><%=lang.getUpload()%></a>
<%
  if ( rcount > 0 ) {  %>
	  <a class="md" href="javascript:del()"><%=lang.getDel()%></a>
  <%}%>
<a class="md" href="javascript:window.close()"><%=lang.getClose()%></a>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="20%" align="left"><%=lang.getPreview()%></th>
    <th width="30%" align="left"><%=lang.getExppreview()%></th>
    <th width="15%" align="left"><%=lang.getMediafile()%></th>
    <th width="25%" align="left"><%=lang.getExpmedia()%></th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	UploadData qfile = ( UploadData )qfiles.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <%
    	    String filedata = qfile.getSerno() + "||" + qfile.getDetailno();
    	    
    	    String[] ary_exppreview = SvString.split(qfile.getExpfile(),"|");
    	    String[] ary_expmedia = SvString.split(qfile.getExpmediafile(),"|");
    	    String mpreview = "";
    	    for( int j=0; j<ary_exppreview.length; j++ ) {
    	    	if ( mpreview.equals("") )
    	    		mpreview = ary_exppreview[j];
    	    	else
    	    		mpreview = mpreview + "<br>" + ary_exppreview[j];
    	    }
    	    String mmedia = "";
    	    for( int k=0; k<ary_expmedia.length; k++ ) {
    	    	if ( mmedia.equals("") )
    	    		mmedia = ary_expmedia[k];
    	    	else
    	    		mmedia = mmedia + "<br>" + ary_expmedia[k];
    	    }
    	  %>
    	  <td align="center"><input type="checkbox" name="check" value=<%=filedata%>></td>
    	  <td><a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(qfile.getServerfile(),"UTF-8")%>&flag=media"><img src="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(qfile.getServerfile(),"UTF-8")%>&flag=media" alt="<%=qfile.getExpfile()%>" border="0"></td>
    	  <td><a href="javascript:mdy('<%=qfile.getDetailno()%>')"><%=mpreview%></a></td>
    	  <td align="left"><a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(qfile.getSmediafile(),"UTF-8")%>&flag=media"><%=qfile.getSmediafile()%></a></td>
    	  <td><%=mmedia%></td>
    	</tr> 
    <%}%>
    	
    <input type="hidden" name="page"> 
    <input type="hidden" name="intpage" value=<%=intpage%>> 
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
