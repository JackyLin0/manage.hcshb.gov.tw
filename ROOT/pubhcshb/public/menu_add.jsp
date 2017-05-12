<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：menu_add.jsp
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
<%@ page import="tw.com.sysview.metatag.*" %>

<%
  //針對回上頁做參數傳遞
  String languageb = ( String )request.getParameter( "language" );
  String murlb = ( String )request.getParameter( "murl" );
  String websitedn = ( String )request.getParameter( "websitedn" );
  String webdnb = ( String )request.getParameter( "webdn" );
  String titleb = ( String )request.getParameter( "title" );
  
  String logindn = ( String )request.getParameter( "logindn" );
  
  String table = ( String )request.getParameter( "t" );
  String table2 = (String)request.getParameter("t2");
  
  //分類檢索Start
  MetaTagData querys = new MetaTagData();    
  boolean rtn = querys.load(table2,websitedn);
  String mserno = "";
  String mtitle = "";
  String creator = "";
  String publisher = "";
  String contributor = "";
  String mtype = "";
  String mformat = "";
  String identifier = "";
  String relation = "";
  String source = "";
  String languagetype = "";
  String rights = "";
  String themeclass = "";
  String theme = "";
  String cakeclass = "";
  String cake = "";
  String serviceclass = "";
  String service = "";  
  if ( rtn ) {
	  mserno = querys.getSerno();
	  mtitle = querys.getTitle();
	  creator = querys.getCreator();
	  publisher = querys.getPublisher();
	  if ( querys.getContributor() != null && !querys.getContributor().equals("null") && !querys.getContributor().equals("") )
		  contributor = querys.getContributor();
	  mtype = querys.getMtype();
	  if ( querys.getMformat() != null && !querys.getMformat().equals("null") && !querys.getMformat().equals("") )
		  mformat = querys.getMformat();
	  identifier = querys.getIdentifier();
	  if ( querys.getRelation() != null && !querys.getRelation().equals("null") && !querys.getRelation().equals("") )
		  relation = querys.getRelation();
	  if ( querys.getSource() != null && !querys.getSource().equals("null") && !querys.getSource().equals("") )
		  source = querys.getSource();
	  if ( querys.getLanguagetype() != null && !querys.getLanguagetype().equals("null") && !querys.getLanguagetype().equals("") )
		  languagetype = querys.getLanguagetype();
	  if ( querys.getRights() != null && !querys.getRights().equals("null") && !querys.getRights().equals("") )
		  rights = querys.getRights();
	  if ( querys.getThemeclass() != null && !querys.getThemeclass().equals("null") && !querys.getThemeclass().equals("") ) {
		  themeclass = querys.getThemeclass(); 
		  String[] ary_one = SvString.split(querys.getThemeclass(),",");
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
		  
	  if ( querys.getCakeclass() != null && !querys.getCakeclass().equals("null") && !querys.getCakeclass().equals("") ) {
		  cakeclass = querys.getCakeclass();
		  String[] ary_one = SvString.split(querys.getCakeclass(),",");
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
		  
	  if ( querys.getServiceclass() != null && !querys.getServiceclass().equals("null") && !querys.getServiceclass().equals("") ) {
		  serviceclass = querys.getServiceclass();
		  String[] ary_one = SvString.split(querys.getServiceclass(),",");
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
	  
  }
  //分類檢索End
  MenuData query = new MenuData();    
  ArrayList qmenus = query.findByday(table);  
  int rcount = query.getAllrecordCount();
  
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
     
  function qrytop()
  {          
     var mlevel = document.menuform.islevel.value;
     //if ( mlevel > 1 )
        //window.type4.style.display='block';
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
  
  function save()
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
     if ( document.menuform.islevelcontent.value == '' )
     {
        alert("【目錄名稱】欄位，不可空白，請輸入！");
        document.menuform.islevelcontent.focus();
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
     document.menuform.action = "menu_addsave.jsp?mflag=" + mflag;
     document.menuform.method="post";
     document.menuform.submit();
  }    
</script>

<form name="backform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="language" value="<%=languageb%>"/>
  <input type="hidden" name="murl" value="<%=murlb%>"/>
  <input type="hidden" name="webdn" value="<%=webdnb%>"/>
  <input type="hidden" name="title" value="<%=titleb%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="t2" value="<%=table2%>"/>
</form>

<body>
<form name="menuform" enctype="multipart/form-data">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/> <!-- metaTag -->
  <input type="hidden" name="t2" value="<%=table2%>"/> <!-- metaTag -->
  
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

 <a class="md" href="javascript:save()"><%=lang.getSave()%></a>	
 <a class="md" href="javascript:window.document.menuform.reset()"><%=lang.getReset()%></a>	 		
 <a class="md" href="javascript:history.go(-1)"><%=lang.getBack()%></a>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4"><%=lang.getDataadd()%></th>
  </tr>
  <tr class="tr">
    <td width="27%" class="T12b"><span class="T12red">※</span><%=lang.getIslevel()%></td>
    <td colspan="3">
      <input name="islevel" type="text" class="lInput01" size="3" maxlength="2" ONKEYPRESS="if ((event.keyCode < 49) || (event.keyCode > 57)) event.returnValue = false;" onblur=qrytop()>      
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
    <td colspan="3"><input name="islevelcontent" type="text" class="lInput01" size="20"/>&nbsp;&nbsp;<span class="T10">(為網站選單目錄名稱，建議不超過6個中文字）</span></td>
  </tr>
  <!-- <tr>
    <td class="T12b">網頁標題名稱<span class="T12red">※</span></td>
    <td colspan="3"><input name="textfield232" type="text" class="lInput01" size="20"/>
      （網頁內容標題文字）</td>
  </tr> -->
  <tr>
    <td class="T12b"><span class="T12red">※</span><%=lang.getFlag()%></td>
    <td colspan="3">
      <input name="mflag" type="radio" value="1" onclick="chg()"/><%=lang.getDevelprogram()%>&nbsp;&nbsp;
      <input name="mflag" type="radio" value="0" onclick="chg()"/><%=lang.getCommonplatepage()%>&nbsp;&nbsp;
      <input name="mflag" type="radio" value="3" onclick="chg()"/><%=lang.getOwnplatepage()%>&nbsp;&nbsp;
      <input name="mflag" type="radio" value="2" onclick="chg()"/><%=lang.getHyperlink()%>
    </td>
  </tr>
  <tr id='type0' style="display:none">
    <td class="T12b"><span class="T12red">※</span><%=lang.getCommonplate()%></td>
    <td class="T12b">
      <input name="islevellink1" type="text" class="lInput01" size="50" readonly/>
    </td>
  </tr>
  <tr id='type1' style="display:none">
    <td class="T12b"><span class="T12red">※</span><%=lang.getUpload1()%></td>
    <td class="T12b">
      <input name="filename1" type="file" class="lInput01" size="20"/>
    </td>
  </tr>  
  <tr id='type3' style="display:none">
    <td class="T12b"><span class="T12red">※</span><%=lang.getOwnplate()%></td>
    <td class="T12b">
      <input name="filename2" type="file" class="lInput01" size="20"/>
    </td>
  </tr>
  <tr id='type2' style="display:none">
    <td class="T12b"><span class="T12red">※</span><%=lang.getHyperlink()%></td>
    <td class="T12b">
      <input name="islevellink2" type="text" class="lInput01" size="50">&nbsp;&nbsp;
      <span class="T10">另開視窗
      <input type="radio" name="target" value="Y" checked><%=lang.getYes()%>&nbsp;&nbsp;
      <input type="radio" name="target" value="N"><%=lang.getNo()%></span>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><%=lang.getFsort()%><span class="T12red"></span></td>
    <td colspan="3"><input name="fsort" type="text" class="lInput01" size="10" maxlength="2" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
      <input type="button" value="<%=lang.getQry() %>" onclick="qsort('<%=table%>','<%=language%>')" />
      <br><span class="T10">(目錄順序排序，輸入數值同目前有數值，會將現有該數值往後遞延）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><%=lang.getStartusing()%></td>
    <td colspan="3">
      <input name="startusing" type="radio" value="1" checked/><%=lang.getYes()%>&nbsp;&nbsp;
      <input name="startusing" type="radio" value="0"/><%=lang.getNo()%>&nbsp;&nbsp;<span class="T10">(是否於民眾端顯示)</span>
    </td>
  </tr>
  <!-- <tr class="tr" id='type4' style="display:none">
    <td class="T12b">是否加入快速連結</td>
    <td colspan="3">
      <input name="showlink" type="radio" value="1"/><%=lang.getYes()%>&nbsp;&nbsp;
      <input name="showlink" type="radio" value="0" checked/><%=lang.getNo()%></span>
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
     
  function chg()
  {
     for ( var i=0;i<document.all.mflag.length;i++ )
     {
       if ( document.all.mflag[i].checked )
       {
         var mflag_value = document.all.mflag[i].value;
         switch(mflag_value)
         {
            case "0":  //使用網頁版型
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
                 window.type0.style.display='none';
                 window.type1.style.display='block';
                 window.type2.style.display='none';
                 window.type3.style.display='none';
                 break;
            case "2":  //超連結網頁
                 window.type0.style.display='none';
                 window.type1.style.display='none';
                 window.type2.style.display='block';
                 window.type3.style.display='none';
                 break;
            case "3":  //自行編輯網頁上傳
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

