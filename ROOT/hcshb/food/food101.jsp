<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：food101.jsp
說明：食品營養專欄維護
開發者：chmei
開發日期：97.02.18
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
  function add()
  {
    document.mform.action="food101_add.jsp";
    document.mform.method="post";
    document.mform.submit();
  }
  
  function qry()
  {
    document.mform.action="food101.jsp";
    document.mform.method="post";
    document.mform.submit();
  }  
  
  function mdy(serno)
  {
     document.mform.serno.value=serno;
     document.mform.action="food101_mdy.jsp";
     document.mform.method="post";
     document.mform.submit();
  } 
    
  function clean()
  {
      document.mform.qpunit.value = "";
      document.mform.qclass.value = "";
      document.mform.keyword.value = "請輸入關鍵字";
  }     
  
  function del()
  {
     x=window.confirm("確定執行整批刪除嗎?")
     if(x)
     {
        document.mform.action="food101_del.jsp?type=0";
        document.mform.method="post";
        document.mform.submit();
     } 
  } 
  
   function resetfsort(tablename) {
      newwin=window.open('../../pubprogram/resetfsort.jsp?tablename='+tablename,'','width=350,height=200,scrollbars=yes,left=300,top=150');
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
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
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
  //關鍵字尋找標題、副標題、內容三個欄位
  String keyword = ( String )request.getParameter( "keyword" );
  if ( keyword == null || keyword.lastIndexOf("請輸入") != -1 )
	  keyword = "";
  String qpunit = ( String )request.getParameter( "qpunit" );
  if ( qpunit == null )
	  qpunit = pubunitdn;
  String qclass = ( String )request.getParameter( "qclass" );   
  if ( qclass == null )
	  qclass = "";  

  FoodData query = new  FoodData();    
  ArrayList qlists = query.findByday(table,keyword,qpunit,qclass);    
  int rcount = query.getAllrecordCount();

  //計算總頁數
  int maxpage=0;
  
  //取餘數
  maxpage=rcount%pagesize;               
  if (maxpage==0)
     maxpage=rcount/pagesize;
  else
     maxpage=(rcount/pagesize)+1;

  //檔案上傳相關路徑(EX：downfile101.jsp位於pubhsinchu/downfile下，則傳參數pubhsinchu/downfile)
  String sysRoot = (String) getServletConfig().getServletContext().getRealPath("");
  sysRoot = sysRoot.replace('\\','/');
  String fullname = sysRoot + request.getRequestURI();
  String fullpath = fullname.substring(0,fullname.lastIndexOf("/"));
  //取得程式所在的資料夾(EX：downfile)
  String fileforder = fullpath.substring(fullpath.lastIndexOf("/")+1,fullpath.length());
  
  //取得程式所在的上一層資料夾(EX：pubhsinchu)
  String fullpath1 = fullpath.substring(0,fullpath.lastIndexOf("/"));  
  String fileforder1 = fullpath1.substring(fullpath1.lastIndexOf("/")+1,fullpath1.length());
  String path = "/" + fileforder1 + "/" + fileforder;

  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());
  
  String role = ( String )session.getAttribute("role");
  
%>


<body>
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="path" value="<%=path%>"/>
<input type="hidden" name="serno"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<div>
  <span class="T11b">發布單位</span>
  <jsp:include page="../../pubprogram/qunit.jsp">
      <jsp:param name="colname" value="qpunit"/>
      <jsp:param name="language" value="ch"/>
      <jsp:param name="datavalue" value="<%=qpunit%>"/>
      <jsp:param name="onchange" value="onchange=qryclass('qpunit')"/>
  </jsp:include>&nbsp;&nbsp;&nbsp;
  <span class="T11b">分類</span>
  <jsp:include page="../../pubprogram/qclass.jsp">
      <jsp:param name="formname" value="mform"/>
      <jsp:param name="tablename" value="FoodClass"/>
      <jsp:param name="colname" value="qclass"/>
      <jsp:param name="pcolname" value="qpunit"/>
      <jsp:param name="datavalue" value="<%=qclass%>"/>
  </jsp:include>&nbsp;&nbsp;&nbsp;
  
  <span class="T11b">標題</span>
  <input name="keyword" type="text" class="lInput01" size="15" value="<%=(keyword.equals("") ? "請輸入關鍵字" : keyword)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';">
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()">查   詢</a>&nbsp;
  <a class="md2" href="javascript:clean()">重   設</a>
</div>
<p>

<a class="md" href="javascript:add()">新   增</a>
<a class="md" href="javascript:del()">刪   除</a>
<%
  if ( role != null && !role.equals("null") && !role.equals("") ) {  %>
	  <a class="md" href="javascript:resetfsort('<%=table%>')">排序重整</a>
  <%}%>
   	  	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="35%" align="left">標題</th>
    <th width="10%">顯示</th>
    <th width="14%" align="left">發布單位</th>
    <th width="11%">更新日期</th>
    <th width="10%">文件檔案</th>
    <th width="10%">圖片檔案</th>
    <!-- <th width="10%">影音檔案</th> -->
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	FoodData qlist = ( FoodData )qlists.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center"><input type="checkbox" name="check" value=<%=qlist.getSerno()%>></td>
    	  <td align="left"><a href="javascript:mdy('<%=qlist.getSerno()%>')"><%=qlist.getSubject()%></a></td>
    	  <td align="left">
    	    <%
    	      if ( qlist.getStartusing().equals("1") )  {  %>
    	    	  <div align="center"><img src="../../img/publish_g.png" alt="發佈中" width="12" height="12" /></div>
    	      <%}else if ( qlist.getStartusing().equals("0") ) {
    	    	  String mclose = qlist.getClosedate();
    	    	  if ( Integer.parseInt(mclose) > Integer.parseInt(ndate) ) {  %>
    	    		  <div align="center"><img src="../../img/publish_g.png" alt="發佈中" width="12" height="12" /></div>
    	    	  <%}else{%>
    	    		  <div align="center"><img src="../../img/publish_r.png" alt="無發佈" width="12" height="12" /></div>
    	    	  <%}
    	      }%>
    	  </td>
    	  <td align="left"><%=qlist.getPubunitname()%></td>    	  
    	  <td align="center"><%=qlist.getUpdatedate().substring(0,4)%>.<%=qlist.getUpdatedate().substring(4,6)%>.<%=qlist.getUpdatedate().substring(6,8)%></td>
    	  <td align="center"><a href="javascript:file('<%=qlist.getSerno()%>','doc','FoodFile','<%=path%>','<%=language%>','<%=pagesize%>')"><img src="../../img/file.gif" alt="file" width="16" height="16" border="0" align="absmiddle" /></a></td>
    	  <td align="center"><a href="javascript:file('<%=qlist.getSerno()%>','pic','FoodFile','<%=path%>','<%=language%>','<%=pagesize%>')"><img src="../../img/Cmd_Save.gif" alt="attachments" width="16" height="16" border="0" align="absmiddle" /></a></td>
    	  <!-- <td align="center"><a href="javascript:file('<%=qlist.getSerno()%>','media','FoodFile','<%=path%>','<%=language%>','<%=pagesize%>')"><img src="../../img/media1.gif" alt="media" width="16" height="16" border="0" align="absmiddle" /></a></td> -->
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
            <jsp:param name="formname" value="mform"/>
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