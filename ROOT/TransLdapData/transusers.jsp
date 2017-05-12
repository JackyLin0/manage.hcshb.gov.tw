<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：transusers.jsp
說明：轉人員
開發者：chmei
開發日期：2017.02.18
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>轉人員</title>
</head>
<body>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.TransLdapData.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<%
  TransUsersData query = new TransUsersData();
  List<Map<String,String>> qlists = query.getLdapUsers();

  if ( qlists != null && qlists.size() > 0 ) {
	  out.println("size="+qlists.size());
	  for ( int i=0; i<qlists.size(); i++ ) {
		  Map<String,String> qlist = qlists.get( i );
		  String unitdn = SvString.right(qlist.get("entrydn"), ",");
		  DepartmentTree qmid = new DepartmentTree();
		  qmid.setUnitdn(unitdn);
		  ArrayList<DSItem> qids = qmid.getDepartment();
		  if ( qids != null && qids.size() > 0 ) {
			  DSItem qid = ( DSItem )qids.get(0);
			  String parentpath = qid.getParentpath() + "," + qid.getId();
			  ArrayList<DSItem> result = new ArrayList<DSItem>();
			  DSItem setdata = new DSItem();
			  
			  setdata.setMuid(qlist.get("uid"));  
			  setdata.setUnitdn(unitdn);
			  setdata.setCn(qlist.get("cn"));
			  setdata.setDn(qlist.get("entrydn"));
			  setdata.setPid(qlist.get("carLicense"));
			  setdata.setEmail(qlist.get("mail"));
			  setdata.setParentid(qid.getId());
			  setdata.setParentpath(parentpath);
			  setdata.setLogincn("sysviewtg2");
			  setdata.setLoginap("sysviewtg2");

			  result.add(setdata);

			  UsersTree obj = new UsersTree();
			  obj.setAdddata(result);

			  boolean rtn  = obj.create();
			  if ( !rtn ) {
				  out.println("dn="+qlist.get("entrydn"));
				  out.println("error="+obj.getErrorMsg());
				  out.println("<br>");
			  }
			  
		  }else{
			  out.println("dn="+qlist.get("entrydn"));
		  }
		  
	  }
  }
%>  
  
  
</body>
</html>