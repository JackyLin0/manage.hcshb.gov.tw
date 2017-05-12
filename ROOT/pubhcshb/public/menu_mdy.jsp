<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：menu_mdy.jsp
說明：選單目錄管理
開發者：chmei
開發日期：97.02.18
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
  //接受查詢條件
  String islevelcontent = ( String )request.getParameter( "islevelcontent" );

  //針對回上頁做參數傳遞
  String languageb = ( String )request.getParameter( "language" );
  String murlb = ( String )request.getParameter( "murl" );
  String webdnb = ( String )request.getParameter( "webdn" );
  String titleb = ( String )request.getParameter( "title" );
  
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  
  String table = ( String )request.getParameter( "t" );
  String serno = ( String )request.getParameter( "serno" );
  
  
  MenuData query = new MenuData();  
  ArrayList qmenus = query.findByday(table);
  int rcount = query.getAllrecordCount();
  
  MenuData qdata = new MenuData();
  boolean qone = qdata.load(table,serno);  
  int mlevel = qdata.getIslevel();
  String mserno = qdata.getTopserno();
  if ( mserno.equals("") )
	  mserno = "0";
  
  String themeclass = "";
  String theme = "";
  String cakeclass = "";
  String cake = "";
  String serviceclass = "";
  String service = "";
  
  if ( qdata.getThemeclass() != null && !qdata.getThemeclass().equals("null") && !qdata.getThemeclass().equals("") ) {
	  themeclass = qdata.getThemeclass();
	  String[] ary_one = SvString.split(qdata.getThemeclass(),",");
	  for ( int i=0; i<ary_one.length; i++ ) {
		  String[] ary_two = SvString.split(ary_one[i],"-");
		  String temp1 = "";
		  for ( int j=0; j<ary_two.length; j++ ) {
			  String[] ary_data = SvString.split(ary_two[j],"||");
			  if ( temp1.equals("") ){
				  temp1 = ary_data[1];
			  }else{
				  temp1 = temp1 + "-" + ary_data[1];
			  }	  	  
		  }
		  if ( theme.equals("") ) {
			  theme = temp1;
		  }else{
			  theme = theme + "," + temp1;
		  }	  	  
	  }
  }
	  
  if ( qdata.getCakeclass() != null && !qdata.getCakeclass().equals("null") && !qdata.getCakeclass().equals("") ) {
	  cakeclass = qdata.getCakeclass();
	  String[] ary_one = SvString.split(qdata.getCakeclass(),",");
	  for ( int i=0; i<ary_one.length; i++ ) {
		  String[] ary_two = SvString.split(ary_one[i],"-");
		  String temp1 = "";
		  for ( int j=0; j<ary_two.length; j++ ) {
			  String[] ary_data = SvString.split(ary_two[j],"||");
			  if ( temp1.equals("") ){
				  temp1 = ary_data[1];
			  }else{
				  temp1 = temp1 + "-" + ary_data[1];
			  }	  	  
		  }
		  if ( cake.equals("") ) {
			  cake = temp1;
		  }else{
			  cake = cake + "," + temp1;
		  }	  	  
	  }
  }
	  
  if ( qdata.getServiceclass() != null && !qdata.getServiceclass().equals("null") && !qdata.getServiceclass().equals("") ) {
	  serviceclass = qdata.getServiceclass();
	  String[] ary_one = SvString.split(qdata.getServiceclass(),",");
	  for ( int i=0; i<ary_one.length; i++ ) {
		  String[] ary_two = SvString.split(ary_one[i],"-");
		  String temp1 = "";
		  for ( int j=0; j<ary_two.length; j++ ) {
			  String[] ary_data = SvString.split(ary_two[j],"||");
			  if ( temp1.equals("") ){
				  temp1 = ary_data[1];
			  }else{
				  temp1 = temp1 + "-" + ary_data[1];
			  }	  	  
		  }
		  if ( service.equals("") ) {
			  service = temp1;
		  }else{
			  service = service + "," + temp1;
		  }	  	  
	  }
  }
%>  

<script>
   arry_islevel = new Array(99);
   <%
     int islevel = 0;
	 String tot_str = "";
     if ( qmenus != null )
     {    	    	 
    	 for ( int k=0; k<rcount; k++ ) {
    		 MenuData qmenu = ( MenuData )qmenus.get( k );
    		 
    		 if ( islevel == 0 )
    			 islevel = qmenu.getIslevel();
    		 
    		 if ( islevel != qmenu.getIslevel() ) { %>
    			 arry_islevel[<%=islevel%>] = "<%=tot_str%>";
    		   <%
    		     islevel = qmenu.getIslevel();
    		     tot_str = "";
    		 }
    		 
    		 if ( tot_str.equals("") )
    			 tot_str = qmenu.getSerno() + "-" + qmenu.getIslevelcontent();
    		 else
    			 tot_str = tot_str + "," + qmenu.getSerno() + "-" + qmenu.getIslevelcontent();
    	 }%>
    	 arry_islevel[<%=islevel%>] = "<%=tot_str%>"; 
     <%}%>
    	   
  function qrytop(olevel)
  {
     var mlevel = document.menuform.islevel.value;
     //if ( mlevel > 1 )
        //window.type4.style.display='block';
     //else
        //window.type4.style.display='none';
       
     //修改若有修改層次時，才須執行
     if ( mlevel != olevel )
     {
        document.menuform.toplevel.options.length = 1;
        document.menuform.toplevel.options[0].value = "";
        document.menuform.toplevel.options[0].text = "---請選擇---";
        mdata = arry_islevel[mlevel-1];
        if ( mdata != null )
        {
           array_mdata = mdata.split(",");
           document.menuform.toplevel.options.length = array_mdata.length+1;
           for ( k=0; k<array_mdata.length; k++ )
           {
              arry_level = array_mdata[k].split("-");
              document.menuform.toplevel.options[k+1].value=arry_level[0];
              document.menuform.toplevel.options[k+1].text=arry_level[1];
           }   
        }   
     }
  }
  
  function setTopLevel(mlevel,mserno)
  {
     document.menuform.toplevel.options.length = 1;
     document.menuform.toplevel.options[0].value = "";
     document.menuform.toplevel.options[0].text = "---請選擇---";
     mdata = arry_islevel[mlevel-1];
     if ( mdata != null )
     {
        array_mdata = mdata.split(",");
        document.menuform.toplevel.options.length = array_mdata.length+1;
        for ( k=0; k<array_mdata.length; k++ )
        {           
           arry_level = array_mdata[k].split("-");
           document.menuform.toplevel.options[k+1].value=arry_level[0];
           document.menuform.toplevel.options[k+1].text=arry_level[1];
           if ( arry_level[0] == mserno )
              document.menuform.toplevel.options[k+1].selected = true;
        }   
     }
  }
  
  function qsort(tablename,language)
  {
     if ( document.menuform.islevel.value == '' )
     {
        alert("請先輸入欲查詢之層次！！");
        document.menuform.islevel.focus();
        return;
     }
     var mlevel = document.menuform.islevel.value;     
     var t = tablename;
     newwnd = window.open('menu_qsort.jsp?mlevel='+mlevel+'&t='+t+'&language='+language,'','width=500,height=300,scrollbars=yes,left=400,top=150');
  }
        
  function back()
  {
     document.backform.action="menu.jsp";
     document.backform.method="post";
     document.backform.submit();
  }
  
  function save(oldflag)
  {
     if ( document.menuform.islevel.value == '' )
     {
        alert("【目錄層次】欄位，不可空白，請輸入！");
        document.menuform.islevel.focus();
        return;
     }
     if ( (document.menuform.islevel.value > 1) && (document.menuform.toplevel.value == '') )
     {
        alert("【上一層級目錄名稱】欄位，不可空白，請選擇！");
        document.menuform.toplevel.focus();
        return;
     }
     if ( document.menuform.mislevelcontent.value == '' )
     {
        alert("【目錄名稱】欄位，不可空白，請輸入！");
        document.menuform.mislevelcontent.focus();
        return;
     }
     if ( (!document.menuform.mflag[0].checked) && (!document.menuform.mflag[1].checked ) && (!document.menuform.mflag[2].checked) && (!document.menuform.mflag[3].checked) )
     {
        alert("【網頁屬性】欄位，不可空白，請輸入！");
        document.menuform.mflag[0].focus();
        return;
     }
     //動態程式
     if ( document.menuform.mflag[0].checked ) 
     {
        //屬性與原本不一樣
        if ( oldflag != 1 )
        {
           if ( document.menuform.filename1.value == '' )
           {
              alert("【檔案上傳】欄位，不可空白，請輸入！");
              document.menuform.filename1.focus();
              return;
           }else{
              var fn = document.menuform.filename1.value.toUpperCase();
              if( fn.indexOf(".JSP") < 0 )
              {
                 alert("您所選的檔案(1)之副檔名不是【.JSP】，請重新選擇！");
                 document.menuform.filename1.focus();
                 return;
              }
           }
        }else{
           if ( document.menuform.filename1.value != '' )
           {
              var fn = document.menuform.filename1.value.toUpperCase();
              if( fn.indexOf(".JSP") < 0 )
              {
                 alert("您所選的相關圖檔(1)之副檔名不是【.JSP】，請重新選擇！");
                 document.menuform.filename1.focus();
                 return;
              }
              document.menuform.nsfile1.value = document.menuform.filename1.value;
           }
        }        
        mflag = "1";
     }
     //網頁版型
     if ( document.menuform.mflag[1].checked ) 
     {
        if ( document.menuform.islevellink1.value == '' )
        {
           alert("【連結】欄位，不可空白，請輸入！");
           document.menuform.islevellink1.focus();
           return;
        } 
        mflag = "0";
     }     
     //自行編輯網頁
     if ( document.menuform.mflag[2].checked ) 
     {
        //屬性與原本不一樣
        if ( oldflag != 3 )
        {
           if ( document.menuform.filename2.value == '' )
           {
              alert("【檔案上傳】欄位，不可空白，請輸入！");
              document.menuform.filename2.focus();
              return;
           }else{
              var fn = document.menuform.filename2.value.toUpperCase();
              if( fn.indexOf(".JSP") < 0 )
              {
                 alert("您所選的檔案(1)之副檔名不是【.JSP】，請重新選擇！");
                 document.menuform.filename2.focus();
                 return;
              }
           } 
        }else{
           if ( document.menuform.filename1.value != '' )
           {
              var fn = document.menuform.filename2.value.toUpperCase();
              if( fn.indexOf(".JSP") < 0 )
              {
                 alert("您所選的檔案(1)之副檔名不是【.JSP】，請重新選擇！");
                 document.menuform.filename2.focus();
                 return;
              }
              document.menuform.nsfile2.value = document.menuform.filename2.value;
           }
        }
        mflag = "3";
     }  
     //超連結
     if ( document.menuform.mflag[3].checked ) 
     {
        if ( document.menuform.islevellink2.value == '' )
        {
           alert("【連結】欄位，不可空白，請輸入！");
           document.menuform.islevellink2.focus();
           return;
        } 
        mflag = "2";
     }
     document.menuform.action = "menu_mdysave.jsp?mflag=" + mflag + "&oldflag=" + oldflag;
     document.menuform.method="post";
     document.menuform.submit();
  }
  
  function del(serno)
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.backform.action="menu_del.jsp?serno=" + serno;
        document.backform.method="post";
        document.backform.submit();
     } 
  }
  
  function tempmdy(serno)
  {
     document.backform.action="menu_tempmdy.jsp?serno=" + serno;
     document.backform.method="post";
     document.backform.submit();
  }
  
  function choice(category,formname,colname) {
	   	 var mwidth="370";
	   	 if ( category == '2' )
	   	       mwidth="450";
	   	       newwnd = window.open('../../pubprogram/metatag/category.jsp?category='+category+'&formname='+formname+'&colname='+colname,'CategoryView','width='+mwidth+',height=480,scrollbars=yes,left=300,top=80');
	        if (newwnd != null) {        
	            if (newwnd.opener == null) 
	             newwnd.opener = self;
	         }
	     }
</script>

<form name="backform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>
  <input type="hidden" name="murl" value="<%=murlb%>"/>
  <input type="hidden" name="title" value="<%=titleb%>"/>
</form>

<body>
<form name="menuform" enctype="multipart/form-data">
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<%
  //webdn變數由pubprogram/qtitle.jsp
  String webdn1 = ( String )session.getAttribute("webdn");
  String[] ary_webdn = SvString.split(webdnb,",");
  String org = SvString.right(ary_webdn[2],"=");
%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=qdata.getFlag()%>')"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:del('<%=qdata.getSerno()%>')"><%=lang.getDel()%></a>	
 <a class="md" href="javascript:window.document.menuform.reset()"><%=lang.getReset()%></a>	 		
 <a class="md" href="javascript:back()"><%=lang.getBack()%></a>
 <a class="md" href="javascript:tempmdy('<%=qdata.getSerno()%>')">可修改連結路徑(此功能站時提供日後會移除)</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4"><%=lang.getDatamdy()%></th>
  </tr>
  <tr  class="tr">
    <td width="27%" class="T12b"><span class="T12red">※</span><%=lang.getIslevel()%></td>
    <td colspan="3">
      <input name="islevel" type="text" class="lInput01" size="3" value="<%=qdata.getIslevel()%>" maxlength="2" ONKEYPRESS="if ((event.keyCode < 49) || (event.keyCode > 57)) event.returnValue = false;" onblur=qrytop()>      
      &nbsp;&nbsp;<span class="T10">(為網站選單目錄之層）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span><%=lang.getToplevelcontent()%></td>
    <td colspan="3">
      <select name="toplevel">
        <option value="">---請選擇---</option>
      </select>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span><%=lang.getIslevelcontent()%></td>
    <td colspan="3"><input name="mislevelcontent" type="text" class="lInput01" value="<%=qdata.getIslevelcontent()%>" size="20"/>&nbsp;&nbsp;<span class="T10">(為網站選單目錄名稱，建議不超過6個中文字）</span></td>
  </tr>
  <!-- <tr>
    <td class="T12b"><span class="T12red">※</span>網頁標題名稱</td>
    <td colspan="3"><input name="textfield232" type="text" class="lInput01" size="20"/>
      （網頁內容標題文字）</td>
  </tr> -->
  <tr>
    <td class="T12b"><span class="T12red">※</span><%=lang.getFlag()%></td>
    <td colspan="3">
      <input name="mflag" type="radio" value="1" onclick="chg('<%=qdata.getFlag()%>')" <%=(qdata.getFlag().equals("1") ? "checked" : "")%>/><%=lang.getDevelprogram()%>&nbsp;&nbsp;
      <input name="mflag" type="radio" value="0" onclick="chg('<%=qdata.getFlag()%>')" <%=(qdata.getFlag().equals("0") ? "checked" : "")%>/><%=lang.getCommonplatepage()%>&nbsp;&nbsp;
      <input name="mflag" type="radio" value="3" onclick="chg('<%=qdata.getFlag()%>')" <%=(qdata.getFlag().equals("3") ? "checked" : "")%>/><%=lang.getOwnplatepage()%>&nbsp;&nbsp;
      <input name="mflag" type="radio" value="2" onclick="chg('<%=qdata.getFlag()%>')" <%=(qdata.getFlag().equals("2") ? "checked" : "")%>/><%=lang.getHyperlink()%>
    </td>
  </tr>
  <tr id='type0' <%=(qdata.getFlag().equals("0") ? "style='display:block'" : "style='display:none'")%>>
    <td class="T12b"><span class="T12red">※</span><%=lang.getCommonplate()%></td>
    <td class="T12b">
      <input name="islevellink1" type="text" class="lInput01" size="50" value="<%=qdata.getIslevellink()%>" readonly/>
    </td>
    <input type="hidden" name="oldislevellink" value="<%=qdata.getIslevellink()%>">
  </tr>
  <tr id='type1' <%=(qdata.getFlag().equals("1") ? "style='display:block'" : "style='display:none'")%>>
    <td class="T12b" valign="top"><span class="T12red">※</span><%=lang.getUpload1()%></td>
    <%
      String mrfile1 = qdata.getClientfile1();
      String msfile1 = qdata.getServerfile1();
    %>
    <td class="T12b">
      <input name="filename1" type="file" class="lInput01" size="20"/>
      <table border="0" id='table1'>
        <%
          if ( (msfile1 != null) && (!msfile1.equals("")) ) { %> 
        	  <span class="T10">【原檔名】：<a href="../../menudowndoc?file=/<%=org%>/ap/<%=java.net.URLEncoder.encode(msfile1,"UTF-8")%>"><%=mrfile1%></a>
        	  <input type="hidden" name="osfile1" value="<%=msfile1%>"/>
        	  <input type="hidden" name="orfile1" value="<%=mrfile1%>"/></span>
          <%}%>
          <input type="hidden" name="nsfile1">
      </table>  
    </td>
  </tr>
  <tr id='type3' <%=(qdata.getFlag().equals("3") ? "style='display:block'" : "style='display:none'")%>>
    <td class="T12b" valign="top"><span class="T12red">※</span><%=lang.getOwnplate()%></td>
    <%
      String mrfile2 = qdata.getClientfile1();
      String msfile2 = qdata.getServerfile1();
    %>
    <td class="T12b">
      <input name="filename2" type="file" class="lInput01" size="20"/>
      <table border="0" id='table2'>
        <%
          if ( (msfile2 != null) && (!msfile1.equals("")) ) { %>
        	  <span class="T10">【原檔名】：<a href="../../menudowndoc?file=/<%=org%>/content/<%=java.net.URLEncoder.encode(msfile1,"UTF-8")%>"><%=mrfile1%></a>
        	  <input type="hidden" name="osfile2" value="<%=msfile2%>"/>
        	  <input type="hidden" name="orfile2" value="<%=mrfile2%>"/></span>
          <%}%>
          <input type="hidden" name="nsfile2">
      </table>  
    </td>
  </tr>
  <tr id='type2' <%=(qdata.getFlag().equals("2") ? "style='display:block'" : "style='display:none'")%>>
    <td class="T12b"><span class="T12red">※</span><%=lang.getHyperlink()%></td>
    <td class="T12b">
      <input name="islevellink2" type="text" class="lInput01" size="50" value="<%=qdata.getIslevellink()%>">
      <%
        String win = qdata.getTarget();
        if ( win == null )
        	win = "Y";
      %>
      <span class="T10">另開視窗
      <input type="radio" name="mtarget" value="Y" <%=(win.equals("Y") ? "checked" : "")%>><%=lang.getYes()%>&nbsp;&nbsp;
      <input type="radio" name="mtarget" value="N" <%=(win.equals("N") ? "checked" : "")%>><%=lang.getNo()%></span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getFsort()%><span class="T12red"></span></td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" maxlength="2" value="<%=qdata.getFsort()%>" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      <input type="button" value="<%=lang.getQry() %>" onclick="qsort('<%=table%>','<%=language%>')" />
      <br><span class="T10">(目錄順序排序，輸入數值同目前有數值，會將現有該數值往後遞延）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getStartusing()%></td>
    <td colspan="3">
      <input name="startusing" type="radio" value="1" <%=(qdata.getStartusing().equals("1") ? "checked" : "")%>/><%=lang.getYes()%>&nbsp;&nbsp;
      <input name="startusing" type="radio" value="0" <%=(qdata.getStartusing().equals("0") ? "checked" : "")%>/><%=lang.getNo()%>&nbsp;&nbsp;<span class="T10">(是否於民眾端顯示)</span>
    </td>
  </tr>
  <%
    String mstyle = "display:none";
    String mshowlink = qdata.getShowlink();
    
    if ( mshowlink == null || mshowlink.equals("null") )
    	mshowlink = "0";
    
    if ( qdata.getIslevel() > 1 )
    	mstyle = "display:block";
  %>
  <!-- <tr class="tr" id='type4' style="<%=mstyle%>">
    <td class="T12b">是否加入快速連結</td>
    <td colspan="3">
      <input name="showlink" type="radio" value="1" <%=(mshowlink.equals("1") ? "checked" : "")%>/><%=lang.getYes()%>&nbsp;&nbsp;
      <input name="showlink" type="radio" value="0" <%=(mshowlink.equals("0") ? "checked" : "")%>/><%=lang.getNo()%>
    </td>
  </tr> -->
  <tr>
    <td class="T12b"><span class="T12red">※</span>主題分類(category.theme)</td>
    <td colspan="3">
      <input type="text" name="themeview" size="40" maxlength="100" value="<%=theme%>" readonly />&nbsp;&nbsp;&nbsp;
      <input type="button" value="選擇全部" onclick="javascript:choice('1','menuform','theme')" />
      <input type="hidden" name="theme" value="<%=themeclass%>" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>施政分類(category.cake)</td>
    <td colspan="3">
      <input type="text" name="cakeview" size="40" maxlength="100" value="<%=cake%>" readonly />&nbsp;&nbsp;&nbsp;
      <input type="button" value="選擇全部" onclick="javascript:choice('2','menuform','cake')" />
      <input type="hidden" name="cake" value="<%=cakeclass%>" />
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>服務分類(category.service)</td>
    <td colspan="3">
      <input type="text" name="serviceview" size="40" maxlength="100" value="<%=service%>" readonly />&nbsp;&nbsp;&nbsp;
      <input type="button" value="選擇全部" onclick="javascript:choice('3','menuform','service')" />
      <input type="hidden" name="service" value="<%=serviceclass%>" />
    </td>
  </tr>
  <tr>
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<!-- <p><div align="left"><a class="md" href="#top"><%=lang.getTop()%></a></div> -->

</form>
</body>
</html>

<script>
     
  function chg(flag)
  {
     for ( var i=0;i<document.all.mflag.length;i++ )
     {
       if ( document.all.mflag[i].checked )
       {
         var mflag_value = document.all.mflag[i].value;
         switch(mflag_value)
         {
            case "0":  //使用網頁版型
                 if ( flag != 0 )
                    document.menuform.islevellink1.value = '';
                 window.type0.style.display='block';
                 window.type1.style.display='none';
                 window.type2.style.display='none';
                 window.type3.style.display='none';
                 newwnd = window.open('../../pubprogram/template.jsp?mlink=<%=org%>','','width=450,height=600,scrollbars=yes,left=300,top=50');
                 if (newwnd != null) {
                    if (newwnd.opener == null) 
                       newwnd.opener = self;
                 }
                 break;
            case "1":  //動態網頁
                 if ( flag != 1 )
                    window.table1.style.display='none';
                 window.type0.style.display='none';
                 window.type1.style.display='block';
                 window.type2.style.display='none';
                 window.type3.style.display='none';
                 break;
            case "2":  //超連結網頁
                 if ( flag != 2 )
                    document.menuform.islevellink2.value = '';
                 window.type0.style.display='none';
                 window.type1.style.display='none';
                 window.type2.style.display='block';
                 window.type3.style.display='none';
                 break;
            case "3":  //自行編輯網頁上傳
                 if ( flag != 3 )
                    window.table2.style.display='none';
                 window.type0.style.display='none';
                 window.type1.style.display='none';
                 window.type2.style.display='none';
                 window.type3.style.display='block';
                 break;     
         }
       }
     }    
  }
  
</script>


<script>
  setTopLevel(<%=mlevel%>,<%=mserno%>);
</script>