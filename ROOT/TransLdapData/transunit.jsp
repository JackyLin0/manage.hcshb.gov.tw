<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：transunit.jsp
說明：轉單位
開發者：chmei
開發日期：2017.02.15
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>轉單位</title>
</head>
<body>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.TransLdapData.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<%
  TransUnitData query = new TransUnitData();
  List<Map<String,String>> qlists = query.getLdapUnit();
  
  if ( qlists != null && qlists.size() > 0 ) {
	  int num4 = 0;
	  for ( int i=0; i<qlists.size(); i++ ) {
		  Map<String,String> qlist = qlists.get( i );
		  String[] ary_dn = SvString.split(qlist.get("entrydn"),",");
		  if ( ary_dn.length == 4 ) {
			  num4 = num4 + 1;
			  String unitdn = SvString.right(qlist.get("entrydn"),",");
			  DepartmentTree qmid = new DepartmentTree();
			  qmid.setUnitdn(unitdn);
			  ArrayList<DSItem> qids = qmid.getDepartment();
			  if ( qids != null && qids.size() > 0 ) {
				  DSItem qid = ( DSItem )qids.get(0);
				  ArrayList<DSItem> result = new ArrayList<DSItem>();
				  DSItem setdata = new DSItem();
				  String parentpath = qid.getParentpath() + "," + qid.getId();

				  setdata.setOu(qlist.get("ou"));  
				  setdata.setChinesetitle(qlist.get("chinesetitle"));
				  setdata.setUnitdn(qlist.get("entrydn"));
				  setdata.setLogincn("sysviewtg2");
				  setdata.setLoginap("sysviewtg2");
				  setdata.setParentid(qid.getId());
				  setdata.setParentpath(parentpath);
				  
				  result.add(setdata);

				  DepartmentTree obj = new DepartmentTree();
				  obj.setAdddata(result);

				  boolean rtn  = obj.create();
				  out.println("rtn4="+rtn);
			  }
		  }
	  }
  }
  
  if ( qlists != null && qlists.size() > 0 ) {
	  int num5 = 0;	  
	  for ( int i=0; i<qlists.size(); i++ ) {
		  Map<String,String> qlist = qlists.get( i );
		  String[] ary_dn = SvString.split(qlist.get("entrydn"),",");
		  if ( ary_dn.length == 5 ) {
			  num5 = num5 + 1;
			  String unitdn = SvString.right(qlist.get("entrydn"),",");
			  DepartmentTree qmid = new DepartmentTree();
			  qmid.setUnitdn(unitdn);
			  ArrayList<DSItem> qids = qmid.getDepartment();
			  if ( qids != null && qids.size() > 0 ) {
				  DSItem qid = ( DSItem )qids.get(0);
				  ArrayList<DSItem> result = new ArrayList<DSItem>();
				  DSItem setdata = new DSItem();
				  String parentpath = qid.getParentpath() + "," + qid.getId();

				  setdata.setOu(qlist.get("ou"));  
				  setdata.setChinesetitle(qlist.get("chinesetitle"));
				  setdata.setUnitdn(qlist.get("entrydn"));
				  setdata.setLogincn("sysviewtg2");
				  setdata.setLoginap("sysviewtg2");
				  setdata.setParentid(qid.getId());
				  setdata.setParentpath(parentpath);
				  
				  result.add(setdata);

				  DepartmentTree obj = new DepartmentTree();
				  obj.setAdddata(result);

				  boolean rtn  = obj.create();
				  out.println("rtn5="+rtn);
			  }else{
				  out.println("entrydn="+qlist.get("entrydn"));
			  }
		  }
	  }
  }
%>

</body>
</html>