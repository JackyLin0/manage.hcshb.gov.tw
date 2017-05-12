<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：transaproot.jsp
說明：轉應用系統
開發者：chmei
開發日期：2017.02.21
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>轉應用系統</title>

</head>
<body>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.ds.*" %>
<%@ page import="tw.com.econcord.TransLdapData.*" %>

<%
  int dnlength = 0;
  String dnlen = ( String )request.getParameter( "dnlen" );
  if ( dnlen != null && !dnlen.equals("null") && !dnlen.equals("") )
	  dnlength = Integer.parseInt(dnlen);
  out.println("dnlength="+dnlength);
  TransApRootData query = new TransApRootData();
  List<Map<String,String>> qlists = query.getApRoot();
  if ( dnlength > 0 && qlists != null && qlists.size() > 0 ) {
	  for ( int i=0; i<qlists.size(); i++ ) {
		  Map<String,String> qlist = qlists.get( i );
		  String[] ary_dn = SvString.split(qlist.get("entrydn"),",");
		  
		  if ( ary_dn.length == dnlength ) {
			  String aplistdn = SvString.right(qlist.get("entrydn"), ",");
			  ApRootTree qmid = new ApRootTree();
			  ArrayList<DSItem> qids = qmid.getAptree(aplistdn);
			  
			  if ( qids != null && qids.size() > 0 ) {
				  DSItem qid = ( DSItem )qids.get(0);				  			  
				  String parentpath = qid.getParentpath() + "," + qid.getId();
				  
				  ArrayList<DSItem> result = new ArrayList<DSItem>();
				  DSItem setdata = new DSItem();
				  
				  setdata.setAplistdn(qlist.get("entrydn"));
				  setdata.setOu(qlist.get("ou"));
				  setdata.setAplisturl(qlist.get("url"));
				  setdata.setParentid(qid.getId());
				  setdata.setParentpath(parentpath);
				  setdata.setSysname(qlist.get("sysname"));
				  setdata.setStartusing(qlist.get("startusing"));
				  setdata.setPagenumber(qlist.get("number"));
				  setdata.setUserunit(qlist.get("punit"));
				  setdata.setLogincn("sysviewtg2");
				  setdata.setLoginap("sysviewtg2");

				  result.add(setdata);

				  ApRootTree obj = new ApRootTree();
				  obj.setAdddata(result);

				  boolean rtn  = obj.create();
				  if ( !rtn ) {
					  out.println("dn="+qlist.get("entrydn"));
					  out.println("sysname="+qlist.get("sysname"));
					  out.println("<br>");
				  }
			  }
		  }
	  }
  }
  
%>  

</body>
</html>

