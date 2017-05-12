<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!--
程式名稱：f101.jsp
說明：分類檢索第一層
開發者：tswenyaw
開發日期：97.04.24
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>網站後端管理</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
  function add()
  {
    document.mform.action="f101_add.jsp";
    document.mform.method="post";
    document.mform.submit();
  }
  
  function qry()
  {
    document.mform.action="f101.jsp";
    document.mform.method="post";
    document.mform.submit();
  }  
  
  function mdy(serno)
  {
     document.mform.serno.value=serno;
     document.mform.action="f101_mdy.jsp";
     document.mform.method="post";
     document.mform.submit();
  } 
    
  function clean() 
  {
      //document.mform.qpunit.value = "";
      document.mform.qdtype.value = "";      
      document.mform.qclass.value = "請輸入關鍵字";
      document.mform.qcname.value = "";
      document.mform.qdldate.value = "";
      document.mform.quse.value = "";
  }     
  
  function del()
  {
     x=window.confirm("確定執行整批刪除嗎?")
     if(x)
     {
        document.mform.action="f101_del.jsp?type=0";
        document.mform.method="post";
        document.mform.submit();
     } 
  } 
  
  /*參數說明
    serno：序號
    filetype：屬性(doc：文件型 pic：圖片型 media：影片、語音型)
    tablename：table名稱(EX：DownFile)
    path：程式所在路徑(EX：/pubhsinchu/downfile)
    language：語系
    pagesize：每頁筆數
  */
  function file(serno,filetype,tablename,path,language,pagesize)
  {
     if ( filetype == 'doc' ) {
        window.open('../../pubprogram/upload/file_list.jsp?serno='+serno+'&table='+tablename+'&path='+path+'&language='+language+'&pagesize='+pagesize,'down','width=900,height=450,scrollbars=yes,left=90,top=90');
     }else if ( filetype == 'pic' ) {
        window.open('../../pubprogram/upload/pic_list.jsp?serno='+serno+'&table='+tablename+'&path='+path+'&language='+language+'&pagesize='+pagesize,'down','width=900,height=450,scrollbars=yes,left=90,top=90');
     }else if ( filetype == 'media' ) {
        window.open('../../pubprogram/upload/media_list.jsp?serno='+serno+'&table='+tablename+'&path='+path+'&language='+language+'&pagesize='+pagesize,'down','width=900,height=450,scrollbars=yes,left=90,top=90');
     }
  } 
         
</script>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  String mpunit = ( String )request.getParameter( "mpunit" );
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );

  if ( intpage1 == null || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);
  
  String logindn = ( String )session.getAttribute("logindn");
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  //接收查詢條件
  
  String qcname = ( String )request.getParameter( "qcname" );   
  if ( qcname == null )
	  qcname = "";  
  
 
  APList query = new APList();  
  ArrayList qlists = query.findByday(table,qcname);    
  int rcount = query.getAllrecordCount();
  //out.println(query.getErrorMsg());
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
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>

<input type="hidden" name="serno"/>
<input type="hidden" name="mpunit" value="<%=mpunit%>"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<div>  
         
             &nbsp;&nbsp;&nbsp; 
         <span class="T11b">關鍵字：</span><input name="qcname" type="text" value="<%=qcname%>" />關鍵字
             &nbsp;&nbsp;&nbsp;
    
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()">查   詢</a>&nbsp;
  <a class="md2" href="javascript:clean()">重   設</a>
</div>
<p> 

<a class="md" href="javascript:add()">新   增</a>
<a class="md" href="javascript:del()">刪   除</a>
   	  	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="10%" align="left">功能名稱</th>
    <th width="10%" align="left">清單頁程式</th>
    <th width="20%" align="left">單筆頁程式</th>

  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	APList qlist = ( APList )qlists.get( i ); %>
    	
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center"><input type="checkbox" name="check" value=<%=qlist.getSerno()%>></td>
    	  <td align="left"><a href="javascript:mdy('<%=qlist.getSerno()%>')"><%=qlist.getPage_name()%></a></td>
    	  <td align="left"><%=qlist.getUppage_url()%></a></td>
    	  
    	  <td align="left"><%=qlist.getPage_url()%></td>
    	  
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
            <jsp:param name="formname" value="mform"/>
        </jsp:include>
      </th>
    </tr>  
  
</table>

<p>
<a class="md" href="#top">回頁首</a>

<div id="page"><span class="T8-5">頁數:</span> <span class="T8-5c"> <%=intpage%> / <%=maxpage%> </span><span class="T8-5">； 資料每頁以<%=pagesize%>筆展現；共有</span><span class="T8-5c"> <%=rcount%> </span> <span class="T8-5">筆資料</span></div>

</form>
</body>
</html>