<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：register101_mdy.jsp
說明：申請事項
開發者：chmei
開發日期：97.02.18
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
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  String path = ( String )request.getParameter( "path" );
  
  HouseRegisterData query = new HouseRegisterData();  
  boolean rtn = query.load(serno,table);  

%>  

<script>
  function back()
  {
     document.mform.action="register101.jsp";
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
     if ( document.mform.startusing[1].checked ) 
     {
        if ( document.mform.endate.value == '' )
        {
           alert("【截止日期】欄位，不可空白，請選擇！");
           document.mform.date2.focus();
           return;
        }
     }
     if ( document.mform.itemname.value == '' )
     {
        alert("【申請項目名稱】欄位，不可空白，請輸入！");
        document.mform.itemname.focus();
        return;
     }
     if ( document.mform.mclass.value == '' )
     {
        alert("【分類】欄位，不可空白，請選擇！");
        document.mform.mclass.focus();
        return;
     }
     if ( document.mform.prepapers.value != '' ) {
        if ( document.mform.prepapers.value.length > 1000 ) {
           alert("【申請人應備證件】欄位，不可超過1000個中文字，請重新輸入！");
           document.mform.prepapers.focus();
           return;
        }
     }
     if ( document.mform.tranunit.value != '' ) {
        if ( document.mform.tranunit.value.length > 1000 ) {
           alert("【承辦單位】欄位，不可超過1000個中文字，請重新輸入！");
           document.mform.tranunit.focus();
           return;
        }
     }
     if ( document.mform.acceptway.value != '' ) {
        if ( document.mform.acceptway.value.length > 1000 ) {
           alert("【受理方式】欄位，不可超過1000個中文字，請重新輸入！");
           document.mform.acceptway.focus();
           return;
        }
     }
     if ( document.mform.applyway.value != '' ) {
        if ( document.mform.applyway.value.length > 1000 ) {
           alert("【申請方式】欄位，不可超過1000個中文字，請重新輸入！");
           document.mform.applyway.focus();
           return;
        }
     }
     if ( document.mform.remark.value != '' ) {
        if ( document.mform.remark.value.length > 1000 ) {
           alert("【備註】欄位，不可超過1000個中文字，請重新輸入！");
           document.mform.remark.focus();
           return;
        }
     }
     
     document.mform.action = "register101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  } 
  
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="register101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
  }           
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name=path value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:del()">刪除</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <%
    String mstartusing = query.getStartusing();
    String mstyle = "style='display:none'";
    if ( mstartusing.equals("0") )
    	mstyle = "style='display:block'";
  %>
  <tr class="tr">
    <td class="T12b" width="20%"><span class="T12red">※</span>啟用</td>
    <td colspan="3">
      <input type="radio" name="startusing" value="1" onclick="chg()" <%=(mstartusing.equals("1") ? "checked" : "")%>>永久有效&nbsp;&nbsp;&nbsp;
      <input type="radio" name="startusing" value="0" onclick="chg()" <%=(mstartusing.equals("0") ? "checked" : "")%>>截止日期
    </td>
  </tr>
  <tr class="tr" id='type' <%=mstyle%>>
    <td class="T12b" width="20%"><span class="T12red">※</span>截止日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date2"/>
          <jsp:param name="colname" value="endate"/>
          <jsp:param name="colnameview" value="endateview"/>
          <jsp:param name="datevalue" value="<%=query.getClosedate()%>" />
      </jsp:include>  
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>申請項目名稱</td>
    <td colspan="3">
      <input name="itemname" type="text" class="lInput01" size="70" maxlength="25" value="<%=query.getItemname()%>"/>
      <span class="T10">(不可超過25個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3"><%=query.getPubunitname()%></td>
    <input type="hidden" name="punit" value=<%=query.getPubunitdn()%>>
    <input type="hidden" name="pubunitname" value=<%=query.getPubunitname()%>>
  </tr> 
  <tr>
    <td class="T12b"><span class="T12red">※</span>分類</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qclass.jsp">
          <jsp:param name="formname" value="mform"/>
          <jsp:param name="tablename" value="HouseRegisterClass"/>
          <jsp:param name="colname" value="mclass"/>
          <jsp:param name="pcolname" value="punit"/>
          <jsp:param name="datavalue" value="<%=query.getMserno()%>"/>
      </jsp:include>              
    </td>
  </tr>
  <tr>
    <td valign="top" class="T12b">申請人應備證件</td>
    <td colspan="3">
      <textarea name="prepapers" cols="75" rows="10"><%=query.getPrepapers()%></textarea>
      <br><span class="T10">(不可超過1000個中文字）</span>
    </td>
  </tr>
  <%
    String misoriginal = "N";
    if ( query.getIsoriginal() != null && !query.getIsoriginal().equals("null") && !query.getIsoriginal().equals("") )
    	misoriginal = query.getIsoriginal();
  %>
  <tr class="tr">
    <td class="T12b">證件是否須正本</td>
    <td colspan="3">
      <input name="isoriginal" type="radio" value="Y" <%=(misoriginal.equals("Y") ? "checked" : "")%>/>是&nbsp;&nbsp;
      <input name="isoriginal" type="radio" value="N" <%=(misoriginal.equals("N") ? "checked" : "")%>/>否
    </td>
  </tr>
  <tr>
    <td class="T12b">處理期限</td>
    <td colspan="3">
      <input name="dealdead" type="text" class="lInput01" size="70" maxlength="10" value="<%=query.getDealdead()%>"/>
      <span class="T10">(不可超過10個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td valign="top" class="T12b">承辦單位</td>
    <td colspan="3">
      <textarea name="tranunit" cols="75" rows="10"><%=query.getTranunit()%></textarea>
      <br><span class="T10">(不可超過1000個中文字）</span>
    </td>
  </tr>
  <tr>
    <td valign="top" class="T12b">受理方式</td>
    <td colspan="3">
      <textarea name="acceptway" cols="75" rows="10"><%=query.getAcceptway()%></textarea>
      <br><span class="T10">(不可超過1000個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td valign="top" class="T12b">申請方式</td>
    <td colspan="3">
      <textarea name="applyway" cols="75" rows="10"><%=query.getApplyway()%></textarea>
      <br><span class="T10">(不可超過1000個中文字）</span>
    </td>
  </tr>
  <tr>
    <td valign="top" class="T12b">備註</td>
    <td colspan="3">
      <textarea name="remark" cols="75" rows="10"><%=query.getRemark()%></textarea>
      <br><span class="T10">(不可超過1000個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">排　序</td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" value="<%=query.getFsort()%>" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;<input type="button" value="查 詢" onclick="qsort('<%=table%>','<%=logindn%>')" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(輸入數值同目前有數值，系統自動將現有該數值往後遞延）</span>
    </td>
  </tr>

  <tr >
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

