<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：indexbanner101_add.jsp
說明：首頁活動預告
開發者：chmei
開發日期：2016.11.21
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="sysview.zhiren.function.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  String websitedn = ( String )request.getParameter( "websitedn" );
  String language = ( String )request.getParameter( "language" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );

%>  

<script>
  function back() {
     document.backform.action="indexbanner101.jsp";
     document.backform.method="post";
     document.backform.submit();
  }

  function qsort(tablename,logindn) {
     newwnd = window.open('../../pubprogram/qsort.jsp?tablename='+tablename+'&logindn='+logindn,'','width=600,height=400,scrollbars=yes,left=300,top=150');
  }
  
  function chg1()
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
     if ( document.mform.filename1.value == '' ) 
     {
        alert("【圖片上傳】欄位，不可空白，請選擇！");
        document.mform.filename1.focus();
        return;
     }
     if ( document.mform.filename1.value != "" )
     {
        var fn = document.mform.filename1.value.toUpperCase();
        if( (fn.indexOf(".JPG") < 0) && (fn.indexOf(".JPEG") < 0) && (fn.indexOf(".GIF") < 0) && (fn.indexOf(".PNG") < 0) )
        {
           alert("您所選的圖片之副檔名不是【.JPG 或 .GIF 或 .JPEG 或 .PNG】，請重新選擇！");
           document.mform.filename1.focus();
           return;
        }  
     }
     if ( (document.mform.filename1.value != '') && (document.mform.fileexp1.value == '') )
     {
        alert("【圖片說明】欄位，不可空白，請輸入！");
        document.mform.fileexp1.focus();
        return;
     }else if ( document.mform.fileexp1.value.length > 150 ) {
        alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
        document.mform.fileexp1.focus();
        return;
     }
     
     if ( document.mform.relateurl.value == 'http://' || document.mform.relateurl.value == '' )
     {
        alert("【相關資訊連結】欄位，不可空白，請輸入！");
        document.mform.relateurl.focus();
        return;
     }else if ( document.mform.relateurl.value.length > 120 ) {
        alert("【相關資訊連結】欄位，不可超過120個字，請重新輸入！");
        document.mform.relateurl.focus();
        return;
     }
     if ( document.mform.relatename.value == '' )
     {
        alert("【網站名稱】欄位，不可空白，請輸入！");
        document.mform.relatename.focus();
        return;
     }else if ( document.mform.relatename.value.length > 60 ) {
        alert("【網站名稱】欄位，不可超過60個中文字，請重新輸入！");
        document.mform.relatename.focus();
        return;
     }
     
     //因上傳元件，需將換行等tag replace
     if ( document.mform.fileexp1.value != '' )
     {
        var contentStr = document.mform.fileexp1.value;
        while (contentStr.indexOf("\n") != -1)
        {
           contentStr = contentStr.replace("\n", "|");
        }
        while (contentStr.indexOf("\r") != -1)
        {
           contentStr = contentStr.replace("\r", "");
        }
        while (contentStr.indexOf("\t") != -1)
        {
           contentStr = contentStr.replace("\t", "");
        }
        document.mform.mfileexp1.value = contentStr;
        document.mform.fileexp1.value = "";
     }
     
     document.mform.action = "indexbanner101_addsave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

<body>
<form name="backform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
  
<form name="mform" enctype="multipart/form-data">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
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
    <td class="T12b" width="22%"><span class="T12red">※</span>發布日期</td>
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
      <input type="radio" name="startusing" value="1" onclick="chg1()" checked>永久有效&nbsp;&nbsp;&nbsp;
      <input type="radio" name="startusing" value="0" onclick="chg1()">截止日期
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
      <input name="subject" type="text" class="lInput01" size="70" maxlength="50" />
      <span class="T10">(不可超過50個中文字)</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
      </jsp:include>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b" width="15%"><span class="T12red">※</span>圖片上傳</td>
    <td class="T12b">
      <input name="filename1" type="file" class="lInput01" size="20" />
      <br><span class="T10">(圖片大小不可超過1M；圖片僅可上傳【jpg】【jpeg】【gif】【png】之檔案)</span>
      <br><span class="T10">【建議圖片尺寸230*170】</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b" width="15%"><span class="T12red">※</span>圖片說明</td>
    <td class="T12b">
      <textarea name="fileexp1" cols="40" rows="3" class="lInput01"></textarea>
      <span class="T10">    (不可超過150個中文字）</span>
    </td>
    <input type="hidden" name="mfileexp1"/>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>相關連結</td>
    <td colspan="3">
      <input name="relateurl" type="text" class="lInput01" value="http://" size="42" maxlength="120" />&nbsp;
      <span class="T12b">請輸入網站名稱</span>&nbsp;<input name="relatename" type="text" class="lInput01" size="27" value="" maxlength="60" />
    </td>
  </tr>
  <tr>
    <td class="T12b">排　序</td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
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

