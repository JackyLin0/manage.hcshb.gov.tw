<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperedit101.jsp
說明：電子報派送編輯
開發者：chmei
開發日期：97.03.16
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
  function add()
  {
    document.mform.action="epaperedit101_add.jsp";
    document.mform.method="post";
    document.mform.submit();
  }
  
  function qry()
  {
    document.mform.action="epaperedit101.jsp";
    document.mform.method="post";
    document.mform.submit();
  }  
  
  function mdy(serno)
  {
     document.mform.serno.value=serno;
     document.mform.action="epaperedit101_mdy.jsp";
     document.mform.method="post";
     document.mform.submit();
  } 
    
  function clean()
  {
      document.mform.sy.value = "";
      document.mform.sm.value = "";
      document.mform.ey.value = "";
      document.mform.em.value = "";
      document.mform.keyword.value = "請輸入關鍵字";
  }     
  
  function del()
  {
     x=window.confirm("確定執行整批刪除嗎?")
     if(x)
     {
        document.mform.action="epaperedit101_del.jsp";
        document.mform.method="post";
        document.mform.submit();
     } 
  }
  
  function file()
  {
     window.open('pic_list.jsp?language=chinese&pagesize=15','down','width=900,height=450,scrollbars=yes,left=90,top=90');
  }
  
  function preview(periodical)
  {
     window.open('epaperpreview.jsp?periodical='+periodical,'epaper','scrollbars=yes,resizable=yes,left=90,top=90');
  }
                 
</script>

<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
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
    
  String pubunitname = "";
  DepartmentTree qunit = new DepartmentTree();
  qunit.setUnitdn(pubunitdn);
  ArrayList<DSItem> qunits = qunit.getDepartment();
  if ( qunits != null && qunits.size() > 0 ) {
	  DSItem qunitname = ( DSItem )qunits.get(0);
	  pubunitname = qunitname.getChinesetitle();
  }
    
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  if ( keyword == null || keyword.lastIndexOf("請輸入") != -1 )
	  keyword = "";
  String sy = ( String )request.getParameter( "sy" );
  String sm = ( String )request.getParameter( "sm" );
  String sdate1 = "000000";
  if ( sy != null && !sy.equals("null") && !sy.equals("") && sm != null && !sm.equals("null") && !sm.equals("") )
	  sdate1 = sy + sm;
  String ey = ( String )request.getParameter( "ey" );
  String em = ( String )request.getParameter( "em" );
  
  String sdate2 = "999999";
  if ( ey != null && !ey.equals("null") && !ey.equals("") && em != null && !em.equals("null") && !em.equals("") )
	  sdate2 = ey + em;

  EpaperEditData query = new  EpaperEditData();    
  ArrayList qlists = query.findByday(keyword,sdate1,sdate2);  
  int rcount = query.getAllrecordCount();

  //計算總頁數
  int maxpage=0;
  
  //取餘數
  maxpage=rcount%pagesize;               
  if (maxpage==0)
     maxpage=rcount/pagesize;
  else
     maxpage=(rcount/pagesize)+1;

  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyy");
  int sndate = Integer.parseInt(fmt.format(Calendar.getInstance().getTime()));
  
%>


<body>
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
<input type="hidden" name="pubunitname" value="<%=pubunitname%>"/>
<input type="hidden" name="serno"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<div>
  <span class="T11b">期刊別</span>　 (起)
  <select name="sy">
     <option value="">---請選擇---</option>
     <%
       for ( int i=sndate; i>=2004; i-- ) { 
    	   String isSelected = "";
    	   if ( sy != null && !sy.equals("null") && !sy.equals("") ) {
    		   if ( i == Integer.parseInt(sy) )
        		   isSelected = "selected";
    	   } %>
    	   <option value=<%=i%> <%=isSelected%>><%=i%></option>
       <%}%>
  </select>&nbsp;年&nbsp;
  <select name="sm">
     <option value="">---請選擇---</option>
     <%
       for ( int j=1; j<=12; j++ ) {
    	   String isSelected = "";
    	   if ( sm != null && !sm.equals("null") && !sm.equals("") ) {
    		   if ( j == Integer.parseInt(sm) )
        		   isSelected = "selected";
    	   } %>
    	   <option value=<%=SvNumber.format( j, "00" )%> <%=isSelected%>><%=SvNumber.format( j, "00" )%></option>
       <%}%>
  </select>&nbsp;月&nbsp;　 (迄)
  <select name="ey">
     <option value="">---請選擇---</option>
     <%
       for ( int k=sndate; k>=2004; k-- ) { 
    	   String isSelected = "";
    	   if ( ey != null && !ey.equals("null") && !ey.equals("") ) {
    		   if ( k == Integer.parseInt(ey) )
        		   isSelected = "selected";
    	   } %>
    	   <option value=<%=k%> <%=isSelected%>><%=k%></option>
       <%}%>
  </select>&nbsp;年&nbsp;
  <select name="em">
     <option value="">---請選擇---</option>
     <%
       for ( int m=1; m<=12; m++ ) {
    	   String isSelected = "";
    	   if ( em != null && !em.equals("null") && !em.equals("") ) {
    		   if ( m == Integer.parseInt(em) )
        		   isSelected = "selected";
    	   } %>
    	   <option value=<%=SvNumber.format( m, "00" )%> <%=isSelected%>><%=SvNumber.format( m, "00" )%></option>
       <%}%>
  </select>&nbsp;月&nbsp;
  <br>
  <span class="T11b">標題</span>
  <input name="keyword" type="text" class="lInput01" size="25" value="<%=(keyword.equals("") ? "請輸入關鍵字" : keyword)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';">    
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()">查   詢</a>&nbsp;
  <a class="md2" href="javascript:clean()">重   設</a>
</div>
<p>

<a class="md" href="javascript:add()">新   增</a>
<a class="md" href="javascript:del()">刪   除</a>
<a class="md" href="javascript:file()">上傳圖片</a>
   	  	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="40%" align="left">標題</th>
    <th width="13%">期刊別</th>
    <th width="13%">派送日期</th>
    <th width="13%">狀態</th>
    <th width="13%">電子報預覽</th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	EpaperEditData qlist = ( EpaperEditData )qlists.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center"><input type="checkbox" name="check" value=<%=qlist.getSerno()%>></td>
    	  <td align="left">
    	    <%
    	      if ( qlist.getFlag().equals("未派送") ) { %>
    	    	  <a href="javascript:mdy('<%=qlist.getSerno()%>')"><%=qlist.getSubject()%></a>
    	      <%}else{%>
    	    	  <%=qlist.getSubject()%>
    	      <%}%>
    	  </td>
    	  <td align="center"><%=qlist.getPeriodical().substring(0,4)%>.<%=qlist.getPeriodical().substring(4,6)%></td>
    	  <%
    	    String mflag = "未編輯完成";
    	    String msenddate = "";
    	    if ( qlist.getSenddate() != null && !qlist.getSenddate().equals("null") && !qlist.getSenddate().equals("") ) {
    	    	msenddate = qlist.getSenddate().substring(0,4) + "." + qlist.getSenddate().substring(4,6) + "." + qlist.getSenddate().substring(6,8);
    	    	mflag = qlist.getFlag();
    	    }%>
    	  <td align="center"><%=msenddate%></td>
    	  <td align="center"><%=mflag%></td>
    	  <td align="center"><a href="javascript:preview('<%=qlist.getPeriodical()%>')"><img src="../../img/Find.gif" alt="電子報預覽" width="16" height="16" border="0" align="absmiddle" /></a></td>
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