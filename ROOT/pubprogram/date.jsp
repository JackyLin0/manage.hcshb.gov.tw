<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="tw.com.sysview.filter.qfilterSql"%>

<%
  String colname=(String)request.getParameter("colname");
  //Sql_Injection
  if ( !colname.equals("") ) {
     qfilterSql qcontentlink = new qfilterSql();
     boolean rtn = qcontentlink.filterSql(colname);
     if ( rtn )
      colname = qcontentlink.getMcontent();
  }
  String view=(String)request.getParameter("view");
  //Sql_Injection
  if ( !view.equals("") ) {
     qfilterSql qcontentlink = new qfilterSql();
     boolean rtn = qcontentlink.filterSql(view);
     if ( rtn )
    	 view = qcontentlink.getMcontent();
  }
  String datevalue=(String)request.getParameter("datevalue");

%>

<script src="../js/Calendar.js"></script>
<script language="javascript">


<%
  if( datevalue==null || datevalue.equals("") ){ %>
	  show_calendar('<%=colname%>','<%=view%>');
  <%}else{%>
      show_calendar('<%=colname%>','<%=view%>','<%=datevalue.substring(0,4)%>','<%=datevalue.substring(4,6)%>');
  <%}%>
  
 
</script>
