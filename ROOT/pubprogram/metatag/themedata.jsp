<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
</script>
  
                     
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="tw.com.sysview.metatag.*" %>

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
  
  //單位網站對照檔
  WebsiteUnitData qweb = new WebsiteUnitData();
  boolean rtnunit = qweb.load(pubunitdn);
  String websitedn = "";
  if ( rtnunit )
	  websitedn = qweb.getWebsitedn();


  MetaTagData query = new MetaTagData();    
  boolean rtn = query.load("MetaTagData",websitedn);
  String theme = "";
  if ( rtn )
	  theme = query.getThemeclass();
  
  String dataserno = ( String )request.getParameter( "dataserno" );
  String metatable = ( String )request.getParameter( "metatable" );
  if ( dataserno != null && !dataserno.equals("null") && !dataserno.equals("") ) {
	  if ( metatable != null && !metatable.equals("null") && !metatable.equals("") ) {
		  MetaTagData qtheme = new MetaTagData();
		  boolean rtn1 = qtheme.loaddata(metatable,dataserno);
		  if ( rtn1 ) {
			  if ( qtheme.getThemeclass() != null && !qtheme.getThemeclass().equals("null") && !qtheme.getThemeclass().equals("") )
				  theme = qtheme.getThemeclass();
		  }
	  }
  }
  
  String themeview = "";
  String[] ary_one = SvString.split(theme,",");
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
	  if ( themeview.equals("") ) {
		  themeview = temp1;
	  }else{
		  themeview = themeview + "," + temp1;
	  }	  	  
  }
  
%>


<input type="text" name="themeview" size="60" maxlength="100" value="<%=themeview%>" readonly />&nbsp;&nbsp;&nbsp;
<input type="button" value="選擇全部" onclick="javascript:choice('1','mform','theme')" />
<input type="hidden" name="theme" value="<%=theme%>" />


