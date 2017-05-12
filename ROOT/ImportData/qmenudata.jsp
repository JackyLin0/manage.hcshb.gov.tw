<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  MenuData query = new MenuData();
  ArrayList<Object> qlists = query.findByday("EmeiMenu","");
  int rcount = query.getAllrecordCount();
  
  if ( qlists != null ) {
	  for ( int i=0; i<rcount; i++ ) {
		  String mdata = "";
		  MenuData qlist = ( MenuData )qlists.get( i );
		  mdata = "insert into KuanshiMenu(Serno,TopSerno,TopLevelContent,TopLevelLink,IsLevel,IsLevelContent,IsLevelLink,Flag,Target,StartUsing,Fsort,ClientFile1,ServerFile1,ShowLink,PostName,CreateDate,UpdateDate)";
		  mdata = mdata + " values('" + qlist.getSerno() + "','" + qlist.getTopserno() + "','" +
				  qlist.getToplevelcontent() + "','" + qlist.getToplevellink() + "','" + qlist.getIslevel() + "','" + 
				  qlist.getIslevelcontent() + "','" + qlist.getIslevellink() + "','" + qlist.getFlag() + "','" + qlist.getTarget() + "','" +
				  qlist.getStartusing() + "','" + qlist.getFsort() + "','" + qlist.getClientfile1() + "','" + qlist.getServerfile1() + "','" + qlist.getShowlink() + "','" +
				  qlist.getPostname() + "','" + qlist.getCreatedate() + "','" + qlist.getUpdatedate() + "')";
		  out.println(mdata);
		  out.println("<br>");
	  }
  }
  
%>


</body>
</html>