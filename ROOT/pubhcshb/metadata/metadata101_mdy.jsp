<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：metadata101_mdy.jsp
說明：分類檢索共用欄位維護
開發者：chmei
開發日期：99.06.27
修改者：
修改日期：
版本：ver1.0
-->

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
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
                     
  function save()
  {
     if ( document.mform.mtitle.value == '' )
     {
        alert("【網站名稱】欄位，不可空白，請輸入！");
        document.mform.mtitle.focus();
        return;     
     }
     if ( document.mform.creator.value == '' )
     {
        alert("【創作者】欄位，不可空白，請輸入！");
        document.mform.creator.focus();
        return;
     }
     if ( document.mform.publisher.value == '' )
     {
        alert("【出版者】欄位，不可空白，請輸入！");
        document.mform.publisher.focus();
        return;
     }
     if ( document.mform.mtype.value == '' )
     {
        alert("【資料類型】欄位，不可空白，請輸入！");
        document.mform.mtype.focus();
        return;
     }
     if ( document.mform.identifier.value == '' )
     {
        alert("【OID】欄位，不可空白，請輸入！");
        document.mform.identifier.focus();
        return;
     }
     if ( document.mform.themeview.value == '' )
     {
        alert("【主題分類】欄位，不可空白，請選擇！");
        document.mform.themeview.focus();
        return;
     }
     if ( document.mform.cakeview.value == '' )
     {
        alert("【施政分類】欄位，不可空白，請選擇！");
        document.mform.cakeview.focus();
        return;
     }
     if ( document.mform.serviceview.value == '' )
     {
        alert("【服務分類】欄位，不可空白，請選擇！");
        document.mform.serviceview.focus();
        return;
     }
          
     document.mform.action = "metadata101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  } 
     
</script>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.metatag.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  String websitedn = ( String )request.getParameter( "websitedn" );
  String menudata = ( String )request.getParameter( "menudata" );

  MetaTagData query = new MetaTagData();    
  boolean rtn = query.load(table,websitedn);
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
	  mserno = query.getSerno();
	  mtitle = query.getTitle();
	  creator = query.getCreator();
	  publisher = query.getPublisher();
	  if ( query.getContributor() != null && !query.getContributor().equals("null") && !query.getContributor().equals("") )
		  contributor = query.getContributor();
	  mtype = query.getMtype();
	  if ( query.getMformat() != null && !query.getMformat().equals("null") && !query.getMformat().equals("") )
		  mformat = query.getMformat();
	  identifier = query.getIdentifier();
	  if ( query.getRelation() != null && !query.getRelation().equals("null") && !query.getRelation().equals("") )
		  relation = query.getRelation();
	  if ( query.getSource() != null && !query.getSource().equals("null") && !query.getSource().equals("") )
		  source = query.getSource();
	  if ( query.getLanguagetype() != null && !query.getLanguagetype().equals("null") && !query.getLanguagetype().equals("") )
		  languagetype = query.getLanguagetype();
	  if ( query.getRights() != null && !query.getRights().equals("null") && !query.getRights().equals("") )
		  rights = query.getRights();
	  if ( query.getThemeclass() != null && !query.getThemeclass().equals("null") && !query.getThemeclass().equals("") ) {
		  themeclass = query.getThemeclass();
		  String[] ary_one = SvString.split(query.getThemeclass(),",");
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
		  
	  if ( query.getCakeclass() != null && !query.getCakeclass().equals("null") && !query.getCakeclass().equals("") ) {
		  cakeclass = query.getCakeclass();
		  String[] ary_one = SvString.split(query.getCakeclass(),",");
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
		  
	  if ( query.getServiceclass() != null && !query.getServiceclass().equals("null") && !query.getServiceclass().equals("") ) {
		  serviceclass = query.getServiceclass();
		  String[] ary_one = SvString.split(query.getServiceclass(),",");
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
 
%>  

<body>
<form name="mform">
  <input type="hidden" name="mserno" value="<%=mserno%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="menudata" value="<%=menudata%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>
  
<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:window.document.mform.reset()">重設</a>	
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="35%"><span class="T12red">※</span>網站名稱</td>
    <td colspan="3">
      <input name="mtitle" size="40" value="<%=mtitle%>" maxlength="20" />
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>創作者(DC.Creator)</td>
    <td colspan="3">
      <input name="creator" size="60" value="<%=creator%>" maxlength="100" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>出版者(DC.Publisher)</td>
    <td colspan="3">
      <input name="publisher" size="60" value="<%=publisher%>" maxlength="100" />
    </td>
  </tr>
  <tr>
    <td class="T12b">貢獻者(DC.Contributor)</td>
    <td colspan="3">
      <input name="contributor" size="60" value="<%=contributor%>" maxlength="100" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>資料類型(DC.Type)</td>
    <td colspan="3">
      <input name="mtype" size="40" value="<%=mtype%>" maxlength="20" />
    </td>
  </tr>
  <tr>
    <td class="T12b">資料格式(DC.Format)</td>
    <td colspan="3">
      <input name="mformat" size="40" value="<%=mformat%>" maxlength="20" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>OID(DC.Identifier)</td>
    <td colspan="3">
      <input name="identifier" size="40" value="<%=identifier%>" maxlength="20" />
    </td>
  </tr>
  <tr>
    <td class="T12b">關連(DC.Relation)</td>
    <td colspan="3">
      <input name="relation" size="60" value="<%=relation%>" maxlength="100" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">來源(DC.Source)</td>
    <td colspan="3">
      <input name="source" size="60" value="<%=source%>" maxlength="100" />
    </td>
  </tr>
  <tr>
    <td class="T12b">語言(DC.Language)</td>
    <td colspan="3">
      <input name="languagetype" size="60" value="<%=languagetype%>" maxlength="20" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b">版權說明(DC.Rights)</td>
    <td colspan="3">
      <input name="rights" size="60" value="<%=rights%>" maxlength="100" />
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>主題分類(category.theme)</td>
    <td colspan="3">
      <input type="text" name="themeview" size="40" maxlength="100" value="<%=theme%>" readonly />&nbsp;&nbsp;&nbsp;
      <input type="button" value="選擇全部" onclick="javascript:choice('1','mform','theme')" />
      <input type="hidden" name="theme" value="<%=themeclass%>" />
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>施政分類(category.cake)</td>
    <td colspan="3">
      <input type="text" name="cakeview" size="40" maxlength="100" value="<%=cake%>" readonly />&nbsp;&nbsp;&nbsp;
      <input type="button" value="選擇全部" onclick="javascript:choice('2','mform','cake')" />
      <input type="hidden" name="cake" value="<%=cakeclass%>" />
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>服務分類(category.service)</td>
    <td colspan="3">
      <input type="text" name="serviceview" size="40" maxlength="100" value="<%=service%>" readonly />&nbsp;&nbsp;&nbsp;
      <input type="button" value="選擇全部" onclick="javascript:choice('3','mform','service')" />
      <input type="hidden" name="service" value="<%=serviceclass%>" />
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

  