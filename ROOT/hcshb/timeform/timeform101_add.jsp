<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：timeform101_add.jsp
說明：各時間表維護
開發者：chmei
開發日期：97.02.19
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );

%>  

<script>
  function back()
  {
     document.mform.action="timeform101.jsp";
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
     if ( document.mform.startusing[1].checked ) 
     {
        if ( document.mform.endate.value == '' )
        {
           alert("【截止日期】欄位，不可空白，請選擇！");
           document.mform.date2.focus();
           return;
        }
        if ( document.mform.stdate.value > document.mform.endate.value )
        {
           alert("【發布日期】不可大於【截止日期】！");
           document.mform.date1.focus();
           return;       
        }
     }
     if ( document.mform.subject.value == '' )
     {
        alert("【標題】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     if ( document.mform.punit.value == '' )
     {
        alert("【發布單位】欄位，不可空白，請選擇！");
        document.mform.punit.focus();
        return;
     }
     
     document.mform.action = "timeform101_addsave.jsp";
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
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料新增</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="20%"><span class="T12red">※</span>發布日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date1"/>
          <jsp:param name="colname" value="stdate"/>
          <jsp:param name="colnameview" value="stdateview"/>
      </jsp:include>  
    </td>
  </tr>
  <tr>
    <td class="T12b" width="15%"><span class="T12red">※</span>啟用</td>
    <td colspan="3">
      <input type="radio" name="startusing" value="1" onclick="chg()" checked>永久有效&nbsp;&nbsp;&nbsp;
      <input type="radio" name="startusing" value="0" onclick="chg()">截止日期
    </td>
  </tr>
  <tr id='type' style='display:none'>
    <td class="T12b" width="20%"><span class="T12red">※</span>截止日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date2"/>
          <jsp:param name="colname" value="endate"/>
          <jsp:param name="colnameview" value="endateview"/>
      </jsp:include>  
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>標題</td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="50" maxlength="50"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">副標題</td>
    <td colspan="3">
      <input name="secsubject" type="text" class="lInput01" size="70" maxlength="100"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過100個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
      </jsp:include>
    </td>
  </tr>
  <tr class="tr">
    <td valign="top" class="T12b">詳細內容</td>
    <td colspan="3">
      <textarea name="content" cols="80" rows="10"></textarea>
      <br><span class="T10">(不可超過1000個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">聯絡人</td>
    <td colspan="3">
      <input name="liaisonper" type="text" class="lInput01" size="50" maxlength="20" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個中文字）</span>
    </td>
  </tr> 
  <tr class="tr">
    <td class="T12b">聯絡電話</td>
    <td colspan="3">
      <input name="liaisontel" type="text" class="lInput01" size="50" maxlength="20" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">電子信箱</td>
    <td colspan="3">
      <input name="liaisonemail" type="text" class="lInput01" size="50" maxlength="40" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過40個字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">排　序</td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;<input type="button" value="查 詢" onclick="qsort('<%=table%>','<%=logindn%>')" />
    </td>
  </tr>       
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

