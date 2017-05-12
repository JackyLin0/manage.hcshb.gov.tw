<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities102.jsp
說明：線上報名表欄位編輯
開發者：chmei
開發日期：97.12.03
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
    document.mform.target="mainFrame";
    document.mform.action="activities102_add.jsp";
    document.mform.method="post";
    document.mform.submit();
  }
  
  function qry()
  {
    document.mform.target="mainFrame";
    document.mform.action="activities102.jsp";
    document.mform.method="post";
    document.mform.submit();
  }  
  
  function mdy(serno)
  {
     document.mform.target="mainFrame";
     document.mform.serno.value=serno;
     document.mform.action="activities102_mdy.jsp";
     document.mform.method="post";
     document.mform.submit();
  } 
    
  function view(serno)
  {
     document.mform.serno.value=serno;
     document.mform.action="activities102_view.jsp";
     document.mform.target="_blank";
     document.mform.method="post";
     document.mform.submit();
  } 
      
  function clean()
  {     
      document.mform.keyword.value = "請輸入關鍵字";
      document.mform.qptdate.value = "";
      document.mform.qdldate.value = "";
      document.mform.pview.value = "";
      document.mform.dview.value = "";
  }     
  
  function del()
  {
     x=window.confirm("確定執行整批刪除嗎?")
     if(x)
     {
        document.mform.target="mainFrame";
        document.mform.action="activities102_del.jsp?type=0";
        document.mform.method="post";
        document.mform.submit();
     } 
  } 
 
</script>

<%@ page import="java.util.*"%> 
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
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
  //關鍵字尋找活動訊息標題
  String keyword = ( String )request.getParameter( "keyword" );
  if ( keyword == null || keyword.lastIndexOf("請輸入") != -1 )
	  keyword = "";
  String qpunit = ( String )request.getParameter( "qpunit" );
  if ( qpunit == null )
	  qpunit = pubunitdn;
  
  String qptdate = ( String )request.getParameter( "qptdate" );
  String sdate1 = qptdate;
  if ( qptdate == null || qptdate.equals("") )
  {	  
	  qptdate = "";
	  sdate1 = "00000000";
  }	  
  String qdldate = ( String )request.getParameter( "qdldate" ); 
  String sdate2 = qdldate;
  if ( qdldate == null || qdldate.equals("") )
  {
	  qdldate = "";
	  sdate2 = "99999999";
  }    
  
  ActivityColumnData query = new ActivityColumnData();
  ArrayList qlists = query.findByday(keyword,qpunit,sdate1,sdate2);  
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

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="intpage" value="<%=intpage%>"/>
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
  </jsp:include>&nbsp;&nbsp;
  <span class="T11b">活動訊息標題</span>
  <input name="keyword" type="text" class="lInput01" size="15" value="<%=(keyword.equals("") ? "請輸入關鍵字" : keyword)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';">
  <br><span class="T11b">發布日期</span>
  <jsp:include page="../../pubprogram/bdate.jsp" >
      <jsp:param name="sdatevalue" value="<%=qptdate%>" />
      <jsp:param name="edatevalue" value="<%=qdldate%>" />
  </jsp:include>  
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()"><%=lang.getQry()%></a>&nbsp;
  <a class="md2" href="javascript:clean()"><%=lang.getReset()%></a>
</div>
<p>

<a class="md" href="javascript:add()">新增</a>
<a class="md" href="javascript:del()">刪除</a>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="3%">&nbsp;</th>
    <th width="4%">&nbsp;</th>
    <th width="35%" align="left">活動訊息標題</th>
    <th width="14%" align="left">發布單位</th>
    <th width="10%">預覽</th>
    <th width="10%">名額</th>
    <th width="12%">報名人數</th>
    <th width="12%">更新日期</th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	ActivityColumnData qlist = ( ActivityColumnData )qlists.get( i );
    	//是否已有人報名
    	String mdisable = "";
    	if ( qlist.getSignupnum() > 0 )
    		mdisable = "disabled"; %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center"><input type="checkbox" name="check" value=<%=qlist.getSerno()%> <%=mdisable%>></td>
    	  <td align="left">
    	    <%
    	      if ( mdisable.equals("disabled") ) {
    	    	  out.println(qlist.getSubject());
    	      }else{%>
    	    	  <a href="javascript:mdy('<%=qlist.getSerno()%>')"><%=qlist.getSubject()%></a>
    	      <%}%>
    	  </td>
    	  <td align="left"><%=qlist.getPubunitname()%></td>
    	  <td align="center"><a href="javascript:view('<%=qlist.getSerno()%>')"><img src="../../img/b_search.png" alt="預覽" width="16" height="16" border="0" align="absmiddle" /></a></td>
    	  <td align="center"><%=qlist.getLimitnum()%></td>
    	  <td align="center"><%=qlist.getSignupnum()%></td>
    	  <%
    	    String mupdate = "";
    	    if ( qlist.getUpdatedate() != null && !qlist.getUpdatedate().equals("null") )
    	    	mupdate = qlist.getUpdatedate().substring(0,4) + "." + qlist.getUpdatedate().substring(4,6) + "." + qlist.getUpdatedate().substring(6,8);
    	  %>
    	  <td align="center"><%=mupdate%></td>
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
