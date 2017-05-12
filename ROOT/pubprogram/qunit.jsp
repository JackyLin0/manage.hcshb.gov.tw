<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：qunit.jsp
說明：發佈單位
開發者：chmei
開發日期：2017.03.03
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>發佈單位</title>

</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.ds.*" %>
<%@ page import="sysview.zhiren.function.*" %>

<body>

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
  if ( datavalue != null && !datavalue.equals("null") && !datavalue.equals("") ) {
	  String[] ary_punit = SvString.split(datavalue,"||");
	  punitdata = ary_punit[0];
  }
  
  if ( logindn1 == null || logindn1.equals("null") ) {%>
	  <script>
	     alert("您已超過時間未使用本系統，為了維護個人資料請重新登錄！");
	     window.open("http://gip.shinchu.gov.tw","_parent");
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
	  
	  //out.println("onchange:"+onchange);
	  //out.println("logindn:"+logindn);
	  //out.println("mpunit:"+mpunit);
	  //out.println("colname: "+colname); // value qpunit
	  //out.println("language:"+language);
	  //out.println("role:"+role);
	  
	  if ( !find_dn && role1.equals("") ) {
		  UnitData qunitname = new UnitData();
		  qunitname.setUnitdn(mlogindn);
		  boolean unitrtn = qunitname.loadUnitName();
		  String uname = "";
		  if ( unitrtn ) {
			  uname = qunitname.getUnitname();
		  }
		  String punit1 = mlogindn + "||" + uname;  %>
		  <input type="text" class="textarea" name="punit1" value=<%=uname%> size="20" readonly >
		  <input type="hidden" name="<%=colname%>" value="<%=punit1%>">
	  <%}else{
		  DepartmentTree qunit = new DepartmentTree();
		  qunit.setParentId("1");
		  ArrayList<DSItem> qunits = qunit.getDepartment();
		  //out.println("[qunits.size()] "+qunits.size()); 17 個單位
		  if ( qunits != null && qunits.size() > 0 ) { %>
			  <select name="<%=colname%>" class="select" <%=onchange%>>
			    <option value="" selected>請選擇單位</option>
			    <%
			      for ( int i=0; i<qunits.size(); i++ ) {
			    	  DSItem qunitdata = ( DSItem )qunits.get( i );
			    	  String unitvalue = qunitdata.getUnitdn() + "||" + qunitdata.getChinesetitle(); %>
			    	  <option value="<%=unitvalue%>" <%=(qunitdata.getUnitdn().equals(punitdata) ? "selected" : "")%>><%=qunitdata.getChinesetitle()%></option>
			      <%}%>
			  </select>  
		  <%}
	  }
	  
  }%>

</body>
</html>
