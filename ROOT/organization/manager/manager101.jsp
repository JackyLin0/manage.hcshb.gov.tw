<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manager101.jsp
說明：主管簡介
開發者：chmei
開發日期：97.02.21
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
    document.mform.action="manager101_add.jsp";
    document.mform.method="post";
    document.mform.submit();
  }
  
  function qry()
  {
    document.mform.action="manager101.jsp";
    document.mform.method="post";
    document.mform.submit();
  }  
  
  function mdy(serno)
  {
     document.mform.serno.value=serno;
     document.mform.action="manager101_mdy.jsp";
     document.mform.method="post";
     document.mform.submit();
  } 
    
  function clean()
  {
      document.mform.qpunit.value = "";   
      document.mform.name.value = "請輸入關鍵字";
  }     
  
  function del()
  {
     x=window.confirm("確定執行整批刪除嗎?")
     if(x)
     {
        document.mform.action="manager101_del.jsp?type=0";
        document.mform.method="post";
        document.mform.submit();
     } 
  } 

</script>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //檔案上傳相關路徑(EX：downfile101.jsp位於pubhsinchu/downfile下，則傳參數pubhsinchu/downfile)
  String sysRoot1 = (String) getServletConfig().getServletContext().getRealPath("");
  sysRoot1 = sysRoot1.replace('\\','/');
  String fullname = sysRoot1 + request.getRequestURI();
  String fullpath = fullname.substring(0,fullname.lastIndexOf("/"));
  //取得程式所在的資料夾(EX：downfile)
  String fileforder = fullpath.substring(fullpath.lastIndexOf("/")+1,fullpath.length());
  
  //取得程式所在的上一層資料夾(EX：pubhsinchu)
  String fullpath1 = fullpath.substring(0,fullpath.lastIndexOf("/"));  
  String fileforder1 = fullpath1.substring(fullpath1.lastIndexOf("/")+1,fullpath1.length());
  String path = "/" + fileforder1 + "/" + fileforder;
  
  session.setAttribute("path",path);

  String language = ( String )request.getParameter( "language" );
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );

  if ( intpage1 == null || intpage1.equals("null") || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);
  
  String pubunitdn = ( String )request.getParameter("pubunitdn");
  
  //接收查詢條件
  //關鍵字尋找標題、副標題、內容三個欄位
  String name = ( String )request.getParameter( "name" );
  if ( name == null || name.lastIndexOf("請輸入") != -1 )
	  name = "";
  String qpunit = ( String )request.getParameter( "qpunit" );
  if ( qpunit == null )
	  qpunit = pubunitdn;

  ManagerData query = new ManagerData();  
  ArrayList qlists = query.findByday(name,qpunit);
  int rcount = query.getAllrecordCount();

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


<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
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
  </jsp:include>&nbsp;
  <span class="T11b">姓名</span>
  <input name="name" type="text" class="lInput01" size="15" value="<%=(name.equals("") ? "請輸入關鍵字" : name)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';">  
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
    <th width="15%" align="left">姓名</th>
    <th width="10%">顯示</th>
    <th width="20%" align="left">職稱</th>
    <th width="10%">排序</th>
    <th width="15%">現任</th>
    <th width="20%">更新日期</th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	ManagerData qlist = ( ManagerData )qlists.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center"><input type="checkbox" name="check" value=<%=qlist.getSerno()%>></td>
    	  <td align="left"><a href="javascript:mdy('<%=qlist.getSerno()%>')"><%=qlist.getName()%></a></td>
    	  <td align="center">
    	    <%
    	    if ( qlist.getIscurrent().equals("1") )  {  %>
    	    	<div align="center"><img src="../../img/publish_g.png" alt="發佈中" width="12" height="12" /></div>
    	    <%}else if ( qlist.getIscurrent().equals("0") ) {%>
    	    	<div align="center"><img src="../../img/publish_r.png" alt="無發佈" width="12" height="12" /></div>
    	    <%}%>
    	  </td>
    	  <td align="left"><%=qlist.getProftitle()%></td>
    	  <td align="center"><%=qlist.getFsort()%></td>
    	  <%
    	    String iscurrent = "";
    	    if ( qlist.getIscurrent().equals("1") )
    	    	iscurrent = "是";
    	    else
    	    	iscurrent = "否";
    	  %>
    	  <td align="center"><%=iscurrent%></td>
    	  <td align="center"><%=qlist.getUpdatedate().substring(0,4)%>.<%=qlist.getUpdatedate().substring(4,6)%>.<%=qlist.getUpdatedate().substring(6,8)%></td>    	  
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

<div id="page"><span class="T8-5">頁數:</span> <span class="T8-5c"> <%=intpage%> / <%=maxpage%> </span><span class="T8-5">； 資料每頁以15筆展現；共有</span><span class="T8-5c"> <%=rcount%> </span> <span class="T8-5">筆資料</span></div>

</form>
</body>
</html>