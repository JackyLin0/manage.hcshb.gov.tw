<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：result101_list.jsp
說明：問卷調查結果查詢
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
  function back()
  {
     document.mform.action="result101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function view(serno,detailno)
  {
    document.mform.serno.value = serno;
    document.mform.detailno.value = detailno;
    document.mform.action="result101_view.jsp";
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

  String serno = ( String )request.getParameter( "serno" );
  
  //尋找填寫該問卷資料
  QuestionData query = new  QuestionData();    
  ArrayList qlists = query.findBynum(serno);    
  int rcount = query.getAllrecordCount();

  //尋找問卷標題
  QuestionnaireData qdata = new QuestionnaireData();
  boolean drtn = qdata.load(serno,table);
  String msubject = "";
  if ( drtn )
	  msubject = qdata.getSubject();
  
  //尋找該問卷題目總數
  QuestionData question = new  QuestionData(); 
  ArrayList qtots = question.findByday(serno);
  int trcount = 0;
  if ( qtots != null )
	  trcount = question.getAllrecordCount();
  
%>


<body>
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="intpage" value="<%=intpage%>"/>
<input type="hidden" name="serno"/>
<input type="hidden" name="detailno"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<p>
<a class="md" href="javascript:back()">回上頁</a>

<div>
  <h2>問卷標題：<%=msubject%></h2>
  <h2>題目總數：共&nbsp;<%=trcount%>&nbsp;題</h2>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="10%">&nbsp;</th>
    <th width="10%">序號</th>
    <th width="30%">姓　名</th>
    <th width="20%">答對題數</th>
    <th width="20%">填卷日期</th>
  </tr>
  <%
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) {
    		QuestionData qlist = ( QuestionData )qlists.get( i ); 
    		QuestionData qname = new QuestionData();
    		boolean rtn = qname.load(serno,qlist.getDetailno());  
    		String name = "";
    		String respond = "";
    		if ( rtn ) {
    			name = qname.getName();
    			respond = qname.getRespond() + "題";
    		} %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td align="center">&nbsp;</td>
    		  <td align="center"><a href="javascript:view('<%=serno%>','<%=qlist.getDetailno()%>')"><%=qlist.getDetailno()%></a></td>
    		  <td align="center"><%=name%></td>
    		  <td align="center"><%=respond%></td>
    		  <td align="center"><%=qlist.getCreatedate().substring(0,4)%>.<%=qlist.getCreatedate().substring(4,6)%>.<%=qlist.getCreatedate().substring(6,8)%></td>
    		</tr>  
    	<%}
    }else{%>
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
		  <td align="center" colspan="4">目前無人填寫問卷</td>
		</tr>
    <%}%>
</table>

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>