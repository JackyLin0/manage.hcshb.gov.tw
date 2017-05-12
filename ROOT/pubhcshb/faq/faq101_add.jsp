<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：faq101_add.jsp
說明：FAQ答客問
開發者：chmei
開發日期：97.02.17
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String mlanguage = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String table2 = ( String )request.getParameter( "t2" );
  
  //尋找登入者的單位，設定欲發布之站台 start
  String aplistdn = ( String )request.getParameter( "webdn" );

  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  //單位網站對照檔
  WebsiteUnitData qweb = new WebsiteUnitData();
  boolean rtnunit = qweb.load(pubunitdn);
  String unitweb = "";
  if ( rtnunit )
	  unitweb = qweb.getWebsitedn();
  
  if ( mlanguage.equals("ch") )
	  mlanguage = "chinese";
  else if( mlanguage.equals("en") )
	  mlanguage = "english";
  else if ( mlanguage.equals("jp") )
	  mlanguage = "japan";

  WebSiteData qstart = new WebSiteData();
  boolean rtn = qstart.load(unitweb,mlanguage);
  String mstart = "";  
  if ( rtn )
	  mstart = qstart.getStartusing();
  
  //判斷此站台是否有納入框架
  int rcount = 0;  
  if ( mstart.equals("Y") ) {
	  PubWebsiteData qpub = new PubWebsiteData();
	  ArrayList qpubwebs = qpub.findByday(table1,unitweb,aplistdn,"P");  
	  rcount = qpub.getAllrecordCount();
  }else{
	  WebSiteData qpubwebs = new WebSiteData();
	  ArrayList qwebs = qpubwebs.findByday(mlanguage);
	  rcount = qpubwebs.getAllrecordCount();
  }  

%>  

<script>
  function back()
  {
     document.mform.action="faq101.jsp";
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
               
  function save(rcount)
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
     if ( document.mform.subject.value == '' )
     {
        alert("【問題】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     if ( document.mform.content.value == '' )
     {
        alert("【解答】欄位，不可空白，請選擇！");
        document.mform.content.focus();
        return;
     }else if ( document.mform.content.value.length > 3000 ) {
        alert("【解答】欄位，不可超過1500個中文字，請重新輸入！");
        document.mform.content.focus();
        return;
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
          
     //檢查勾選的站台是否有選擇類別
     var mflag = 0;
     for ( i=0; i<rcount; i++ ) 
     {        
        var web = "websitedn"+i;
        var mweb = "document.mform.websitedn"+i;
        var mclass = "document.mform.webclass"+i;
        if (window.eval(mweb))
        {
           if ( eval(mweb).checked )
           {
              mflag = mflag + 1;
              if ( eval(mclass).value == '' )
              {
                 alert("【分類】欄位，不可空白，請選擇！");
                 eval(mclass).focus();
                 return;
              }   
           }
       }
     }

     if ( mflag == 0 )
     {
        alert("您未勾選【資料顯示站台】，請勾選！");
        document.mform.websitedn1.focus();
        return;
     }
     
     document.mform.action = "faq101_addsave.jsp?webrcount="+rcount;
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

</head>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="t2" value="<%=table2%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=rcount%>')"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:window.document.mform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4"><%=lang.getDataadd()%></th>
  </tr>
  <tr>
    <td class="T12b" width="15%"><span class="T12red">※</span><%=lang.getStartusing()%></td>
    <td colspan="3">
      <input type="radio" name="startusing" value="1" onclick="chg()" checked><%=lang.getPerpetual()%>&nbsp;&nbsp;&nbsp;
      <input type="radio" name="startusing" value="0" onclick="chg()"><%=lang.getClosedate()%>
    </td>
  </tr>
  <tr id='type' style='display:none'>
    <td class="T12b" width="20%"><span class="T12red">※</span><%=lang.getClosedate()%></td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date2"/>
          <jsp:param name="colname" value="endate"/>
          <jsp:param name="colnameview" value="endateview"/>
      </jsp:include>  
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getPubunitname()%></td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/qunit.jsp">
          <jsp:param name="colname" value="punit"/>
          <jsp:param name="language" value="ch"/>
      </jsp:include>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span><%=lang.getQuestion()%></td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="70" maxlength="100"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過100個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td valign="top" class="T12b"><span class="T12red">※</span><%=lang.getAnswer()%></td>
    <td colspan="3">
      <textarea name="content" cols="80" rows="12"></textarea>
      <br><span class="T10">(不可超過1500個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getFsort()%></td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      &nbsp;&nbsp;&nbsp;<input type="button" value="<%=lang.getQry()%>" onclick="qsort('FAQ','<%=logindn%>')" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getName()%></td>
    <td colspan="3">
      <input name="liaisonper" type="text" class="lInput01" size="50" maxlength="20" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getTel()%></td>
    <td colspan="3">
      <input name="liaisontel" type="text" class="lInput01" size="50" maxlength="20" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getEmail()%></td>
    <td colspan="3">
      <input name="liaisonemail" type="text" class="lInput01" size="50" maxlength="40" />
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過40個字）</span>
    </td>
  </tr>
  <tr>
    <td valign="top" class="T12b"><%=lang.getWebsitedata()%></td>
    <td colspan="3">
      <%
        if ( mstart.equals("Y") ) { %>
        	<jsp:include page="../../pubprogram/website/pubwebsite.jsp">
        	    <jsp:param name="t" value="<%=table%>"/>
        	    <jsp:param name="t1" value="<%=table1%>"/>
        	</jsp:include>
        <%}else{%>
        	<jsp:include page="../../pubprogram/website/pubnowebsite.jsp">
        	    <jsp:param name="mlanguage" value="<%=mlanguage%>"/>
        	</jsp:include>
        <%}%> 
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

