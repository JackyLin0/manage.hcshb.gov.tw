<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：quote101_qry.jsp
說明：資料引用主網話說健康
開發者：chmei
開發日期：97.03.01
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
     document.mform.action="quote101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function qry()
  {
     document.mform.action="quote101_qry.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function mdy()
  {
     document.mform.action="quote101_mdysave.jsp";
     document.mform.method="post";
     document.mform.submit();
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
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );

  if ( intpage1 == null || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);
  
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  if ( keyword == null || keyword.lastIndexOf("請輸入") != -1 )
	  keyword = "";
  
  String qmserno = ( String )request.getParameter( "classdata" );   
  if ( qmserno == null )
	  qmserno = "";  
  
  //尋找電子報類別
  ClassData qmclass = new ClassData();
  ArrayList qclasss = qmclass.findByday("EpaperClass");
  int crcount = qmclass.getAllrecordCount();
  
  //尋找已被引用話說健康資料
  EpaperData query = new EpaperData();
  query.setTablename("TalkHealth");
  ArrayList qlists = query.findBtalk(keyword,qmserno);
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

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="intpage" value="<%=intpage%>"/>
<input type="hidden" name="language" value="<%=language%>"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>引用話說健康資料</h2>
</div>

<div>
  <span class="T11b">分類</span>
  <%
    if ( qclasss != null ) { %>
    	<select name="classdata">
    	   <option value="">--- 請選擇 ---</option>
    	   <%
    	     String[] ary_qmserno = null;
    	     if ( !qmserno.equals("") )
    	    	 ary_qmserno = SvString.split(qmserno,"||");
    	     for ( int c=0; c<crcount; c++ ) {
    	    	 ClassData qclass = ( ClassData )qclasss.get( c );
    	    	 String isSelected = "";
    	    	 if ( ary_qmserno != null && !ary_qmserno.equals("null") ) {
    	    		 if ( qclass.getSerno().equals(ary_qmserno[0]) )
    	    			 isSelected = "selected";
    	    	 }
    	    	 String datavalue = qclass.getSerno() + "||" + qclass.getClassname(); %>
    	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qclass.getClassname()%></option>
    	     <%}%>
    	</select>
    <%}%>&nbsp;&nbsp;&nbsp;
  <span class="T11b">標題</span>
  <input name="keyword" type="text" class="lInput01" size="15" value="<%=(keyword.equals("") ? "請輸入關鍵字" : keyword)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';">    
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()">查   詢</a>
  <a class="md2" href="javascript:clean()">重   設</a>  
</div>
<p>

<a class="md" href="javascript:mdy()">儲   存</a>
<a class="md" href="javascript:back()">回上頁</a>
   	  	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="15%">取消引用</th>
    <th width="20%" align="left">電子報分類名稱</th>
    <th width="60%" align="left">標題</th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	EpaperData qlist = ( EpaperData )qlists.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center"><input type="checkbox" name="check" value=<%=qlist.getSerno()%>></td>
    	  <td align="left"><%=qlist.getMclassname()%></td>
    	  <td align="left"><a href="javascript:mdy('<%=qlist.getSerno()%>')" title="<%=qlist.getContent()%>"><%=qlist.getSubject()%></a></td>    	  
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