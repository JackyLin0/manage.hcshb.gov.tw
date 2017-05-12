<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：prize101.jsp
說明：產生中獎名單
開發者：chmei
開發日期：97.12.14
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
  function qry()
  {
    document.mform.action="prize101.jsp";
    document.mform.method="post";
    document.mform.submit();
  }  
      
  function prize(serno)
  {
     document.mform.serno.value=serno;
     document.mform.action="prize101_prize.jsp";
     document.mform.method="post";
     document.mform.submit();
  } 
      
  function view(serno)
  {
     document.mform.serno.value=serno;
     document.mform.action="prize101_view.jsp";
     document.mform.method="post";
     document.mform.submit();
  } 
    
  function clean()
  {
      document.mform.qpunit.value = "";
      document.mform.keyword.value = "請輸入關鍵字";
      document.mform.qptdate.value = "";
      document.mform.qdldate.value = "";
      document.mform.pview.value = "";
      document.mform.dview.value = "";
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
  
  //接收查詢條件
  //關鍵字尋找標題、副標題、內容三個欄位
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
  
  QuestionData query = new  QuestionData();    
  ArrayList qlists = query.findByday(table,keyword,qpunit,sdate1,sdate2);    
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
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
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
  </jsp:include>&nbsp;&nbsp;&nbsp;
  <span class="T11b">標題</span>
  <input name="keyword" type="text" class="lInput01" size="15" value="<%=(keyword.equals("") ? "請輸入關鍵字" : keyword)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';">
  <br><span class="T11b">發布日期</span>
  <jsp:include page="../../pubprogram/bdate.jsp" >
      <jsp:param name="sdatevalue" value="<%=qptdate%>" />
      <jsp:param name="edatevalue" value="<%=qdldate%>" />
  </jsp:include>
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()">查   詢</a>&nbsp;
  <a class="md2" href="javascript:clean()">重   設</a>
</div>
<p>

<div >
  <h2>僅有需填寫基本資料之問卷才可產生名單</h2>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="35%" align="left">標題</th>
    <th width="20%">填卷總人數</th>
    <th width="20%" align="left">&nbsp;</th>
    <th width="20%">&nbsp;</th>
  </tr>
  <%
    if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	intpage = Integer.parseInt(request.getParameter("page"));
    }
  
    int startpage=(intpage-1)*pagesize+1;
    int endpage=startpage+pagesize-1;    
    
    for ( int i=(startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	QuestionData qlist = ( QuestionData )qlists.get( i ); %>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <td align="center"><%=i+1%></td>
    	  <td align="center">&nbsp;</td>
    	  <td align="left"><%=qlist.getSubject()%></td>
    	  <td align="left">
    	    <%
    	      //查詢填卷總人數
    	      QuestionData qnum = new QuestionData();
    	      ArrayList qnums = qnum.findBynum(qlist.getSerno());
    	      int numrcount = 0;
    	      if ( qnums != null )
    	    	  numrcount = qnum.getAllrecordCount(); %>
    	      <div align="center"><%=numrcount%>&nbsp;&nbsp;人</div>
    	  </td>
    	  <%
    	    //查詢是否已產生名單
    	    QuestionData qdata = new QuestionData();
    	    ArrayList qprizes = qdata.findByprize(qlist.getSerno());
    	    if ( qprizes != null ) { %>
    	    	<td align="center"><a class="md" href="javascript:view('<%=qlist.getSerno()%>')">查看名單</a></td> 
    	    	<td align="center"><a class="md" href="javascript:prize('<%=qlist.getSerno()%>')">重新產生名單</a></td>
    	    <%}else{%>
    	    	<td align="center">&nbsp;</td>
    	    	<td align="center"><a class="md" href="javascript:prize('<%=qlist.getSerno()%>')">產生名單</a></td>
    	    <%}%>
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