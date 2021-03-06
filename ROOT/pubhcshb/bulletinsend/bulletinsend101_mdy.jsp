<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：bulletinsend101_mdy.jsp
說明：新聞稿維護-修改
開發者：yclai
開發日期：102.08.20
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%
 try {%>
<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );
  String qptdate = ( String )request.getParameter( "qptdate" );
  String qdldate = ( String )request.getParameter( "qdldate" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String table2 = ( String )request.getParameter( "t2" );
  String mlanguage = ( String )request.getParameter( "language" );  
  
  String serno = ( String )request.getParameter( "serno" );
  
  String path = ( String )request.getParameter( "path" );
  
  //尋找登入者的單位，設定欲發布之站台 start
  String aplistdn = ( String )request.getParameter( "webdn" );
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  //單位網站對照檔
  WebsiteUnitData qweb = new WebsiteUnitData();
  boolean rtnunit = qweb.load(pubunitdn);
  String unitweb = "";
  if ( rtnunit )
	  unitweb = qweb.getWebsitedn();
  
  if ( mlanguage.equals("ch") )
	  mlanguage = "chinese";
  else if( mlanguage.equals("en") )
	  mlanguage = "english";
  else if ( mlanguage.equals("jp") )
	  mlanguage = "japan";

//   WebSiteData qstart = new WebSiteData();
//   boolean rtn = qstart.load(unitweb,mlanguage);
//   String mstart = "";  
//   if ( rtn )
// 	  mstart = qstart.getStartusing();
  
  //判斷此站台是否有納入框架
//   int rcount = 0;  
//   if ( mstart.equals("Y") ) {
// 	  PubWebsiteData qpub = new PubWebsiteData();
// 	  ArrayList<Object> qpubwebs = qpub.findByday(table1,unitweb,aplistdn,"P");  
// 	  rcount = qpub.getAllrecordCount();
//   }else{
// 	  WebSiteData qpubwebs = new WebSiteData();
// 	  ArrayList<Object> qwebs = qpubwebs.findByday(mlanguage);
// 	  rcount = qpubwebs.getAllrecordCount();
//   }  

  BulletinSendData qbulletin = new BulletinSendData();    
  boolean rtn1 = qbulletin.load(table2,serno);  

%>  

<script>
  function back()
  {
     document.mform.action="bulletin101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function qsort(tablename,logindn)
  {
     newwnd = window.open('../../pubprogram/qsort.jsp?tablename='+tablename+'&logindn='+logindn,'','width=600,height=400,scrollbars=yes,left=300,top=150');
  }
  
  function chg()
  {
     for ( var i=0; i<document.all.startusing.length; i++ )
     {
        if ( document.all.startusing[i].checked )
        {
           var startusing_value = document.all.startusing[i].value;           
           switch(startusing_value)
           {
              case "1": //永久有效
                   window.type.style.display='none';
                   break;
              case "0": //截止日期
                   window.type.style.display='block';
                   break;
           }
        }
     }                  
  }
   
  function save()
  {          
     if ( document.mform.stdate.value == '' )
     {
        alert("【發布日期】欄位，不可空白，請選擇！");
        document.mform.date1.focus();
        return;     
     }
     if ( document.mform.subject.value == '' )
     {
        alert("【標題】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     
     if ( document.mform.content.value != '' ) 
     {
        if ( document.mform.content.value.length > 2000 )
        {
           alert("【詳細內容】欄位，不可超過1500個中文字，請重新輸入！");
           document.mform.content.focus();
           return;
        }
     }
     if ( document.mform.relateurl.value != 'http://' && document.mform.relateurl.value != '' ) 
     {
        if ( document.mform.relatename.value == '' )
        {
           alert("【網站名稱】欄位，不可空白，請輸入！");
           document.mform.relatename.focus();
           return;
        }
     }
     
     document.mform.action = "bulletinsend101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
    
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="bulletinsend101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
  }    
  
  function word() {
	     
	  document.getElementById("mform").action = "bulletinsend101_word.jsp";
	  document.getElementById("mform").method = "post";
	  document.getElementById("mform").submit();
  }
  
  function send() {
	  document.getElementById("mform").action = "bulletinsendmail/mailmenu101.jsp";
	  document.getElementById("mform").method = "post";
	  document.getElementById("mform").submit();
  }
  
  function send1() {
	  document.getElementById("mform").action = "bulletinsendmail/mailmenu102.jsp";
	  document.getElementById("mform").method = "post";
	  document.getElementById("mform").submit();
  }
  
  
  function preview(serno)
  {
	  window.open('bulletinsendview.jsp?serno='+serno,'bulletin','scrollbars=yes,resizable=yes,left=90,top=90');
  }
</script>

</head>
  
<body>
<form id="mform" name="mform">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="t2" value="<%=table2%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
  <input type="hidden" name="qptdate" value="<%=qptdate%>"/>
  <input type="hidden" name="qdldate" value="<%=qdldate%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()"><%=lang.getSave()%></a>
 <a class="md" href="javascript:del()"><%=lang.getDel()%></a>	
 <a class="md" href="javascript:window.document.mform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 <a class="md" href="javascript:word()">匯出新聞稿</a>
 <a class="md" href="javascript:preview('<%=serno%>')">預覽新聞稿</a>
 <a class="md" href="javascript:send()">測試寄信</a>
 <a class="md" href="javascript:send1()">寄信</a>
 
 
 
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4"><%=lang.getDatamdy()%></th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="17%"><span class="T12red">※</span><%=lang.getPosterdate()%></td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date1"/>
          <jsp:param name="colname" value="stdate"/>
          <jsp:param name="colnameview" value="stdateview"/>
          <jsp:param name="datevalue" value="<%=qbulletin.getPosterdate()%>" />
      </jsp:include>  
      <jsp:include page="../../pubprogram/choicetime.jsp">
          <jsp:param name="hcolname" value="phour"/>
          <jsp:param name="mcolname" value="pminute"/>
          <jsp:param name="timevalue" value="<%=qbulletin.getPostertime()%>"/>
      </jsp:include> 
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getSubject()%></td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="70" maxlength="50" value="<%=qbulletin.getSubject()%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getSecsubject()%></td>
    <%
      String msecsubject = qbulletin.getSecsubject();
      if ( msecsubject == null || msecsubject.equals("null") )
    	  msecsubject = "";
    %>
    <td colspan="3">
      <input name="secsubject" type="text" class="lInput01" size="70" maxlength="100" value="<%=msecsubject%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過100個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getPubunitname()%></td>
    <td colspan="3"><%=qbulletin.getPubunitname()%></td>
  </tr> 
  <input type="hidden" name="pubunitdn" value="<%=qbulletin.getPubunitdn()%>"/>
  <input type="hidden" name="pubunitname" value="<%=qbulletin.getPubunitname()%>"/>
  <tr>
    <td valign="top" class="T12b"><%=lang.getContent()%></td>
    <%
      String mcontent = qbulletin.getContent();
      if ( mcontent == null || mcontent.equals("null") )
    	  mcontent = "";
    %>
    <td colspan="3">
      <textarea name="content" cols="77" rows="18"><%=mcontent%></textarea>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過1500個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getRelateurl()%></td>
    <%
      String mrelaturl = qbulletin.getRelateurl();
      String mrelatname = qbulletin.getRelatename();
      if ( mrelaturl == null || mrelaturl.equals("null") || mrelaturl.equals("") )
    	  mrelaturl = "http://";
      if ( mrelatname == null || mrelatname.equals("null") )
    	  mrelatname = "";
    %>
    <td colspan="3">
      <input name="relateurl" type="text" class="lInput01" value="<%=mrelaturl%>" size="45" maxlength="200" />&nbsp;
      <span class="T12b"><%=lang.getWebname()%></span>&nbsp;<input name="relatename" type="text" class="lInput01" size="30" value="<%=mrelatname%>" maxlength="60" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">撰稿單位</td>
    <td colspan="3">
      <input name="liaisonunit" type="text" class="lInput01" size="50" maxlength="20" value="<%=qbulletin.getLiaisonunit()%>" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getName()%></td>
    <td colspan="3">
      <input name="liaisonper" type="text" class="lInput01" size="50" maxlength="20" value="<%=qbulletin.getLiaisonper()%>" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個中文字）</span>
    </td>
  </tr>

  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<p></p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>
<% }catch(Exception Error){
	out.println(Error.toString());
} %>