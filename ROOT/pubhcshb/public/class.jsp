<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：class.jsp
說明：分類程式(適用單站台)
開發者：chmei
開發日期：97.02.16
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function add()
  {
    document.classform.action="class_add.jsp";
    document.classform.method="post";
    document.classform.submit();
  }
  
  function qry()
  {
    document.classform.action="class.jsp";
    document.classform.method="post";
    document.classform.submit();
  }  
  
  function mdy(serno)
  {
     document.classform.serno.value=serno;
     document.classform.action="class_mdy.jsp";
     document.classform.method="post";
     document.classform.submit();
  } 
    
  function clean()
  {
     document.classform.qwebsite.value = "";
     document.classform.qclassname.value = "請輸入關鍵字";
  }     
  
  function del()
  {
     x=window.confirm("確定執行整批刪除嗎?")
     if(x)
     {
        document.classform.action="class_del.jsp?type=0";
        document.classform.method="post";
        document.classform.submit();
     } 
  }        
</script>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );

  if ( intpage1 == null || intpage1.equals("null") || intpage1.equals("") )
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
  
  //單位DN與站台DN對照
  WebsiteUnitData qweb = new WebsiteUnitData();    
  boolean webrtn = qweb.load(pubunitdn);
  String website = "";
  if ( webrtn )
	  website = qweb.getWebsitedn();

  //接收查詢條件
  String qclassname = ( String )request.getParameter( "qclassname" );
  if ( qclassname == null || qclassname.lastIndexOf("請輸入") != -1 )
	  qclassname = "";
  String qwebsite = ( String )request.getParameter( "qwebsite" );  
  if ( qwebsite == null )
	  qwebsite = website;

  WebClassData query = new WebClassData();
  ArrayList<Object> qlists = query.findByday(table,qwebsite,qclassname);
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
<form name="classform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="intpage" value="<%=intpage%>"/>
<input type="hidden" name="serno"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<div ><span class="T11b"><%=lang.getClassname()%>&nbsp;</span>
 <input name="qclassname" type="text" class="lInput01" size="20" value="<%=(qclassname.equals("") ? "請輸入關鍵字" : qclassname)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';" />
  &nbsp;&nbsp;
 <span class="T11b"><%=lang.getWebsitename()%></span>
 <jsp:include page="../../pubprogram/website/qwebsite.jsp">
     <jsp:param name="colname" value="qwebsite"/>
     <jsp:param name="language" value="ch"/>
     <jsp:param name="datavalue" value="<%=qwebsite%>"/>
 </jsp:include>
 &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()"><%=lang.getQry()%></a> <a class="md2" href="javascript:clean()"><%=lang.getReset()%></a>
</div>
<p></p>

<a class="md" href="javascript:add()"><%=lang.getAdd()%></a>
<a class="md" href="javascript:del()"><%=lang.getDel()%></a>
   	  	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="32%" align="left"><%=lang.getClassname()%></th>
    <th width="22%"><%=lang.getWebsitename()%></th>
    <th width="20%"><%=lang.getPubunitname()%></th>
    <th width="16%"><%=lang.getUpdatedate()%></th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }

    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	WebClassData qlist = ( WebClassData )qlists.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center"><input type="checkbox" name="check" value="<%=qlist.getSerno()%>" /></td>
    	  <td align="left"><a href="javascript:mdy('<%=qlist.getSerno()%>')"><%=qlist.getClassname()%></a></td>
    	  <td align="center"><%=qlist.getWebsitename()%></td>
    	  <td align="center"><%=qlist.pubunitname%></td>
    	  <td align="center"><%=qlist.getUpdatedate().substring(0,4)%>.<%=qlist.getUpdatedate().substring(4,6)%>.<%=qlist.getUpdatedate().substring(6,8)%></td>
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
            <jsp:param name="formname" value="classform"/>
        </jsp:include>
      </th>
    </tr>  
  
</table>

<p></p>
 <a class="md" href="#top">回頁首</a>
 
<div id="page"><span class="T8-5">頁數:</span> <span class="T8-5c"> <%=intpage%> / <%=maxpage%> </span><span class="T8-5">； 資料每頁以15筆展現；共有</span><span class="T8-5c"> <%=rcount%> </span> <span class="T8-5">筆資料</span></div>

</form>
</body>
</html>