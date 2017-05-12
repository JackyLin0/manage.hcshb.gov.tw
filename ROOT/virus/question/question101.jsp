<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：question101.jsp
說明：問題反應
開發者：hank
開發日期：98.07.31
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
function add(){
	document.mform.action="question101_add.jsp";
    document.mform.method="post";
    document.mform.submit();
}
function qry(){
    document.mform.action="question101.jsp";
    document.mform.method="post";
    document.mform.submit();
}  
  
function answer(serno){
     document.mform.serno.value=serno;
     document.mform.action="question101_answer.jsp";
     document.mform.method="post";
     document.mform.submit();
} 
    
function clean(){  
	document.mform.keyword.value = "請輸入關鍵字";
}     

function cha(){
	document.mform.action="question101.jsp";
    document.mform.method="post";
    document.mform.submit();
}

function del()
{
   x=window.confirm("確定執行整批刪除嗎?")
   if(x)
   {
      document.mform.action="question101_del.jsp?type=0";
      document.mform.method="post";
      document.mform.submit();
   } 
}
</script>

<%@ page import="java.util.*"%>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String hcshb = PropertiesBean.getBundle("tw.com.econcord.properties.project", "hcshb", Locale.TAIWAN);

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
  if ( pubunitdn.equals(hcshb) )
	  pubunitdn = "";
  
  //接收查詢條件
  //關鍵字尋找標題、副標題、內容三個欄位
  String schName = ( String )request.getParameter( "schName" );
  if ( schName == null || schName.equals("") )
	  schName = "";
  
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
  
  String isAnswer = request.getParameter("isAnswer");
  if(isAnswer == null){
	  isAnswer = "0";
  }
  
  QuesresponseData query = new QuesresponseData();   
  ArrayList qlists = query.findByday(table,keyword,schName,qpunit,sdate1,sdate2,isAnswer);
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
<form name="mform" method="post">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="intpage" value="<%=intpage%>"/>
<input type="hidden" name="language" value="<%=language%>"/>

<input type="hidden" name="serno"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<div>
  <span class="T11b">隸屬單位</span>
  <jsp:include page="../qunit.jsp">
      <jsp:param name="colname" value="qpunit"/>
      <jsp:param name="language" value="ch"/>
      <jsp:param name="datavalue" value="<%=qpunit%>"/>
      <jsp:param name="onchange" value="cha"/>
  </jsp:include>&nbsp;&nbsp;
  <span class="T11b">學校名稱</span>
  <jsp:include page="../../pubprogram/qschool.jsp">
      <jsp:param name="colname" value="schName"/>
      <jsp:param name="datavalue" value="<%=qpunit%>"/>
      <jsp:param name="schName" value="<%=schName%>"/>
  </jsp:include>&nbsp;&nbsp;
  <br>
  <span class="T11b">關鍵字</span>
  <input name="keyword" type="text" class="lInput01" size="15" value="<%=(keyword.equals("") ? "請輸入關鍵字" : keyword)%>" onFocus="javascript: if (this.value=='請輸入關鍵字') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入關鍵字';">

  <span class="T11b">反應日期</span>
  <jsp:include page="../../pubprogram/bdate.jsp" >
    <jsp:param name="sdatevalue" value="<%=qptdate%>" />
    <jsp:param name="edatevalue" value="<%=qdldate%>" />
  </jsp:include>

<br>
  <%
    if(isAnswer.equals("0")){
  %>
  <input type="radio" name="isAnswer" value="0" checked>未解答
  <input type="radio" name="isAnswer" value="1">已解答
  <%
    }else{
  %>
  <input type="radio" name="isAnswer" value="0">未解答
  <input type="radio" name="isAnswer" value="1" checked>已解答
  <%
    }
  %>
  
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()">查   詢</a>&nbsp;
  <a class="md2" href="javascript:clean()">重   設</a>
</div>
<p>

<a class="md" href="javascript:add()">新   增</a>
<a class="md" href="javascript:del()">刪除</a>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="5%">&nbsp;</th>
    <th width="25%" align="center">學校名稱</th>
    <th width="30%" align="center">問題反應</th>
    <th width="20%" align="center">反應日期</th>
    <th align="center">發佈者名稱</th>
  </tr>

<%
	if((request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals(""))){
      intpage = Integer.parseInt(request.getParameter("page"));
  }
  
  int startpage=(intpage-1)*pagesize+1;
  int endpage=startpage+pagesize-1;    
    
  for(int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++){
	  QuesresponseData qlist = ( QuesresponseData )qlists.get( i );
%>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center"><%=i+1%></td>
    <td align="center"><input type="checkbox" name="check" value=<%=qlist.getSerno()%>></td>
    <td align="center"><%=qlist.getSchName()%></td>
    <%
      String question = qlist.getQuestion();
      if(question.length() > 20){
    	  question = question.substring(0,20);
      }
    %>
    <td align="center"><a href="javascript:answer('<%=qlist.getSerno()%>')"><%=question%></a></td>    	  
    <td align="center"><%=qlist.getPostDate().substring(0,4)%>.<%=qlist.getPostDate().substring(4,6)%>.<%=qlist.getPostDate().substring(6,8)%></td>
    <td align="center"><%=qlist.getPostname()%></td>
  </tr> 
<%
  }
%>
    	
  <input type="hidden" name="page"/> 
  <input type="hidden" name="intpage" value="<%=intpage%>"/> 
  
  <!-- 分頁 -->
  <%
    try{
    if(rcount > 0){
  %>
  <tr class="tr01">
    <th colspan="6">
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
  <%
    }
    }catch(Exception e){
    	out.print(e);
    }
  %>  
  
</table>

<p>
<a class="md" href="#top">回頁首</a>

<div id="page"><span class="T8-5">頁數:</span> <span class="T8-5c"> <%=intpage%> / <%=maxpage%> </span><span class="T8-5">； 資料每頁以15筆展現；共有</span><span class="T8-5c"> <%=rcount%> </span> <span class="T8-5">筆資料</span></div>

</form>
</body>
</html>