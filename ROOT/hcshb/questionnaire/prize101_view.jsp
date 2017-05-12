<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：prize101_view.jsp
說明：中獎名單查詢
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
     document.mform.action="prize101.jsp";
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
  
  //查詢該問卷資料
  QuestionnaireData qdata = new QuestionnaireData();
  boolean rtn = qdata.load(serno,table);
  String msubject = "";
  String mbasicfield = "";
  if ( rtn ) {
	  msubject = qdata.getSubject();
	  mbasicfield = qdata.getBasicfield();
  }

  String[] ary_basic = null;
  if ( !mbasicfield.equals("") ) {
	  ary_basic = SvString.split(mbasicfield,"||");
  }
  
  //查詢中獎名單
  QuestionData query = new  QuestionData();    
  ArrayList qlists = query.findByprize(serno);
  int rcount = query.getAllrecordCount();

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

<p>
<a class="md" href="javascript:back()">回上頁</a>

<div>
  <h2>標　題：<%=msubject%></h2>
</div>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <%
      if ( SvString.contain(ary_basic,"1") ) { %>
    	  <th>姓名</th>
      <%}
      if ( SvString.contain(ary_basic,"2") ) { %>
    	  <th>身份證字號</th>
      <%}
      if ( SvString.contain(ary_basic,"3") ) { %>
    	  <th>性別</th>
      <%}
      if ( SvString.contain(ary_basic,"4") ) { %>
    	  <th>E-MAIL</th>
      <%}
      if ( SvString.contain(ary_basic,"5") ) { %>
    	  <th>住址</th>
      <%}
      if ( SvString.contain(ary_basic,"6") ) { %>
    	  <th>電話</th>
      <%}
      if ( SvString.contain(ary_basic,"7") ) { %>
    	  <th>學歷</th>
      <%}
      if ( SvString.contain(ary_basic,"8") ) { %>
    	  <th>年齡</th>
      <%}
      if ( SvString.contain(ary_basic,"9") ) { %>
    	  <th>職業</th>
      <%}%>
  </tr>
  <%
    for ( int i=0; i<rcount; i++ )  {
    	QuestionData qlist = ( QuestionData )qlists.get( i );
    	QuestionData qbasic = new QuestionData();
    	boolean brtn = qbasic.load(qlist.getSerno(),qlist.getDetailno());  %>    	
    	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	  <%
    	    if ( brtn ) {
    	    	if ( SvString.contain(ary_basic,"1") ) { %>
    	    		<td align="center"><%=qbasic.getName()%></td>
    	    	<%}
    	    	if ( SvString.contain(ary_basic,"2") ) { %>
    	    		<td align="center"><%=qbasic.getPid()%></td>
    	    	<%}
    	    	if ( SvString.contain(ary_basic,"3") ) { %>
    	    		<td align="center"><%=qbasic.getSex()%></td>
    	    	<%}
    	    	if ( SvString.contain(ary_basic,"4") ) { %>
    	    		<td align="center"><%=qbasic.getEmail()%></td>
    	    	<%}
    	    	if ( SvString.contain(ary_basic,"5") ) { %>
    	    		<td align="center"><%=qbasic.getArea()%>&nbsp;<%=qbasic.getCityname()%><%=qbasic.getTownsname()%><%=qbasic.getAddress()%></td>
    	    	<%}
    	    	if ( SvString.contain(ary_basic,"6") ) { %>
    	    		<td align="center"><%=qbasic.getTel()%></td>
    	    	<%}
    	    	if ( SvString.contain(ary_basic,"7") ) {
    	    		String degree = "";
    	    		if ( qbasic.getDegree().trim().equals("1") )
    	    			degree = "國小";
    	    		else if ( qbasic.getDegree().trim().equals("2") )
    	    			degree = "國中";
    	    		else if ( qbasic.getDegree().trim().equals("3") )
    	    			degree = "高中職";
    	    		else if ( qbasic.getDegree().trim().equals("4") )
    	    			degree = "專科";
    	    		else if ( qbasic.getDegree().trim().equals("5") )
    	    			degree = "大學";
    	    		else if ( qbasic.getDegree().trim().equals("6") )
    	    			degree = "碩士";
    	    		else if ( qbasic.getDegree().trim().equals("7") )
    	    			degree = "博士";
    	    		else if ( qbasic.getDegree().trim().equals("8") )
    	    			degree = "其他"; %>
    	    		<td align="center"><%=degree%></td>
    	    	<%}
    	    	if ( SvString.contain(ary_basic,"8") ) {
    	    		String age = "";
    	    		if ( qbasic.getAge().trim().equals("1") )
    	    			age = "10歲以下";
    	    		else if ( qbasic.getAge().trim().equals("2") )
    	    			age = "11-20歲";
    	    		else if ( qbasic.getAge().trim().equals("3") )
    	    			age = "21-30歲";
    	    		else if ( qbasic.getAge().trim().equals("4") )
    	    			age = "31-40歲";
    	    		else if ( qbasic.getAge().trim().equals("5") )
    	    			age = "41-50歲";
    	    		else if ( qbasic.getAge().trim().equals("6") )
    	    			age = "51-60歲";
    	    		else if ( qbasic.getAge().trim().equals("7") )
    	    			age = "61-70歲";
    	    		else if ( qbasic.getAge().trim().equals("8") )
    	    			age = "71-80歲"; 
    	    		else if ( qbasic.getAge().trim().equals("9") )
    	    			age = "81-90歲"; 
    	    		else if ( qbasic.getAge().trim().equals("10") )
    	    			age = "91-100歲"; 
    	    		else if ( qbasic.getAge().trim().equals("11") )
    	    			age = "100歲以上"; %>
    	    		<td align="center"><%=age%></td>
    	    	<%}
    	    	if ( SvString.contain(ary_basic,"9") ) {
    	    		String job = "";
    	    		if ( qbasic.getJob().trim().equals("1") )
    	    			job = "自由業";
    	    		else if ( qbasic.getJob().trim().equals("2") )
    	    			job = "行銷廣告";
    	    		else if ( qbasic.getJob().trim().equals("3") )
    	    			job = "藝術";
    	    		else if ( qbasic.getJob().trim().equals("4") )
    	    			job = "設計";
    	    		else if ( qbasic.getJob().trim().equals("5") )
    	    			job = "政府機關";
    	    		else if ( qbasic.getJob().trim().equals("6") )
    	    			job = "軍警";
    	    		else if ( qbasic.getJob().trim().equals("7") )
    	    			job = "礦業及土石採取業";
    	    		else if ( qbasic.getJob().trim().equals("8") )
    	    			job = "醫療保健及環境衛生業"; 
    	    		else if ( qbasic.getJob().trim().equals("9") )
    	    			job = "建築營造及不動產相關業"; 
    	    		else if ( qbasic.getJob().trim().equals("10") )
    	    			job = "法律／會計／顧問／研發業"; 
    	    		else if ( qbasic.getJob().trim().equals("11") )
    	    			job = "金融投顧及保險業歲"; 
    	    		else if ( qbasic.getJob().trim().equals("12") )
    	    			job = "政治宗教及社福相關業"; 
    	    		else if ( qbasic.getJob().trim().equals("13") )
    	    			job = "運輸物流及倉儲"; 
    	    		else if ( qbasic.getJob().trim().equals("14") )
    	    			job = "農林漁牧水電資源業"; 
    	    		else if ( qbasic.getJob().trim().equals("15") )
    	    			job = "一般製造業"; 
    	    		else if ( qbasic.getJob().trim().equals("16") )
    	    			job = "電子資訊／軟體／半導體相關業"; 
    	    		else if ( qbasic.getJob().trim().equals("17") )
    	    			job = "一般服務業"; 
    	    		else if ( qbasic.getJob().trim().equals("18") )
    	    			job = "旅遊／休閒／運動業"; 
    	    		else if ( qbasic.getJob().trim().equals("19") )
    	    			job = "大眾傳播相關產業"; 
    	    		else if ( qbasic.getJob().trim().equals("20") )
    	    			job = "文教相關業"; 
    	    		else if ( qbasic.getJob().trim().equals("21") )
    	    			job = "其他"; %>
    	    		<td align="center"><%=job%></td>
    	    	<%}
    	    }%>
    	</tr> 
    	
    <%}%>

</table>

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>