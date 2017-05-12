<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperdata101_add.jsp
說明：電子報資料維護
開發者：chmei
開發日期：97.03.01
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
  var RowContents=new Array();   //每一行的物件內容
  var mytab;                    //Table物件
  // IE 或 Netscape
  if (navigator.appName.indexOf("Netscape") != -1) 
    isNS=true;
  else 
    isNS=false;

  // TbName:Table Id   RowIndex:欲複製的列數，若未設定則預設為最後一行
  function GetSourceRow(TbName,RowIndex) 
  {
  	 if (isNS) 
  	   mytab = document.getElementById(TbName);
  	 else
  	   mytab = document.all[TbName];
  	   
  	 if (!RowIndex)
  	   RowIndex=mytab.rows.length - 1;
  	 var SourceRow = mytab.rows[RowIndex]		
  	 for (var i=0; i<SourceRow.cells.length; i++) 
  	  {
  	 	RowContents[i]=SourceRow.cells[i].innerHTML
  	  }
  }
  
  // 增加詳細內容一列
  function AddRow() 
  {
      var rec = eval(document.mform.rec.value) + 1;
      var k = eval(rec) - 1;
         	       	       	       	       	       	       	       	     
	  var SourceRow = mytab.rows[mytab.rows.length - 1]
	  mytab.insertRow(mytab.rows.length)
	  var newrow = mytab.rows[mytab.rows.length - 1]
	  	 
	  for (var i=0; i<SourceRow.cells.length; i++)
	  {   
	     newrow.insertCell(i)
	     var data = k + "." + "<textarea name=content" + k + " cols=80 rows=7></textarea><br><span class=T10>    &nbsp;&nbsp;&nbsp;&nbsp;(至多1500個中文字）</span>";
	     newrow.cells[i].innerHTML=newrow.cells[i].innerHTML=data;
	  }
	  document.mform.rec.value=rec; 
  }
    
  function back()
  {
     document.mform.action="epaperdata101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
    
  function qsort(tablename,logindn)
  {
     newwnd = window.open('../../pubprogram/qsort.jsp?tablename='+tablename+'&logindn='+logindn,'','width=600,height=400,scrollbars=yes,left=300,top=150');
  }

  function save()
  {
     if ( document.mform.subject.value == '' )
     {
        alert("【欄位】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     if ( document.mform.punit.value == '' )
     {
        alert("【發布單位】欄位，不可空白，請選擇！");
        document.mform.punit.focus();
        return;
     }
     if ( document.mform.mclass.value == '' )
     {
        alert("【分類】欄位，不可空白，請選擇！");
        document.mform.mclass.focus();
        return;
     }
     var num = document.mform.rec.value;
     if ( num == 1 )
     {
        alert("【詳細內容】欄位，至少需輸入一項，請輸入！");
        return;
     }
     
     document.mform.action = "epaperdata101_addsave.jsp";
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
    <td class="T12b"><span class="T12red">※</span>標題</td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="50" maxlength="50"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
          <jsp:param name="onchange" value="onchange=qryclass('punit')"/>
      </jsp:include>
    </td>
  </tr>  
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>分類</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qpubclass.jsp">
          <jsp:param name="formname" value="mform"/>
          <jsp:param name="tablename" value="EpaperClass"/>
          <jsp:param name="colname" value="mclass"/>
          <jsp:param name="pcolname" value="punit"/>
      </jsp:include>           
    </td>
  </tr>
  <tr>
    <td class="T12b" valign="top"><span class="T12red">※</span>詳細內容</td>
    <td colspan="3">
      <table border="0" width="97%">
        <tr align="left">
          <td><a class="md" href="javascript:AddRow()">新增一列</a></td>
        </tr>
        <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
          <td>
            <table id="Tab1" border="0" cellpadding="0" cellspacing="0" width="98%">
              <tr class="tr">
                <td class=T12b width="15%">
                </td>
              </tr>
              <input type="hidden" name="rec" value="1"/>
            </table>    
          </td>
        </tr>    
      </table>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">作者</td>
    <td colspan="3">
      <input name="author" type="text" class="lInput01" size="50" maxlength="50"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">出處</td>
    <td colspan="3">
      <input name="publisher" type="text" class="lInput01" size="50" maxlength="100"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">審稿者</td>
    <td colspan="3">
      <input name="examiner" type="text" class="lInput01" size="50" maxlength="100"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
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

  
<script>
   GetSourceRow("Tab1");
</script>  
