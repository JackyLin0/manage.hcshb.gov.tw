<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manual101.jsp
說明：手動派送電子報
開發者：chmei
開發日期：97.03.22
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
    
  <!-- 訂戶加入 -->
  function madd()
  {
     var sel1 = document.mform.emails1;
     var sel2 = document.mform.emails;                          
     if (document.mform.emails.options.length == 0) return;
     if ( sel2.options.length > 0 )
     {
        for ( var i = 0; i < sel2.options.length; i++ )
        {
           if (sel2.options[i].selected == true)
           {
              sel1.options[sel1.options.length] = new
              Option(sel2.options[i].text,sel2.options[i].value);
           }
        }
        for ( var i = sel2.options.length - 1; i >= 0 ; i-- )
        {
           if ( sel2.options[i].selected == true ) {
             sel2.options[sel2.options.selectedIndex] = null;} 
        }                                                     
     }                                                       
  }  
                                                                    
  <!-- 訂戶移除 -->                                      
  function mdel()
  {
     var sel1 = document.mform.emails1;
     var sel2 = document.mform.emails;
     if (document.mform.emails1.options.length == 0) return;
     if ( sel1.options.length > 0 )
     {
        for ( var i = 0; i < sel1.options.length; i++ )
        {
           if ( sel1.options[i].selected == true )
           {
             sel2.options[sel2.options.length] = new
             Option(sel1.options[i].text,sel1.options[i].value);
           }
        }                                                     
        for ( var i = sel1.options.length - 1; i >= 0 ; i-- )
        {
           if ( sel1.options[i].selected == true ){
             sel1.options[sel1.options.selectedIndex] = null;
           }
        }
     }                                                       
  }
  
  function send()
  {
     if ( document.mform.periodical.value == '' ) {
        alert("【欲派送電子報之期刊】欄位，不可空白，請選擇");
        document.mform.periodical.focus();
        return;
     }
     if ( document.mform.emails1.length == 0 ) {
        alert("您未指定【欲派送訂戶】，請選擇！");
        document.mform.emails1.focus();
        return;
      }else{
        for ( i=0; i<document.mform.emails1.length; i++ )
        {
           document.mform.emails1.options[i].selected=true;
        }
        document.mform.action = "manual101_send.jsp";
        document.mform.method = "post";
        document.mform.submit();
      }   
  }
  
</script>

<%@ page import="tw.com.sysview.dba.*" %>

<body>
<form name="mform">
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:send()">確定</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">電子報手動派送</th>
  </tr>
  <%
    EpaperEditData query = new EpaperEditData();
    ArrayList qlists = query.findByday("","00000000","99999999");
    int rcount = query.getAllrecordCount();
  %>
  <tr class="tr">
    <td width="25%" class="T12b" width="20%"><span class="T12red">※</span>欲派送電子報之期刊</td>
    <td colspan="3">
      <select name="periodical">
         <option value="">--- 請選擇 ---</option>
         <%
           if ( qlists != null ) {
        	   for ( int i=0; i<rcount; i++ ) {
        		   EpaperEditData qlist = ( EpaperEditData )qlists.get( i );  %>
        		   <option value="<%=qlist.getPeriodical()%>"><%=qlist.getPeriodical().substring(0,4)%>年<%=qlist.getPeriodical().substring(4,6)%>月</option>
        	   <%}
           }%>
      </select>
    </td>
  </tr>
  <%
    EpaperMailData qmail1 = new EpaperMailData();
    ArrayList qmails = qmail1.findByday("");
    int mrcount = qmail1.getAllrecordCount();
  %>
  <tr>
    <td class="T12b"><span class="T12red">※</span>欲派送之訂戶設定</td>
    <td colspan="3">
      <table border="0">
        <tr>
          <td align="center" class="T12b"><strong>未指定訂戶</strong></td>
          <td align="center"></td>
          <td align="center" class="T12b"><strong>已指定訂戶</strong></td>          
        </tr>
        <tr align="center">
          <td rowspan="2" align="center">
            <select name="emails" multiple size=10>
              <%
                if ( qmails != null ) {
                	for ( int j=0; j<mrcount; j++ ) {
                		EpaperMailData qmail = ( EpaperMailData )qmails.get( j ); %>
                		<option value="<%=qmail.getEmail()%>"><%=qmail.getName()%>【<%=qmail.getEmail()%>】</option>
                	<%}
                }%>
            </select>
          </td>
          <td align="center" valign="middle">
            <input type="button" value="加入-->" onclick="madd()">
          </td>
          <td rowspan="2" align="center">
            <select name="emails1" multiple size=10>
            </select>
          </td>
        </tr>
        <tr>
          <td align="center" valign="middle">
            <input type="button" value="<--移除" onclick="mdel()">
          </td>
        </tr>
      </table>
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

