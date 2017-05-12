<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperdata101_mdy.jsp
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

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接收查詢條件
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );
  String keyword = ( String )request.getParameter( "keyword" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );  
  
  String table = ( String )request.getParameter( "t" );
  String serno = ( String )request.getParameter( "serno" );
  String path = ( String )request.getParameter( "path" );
  String language = ( String )request.getParameter( "language" );
  
  EpaperData query = new EpaperData();
  boolean rtn = query.load(serno,table);
  
  EpaperData qmitem = new EpaperData();
  ArrayList qitems = qmitem.findByday(serno);
  int rcount = qmitem.getAllrecordCount();
  
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
	     var data = k + "." + "<textarea name=content" + k + " cols=80 rows=7></textarea><br><span class=T10>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(至多1000個中文字）</span>";
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
          
     document.mform.action = "epaperdata101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  } 
  
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="epaperdata101_del.jsp?type=1";
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
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>標題</td>
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
      <jsp:include page="../../pubprogram/qpubclass.jsp">
          <jsp:param name="formname" value="mform"/>
          <jsp:param name="tablename" value="EpaperClass"/>
          <jsp:param name="colname" value="mclass"/>
          <jsp:param name="pcolname" value="punit"/>
          <jsp:param name="datavalue" value="<%=query.getMserno()%>"/>
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
            <table id="Tab1" width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr class="tr">
                <td class=T12b width="20%">
                  <%
                    if ( qitems != null ) {
                    	for ( int i=0; i<rcount; i++ ) {
                    		EpaperData qitem = ( EpaperData )qitems.get( i ); %>
                    		<%=i+1%>.<textarea name=content<%=i+1%> cols="80" rows="7"><%=qitem.getContent()%></textarea><br><span class=T10>    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(至多1000個中文字）</span><br>
                    	<%}
                    }%>
                </td>
              </tr>
              <input type="hidden" name="rec" value="<%=rcount+1%>"/>
            </table>    
          </td>
        </tr>    
      </table>
    </td>
  </tr>
  <%
    String mauthor = query.getAuthor();
    if ( mauthor == null || mauthor.equals("null") )
    	mauthor = "";
    String mpublisher = query.getPublisher();
    if ( mpublisher == null || mpublisher.equals("null") )
    	mpublisher = "";
    String mexaminer = query.getExaminer();
    if ( mexaminer == null || mexaminer.equals("null") )
    	mexaminer = "";
  %>
  <tr class="tr">
    <td class="T12b">作者</td>
    <td colspan="3">
      <input name="author" type="text" class="lInput01" size="50" maxlength="50" value="<%=mauthor%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">出處</td>
    <td colspan="3">
      <input name="publisher" type="text" class="lInput01" size="50" maxlength="50" value="<%=mpublisher%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">審稿者</td>
    <td colspan="3">
      <input name="examiner" type="text" class="lInput01" size="50" maxlength="100" value="<%=mexaminer%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b">排　序</td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" value="<%=query.getFsort()%>" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
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

<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

  
<script>
   GetSourceRow("Tab1");
</script>  
