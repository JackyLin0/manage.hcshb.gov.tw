<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：result101_view.jsp
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
     document.mform.action="result101_list.jsp";
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
  String detailno = ( String )request.getParameter( "detailno" );
  
  //尋找基本資料
  QuestionData qdata = new QuestionData();
  boolean rtn = qdata.load(serno,Integer.parseInt(detailno));
  
  //尋找題目
  QuestionData query = new  QuestionData(); 
  ArrayList qlists = query.findByday(serno);
  int rcount = query.getAllrecordCount();

%>


<body>
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="intpage" value="<%=intpage%>"/>
<input type="hidden" name="serno" value="<%=serno%>"/>
<input type="hidden" name="detailno" value="<%=detailno%>"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<p>
<a class="md" href="javascript:back()">回上頁</a>

<%
  if ( rtn ) { %>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
	    <tr class="tr">
	      <th colspan="4">填卷者基本資料</th>
	    </tr>
	    <%
	      if ( qdata.getName() != null && !qdata.getName().equals("null") && !qdata.getName().equals("") ) { %>
	    	  <tr class="tr">
	    	    <td class="T12b" width="23%">姓名</td>
	    	    <td colspan="3"><%=qdata.getName()%></td>
	    	  </tr>
	      <%}
	      if ( qdata.getPid() != null && !qdata.getPid().equals("null") && !qdata.getPid().equals("") ) { %>
	    	  <tr>
	    	    <td class="T12b" width="23%">身份證字號</td>
	    	    <td colspan="3"><%=qdata.getPid()%></td>
	    	  </tr>	    	  
	      <%}
	      if ( qdata.getSex() != null && !qdata.getSex().equals("null") && !qdata.getSex().equals("") ) { %>
	    	  <tr class="tr">
	    	    <td class="T12b" width="23%">性別</td>
	    	    <td colspan="3"><%=qdata.getSex()%></td>
	    	  </tr>	    	  
	      <%}
	      if ( qdata.getEmail() != null && !qdata.getEmail().equals("null") && !qdata.getEmail().equals("") ) { %>
	    	  <tr>
	    	    <td class="T12b" width="23%">E-MAIL</td>
	    	    <td colspan="3"><%=qdata.getEmail()%></td>
	    	  </tr>	    	  
	      <%}
	      if ( qdata.getCityno() != null && !qdata.getCityno().equals("null") && !qdata.getCityno().equals("") ) { %>
	    	  <tr class="tr">
	    	    <td class="T12b" width="23%">住址</td>
	    	    <td colspan="3"><%=qdata.getArea()%>&nbsp;<%=qdata.getCityname()%><%=qdata.getTownsname()%><%=qdata.getAddress()%></td>
	    	  </tr>	    	  
	      <%}
	      if ( qdata.getTel() != null && !qdata.getTel().equals("null") && !qdata.getTel().equals("") ) { %>
	    	  <tr>
	    	    <td class="T12b" width="23%">電話</td>
	    	    <td colspan="3"><%=qdata.getTel()%></td>
	    	  </tr>	    	  
	      <%}
	      if ( qdata.getDegree() != null && !qdata.getDegree().equals("null") && !qdata.getDegree().equals("") ) {
	    	  String degree = "";
	    	  if ( qdata.getDegree().trim().equals("1") )
	    		  degree = "國小";
	    	  else if ( qdata.getDegree().trim().equals("2") )
	    		  degree = "國中";
	    	  else if ( qdata.getDegree().trim().equals("3") )
	    		  degree = "高中職";
	    	  else if ( qdata.getDegree().trim().equals("4") )
	    		  degree = "專科";
	    	  else if ( qdata.getDegree().trim().equals("5") )
	    		  degree = "大學";
	    	  else if ( qdata.getDegree().trim().equals("6") )
	    		  degree = "碩士";
	    	  else if ( qdata.getDegree().trim().equals("7") )
	    		  degree = "博士";
	    	  else if ( qdata.getDegree().trim().equals("8") )
	    		  degree = "其他"; %>
	    	  <tr class="tr">
	    	    <td class="T12b" width="23%">學歷</td>
	    	    <td colspan="3"><%=degree%></td>
	    	  </tr>	    	  
	      <%}
	      if ( qdata.getAge() != null && !qdata.getAge().equals("null") && !qdata.getAge().equals("") ) { 
	    	  String age = "";
	    	  if ( qdata.getAge().equals("1") )
	    		  age = "10歲以下";
	    	  else if ( qdata.getAge().trim().equals("2") )
	    		  age = "11-20歲";
	    	  else if ( qdata.getAge().trim().equals("3") )
	    		  age = "21-30歲";
	    	  else if ( qdata.getAge().trim().equals("4") )
	    		  age = "31-40歲";
	    	  else if ( qdata.getAge().trim().equals("5") )
	    		  age = "41-50歲";
	    	  else if ( qdata.getAge().trim().equals("6") )
	    		  age = "51-60歲";
	    	  else if ( qdata.getAge().trim().equals("7") )
	    		  age = "61-70歲";
	    	  else if ( qdata.getAge().trim().equals("8") )
	    		  age = "71-80歲"; 
	    	  else if ( qdata.getAge().trim().equals("9") )
	    		  age = "81-90歲"; 
	    	  else if ( qdata.getAge().trim().equals("10") )
	    		  age = "91-100歲"; 
	    	  else if ( qdata.getAge().trim().equals("11") )
	    		  age = "100歲以上"; %>
	    	  <tr>
	    	    <td class="T12b" width="23%">年齡</td>
	    	    <td colspan="3"><%=age%></td>
	    	  </tr>	    	  
	      <%}
	      if ( qdata.getJob() != null && !qdata.getJob().equals("null") && !qdata.getJob().equals("") ) { 
	    	  String job = "";
	    	  if ( qdata.getJob().equals("1") )
	    		  job = "自由業";
	    	  else if ( qdata.getJob().trim().equals("2") )
	    		  job = "行銷廣告";
	    	  else if ( qdata.getJob().trim().equals("3") )
	    		  job = "藝術";
	    	  else if ( qdata.getJob().trim().equals("4") )
	    		  job = "設計";
	    	  else if ( qdata.getJob().trim().equals("5") )
	    		  job = "政府機關";
	    	  else if ( qdata.getJob().trim().equals("6") )
	    		  job = "軍警";
	    	  else if ( qdata.getJob().trim().equals("7") )
	    		  job = "礦業及土石採取業";
	    	  else if ( qdata.getJob().trim().equals("8") )
	    		  job = "醫療保健及環境衛生業"; 
	    	  else if ( qdata.getJob().trim().equals("9") )
	    		  job = "建築營造及不動產相關業"; 
	    	  else if ( qdata.getJob().trim().equals("10") )
	    		  job = "法律／會計／顧問／研發業"; 
	    	  else if ( qdata.getJob().trim().equals("11") )
	    		  job = "金融投顧及保險業歲"; 
	    	  else if ( qdata.getJob().trim().equals("12") )
	    		  job = "政治宗教及社福相關業"; 
	    	  else if ( qdata.getJob().trim().equals("13") )
	    		  job = "運輸物流及倉儲"; 
	    	  else if ( qdata.getJob().trim().equals("14") )
	    		  job = "農林漁牧水電資源業"; 
	    	  else if ( qdata.getJob().trim().equals("15") )
	    		  job = "一般製造業"; 
	    	  else if ( qdata.getJob().trim().equals("16") )
	    		  job = "電子資訊／軟體／半導體相關業"; 
	    	  else if ( qdata.getJob().trim().equals("17") )
	    		  job = "一般服務業"; 
	    	  else if ( qdata.getJob().trim().equals("18") )
	    		  job = "旅遊／休閒／運動業"; 
	    	  else if ( qdata.getJob().trim().equals("19") )
	    		  job = "大眾傳播相關產業"; 
	    	  else if ( qdata.getJob().trim().equals("20") )
	    		  job = "文教相關業"; 
	    	  else if ( qdata.getJob().trim().equals("21") )
	    		  job = "其他"; %>
	    	  <tr class="tr">
	    	    <td class="T12b" width="23%">職業</td>
	    	    <td colspan="3"><%=job%></td>
	    	  </tr>	    	  
	      <%}%>
	      <tr>
	        <th >&nbsp;</th>
	        <th >&nbsp;</th>
	        <th >&nbsp;</th>
	        <th >&nbsp;</th>
	      </tr>
	  </table>  
  <%}%>
  <br/>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
    <tr class="tr">
      <th colspan="4">填卷者答案</th>
    </tr>
    <%
      if ( qlists != null ) {
    	  for ( int i=0; i<rcount; i++ ) {
    		  QuestionData qlist = ( QuestionData )qlists.get( i );
    		  String mrelletion = qlist.getRellection();
    		  String mchoicetype = qlist.getChoicetype();
    		  QuestionData qans = new QuestionData();
        	  boolean drtn = qans.load(serno,(i+1),Integer.parseInt(detailno));
        	  
        	  String answer1 = "";
        	  String answer2 = "";
        	  String answer3 = "";
        	  String answer4 = "";
        	  String answer5 = "";
        	  String answer6 = "";
        	  String answer7 = "";
        	  String answer8 = "";
        	  String inputtext = "";
        	  if ( drtn ) {
        		  answer1 = qans.getAnswer1();
            	  answer2 = qans.getAnswer2();
            	  answer3 = qans.getAnswer3();
            	  answer4 = qans.getAnswer4();
            	  answer5 = qans.getAnswer5();
            	  answer6 = qans.getAnswer6();
            	  answer7 = qans.getAnswer7();
            	  answer8 = qans.getAnswer8();
            	  inputtext = qans.getInputtext();
        	  }  %>	  
        	  <tr class="tr">
        	    <td align="left" class="T12b"><%=i+1%>‧<%=qlist.getMsubject()%></td>
        	  </tr>
    		  <tr>
    		    <td>
    		      <table width="96%" border="0" cellpadding="0" cellspacing="0">
    		        <%
    		          if ( qlist.getServerfile1() != null && !qlist.getServerfile1().equals("null") && !qlist.getServerfile1().equals("") ) {
    		        	  String Ischeck = "";
    		        	  if ( answer1.equals("Y") )
    		        		  Ischeck = "checked";  %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" align="left" class="T12b">
    		        	      <%
    		        	        if ( mrelletion.equals("Y") ) { %>
    		        	        	<input type="checkbox" name="check<%=i+1%>1" <%=Ischeck%> disabled/>
    		        	        <%}else{%>
    		        	        	<input type="radio" name="check<%=i+1%>1" <%=Ischeck%> disabled/>
    		        	        <%}%>
    		        	    </td>
    		        	    <td align="left" class="T12b">
    		        	      <%
    		        	        if ( mchoicetype.equals("1") ) { %>
    		        	        	<%=qlist.getServerfile1()%>
    		        	        <%}else{
    		        	        	String msfile = qlist.getServerfile1();
    		        	        	if ( qlist.getImagemagick1() != null && !qlist.getImagemagick1().equals("null") && !qlist.getImagemagick1().equals("") )
    		        	        		msfile = qlist.getImagemagick1(); %>
    		        	        	<img src="../../downdoc?file=/question/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=uploadpath" alt="<%=qlist.getExpfile1()%>" width="118" height="58" border="0" class="imagebox"/>
    		        	        	&nbsp;&nbsp;圖說：<%=qlist.getExpfile1()%>
    		        	        <%}%>
    		        	    </td>
    		        	  </tr>
    		          <%}
    		          if ( qlist.getServerfile2() != null && !qlist.getServerfile2().equals("null") && !qlist.getServerfile2().equals("") ) { 
    		        	  String Ischeck = "";
    		        	  if ( answer2.equals("Y") )
    		        		  Ischeck = "checked";  %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" class="T12b">
    		        	      <%
    		        	        if ( mrelletion.equals("Y") ) { %>
    		        	        	<input type="checkbox" name="check<%=i+1%>2" <%=Ischeck%> disabled/>
    		        	        <%}else{%>
    		        	        	<input type="radio" name="check<%=i+1%>2" <%=Ischeck%> disabled/>
    		        	        <%}%>
    		        	    </td>
    		        	    <td align="left" class="T12b">
    		        	      <%
    		        	        if ( mchoicetype.equals("1") ) { %>
    		        	        	<%=qlist.getServerfile2()%>
    		        	        <%}else{
    		        	        	String msfile = qlist.getServerfile2();
    		        	        	if ( qlist.getImagemagick2() != null && !qlist.getImagemagick2().equals("null") && !qlist.getImagemagick2().equals("") )
    		        	        		msfile = qlist.getImagemagick2(); %>
    		        	        	<img src="../../downdoc?file=/question/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=uploadpath" alt="<%=qlist.getExpfile2()%>" width="118" height="58" border="0" class="imagebox"/>
    		        	        	&nbsp;&nbsp;圖說：<%=qlist.getExpfile2()%>
    		        	        <%}%>
    		        	    </td>
    		        	  </tr>
    		          <%}
    		          if ( qlist.getServerfile3() != null && !qlist.getServerfile3().equals("null") && !qlist.getServerfile3().equals("") ) { 
    		        	  String Ischeck = "";
    		        	  if ( answer3.equals("Y") )
    		        		  Ischeck = "checked";  %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" class="T12b">
    		        	      <%
    		        	        if ( mrelletion.equals("Y") ) { %>
    		        	        	<input type="checkbox" name="check<%=i+1%>3" <%=Ischeck%> disabled/>
    		        	        <%}else{%>
    		        	        	<input type="radio" name="check<%=i+1%>3" <%=Ischeck%> disabled/>
    		        	        <%}%>
    		        	    </td>
    		        	    <td align="left" class="T12b">
    		        	      <%
    		        	        if ( mchoicetype.equals("1") ) { %>
    		        	        	<%=qlist.getServerfile3()%>
    		        	        <%}else{
    		        	        	String msfile = qlist.getServerfile3();
    		        	        	if ( qlist.getImagemagick3() != null && !qlist.getImagemagick3().equals("null") && !qlist.getImagemagick3().equals("") )
    		        	        		msfile = qlist.getImagemagick3(); %>
    		        	        	<img src="../../downdoc?file=/question/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=uploadpath" alt="<%=qlist.getExpfile3()%>" width="118" height="58" border="0" class="imagebox"/>
    		        	        	&nbsp;&nbsp;圖說：<%=qlist.getExpfile3()%>
    		        	        <%}%>
    		        	    </td>
    		        	  </tr>
    		          <%}
    		          if ( qlist.getServerfile4() != null && !qlist.getServerfile4().equals("null") && !qlist.getServerfile4().equals("") ) { 
    		        	  String Ischeck = "";
    		        	  if ( answer4.equals("Y") )
    		        		  Ischeck = "checked";  %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" class="T12b">
    		        	      <%
    		        	        if ( mrelletion.equals("Y") ) { %> 
    		        	        	<input type="checkbox" name="check<%=i+1%>4" <%=Ischeck%> disabled/>
    		        	        <%}else{%>
    		        	        	<input type="radio" name="check<%=i+1%>4" <%=Ischeck%> disabled/>
    		        	        <%}%>
    		        	    </td>
    		        	    <td align="left" class="T12b">
    		        	      <%
    		        	        if ( mchoicetype.equals("1") ) {  %>
    		        	        	<%=qlist.getServerfile4()%>
    		        	        <%}else{
    		        	        	String msfile = qlist.getServerfile4();
    		        	        	if ( qlist.getImagemagick4() != null && !qlist.getImagemagick4().equals("null") && !qlist.getImagemagick4().equals("") )
    		        	        		msfile = qlist.getImagemagick4(); %>
    		        	        	<img src="../../downdoc?file=/question/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=uploadpath" alt="<%=qlist.getExpfile4()%>" width="118" height="58" border="0" class="imagebox"/>
    		        	        	&nbsp;&nbsp;圖說：<%=qlist.getExpfile4()%>
    		        	        <%}%>
    		        	    </td>
    		        	  </tr>
    		          <%}
    		          if ( qlist.getServerfile5() != null && !qlist.getServerfile5().equals("null") && !qlist.getServerfile5().equals("") ) { 
    		        	  String Ischeck = "";
    		        	  if ( answer5.equals("Y") )
    		        		  Ischeck = "checked";  %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" class="T12b">
    		        	      <%
    		        	        if ( mrelletion.equals("Y") ) { %>
    		        	        	<input type="checkbox" name="check<%=i+1%>5" <%=Ischeck%> disabled/>
    		        	        <%}else{%>
    		        	        	<input type="radio" name="check<%=i+1%>5" <%=Ischeck%> disabled/>
    		        	        <%}%>
    		        	    </td>
    		        	    <td align="left" class="T12b">
    		        	      <%
    		        	        if ( mchoicetype.equals("1") ) { %>
    		        	        	<%=qlist.getServerfile5()%>
    		        	        <%}else{
    		        	        	String msfile = qlist.getServerfile5();
    		        	        	if ( qlist.getImagemagick5() != null && !qlist.getImagemagick5().equals("null") && !qlist.getImagemagick5().equals("") )
    		        	        		msfile = qlist.getImagemagick5(); %>
    		        	        	<img src="../../downdoc?file=/question/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=uploadpath" alt="<%=qlist.getExpfile5()%>" width="118" height="58" border="0" class="imagebox"/>
    		        	        	&nbsp;&nbsp;圖說：<%=qlist.getExpfile5()%>
    		        	        <%}%>
    		        	    </td>
    		        	  </tr>
    		          <%}
    		          if ( qlist.getServerfile6() != null && !qlist.getServerfile6().equals("null") && !qlist.getServerfile6().equals("") ) { 
    		        	  String Ischeck = "";
    		        	  if ( answer6.equals("Y") )
    		        		  Ischeck = "checked";  %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" class="T12b">
    		        	      <%
    		        	        if ( mrelletion.equals("Y") ) { %>
    		        	        	<input type="checkbox" name="check<%=i+1%>6" <%=Ischeck%> disabled/>
    		        	        <%}else{%>
    		        	        	<input type="radio" name="check<%=i+1%>6" <%=Ischeck%> disabled/>
    		        	        <%}%>
    		        	    </td>
    		        	    <td align="left" class="T12b">
    		        	      <%
    		        	        if ( mchoicetype.equals("1") ) { %>
    		        	        	<%=qlist.getServerfile6()%>
    		        	        <%}else{
    		        	        	String msfile = qlist.getServerfile6();
    		        	        	if ( qlist.getImagemagick6() != null && !qlist.getImagemagick6().equals("null") && !qlist.getImagemagick6().equals("") )
    		        	        		msfile = qlist.getImagemagick6(); %>
    		        	        	<img src="../../downdoc?file=/question/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=uploadpath" alt="<%=qlist.getExpfile6()%>" width="118" height="58" border="0" class="imagebox"/>
    		        	        	&nbsp;&nbsp;圖說：<%=qlist.getExpfile6()%>
    		        	        <%}%>
    		        	    </td>
    		        	  </tr>
    		          <%}
    		          if ( qlist.getServerfile7() != null && !qlist.getServerfile7().equals("null") && !qlist.getServerfile7().equals("") ) { 
    		        	  String Ischeck = "";
    		        	  if ( answer7.equals("Y") )
    		        		  Ischeck = "checked";  %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" class="T12b">
    		        	      <%
    		        	        if ( mrelletion.equals("Y") ) { %>
    		        	        	<input type="checkbox" name="check<%=i+1%>7" <%=Ischeck%> disabled/>
    		        	        <%}else{%>
    		        	        	<input type="radio" name="check<%=i+1%>7" <%=Ischeck%> disabled/>
    		        	        <%}%>
    		        	    </td>
    		        	    <td align="left" class="T12b">
    		        	      <%
    		        	        if ( mchoicetype.equals("1") ) { %>
    		        	        	<%=qlist.getServerfile7()%>
    		        	        <%}else{
    		        	        	String msfile = qlist.getServerfile7();
    		        	        	if ( qlist.getImagemagick7() != null && !qlist.getImagemagick7().equals("null") && !qlist.getImagemagick7().equals("") )
    		        	        		msfile = qlist.getImagemagick7(); %>
    		        	        	<img src="../../downdoc?file=/question/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=uploadpath" alt="<%=qlist.getExpfile7()%>" width="118" height="58" border="0" class="imagebox"/>
    		        	        	&nbsp;&nbsp;圖說：<%=qlist.getExpfile7()%>
    		        	        <%}%>
    		        	    </td>
    		        	  </tr>
    		          <%}
    		          if ( qlist.getServerfile8() != null && !qlist.getServerfile8().equals("null") && !qlist.getServerfile8().equals("") ) { 
    		        	  String Ischeck = "";
    		        	  if ( answer8.equals("Y") )
    		        		  Ischeck = "checked";  %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" class="T12b">
    		        	      <%
    		        	        if ( mrelletion.equals("Y") ) { %>
    		        	        	<input type="checkbox" name="check<%=i+1%>8" <%=Ischeck%> disabled/>
    		        	        <%}else{%>
    		        	        	<input type="radio" name="check<%=i+1%>8" <%=Ischeck%> disabled/>
    		        	        <%}%>
    		        	    </td>
    		        	    <td align="left" class="T12b">
    		        	      <%
    		        	        if ( mchoicetype.equals("1") ) { %>
    		        	        	<%=qlist.getServerfile8()%>
    		        	        <%}else{
    		        	        	String msfile = qlist.getServerfile8();
    		        	        	if ( qlist.getImagemagick8() != null && !qlist.getImagemagick8().equals("null") && !qlist.getImagemagick8().equals("") )
    		        	        		msfile = qlist.getImagemagick8(); %>
    		        	        	<img src="../../downdoc?file=/question/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=uploadpath" alt="<%=qlist.getExpfile8()%>" width="118" height="58" border="0" class="imagebox"/>
    		        	        	&nbsp;&nbsp;圖說：<%=qlist.getExpfile8()%>
    		        	        <%}%>
    		        	    </td>
    		        	  </tr>
    		          <%}
    		          if ( inputtext != null && !inputtext.equals("null") && !inputtext.equals("") && !inputtext.equals("a") ) { %>
    		        	  <tr>
    		        	    <td width="3%" align="left" class="T12b">&nbsp</td>
    		        	    <td width="5%" class="T12b">&nbsp;</td>
    		        	    <td align="left" class="T12b">
    		        	                其他說明：<input type="text" name="inputtext<%=i+1%>" size="55" maxlength="50" value="<%=inputtext%>" readonly/>
    		        	    </td>
    		        	  </tr>  
    		          <%}%>
    		      </table>
    		    </td>
    		  </tr> 
    	  <%}
      }%>
      
  </table>  

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>