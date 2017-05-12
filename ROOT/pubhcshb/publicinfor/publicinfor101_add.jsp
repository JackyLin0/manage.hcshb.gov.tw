<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：publicinfor101_add.jsp
說明：公開資訊
開發者：chmei
開發日期：99.05.25
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公開資訊</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function back()
  {
     document.backform.action="publicinfor101.jsp";
     document.backform.method="post";
     document.backform.submit();
  }
  
  function chg()
  {
	  for ( var i=0;i<document.all.flag.length;i++ ) {
		  if ( document.all.flag[i].checked ) {
			  var mflag_value = document.all.flag[i].value;
			  switch(mflag_value) {
			     case "1":
				      window.type1.style.display='block';
				      window.type2.style.display='none';
				      window.type3.style.display='none';
				      window.type4.style.display='none';
				      window.type5.style.display='none';
				      break;
				 case "2":
					  window.type1.style.display='none';
					  window.type2.style.display='block';
					  window.type3.style.display='none';
					  window.type4.style.display='none';
					  window.type5.style.display='none';
					  break;
				 case "3":
					  window.type1.style.display='none';
					  window.type2.style.display='none';
					  window.type3.style.display='block';
					  window.type4.style.display='block';
					  window.type5.style.display='none';
					  break;
				 case "4":
					  window.type1.style.display='none';
					  window.type2.style.display='none';
					  window.type3.style.display='none';
					  window.type4.style.display='none';
					  window.type5.style.display='block';
					  break;	  
			  }
		  }
	  }    
  }
  
  function qsort(tablename,logindn)
  {
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
  
  function save(path) {
	  if ( document.mform.stdate.value == '' ) {
		  alert("【發布日期】欄位，不可空白，請選擇！");
		  document.mform.date1.focus();
		  return;
	  }
	  if ( document.mform.startusing[1].checked ) {
		  if ( document.mform.endate.value == '' ) {
			  alert("【截止日期】欄位，不可空白，請選擇！");
			  document.mform.date2.focus();
			  return;
		  }
		  if ( document.mform.stdate.value > document.mform.endate.value ) {
			  alert("【發布日期】不可大於【截止日期】！");
			  document.mform.date1.focus();
			  return;
		  }
	  }
	  if ( document.mform.subject.value == '' ) {
		  alert("【標題】欄位，不可空白，請選擇！");
		  document.mform.subject.focus();
		  return;
	  }
	  if ( document.mform.punit.value == '' ) {
		  alert("【發布單位】欄位，不可空白，請選擇！");
		  document.mform.punit.focus();
		  return;
	  }
	  if ( document.mform.qclass.value == '' ) {
		  alert("【分類】欄位，不可空白，請選擇！");
		  document.mform.qclass.focus();
		  return;
	  }
	  if ( document.mform.flag[0].checked ) {
		  if ( document.mform.relateurl.value == 'http://' ) {
			  alert("【相關資訊連結】欄位，不可空白，請輸入！");
			  document.mform.relateurl.focus();
			  return;
		  }else if ( document.mform.relateurl.value.length > 170 ) {
			  alert("【相關資訊連結】欄位，不可超過170個字，請重新輸入！");
			  document.mform.relateurl.focus();
			  return;
		  }
		  if ( document.mform.relatename.value == '' ) {
			  alert("【網站名稱】欄位，不可空白，請輸入！");
			  document.mform.relatename.focus();
			  return;
		  }else if ( document.mform.relatename.value.length > 60 ) {
			  alert("【網站名稱】欄位，不可超過60個中文字，請重新輸入！");
			  document.mform.relatename.focus();
			  return;
		  }
	  }else if ( document.mform.flag[2].checked ){
		  if ( document.mform.filename.value == '' ) {
			  alert("【檔案上傳】欄位，不可空白，請選擇！");
			  document.mform.filename.focus();
			  return;
		  }
		  if ( document.mform.filename.value != "" ) {
			  var fn = document.mform.filename.value.toUpperCase();
			  if( (fn.indexOf(".DOC") < 0) && (fn.indexOf(".PDF") < 0) && (fn.indexOf(".TXT") < 0) && (fn.indexOf(".XLS") < 0) && (fn.indexOf(".PPT") < 0) ) {
				  alert("您所選的檔案(2)之副檔名不是【.DOC 或 .PDF 或 .TXT 或 .XLS 或 .PPT】，請重新選擇！");
				  document.mform.filename.focus();
				  return;
			  }
		  }
		  if ( (document.mform.filename.value != '') && (document.mform.fileexp.value == '') ) {
			  alert("有上傳檔案者，其【檔案說明】欄位，不可空白，請輸入！");
			  document.mform.fileexp.focus();
			  return;
		  }else if ( document.mform.fileexp.value.length > 150 ) {
			  alert("【檔案說明】欄位，不可超過150個中文字，請重新輸入！");
			  document.mform.fileexp.focus();
			  return;
		  }
	  }else if ( document.mform.flag[3].checked ){
		  if ( document.mform.content.value == '' ) {
			  alert("【詳細內容】欄位，不可空白，請輸入！");
              document.mform.content.focus();
              return;
          }
      }

      //因上傳元件，需將換行等tag replace
      if ( document.mform.fileexp.value != '' ) {
          var contentStr = document.mform.fileexp.value;
          while (contentStr.indexOf("\n") != -1) {
              contentStr = contentStr.replace("\n", "|");
          }
          while (contentStr.indexOf("\r") != -1) {
              contentStr = contentStr.replace("\r", "");
          }
          while (contentStr.indexOf("\t") != -1) {
              contentStr = contentStr.replace("\t", "");
          }
          document.mform.fileexp1.value = contentStr;
          document.mform.fileexp.value = "";
      }

      document.mform.action = "publicinfor101_addsave.jsp?path=" + path;
      document.mform.method = "post";
      document.mform.submit();
  }    
</script>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


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
  //取tablemenu
  String[] ary_websitedn = SvString.split(websitedn,",");
  String table1 = SvString.right(ary_websitedn[0],"=");
  String menutable = table1.substring(0,1).toUpperCase() + table1.substring(1) + "Menu";
  
  String language = ( String )request.getParameter( "language" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String path = ( String )request.getParameter( "path" );
  
  String table = ( String )request.getParameter( "t" );

%>  

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
  <input type="hidden" name="fileexp1"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=path%>')">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料新增</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="17%"><span class="T12red">※</span>發布日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date1"/>
          <jsp:param name="colname" value="stdate"/>
          <jsp:param name="colnameview" value="stdateview"/>
      </jsp:include>  
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>啟用</td>
    <td colspan="3">
      <input type="radio" name="startusing" value="1" onclick="chg1()" checked>永久有效&nbsp;&nbsp;&nbsp;
      <input type="radio" name="startusing" value="0" onclick="chg1()">截止日期
    </td>
  </tr>
  <tr id='type' style='display:none'>
    <td class="T12b"><span class="T12red">※</span>截止日期</td>
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
    <td class="T12b"><span class="T12red">※</span>分類</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qpubclass.jsp">
          <jsp:param name="language" value="<%=language%>"/>
          <jsp:param name="tablename" value="PublicInforClass"/>
          <jsp:param name="colname" value="qclass"/>
      </jsp:include>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>屬性</td>
    <td colspan="3">
      <input type="radio" name="flag" value="1" onclick="chg()" checked />連結外部網址
      <input type="radio" name="flag" value="2" onclick="chg()" />連結本網站功能
      <input type="radio" name="flag" value="3" onclick="chg()" />開啟檔案
      <input type="radio" name="flag" value="4" onclick="chg()" />輸入內容
    </td>
  </tr>
  <tr class="tr" id='type1' style="display:block">
    <td class="T12b"><span class="T12red">※</span>連結外部網址</td>
    <td colspan="3">
      <input name="relateurl" type="text" class="lInput01" value="http://" size="42" maxlength="170" />&nbsp;
      <span class="T12b">請輸入網站名稱</span>&nbsp;<input name="relatename" type="text" class="lInput01" size="27" value="" maxlength="60" />
    </td>
  </tr>
  <tr class="tr" id='type2' style="display:none">
    <td class="T12b"><span class="T12red">※</span>連結本局<br>&nbsp;&nbsp;網站功能</td>
    <%
      PublicInforData qmenu = new PublicInforData();
      ArrayList<Object> qlists = qmenu.findByday(menutable);
      int rcount = qmenu.getAllrecordCount();
    %>
    <td colspan="3">
      <select name="menu">
      <%
        if ( qlists != null ) {
        	for ( int i=0; i<rcount; i++ ) {
        		PublicInforData qlist = ( PublicInforData )qlists.get( i );
        		String contlink = SvString.right(qlist.getContlink(),"/");
        		if ( websitedn.equals("ou=hcshb,ou=ap_root,o=hcshb,c=tw") )
        			contlink = "hcshb/" + contlink;
        		String datavalue = "home.jsp?serno=" + qlist.getMenuserno() + "&mserno=" + qlist.getTopserno() + "&contlink=" + contlink + "&menudata=" + menutable;
        		datavalue = datavalue + "||" + qlist.getIslevelcontent() + "||" + qlist.getMenuserno(); %>
        		<option value="<%=datavalue%>"><%=qlist.getIslevelcontent()%></option>
        	<%}
        }%>
      </select>
    </td>
  </tr>
  <tr class="tr" id='type3' style="display:none">
    <td class="T12b" width="15%"><span class="T12red">※</span>檔案上傳</td>
    <td class="T12b">
      <input name="filename" type="file" class="lInput01" size="20" />
      <br/><span class="T10">(檔案大小不可超過1M；僅可上傳【doc】【pdf】【xls】【txt】【ppt】之檔案)</span>
    </td>
  </tr>  
  <tr class="tr" class="tr" id='type4' style="display:none">
    <td class="T12b" width="15%"><span class="T12red">※</span>檔案說明</td>
    <td class="T12b">
      <input name="fileexp" type="text" class="lInput01" size="25" maxlength="150" />
      <span class="T10">    (不可超過150個中文字）</span>
    </td>
  </tr>
  <tr class="tr" id='type5' style="display:none">
    <td class="T12b"><span class="T12red">※</span>詳細內容</td>
    <td colspan="3">
      <textarea name="content" rows="10" cols="78"></textarea>
      <br><span class="T10">    (不可超過2000個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">排　序</td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;<input type="button" value="查 詢" onclick="qsort('<%=table%>','<%=logindn%>')" />
    </td>
  </tr>
  <tr >
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

