<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manager101_mdy.jsp
說明：主管簡介
開發者：chmei
開發日期：97.02.21
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
  String name = ( String )request.getParameter( "name" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  
  //參數
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String serno = ( String )request.getParameter( "serno" );
  String language = ( String )request.getParameter( "language" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String murlback = ( String )request.getParameter( "murl" );
  
  String path = ( String )session.getAttribute("path");
  
  ManagerData query = new ManagerData();  
  boolean rtn = query.load(serno);  

%>  

<script>
  function back()
  {
     document.back.action="manager101.jsp";
     document.back.method="post";
     document.back.submit();
  }
  function qsort(pubunitdn)
  {
     newwnd = window.open('manager_qsort.jsp?pubunitdn='+pubunitdn,'','width=500,height=300,scrollbars=yes,left=400,top=150');
  }
          
  function save()
  {
     if ( document.mform.mname.value == '' ) 
     {
        alert("【姓名】欄位，不可空白，請輸入！");
        document.mform.mname.focus();
        return;
     }
     if ( document.mform.proftitle.value == '' ) 
     {
        alert("【職稱】欄位，不可空白，請輸入！");
        document.mform.proftitle.focus();
        return;
     }

     if ( document.mform.filename1.value != '' ) 
     {
        var fn = document.mform.filename1.value.toUpperCase();
        if( (fn.indexOf(".JPG") < 0) && (fn.indexOf(".JPEG") < 0) && (fn.indexOf(".GIF") < 0) && (fn.indexOf(".PNG") < 0) )
        {
           alert("您所選的圖片之副檔名不是【.JPG 或 .GIF 或 .JPEG 或 .PNG】，請重新選擇！");
           document.mform.filename1.focus();
           return;
        }
     }
     if ( document.mform.filename1.value != '' ) 
     {
        if ( document.mform.fileexp1.value == '' )
        {
           alert("【圖片說明】欄位，不可空白，請輸入！");
           document.mform.fileexp1.focus();
           return;
        }else if ( document.mform.fileexp1.value.length > 150 ) {
           alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
           document.mform.fileexp1.focus();
           return;
        }
     }  
     if ( document.mform.filename1.value != '' )
        document.mform.nsfile.value = document.mform.filename1.value;
     
     //因上傳元件，需將換行等tag replace
     for ( i=1; i<11; i++ )
     {
        thisform = "document.mform.content"+i;
        thisform1 = "document.mform.mcontent"+i;
        if ( eval(thisform).value != '' )
        {
           var contentStr = eval(thisform).value;
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
           eval(thisform1).value = contentStr;
           eval(thisform).value = "";
        }    
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
     
     document.mform.action = "manager101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }
    
  function del(serno)
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.back.action="manager101_del.jsp?type=1&serno="+serno;
        document.back.method="post";
        document.back.submit();
     } 
  }        
</script>

<body>
<form name="back">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
  <input type="hidden" name="murl" value="<%=murlback%>"/>
  <input type="hidden" name="name" value="<%=name%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
</form>

<form name="mform" enctype="multipart/form-data">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
  <input type="hidden" name="name" value="<%=name%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:del('<%=serno%>')">刪除</a>	
 <a class="md" href="javascript:window.document.mform.reset()">重設</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3"><%=query.getPubunitname()%></td>
    <input type="hidden" name="punit" value=<%=query.getPubunitdn()%>>
    <input type="hidden" name="pubunitname" value=<%=query.getPubunitname()%>>
  </tr> 
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>姓名</td>
    <td colspan="3">
      <input name="mname" type="text" class="lInput01" size="30" value="<%=query.getName()%>" />
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>職稱</td>
    <td colspan="3">
      <input name="proftitle" type="text" class="lInput01" size="60" value="<%=query.getProftitle()%>" />
      <span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">項目1</td>
    <td colspan="3">
      <input name="item1" type="text" class="lInput01" size="60" value="<%=query.getItem1()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容1</td>
    <td colspan="3">
      <textarea name="content1" cols="70" rows="3"><%=query.getContent1()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent1">
  </tr>
  <tr class="tr">
    <td class="T12b">項目2</td>
    <td colspan="3">
      <input name="item2" type="text" class="lInput01" size="60" value="<%=query.getItem2()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容2</td>
    <td colspan="3">
      <textarea name="content2" cols="70" rows="3"><%=query.getContent2()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent2">
  </tr>
  <tr class="tr">
    <td class="T12b">項目3</td>
    <td colspan="3">
      <input name="item3" type="text" class="lInput01" size="60" value="<%=query.getItem3()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容3</td>
    <td colspan="3">
      <textarea name="content3" cols="70" rows="3"><%=query.getContent3()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent3">
  </tr>
  <tr class="tr">
    <td class="T12b">項目4</td>
    <td colspan="3">
      <input name="item4" type="text" class="lInput01" size="60" value="<%=query.getItem4()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容4</td>
    <td colspan="3">
      <textarea name="content4" cols="70" rows="3"><%=query.getContent4()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent4">
  </tr>
  <tr class="tr">
    <td class="T12b">項目5</td>
    <td colspan="3">
      <input name="item5" type="text" class="lInput01" size="60" value="<%=query.getItem5()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容5</td>
    <td colspan="3">
      <textarea name="content5" cols="70" rows="3"><%=query.getContent5()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent5">
  </tr>
  <tr class="tr">
    <td class="T12b">項目6</td>
    <td colspan="3">
      <input name="item6" type="text" class="lInput01" size="60" value="<%=query.getItem6()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容6</td>
    <td colspan="3">
      <textarea name="content6" cols="70" rows="3"><%=query.getContent6()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent6">
  </tr>
  <tr class="tr">
    <td class="T12b">項目7</td>
    <td colspan="3">
      <input name="item7" type="text" class="lInput01" size="60" value="<%=query.getItem7()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容7</td>
    <td colspan="3">
      <textarea name="content7" cols="70" rows="3"><%=query.getContent7()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent7">
  </tr>
  <tr class="tr">
    <td class="T12b">項目8</td>
    <td colspan="3">
      <input name="item8" type="text" class="lInput01" size="60" value="<%=query.getItem8()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容8</td>
    <td colspan="3">
      <textarea name="content8" cols="70" rows="3"><%=query.getContent8()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent8">
  </tr>
  <tr class="tr">
    <td class="T12b">項目9</td>
    <td colspan="3">
      <input name="item9" type="text" class="lInput01" size="60" value="<%=query.getItem9()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容9</td>
    <td colspan="3">
      <textarea name="content9" cols="70" rows="3"><%=query.getContent9()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent9">
  </tr>
  <tr class="tr">
    <td class="T12b">項目10</td>
    <td colspan="3">
      <input name="item10" type="text" class="lInput01" size="60" value="<%=query.getItem10()%>" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容10</td>
    <td colspan="3">
      <textarea name="content10" cols="70" rows="3"><%=query.getContent10()%></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent10">
  </tr>                
  <tr class="tr">
    <td class="T12b">現　任</td>
    <td colspan="3">
      <input name="iscurrent" type="radio" value="1" <%=(query.getIscurrent().equals("1") ? "checked" : "")%>/>是&nbsp;&nbsp;
      <input name="iscurrent" type="radio" value="0" <%=(query.getIscurrent().equals("0") ? "checked" : "")%>/>否
    </td>
  </tr>
  <%
    String oclientfile1 = query.getClientfile1();
    String oserverfile1 = query.getServerfile1();
    String oexpfile1 = query.getExpfile1();
  %>
  <tr>
    <td class="T12b" width="15%">圖片上傳</td>
    <td class="T12b">
      <input name="filename1" type="file" class="lInput01" size="20" />
      <%
        if ( oserverfile1 != null && !oserverfile1.equals("") ) { %>
        	<br><br><span class="T10">【原圖片檔名】：<a href="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile1,"UTF-8")%>&flag=pic"><%=oclientfile1%></a></span>
        	&nbsp;&nbsp;&nbsp;<input type="checkbox" name="dfile"/><span class="T10">刪除原檔案&nbsp;&nbsp;(說明：若只要替代檔案，此欄不需打勾)</span>
        <%}%>
        <input type="hidden" name="osfile" value="<%=oserverfile1%>"/> 
        <input type="hidden" name="ocfile" value="<%=oclientfile1%>"/>  
        <br><span class="T10">(圖片大小不可超過1M；圖片之副檔名僅可上傳【jpg】【jpeg】【gif】【png】之檔案)</span>
        <br><span class="T10">【建議圖片解析度為72dpi，寬140像素(約5公分)】</span> 
    </td>
    <input type="hidden" name="nsfile">
  </tr>  
  <tr class="tr">
    <td class="T12b" width="15%">圖片說明</td>
    <td class="T12b">
      <textarea name="fileexp1" cols="40" rows="3" class="lInput01"><%=oexpfile1%></textarea>
      <span class="T8-5">    (至多150字）</span>
    </td>
    <input type="hidden" name="mfileexp1">
  </tr>
  <tr>
    <td class="T12b" width="15%">排序</td>
    <td class="T12b">
      <input name="fsort" type="text" class="lInput01" size="10" maxlength="2" value=<%=query.getFsort()%> ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      <input type="button" value="查詢" onclick="qsort('<%=query.getPubunitdn()%>')"/>
      <br><span class="T10">(輸入數值同目前有數值，會將現有該數值往後遞延；不輸者，由系統自動排序）</span>
    </td>
  </tr>  
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<br>
<%
  if ( !oserverfile1.equals("") ) { %>
	  <table border="0" width="100%">
	  <tr>
	    <td align="center">
	      <img src="../../showimage?file=<%=path%>/<%=java.net.URLEncoder.encode(oserverfile1,"UTF-8")%>&flag=pic&w=230&h=275" alt="<%=oexpfile1%>" border="0">
	    </td>
	  </tr>  
	</table>
  <%}%>

<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

