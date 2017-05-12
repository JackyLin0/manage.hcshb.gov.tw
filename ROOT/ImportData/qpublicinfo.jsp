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
  PublicInforData query = new PublicInforData();
  ArrayList<Object> qlists = query.findByday("PublicInfor","","ou=chupei,ou=ap_root,o=hcshb,c=tw","","00000000","99999999");
  int rcount = query.getAllrecordCount();
  out.println(rcount);
  if ( qlists != null ) {
	  for ( int i=0; i<rcount; i++ ) {
		  String mdata = "";
		  PublicInforData qlist = ( PublicInforData )qlists.get( i );
		  mdata = "insert into PublicInfor(Serno,PubUnitDN,PubUnitName,Mserno,Mclassname,Subject,WebSiteDN,WebSiteName,PosterDate,CloseDate,StartUsing,Flag,RelateUrl,RelateName,ClientFile,ServerFile,ExpFile,Content,Fsort,PostName,UpdateDate)";
		  mdata = mdata + " values('" + qlist.getSerno() + "','" + qlist.getPubunitdn() + "','" +
				  qlist.getPubunitname() + "','" + qlist.getMserno() + "','" + qlist.getMclassname() + "','" + 
				  qlist.getSubject() + "','" + qlist.getWebsitedn() + "','" + qlist.getWebsitename() + "','" + qlist.getPosterdate() + "','" +
				  qlist.getClosedate() + "','" + qlist.getStartusing() + "','" + qlist.getFlag() + "','" + qlist.getRelateurl() + "','" + qlist.getRelatename() + "','" +
				  qlist.getClientfile() + "','" + qlist.getServerfile() + "','" + qlist.getExpfile() + "','" + qlist.getContent() + "','" + qlist.getFsort() + "','" + qlist.getPostname() + "','" + qlist.getUpdatedate() + "')";
		  out.println(mdata);
		  out.println("<br>");
	  }
  }
  
%>


</body>
</html>