<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
  String list_page = request.getRequestURI();
  int int1 = list_page.lastIndexOf("/");
  
  list_page = list_page.substring(int1+1,list_page.length());
  String startpage1 = ( String )request.getParameter( "startpage" );
  int startpage = Integer.parseInt(startpage1);
  
  String pagesize1 = ( String )request.getParameter( "pagesize" );
  int pagesize = Integer.parseInt( pagesize1 );
  
  String intpage1 = ( String )request.getParameter( "intpage" );
  
  int intpage = Integer.parseInt( intpage1 );
  
  String maxpage1 = ( String )request.getParameter( "maxpage" );
  int maxpage = Integer.parseInt( maxpage1 );
  
  String endpage1 = ( String )request.getParameter( "endpage" );
  int endpage = Integer.parseInt( endpage1 );

  String rcount1 = (String)request.getParameter( "rcount" );
  int rcount = Integer.parseInt( rcount1 );
  
  String formname = ( String )request.getParameter( "formname" );

%>

<script language="javascript">
 function list(page,intpage)
 {
     var thisform = "document.<%=formname%>";
     eval(thisform).page.value = page;
     eval(thisform).intpage.value = Number(intpage);
     eval(thisform).action = "<%=list_page%>";
     eval(thisform).method = "post";
     eval(thisform).submit();
 }
 
 function mlist()
 {
     var thisform = "document.<%=formname%>";
     eval(thisform).page.value = eval(thisform).listpage.value;
     eval(thisform).action = "<%=list_page%>";
     eval(thisform).method = "post";
     eval(thisform).submit();
 }
</script>

<%
  if ( startpage > pagesize ) { %>
	  <a href="javascript:list(<%=intpage-1%>,<%=intpage%>)"><img src="../../img/PreviousPage.gif" alt="上1頁" width="16" height="16" align="absmiddle" border=0/></a>
  <%}else{%>
	  <img src="../../img/PreviousPage_unavailable.gif" alt="無上1頁" width="16" height="16" align="absmiddle" border=0/>
  <%}
  int startnum = 0;
  int endnum = 0;
  if ( maxpage <= 10 ) {
	  startnum = 1;
	  endnum = maxpage;
  }else{
	  startnum = intpage;
	  endnum = intpage + 9;
	  if ( endnum >= maxpage ) {
		  startnum = maxpage - 9;
		  endnum = maxpage;
	  }
  } 
  
  for ( int i=startnum; i<=endnum; i++ ) {  %>
	  <a href="javascript:list(<%=i%>,<%=intpage%>)"><%=i%>
  <%}
  
  if (endpage < rcount) { %>
	  <a href="javascript:list(<%=intpage+1%>,<%=intpage%>)"><img src="../../img/NextPage.gif" alt="下1頁" width="16" height="16" align="absmiddle" border=0/></a>
  <%}else{%>
	  <img src="../../img/PreviousPage_unavailable.gif" alt="無上1頁" width="16" height="16" align="absmiddle" border=0/>
  <%}%>
  
<select name="listpage" class="select" onchange="mlist()">
  <option value="" "selected">頁數</option>
  <%
    for ( int j=1; j<=maxpage; j++ ) {
    	String isSelected = "";
    	if ( j == intpage )
    		isSelected = "selected"; %>
    	<option value=<%=j%> <%=isSelected%>>第<%=j%>頁</option>
    <%}%>
</select>

