<%@page import="tw.com.sysview.dba.meeting.PlaceData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：qplace.jsp
說明：會議室場地
開發者：yclai
開發日期：103.08.26
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>會議室場地</title>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>

</head>

<%

  String onchange = ( String )request.getParameter( "onchange" );
  if ( onchange == null )
	  onchange = "";
  String logindn1 = ( String )session.getAttribute("logindn");
  String mpunit1 = ( String )request.getParameter( "mpunit" );
  if ( mpunit1 != null && !mpunit1.equals("null") )
	  session.setAttribute("mpunit",mpunit1);
  if ( mpunit1 == null || mpunit1.equals("null") )
	  mpunit1 = ( String )session.getAttribute("mpunit");
  
  String colname = ( String )request.getParameter( "colname" );
  String language = ( String )request.getParameter( "language" );
  String datavalue = ( String )request.getParameter( "datavalue" );
  String punitdata = "";
  if ( datavalue != null && !datavalue.equals("") ) {
	  String[] ary_punit = SvString.split(datavalue,"||");
	  punitdata = ary_punit[0];
  }
  
  
//   String qwebsite = ( String )request.getParameter( "qwebsite" );
    
  String table = ( String )request.getParameter( "t" );
  
  if ( (logindn1 == null) || (logindn1.equals("null")) ) {  %>
	  <script>
	     alert("您已超過時間未使用本系統，為了維護個人資料請重新登錄！");
	     window.open("index.jsp","_parent");
	  </script>
  <%}else{
	  String[] ary_logindn = SvString.split(logindn1,",");
	  String mlogindn = logindn1;
	  if ( ary_logindn.length > 4 ) {
		  for ( int i=0; i<ary_logindn.length-4; i++ ) {
			  mlogindn = SvString.right(mlogindn,",");
		  }
	  }
	  //此AP負責局室
	  String[] apunit = SvString.split(mpunit1,"||");
	  boolean find_dn = SvString.contain(apunit,mlogindn);
	  //自session找出角色
	  String role1 = ( String )session.getAttribute("role");
   
      PlaceData query = new PlaceData();
      ArrayList palces = query.findBypalce(table, "");
		  %>
		<select name="<%=colname%>" class="select" <%=onchange%> >
		<option value="" selected>請選擇場地</option>
        <%for(int i=0; i<palces.size(); i++) {
        	PlaceData pdata = (PlaceData)palces.get(i);
            String select="";
            if (datavalue.equals(pdata.getSerno()))
            	select="selected";
            %>
			<option value="<%=pdata.getSerno()%>" <%=select%> ><%=pdata.getPlacename()%></option>
        <%} %>
        </select>
	<%}%>
	     

</html>

