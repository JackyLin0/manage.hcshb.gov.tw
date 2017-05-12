<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：prize101_prize.jsp
說明：問卷調查資料維護
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

<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );

  //尋找問卷標題
  QuestionnaireData qdata = new QuestionnaireData();
  boolean drtn = qdata.load(serno,table);
  String msubject = "";
  if ( drtn )
	  msubject = qdata.getSubject();
  
  //查詢填卷總人數
  QuestionData qnum = new QuestionData();
  ArrayList qnums = qnum.findBynum(serno);
  int numrcount = 0;
  if ( qnums != null )
	  numrcount = qnum.getAllrecordCount();
  
  //尋找該問卷題目總數
  QuestionData question = new  QuestionData(); 
  ArrayList qtots = question.findByday(serno);
  int trcount = 0;
  if ( qtots != null )
	  trcount = question.getAllrecordCount();
  
%>  

<script>
  function back()
  {
     document.mform.action="prize101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }

  function save()
  {
     var nownum = document.mform.num.value;
     var numrcount = document.mform.numrcount.value;
     if ( nownum == '' || nownum == '0' ) {
        alert("【本問卷抽獎人數】之欄位，不可空白，請輸入");
        document.mform.num.focus();
        return;
     }
     if ( nownum > numrcount ) {
        alert("本次欲抽出知名額【大於】填問卷總人數，請修正");
        document.mform.num.focus();
        return
     }
     
     document.mform.action = "prize101_prizesave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

<body>

<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">確定</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">產生中獎名單</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="23%">本問卷標題</td>
    <td colspan="3"><%=msubject%></td>
  </tr>
  <tr>
    <td class="T12b" width="15%">本問卷填寫總人數</td>
    <td colspan="3"><%=numrcount%></td>
    <input type="hidden" name="numrcount" value="<%=numrcount%>"/>
  </tr>
  <tr class="tr">
    <td class="T12b" width="20%"><span class="T12red">※</span>本問卷抽獎人數</td>
    <td colspan="3"><input type="text" name="num" size="6" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />&nbsp;人</td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>參加抽獎條件</td>
    <td colspan="3">
      <select name="flag">
         <option value="0">無條件</option>
         <%
           for ( int i=trcount; i>0; i-- ) { %>
        	   <option value="<%=i%>">答對<%=i%>題以上</option>
           <%}%>
      </select>
    </td>
  </tr>
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

</form>
</body>
</html>

