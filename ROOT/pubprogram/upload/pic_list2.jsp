<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：pic_list.jsp
說明：檔案管理(圖片檔案)
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
  function upload(){
     document.fileform.action = "pic_upload.jsp";
     document.fileform.method = "post";
     document.fileform.submit();
  }
  
  function mdy(detailno){
     document.fileform.detailno.value = detailno;
     document.fileform.action = "pic_mdy.jsp";
     document.fileform.method = "post";
     document.fileform.submit();
  }
    
  function save()
  {
     document.fileform.action="pic_mainsave.jsp";
     document.fileform.method="post";
     document.fileform.submit();
  } 
          
  function del()
  {
     x=window.confirm("確定執行整批刪除嗎?")
     if(x)
     {
        document.fileform.action="pic_del.jsp";
        document.fileform.method="post";
        document.fileform.submit();
     } 
  }      
</script>

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
  ArrayList qfiles = qupload.findByday(tablename,serno,"pic");
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
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=lang.getPicmanage()%></h2>
</div>
<br>
<a class="md" href="javascript:upload()"><%=lang.getUpload()%></a>
<%
  if ( rcount > 0 ) {  %>
	  
	  <a class="md" href="javascript:del()"><%=lang.getDel()%></a>
  <%}%>
<a class="md" href="javascript:window.save()"><%=lang.getSave()%></a>
<a class="md" href="javascript:window.close()"><%=lang.getClose()%></a>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="10%" align="center"><%=lang.getMainimage()%></th>
     <th width="40%" align="center"><%=lang.getPicname()%></th>
    <th width="40%" align="left"><%=lang.getPicexp()%></th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	UploadData qfile = ( UploadData )qfiles.get( i ); %>
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
    	    String mimage = qfile.getMainimage();
    	    if ( qfile.getMainimage() == null || qfile.getMainimage().equals("null") || qfile.getMainimage().equals("") )
    	    	mimage = "N";
    	    String mainvalue = qfile.getSerno() + "||" + qfile.getDetailno();  %>
    	  <td align="center"><input type="checkbox" name="check" value="<%=filedata%>"/></td>
    	  <td align="center"><input name="mainimage" type="radio" value="<%=mainvalue%>" <%=(mimage.equals("Y") ? "checked" : "")%>/></td>
    	  <td align="center" width="40%">
    	    <%
    	      if ( qfile.getImagemagick() != null && !qfile.getImagemagick().equals("null") && !qfile.getImagemagick().equals("") ) {  %>
    	    	  <a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(qfile.getServerfile(),"UTF-8")%>&flag=pic"><img src="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic" alt="<%=qfile.getExpfile()%>" border="0"/></a>
    	      <%}else{%>
    	    	  <a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(qfile.getServerfile(),"UTF-8")%>&flag=pic"><img src="../../showimage?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic&w=160&h=200" alt="<%=qfile.getExpfile()%>" border="0"/></a>
    	      <%}%>
    	  </td>      
    	  <td align="left"><a href="javascript:mdy('<%=qfile.getDetailno()%>')"><%=mexppic%></a></td>
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
