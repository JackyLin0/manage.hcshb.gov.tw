<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：maildata101_mdy.jsp
說明：訂戶資料維護
開發者：chmei
開發日期：97.03.16
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
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" ); 
  String pubunitdn = ( String )request.getParameter( "pubunitdn" ); 
  String pubunitname = ( String )request.getParameter( "pubunitname" ); 
  
  String serno = ( String )request.getParameter( "serno" );
  String language = ( String )request.getParameter( "language" );
  
  EpaperMailData query = new EpaperMailData();
  boolean rtn = query.load(serno);

%>  

<script>
  function back()
  {
     document.mform.action="maildata101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }

  function save()
  {
     if ( document.mform.name.value == '' )
     {
        alert("【姓名】欄位，不可空白，請輸入！");
        document.mform.name.focus();
        return;     
     }
     if ( document.mform.email.value == '' )
     {
        alert("【Email】欄位，不可空白，請輸入！");
        document.mform.email.focus();
        return;
     }
     if ( document.mform.myear.value != '') {
        if ( document.mform.myear.value.length != 4 ) {
           alert("【生日年】欄位，請輸入西元年！");
           document.mform.myear.focus();
           return; 
        }else if ( document.mform.mmonth.value == '' || document.mform.mmonth.value.lastIndexOf("請輸入") != -1 ) {
           alert("【生日月】欄位，不可空白，請輸入！");
           document.mform.mmonth.focus();
           return; 
        }else if ( document.mform.mday.value == '' || document.mform.mday.value.lastIndexOf("請輸入") != -1 ) {
           alert("【生日日】欄位，不可空白，請輸入！");
           document.mform.mday.focus();
           return; 
        }
     }
          
     document.mform.action = "maildata101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  } 
  
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="maildata101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
  }           
</script>

<body>
<form name="mform">
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name=language value="<%=language%>"/>
  <input type="hidden" name=pubunitdn value="<%=pubunitdn%>"/>
  <input type="hidden" name=pubunitname value="<%=pubunitname%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:del()">刪除</a>	
 <a class="md" href="javascript:window.document.mform.reset()">重設</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>姓名</td>
    <td colspan="3">
      <input name="name" type="text" class="lInput01" size="30" maxlength="50" value="<%=query.getName()%>"/>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>Email</td>
    <td colspan="3">
      <input name="email" type="text" class="lInput01" size="30" maxlength="50" value="<%=query.getEmail()%>"/>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">性別</td>
    <td colspan="3">
      <input type="radio" name="sex" value="男" <%=(query.getSex().equals("男") ? "checked" : "")%>/>男 &nbsp;&nbsp;
      <input type="radio" name="sex" value="女" <%=(query.getSex().equals("女") ? "checked" : "")%>/>女
    </td>
  </tr>
  <%
    String byear = "";
    String bmonth = "";
    String bday = "";
    if ( query.getBirthday() != null && !query.getBirthday().equals("null") && !query.getBirthday().equals("") ) {
    	byear = query.getBirthday().substring(0,4);
    	bmonth = query.getBirthday().substring(4,6);
    	bday = query.getBirthday().substring(6,8);
    }
  %>
  <tr>
    <td class="T12b">生日</td>
    <td colspan="3">
                 西元 <input name="myear" type="text" size="8" value=<%=(byear.equals("") ? "" : byear)%>>年  
      <input name="mmonth" type="text" size="8" value=<%=(bmonth.equals("") ? "" : bmonth)%>>月  
      <input name="mday" type="text" size="8" value=<%=(bday.equals("") ? "" : bday)%>>日 
    </td>
  </tr>
  <%
    String edu = "";
    if ( query.getEdu() != null && !query.getEdu().equals("null") && !query.getEdu().equals("") )
    	edu = query.getEdu();
  %>
  <tr class="tr">
    <td class="T12b">教育程度</td>
    <td colspan="3">
      <select name="edu">
         <option value="" <%=(edu.equals("") ? "selected" : "")%>>-請選擇-</option>
         <option value="小學" <%=(edu.equals("小學") ? "selected" : "")%>>小學</option>
         <option value="國中" <%=(edu.equals("國中") ? "selected" : "")%>>國中</option>
         <option value="高中" <%=(edu.equals("高中") ? "selected" : "")%>>高中</option>
         <option value="大學" <%=(edu.equals("大學") ? "selected" : "")%>>大學</option>
         <option value="研究所" <%=(edu.equals("研究所") ? "selected" : "")%>>研究所</option>
         <option value="博士" <%=(edu.equals("博士") ? "selected" : "")%>>博士</option>
      </select>
    </td>
  </tr>
  <%
    String occupation = "";
    if ( query.getOccupation() != null && !query.getOccupation().equals("null") && !query.getOccupation().equals("") )
    	occupation = query.getOccupation();
  %>
  <tr>
    <td class="T12b">職業</td>
    <td colspan="3">
      <input name="occupation" type="text" class="lInput01" size="30" maxlength="50" value="<%=occupation%>"/>
    </td>
  </tr>
  <%
    String fond = "";
    if ( query.getFond() != null && !query.getFond().equals("null") && !query.getFond().equals("") )
    	fond = query.getFond();
  %>
  <tr class="tr">
    <td class="T12b">喜好</td>
    <td colspan="3">
      <input name="fond" type="text" class="lInput01" size="30" maxlength="50" value="<%=fond%>"/>
    </td>
  </tr>
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

</form>
</body>
</html>

