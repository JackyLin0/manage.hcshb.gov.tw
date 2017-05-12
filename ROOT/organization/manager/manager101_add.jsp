<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：manager101_add.jsp
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

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String language = ( String )request.getParameter( "language" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String murlback = ( String )request.getParameter( "murl" );

%>  

<script>  
  function qsort(pubunitdn)
  {
     newwnd = window.open('manager_qsort.jsp?pubunitdn='+pubunitdn,'','width=500,height=300,scrollbars=yes,left=400,top=150');
  }
        
  function back()
  {
     document.back.action="manager101.jsp";
     document.back.method="post";
     document.back.submit();
  }
  
  function save()
  {
     if ( document.mform.punit.value == '' )
     {
        alert("【發布單位】欄位，不可空白，請選擇！");
        document.mform.punit.focus();
        return;
     }
     if ( document.mform.name.value == '' ) 
     {
        alert("【姓名】欄位，不可空白，請輸入！");
        document.mform.name.focus();
        return;
     }
     if ( document.mform.proftitle.value == '' ) 
     {
        alert("【職稱】欄位，不可空白，請輸入！");
        document.mform.proftitle.focus();
        return;
     }
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
     
     document.mform.action = "manager101_addsave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

<body>
<form name="back">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
  <input type="hidden" name="murl" value="<%=murlback%>"/>
</form>

<form name="mform" enctype="multipart/form-data">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
  
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
    <td class="T12b"><span class="T12red">※</span>姓名</td>
    <td colspan="3">
      <input name="name" type="text" class="lInput01" size="30" />
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>職稱</td>
    <td colspan="3">
      <input name="proftitle" type="text" class="lInput01" size="60" />
      <span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr class="tr">
    <td class="T12b">項目1</td>
    <td colspan="3">
      <input name="item1" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容1</td>
    <td colspan="3">
      <textarea name="content1" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent1">
  </tr>
  <tr class="tr">
    <td class="T12b">項目2</td>
    <td colspan="3">
      <input name="item2" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容2</td>
    <td colspan="3">
      <textarea name="content2" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent2">
  </tr>
  <tr class="tr">
    <td class="T12b">項目3</td>
    <td colspan="3">
      <input name="item3" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容3</td>
    <td colspan="3">
      <textarea name="content3" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent3">
  </tr>
  <tr class="tr">
    <td class="T12b">項目4</td>
    <td colspan="3">
      <input name="item4" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容4</td>
    <td colspan="3">
      <textarea name="content4" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent4">
  </tr>
  <tr class="tr">
    <td class="T12b">項目5</td>
    <td colspan="3">
      <input name="item5" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容5</td>
    <td colspan="3">
      <textarea name="content5" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent5">
  </tr>
  <tr class="tr">
    <td class="T12b">項目6</td>
    <td colspan="3">
      <input name="item6" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容6</td>
    <td colspan="3">
      <textarea name="content6" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent6">
  </tr>
  <tr class="tr">
    <td class="T12b">項目7</td>
    <td colspan="3">
      <input name="item7" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容7</td>
    <td colspan="3">
      <textarea name="content7" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent7">
  </tr>
  <tr class="tr">
    <td class="T12b">項目8</td>
    <td colspan="3">
      <input name="item8" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容8</td>
    <td colspan="3">
      <textarea name="content8" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent8">
  </tr>
  <tr class="tr">
    <td class="T12b">項目9</td>
    <td colspan="3">
      <input name="item9" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容9</td>
    <td colspan="3">
      <textarea name="content9" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent9">
  </tr>
  <tr class="tr">
    <td class="T12b">項目10</td>
    <td colspan="3">
      <input name="item10" type="text" class="lInput01" size="60" />
      <br><span class="T10">    (至多20個中文字）</span>
    </td>
  </tr>  
  <tr>
    <td class="T12b">內容10</td>
    <td colspan="3">
      <textarea name="content10" cols="70" rows="3"></textarea>
      <br><span class="T10">    (至多200個中文字）</span>
    </td>
    <input type="hidden" name="mcontent10">
  </tr>                
  <tr class="tr">
    <td class="T12b">現　任</td>
    <td colspan="3">
      <input name="iscurrent" type="radio" value="1" checked/>是&nbsp;&nbsp;
      <input name="iscurrent" type="radio" value="0"/>否
    </td>
  </tr>
  <tr>
    <td class="T12b" width="15%">圖片上傳</td>
    <td class="T12b">
      <input name="filename1" type="file" class="lInput01" size="20" />
      <br><span class="T10">(圖片大小不可超過1M；圖片之副檔名僅可上傳【jpg】【jpeg】【gif】【png】之檔案)</span>
      <br><span class="T10">【建議圖片解析度為72dpi，寬140像素(約5公分)】</span>
    </td>
  </tr>  
  <tr class="tr">
    <td class="T12b" width="15%">圖片說明</td>
    <td class="T12b">
      <textarea name="fileexp1" cols="40" rows="3" class="lInput01"></textarea>
      <span class="T8-5">    (至多150字）</span>
    </td>
    <input type="hidden" name="mfileexp1">
  </tr>
  <tr>
    <td class="T12b" width="15%">排序</td>
    <td class="T12b">
      <input name="fsort" type="text" class="lInput01" size="10" maxlength="2" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      <input type="button" value="查詢" onclick="qsort('<%=pubunitdn%>')"/>
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

<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

