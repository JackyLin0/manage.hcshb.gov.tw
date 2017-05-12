<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：restaurant101_mdy.jsp
說明：無菸餐廳
開發者：chmei
開發日期：97.01.14
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
  
  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  String path = ( String )request.getParameter( "path" );
  String language = ( String )request.getParameter( "language" );
  
  RestaurantData query = new RestaurantData();  
  boolean rtn = query.load(serno,table);

%>  

<script>
  function back()
  {
     document.mform.action="restaurant101.jsp";
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
        alert("【餐廳名稱】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     if ( document.mform.mclass.value == '' )
     {
        alert("【分類】欄位，不可空白，請選擇！");
        document.mform.mclass.focus();
        return;
     }     
     if ( document.mform.AddrZone.value == '' || document.mform.cityno.value == '' || document.mform.townsno.value == '' || document.mform.Addr.value == '' || document.mform.Addr.value.indexOf("請輸入") != "-1" )
     {
        alert("【地址】欄位，不可空白，請選擇！");
        document.mform.AddrZone.focus();
        return;
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
     
     if ( document.mform.liaisonemail.value != '' )
     {
  	    var m=document.mform.liaisonemail.value;
         if (m.indexOf("@") =="-1" ||
             m.indexOf("@@") !="-1" ||
             m.indexOf("@.") !="-1" ||
             m.indexOf(".@") !="-1" ||
             m.indexOf(".") =="-1" ||
             m.substring(m.length-1,m.length) =="." ||
             m.substring(m.length-1,m.length) =="@") 
         {
            alert("E-mail格式錯誤，請重新輸入!!");
            document.mform.liaisonemail.focus();
            return;
         }
     }
     
     document.mform.action = "restaurant101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  } 
  
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="restaurant101_del.jsp?type=1";
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
  <input type="hidden" name=language value="<%=language%>"/>
  
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
    <td class="T12b" width="20%"><span class="T12red">※</span>發布日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date1"/>
          <jsp:param name="colname" value="stdate"/>
          <jsp:param name="colnameview" value="stdateview"/>
          <jsp:param name="datevalue" value="<%=query.getPosterdate()%>" />
      </jsp:include>  
    </td>
  </tr>
  <%
    String mstartusing = query.getStartusing();
    String mstyle = "style='display:none'";
    if ( mstartusing.equals("0") )
    	mstyle = "style='display:block'";
  %>
  <tr>
    <td class="T12b" width="15%"><span class="T12red">※</span>啟用</td>
    <td colspan="3">
      <input type="radio" name="startusing" value="1" onclick="chg()" <%=(mstartusing.equals("1") ? "checked" : "")%>>永久有效&nbsp;&nbsp;&nbsp;
      <input type="radio" name="startusing" value="0" onclick="chg()" <%=(mstartusing.equals("0") ? "checked" : "")%>>截止日期
    </td>
  </tr>
  <tr id='type' <%=mstyle%>>
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
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>餐廳名稱</td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="50" maxlength="50" value="<%=query.getSubject()%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3"><%=query.getPubunitname()%></td>
    <input type="hidden" name="punit" value=<%=query.getPubunitdn()%>>
    <input type="hidden" name="pubunitname" value=<%=query.getPubunitname()%>>
  </tr>  
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>分類</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qclass.jsp">
          <jsp:param name="formname" value="mform"/>
          <jsp:param name="tablename" value="RestaurantClass"/>
          <jsp:param name="colname" value="mclass"/>
          <jsp:param name="pcolname" value="punit"/>
          <jsp:param name="datavalue" value="<%=query.getMserno()%>"/>
      </jsp:include>              
    </td>
  </tr>
  <tr>
    <td valign="top" class="T12b">簡介(特色)</td>
    <td colspan="3"><textarea name="content" cols="80" rows="18"><%=query.getContent()%></textarea></td>
  </tr> 
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>地址</td>
    <%
      String mtownsno = query.getArea() + "||" + query.getTownsno(); 
    %>
    <td colspan="3">
      <jsp:include page="../../pubprogram/address.jsp">
          <jsp:param name="type" value="upd" />
          <jsp:param name="area" value="<%=query.getArea()%>" />
          <jsp:param name="cityno" value="<%=query.getCityno()%>" />
          <jsp:param name="townsno" value="<%=mtownsno%>" />
          <jsp:param name="addr" value="<%=query.getAddress()%>" />
      </jsp:include>
    </td>
  </tr>  
  <%
    String mrelaturl = query.getRelateurl();
    String mrelatname = query.getRelatename();
    if ( mrelaturl == null || mrelaturl.equals("null") || mrelaturl.equals("") )
    	mrelaturl = "http://";
    if ( mrelatname == null || mrelatname.equals("null") )
    	mrelatname = "";
  %>
  <tr>
    <td class="T12b">相關資訊連結</td>
    <td colspan="3">
      <input name="relateurl" type="text" class="lInput01" size="45" maxlength="120" value="<%=mrelaturl%>"/>&nbsp;
      <span class="T12b">請輸入網站名稱</span>&nbsp;<input name="relatename" type="text" class="lInput01" size="30" maxlength="60" value=<%=((mrelatname == null) ? "" : mrelatname)%>>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">排　序</td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" value="<%=query.getFsort()%>" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;<input type="button" value="查 詢" onclick="qsort('<%=table%>','<%=logindn%>')" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(輸入數值同目前有數值，系統自動將現有該數值往後遞延）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">聯絡人</td>
    <%
      String mname = query.getLiaisonper();
      if ( mname == null || mname.equals("null") )
    	  mname = "";
    %>
    <td colspan="3">
      <input name="liaisonper" type="text" class="lInput01" size="70" maxlength="20" value="<%=mname%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">聯絡電話</td>
    <%
      String mtel = query.getLiaisontel();
      if ( mtel == null || mtel.equals("null") )
    	  mtel = "";
    %>
    <td colspan="3">
      <input name="liaisontel" type="text" class="lInput01" size="70" maxlength="20" value="<%=mtel%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個字）</span>
    </td>
  </tr>
  <tr">
    <td class="T12b">電子信箱</td>
    <%
      String memail = query.getLiaisonemail();
      if ( memail == null || memail.equals("null") )
    	  memail = "";
    %>
    <td colspan="3">
      <input name="liaisonemail" type="text" class="lInput01" size="70" maxlength="40" value="<%=memail%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過40個字）</span>
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

