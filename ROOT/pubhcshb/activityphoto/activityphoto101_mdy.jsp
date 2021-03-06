<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activityphoto101_mdy.jsp
說明：活動花絮維護
開發者：chmei
開發日期：97.02.17
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );
  String qptdate = ( String )request.getParameter( "qptdate" );
  String qdldate = ( String )request.getParameter( "qdldate" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String table2 = ( String )request.getParameter( "t2" );
  String mlanguage = ( String )request.getParameter( "language" );
  
  String serno = ( String )request.getParameter( "serno" );
  
  String path = ( String )request.getParameter( "path" );
  
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

  ActivityPhotoData qactivities = new ActivityPhotoData();    
  boolean rtn1 = qactivities.load(table2,serno);

%>  

<script>
  function back()
  {
     document.mform.action="activityphoto101.jsp";
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
     if ( document.mform.sponsorunit.value != '' )
     {
        if ( document.mform.sponsorunit.value.length > 500 )
        {
           alert("【主辦單位】欄位長度，不可超過500個中文字，請重新輸入！");
           document.mform.sponsorunit.focus();
           return;
        }
     }
     if ( document.mform.assistunit.value != '' ) 
     {
        if ( document.mform.assistunit.value.length > 500 )
        {
           alert("【協辦單位】欄位長度，不可超過500個中文字，請重新輸入！");
           document.mform.assistunit.focus();
           return;
        }
     }
     if ( document.mform.content.value != '' )
     {
        if ( document.mform.content.value.length > 1500 )
        {
           alert("【詳細內容】欄位長度，不可超過1500個中文字，請重新輸入！");
           document.mform.content.focus();
           return;
        }
     }
     if ( document.mform.actsdate.value != '' && document.mform.actedate.value != '' )
     {
        if ( document.mform.actsdate.value > document.mform.actedate.value )
        {
           alert( "【活動日期(起)】不可大於【活動日期(迄)】！");
           document.mform.actsdate1.focus();
           return;
        }    
     } 
     if ( document.mform.actplace.value != '' )
     {
        if ( document.mform.actplace.value.length > 100 ) 
        {
           alert( "【活動地點】欄位長度，不可超過100個中文字，請重新輸入！");
           document.mform.actplace.focus();
           return;
        }
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
        document.mform.websitedn0.focus();
        return;
     }
     
     document.mform.action = "activityphoto101_mdysave.jsp?webrcount="+rcount;
     document.mform.method = "post";
     document.mform.submit();
  }    
    
  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="activityphoto101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
  }         
</script>

  
<body>
<form name="mform">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="t2" value="<%=table2%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
  <input type="hidden" name="qptdate" value="<%=qptdate%>"/>
  <input type="hidden" name="qdldate" value="<%=qdldate%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=rcount%>')"><%=lang.getSave()%></a>
 <a class="md" href="javascript:del()"><%=lang.getDel()%></a>	
 <a class="md" href="javascript:window.document.mform.reset()"><%=lang.getCancel()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4"><%=lang.getDatamdy()%></th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="20%"><span class="T12red">※</span><%=lang.getPosterdate()%></td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date1"/>
          <jsp:param name="colname" value="stdate"/>
          <jsp:param name="colnameview" value="stdateview"/>
          <jsp:param name="datevalue" value="<%=qactivities.getPosterdate()%>" />
      </jsp:include>  
    </td>
  </tr>
  <%
    String mstartusing = qactivities.getStartusing();
    String mstyle = "style='display:none'";
    if ( mstartusing.equals("0") )
    	mstyle = "style='display:block'";
  %>
  <tr>
    <td class="T12b" width="15%"><span class="T12red">※</span><%=lang.getStartusing()%></td>
    <td colspan="3">
      <input type="radio" name="startusing" value="1" onclick="chg()" <%=(mstartusing.equals("1") ? "checked" : "")%>><%=lang.getPerpetual()%>&nbsp;&nbsp;&nbsp;
      <input type="radio" name="startusing" value="0" onclick="chg()" <%=(mstartusing.equals("0") ? "checked" : "")%>><%=lang.getClosedate()%>
    </td>
  </tr>
  <tr class="tr" id='type' <%=mstyle%>>
    <td class="T12b" width="20%"><span class="T12red">※</span><%=lang.getClosedate()%></td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date2"/>
          <jsp:param name="colname" value="endate"/>
          <jsp:param name="colnameview" value="endateview"/>
          <jsp:param name="datevalue" value="<%=qactivities.getClosedate()%>" />
      </jsp:include>  
    </td>
  </tr> 
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getSubject()%></td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="70" value="<%=qactivities.getSubject()%>" maxlength="50"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getSecsubject()%></td>
    <%
      String msecsubject = qactivities.getSecsubject();
      if ( msecsubject == null || msecsubject.equals("null") )
    	  msecsubject = "";
    %>
    <td colspan="3">
      <input name="secsubject" type="text" class="lInput01" size="70" maxlength="100" value="<%=msecsubject%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過100個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getPubunitname()%></td>
    <td colspan="3"><%=qactivities.getPubunitname()%></td>
  </tr> 
  <input type="hidden" name="pubunitdn" value="<%=qactivities.getPubunitdn()%>"/>
  <input type="hidden" name="pubunitname" value="<%=qactivities.getPubunitname()%>"/>
  <tr>
    <td class="T12b"><%=lang.getSponsorunit()%></td>
    <td colspan="3">
      <textarea name="sponsorunit" cols="76" rows="3"><%=qactivities.getSponsorunit()%></textarea><br>
      <span class="T10">多個單位請以頓號(、)隔開&nbsp;&nbsp;&nbsp;(不可超過500個中文字）</span>
    </td>
  </tr> 
  <tr class="tr">
    <td class="T12b"><%=lang.getAssistunit()%></td>
    <%
      String massistunit = qactivities.getAssistunit();
      if ( massistunit == null || massistunit.equals("null") )
    	  massistunit = "";
    %>
    <td colspan="3">
      <textarea name="assistunit" cols="76" rows="3"><%=massistunit%></textarea><br>
      <span class="T10">多個單位請以頓號(、)隔開&nbsp;&nbsp;&nbsp;(不可超過500個中文字）</span>
    </td>
  </tr>   
  <tr>
    <td valign="top" class="T12b"><%=lang.getContent()%></td>
    <%
      String mcontent = qactivities.getContent();
      if ( mcontent == null || mcontent.equals("null") )
    	  mcontent = "";
    %>
    <td colspan="3">
      <textarea name="content" cols="80" rows="18"><%=mcontent%></textarea>
      <br><span class="T10">(不可超過1500個中文字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b" width="20%"><%=lang.getActsdate()%></td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="actsdate1"/>
          <jsp:param name="colname" value="actsdate"/>
          <jsp:param name="colnameview" value="actsdateview"/>
          <jsp:param name="datevalue" value="<%=qactivities.getActsdate()%>" />
      </jsp:include>&nbsp;&nbsp;&nbsp;
      <jsp:include page="../../pubprogram/choicetime.jsp">
          <jsp:param name="hcolname" value="actshour"/>
          <jsp:param name="mcolname" value="actsminute"/>
          <jsp:param name="timevalue" value="<%=qactivities.getActstime()%>"/>
      </jsp:include> 
    </td>
  </tr>
  <tr>
    <td class="T12b" width="20%"><%=lang.getActedate()%></td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp">
          <jsp:param name="buttonname" value="actedate1"/>
          <jsp:param name="colname" value="actedate"/>
          <jsp:param name="colnameview" value="actedateview"/>
          <jsp:param name="datevalue" value="<%=qactivities.getActedate()%>" />
      </jsp:include>&nbsp;&nbsp;&nbsp;
      <jsp:include page="../../pubprogram/choicetime.jsp">
          <jsp:param name="hcolname" value="actehour"/>
          <jsp:param name="mcolname" value="acteminute"/>
          <jsp:param name="timevalue" value="<%=qactivities.getActetime()%>"/>
      </jsp:include>
    </td>
  </tr>      
  <tr class="tr">
    <td class="T12b"><%=lang.getActplace()%></td>
    <%
      String mactplace = qactivities.getActplace();
      if ( mactplace == null || mactplace.equals("null") )
    	  mactplace = "";
    %>
    <td colspan="3">
      <input name="actplace" type="text" class="lInput01" size="70" maxlength="100" value="<%=mactplace%>"/>
      <span class="T10">&nbsp;&nbsp;&nbsp;(不可超過100個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getName()%></td>
    <%
      String mname = qactivities.getLiaisonper();
      if ( mname == null || mname.equals("null") )
    	  mname = "";
    %>
    <td colspan="3">
      <input name="liaisonper" type="text" class="lInput01" size="70" maxlength="20" value="<%=mname%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getTel()%></td>
    <%
      String mtel = qactivities.getLiaisontel();
      if ( mtel == null || mtel.equals("null") )
    	  mtel = "";
    %>
    <td colspan="3">
      <input name="liaisontel" type="text" class="lInput01" size="70" maxlength="20" value="<%=mtel%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getFax()%></td>
    <%
      String mfax = qactivities.getLiaisonfax();
      if ( mfax == null || mfax.equals("null") )
    	  mfax = "";
    %>
    <td colspan="3">
      <input name="liaisonfax" type="text" class="lInput01" size="70" maxlength="20" value="<%=mfax%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過20個字）</span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getEmail()%></td>
    <%
      String memail = qactivities.getLiaisonemail();
      if ( memail == null || memail.equals("null") )
    	  memail = "";
    %>
    <td colspan="3">
      <input name="liaisonemail" type="text" class="lInput01" size="70" maxlength="40" value="<%=memail%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過40個字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getRelateurl()%></td>
    <%
      String mrelaturl = qactivities.getRelateurl();
      String mrelatname = qactivities.getRelatename();
      if ( mrelaturl == null || mrelaturl.equals("null") || mrelaturl.equals("") )
    	  mrelaturl = "http://";
      if ( mrelatname == null || mrelatname.equals("null") )
    	  mrelatname = "";
    %>
    <td colspan="3">
      <input name="relateurl" type="text" class="lInput01" value="<%=mrelaturl%>" size="45" maxlength="120" />&nbsp;
      <span class="T12b"><%=lang.getWebname()%></span>&nbsp;<input name="relatename" type="text" class="lInput01" size="30" maxlength="60" value="<%=mrelatname%>"/>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getFsort()%><span class="T12red"></span></td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" maxlength="2" value="<%=qactivities.getFsort()%>" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      <input type="button" value="<%=lang.getQry() %>" onclick="qsort('ActivityPhoto','<%=logindn%>')" />
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
        	    <jsp:param name="serno" value="<%=serno%>"/>
        	</jsp:include>
        <%}else{%>
        	<jsp:include page="../../pubprogram/website/pubnowebsite.jsp">
        	    <jsp:param name="mlanguage" value="<%=mlanguage%>"/>
        	    <jsp:param name="serno" value="<%=serno%>"/>
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

