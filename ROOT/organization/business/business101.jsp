<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：business101.jsp
說明：業務簡介
開發者：chmei
開發日期：97.02.21
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<script>
  function qrynum()
  {
     document.mform.action="business101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
     document.mform.action="business101_save.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
</script>

</head>

<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="tw.com.sysview.filter.qfilterSql"%>
<%@ page import="tw.com.econcord.ds.*" %>

<%
  String language = ( String )request.getParameter( "language" );
  //Sql_Injection
  if ( !language.equals("") ) {
     qfilterSql qcontentlink = new qfilterSql();
     boolean rtn = qcontentlink.filterSql(language);
     if ( rtn )
    	 language = qcontentlink.getMcontent();
  }
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  //Sql_Injection
  if ( !pubunitdn.equals("") ) {
     qfilterSql qcontentlink = new qfilterSql();
     boolean rtn = qcontentlink.filterSql(pubunitdn);
     if ( rtn )
    	 pubunitdn = qcontentlink.getMcontent();
  }

  String pubunitname = "";
  int unitid = 0;
  DepartmentTree qunit1 = new DepartmentTree();
  qunit1.setUnitdn(pubunitdn);
  ArrayList<DSItem> qunits1 = qunit1.getDepartment();
  if ( qunits1 != null && qunits1.size() > 0 ) {
	  DSItem qunitname = ( DSItem )qunits1.get(0);
	  pubunitname = qunitname.getChinesetitle();
	  unitid = qunitname.getId();
  }
  
  DepartmentTree qunit = new DepartmentTree();
  qunit.setParentId(String.valueOf(unitid));
  ArrayList<DSItem> qunits = qunit.getDepartment();
  
  //業務簡介
  BusinessData qcon = new BusinessData();
  boolean rtn = qcon.load(pubunitdn);
  String mcontent = "";
  String mserno = "";
  if ( rtn ) {
	  mserno = qcon.getSerno();
	  mcontent = qcon.getContent();
  }


%>

<body>
<form name="mform">
<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
<input type="hidden" name="pubunitname" value="<%=pubunitname%>"/>
<input type="hidden" name="mserno" value="<%=mserno%>"/>

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<a class="md" href="javascript:save()">儲   存</a>

<br><br>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th colspan="2">業務簡介</th>
  </tr>
  <%
    String temp_mcontent = ( String )request.getParameter( "content" );
  
    if ( temp_mcontent != null && !temp_mcontent.equals("null") && !temp_mcontent.equals("") ) {
    	qfilterSql qcontentlink = new qfilterSql();
        boolean rtnc = qcontentlink.filterSql(temp_mcontent);
        if ( rtnc )
        	mcontent = qcontentlink.getMcontent();
    }
     
  %>
  <tr>
    <td>詳細內容</td>
    <td>
      <textarea name="content" cols="80" rows="8"><%=mcontent%></textarea>
      <br><span class="T10">    (至多500個中文字）</span>
    </td>
  </tr>

</table>  
<p>　</p>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th colspan="2">業務職掌</th>
  </tr>
  <%
    int i=0;
    if ( qunits != null && qunits.size() > 0 ) {
    	for ( int z=0; z<qunits.size(); z++ ) {
    		DSItem qunitdn = ( DSItem )qunits.get( z );
    		i = i + 1;
    		String num = ( String )request.getParameter( "num"+i );
    		if ( num == null || num.equals("null") )
    			num = "0";
    		String mcolor = "";
    		if ( i%2 == 0 ) {
    			mcolor = "class='tr'";
    		} %>
      		<tr <%=mcolor%>>
      		  <td width="20%" valign="top"><%=qunitdn.getChinesetitle()%></td>
      		  <input type="hidden" name="unitdn<%=i%>" value=<%=qunitdn.getUnitdn()%>>
      		  <input type="hidden" name="unitname<%=i%>" value=<%=qunitdn.getChinesetitle()%>>
      		  <td>
      		    <table border="0">
      		      <%
      		        if ( !num.equals("") ) {
      		        	//業務執掌
      		        	BusinessData query = new BusinessData();
      		        	ArrayList qlists = query.findByday(pubunitdn,qunitdn.getUnitdn());
      		        	int rcount = query.getAllrecordCount();      		        	
      		        	if ( qlists == null )
      		        		rcount = Integer.parseInt(num); %>
      		        	
      		        	<tr>
      		        	  <td align="left">
      		        	    <select name="num<%=i%>" onchange="qrynum()">
      		        	       <option value="0">--請選擇--</option>
      		        	       <%
      		        	         if ( num.equals("0") )
      		        	        	 num = String.valueOf(rcount);
      		        	         for ( int k=1; k<21; k++ ) {
      		        	        	 String isSelected = "";
      		        	        	 if ( k == Integer.parseInt(num) )
      		        	        		 isSelected = "selected";  %>
      		        	        	 <option value="<%=k%>" <%=isSelected%>><%=k%></option>
      		        	         <%}%>
      		        	    </select>
      		        	  </td>
      		        	</tr>
      		        	<%
      		        	  if ( qlists == null ) {
      		        		  for ( int j=0; j<rcount; j++ ) { %>
      		        			  <tr>
      		        			    <td><%=j+1%>、標題</td>
      		        			    <%
      		        			      String msubject = ( String )request.getParameter( "subject"+i+j );
      		        			      if ( msubject == null || msubject.equals("null") ){
      		        			    	  msubject = "";
                 		              } else {
                 		        		  //Sql_Injection
                 		        		  qfilterSql qcontentlink = new qfilterSql();
                 		        		  boolean rtns = qcontentlink.filterSql(msubject);
                 		        		  if ( rtns )
                 		        			 msubject = qcontentlink.getMcontent();
                 		        	  }
      		        			    %>
      		        			    <td>
      		        			      <input type="text" name="subject<%=i%><%=j%>" size="50" value="<%=msubject%>">
      		        			      <br><span class="T10">    (至多100個中文字）</span>
      		        			    </td>
      		        			  </tr>      		        		 
      		        			  <tr>
      		        			    <td>內容</td>
      		        			    <%
      		        			      String mcontent1 = ( String )request.getParameter( "content1"+i+j );
      		        			      if ( mcontent1 == null || mcontent1.equals("null") ) {
      		        			    	  mcontent1 = "";
            		        		  } else {
                        		        	  //Sql_Injection
                        		        	  qfilterSql qcontentlink = new qfilterSql();
                        		        	  boolean rtnc = qcontentlink.filterSql(mcontent1);
                        		        	  if ( rtnc )
                        		        		  mcontent1 = qcontentlink.getMcontent();
                        		      }
      		        			    %>
      		        			    <td>
      		        			      <textarea name="content1<%=i%><%=j%>" cols="70" rows="5"><%=mcontent1%></textarea>
      		        			      <br><span class="T10">    (至多500個中文字）</span>
      		        			    </td>
      		        			  </tr>
        		        	  <%}
      		        	  }else{
      		        		  if ( rcount > Integer.parseInt(num) )
      		        			  rcount = Integer.parseInt(num);
      		        		  for ( int j=0; j<rcount; j++ ) {
      		        			  BusinessData qlist = ( BusinessData )qlists.get( j );  %>
      		        			  <tr>
      		        			    <td><%=j+1%>、標題</td>
      		        			    <%
      		        			      String bsubject = ( String )request.getParameter( "subject"+i+j );
      		        			      if ( bsubject == null || bsubject.equals("null") ) {
      		        			    	  bsubject = qlist.getSubject();  
      		        			      } else {
                    		        	  //Sql_Injection
                    		        	  qfilterSql qcontentlink = new qfilterSql();
                    		        	  boolean rtns = qcontentlink.filterSql(bsubject);
                    		        	  if ( rtns )
                    		        		  bsubject = qcontentlink.getMcontent();
                    		          }
      		        			    %>
      		        			    <td>
      		        			      <input type="text" name="subject<%=i%><%=j%>" size="50" value="<%=bsubject%>">
      		        			      <br><span class="T10">    (至多100個中文字）</span>
      		        			    </td>
      		        			  </tr>
      		        			  <tr>
      		        			    <td>內容</td>
      		        			    <%
      		        			      String bcontent = ( String )request.getParameter( "content1"+i+j );
      		        			      if ( bcontent == null || bcontent.equals("null") ) {
      		        			    	  bcontent = qlist.getContent();  
                		        	  } else {
                    		        	  //Sql_Injection
                    		        	  qfilterSql qcontentlink = new qfilterSql();
                    		        	  boolean rtnc = qcontentlink.filterSql(bcontent);
                    		        	  if ( rtnc )
                    		        		  bcontent = qcontentlink.getMcontent();
                    		          }
                          %>
      		        			    <td>
      		        			      <textarea name="content1<%=i%><%=j%>" cols="70" rows="5"><%=bcontent%></textarea>
      		        			      <br><span class="T10">    (至多500個中文字）</span>
      		        			    </td>
      		        			  </tr>
      		        		  <%}
      		        		  
      		        		  if ( Integer.parseInt(num) > rcount ) {   
      		        			  for ( int j=rcount; j<Integer.parseInt(num); j++ ) {  %>
      		        				  <tr>
      		        				    <td><%=j+1%>、標題</td>
      		        				    <%
      		        				      String msubject = ( String )request.getParameter( "subject"+i+j );
      		        				      if ( msubject == null || msubject.equals("null") ) {
      		        				    	  msubject = "";
             		        			  } else {
                             		        	  //Sql_Injection
                             		        	  qfilterSql qcontentlink = new qfilterSql();
                             		        	  boolean rtns = qcontentlink.filterSql(msubject);
                             		        	  if ( rtns )
                             		        		 msubject = qcontentlink.getMcontent();
                             		      }
      		        				    %>
      		        				    <td>
      		        				      <input type="text" name="subject<%=i%><%=j%>" size="50" value="<%=msubject%>">
      		        				      <br><span class="T10">    (至多100個中文字）</span>
      		        				    </td>
      		        				  </tr>      		        		 
      		        				  <tr>
      		        				    <td>內容</td>
      		        				    <%
      		        				      String mcontent1 = ( String )request.getParameter( "content1"+i+j );
      		        				      if ( mcontent1 == null || mcontent1.equals("null") ) {
      		        				    	  mcontent1 = "";
            		        			  } else {
                             		        	  //Sql_Injection
                             		        	  qfilterSql qcontentlink = new qfilterSql();
                             		        	  boolean rtnc = qcontentlink.filterSql(mcontent1);
                             		        	  if ( rtnc )
                             		        		 mcontent1 = qcontentlink.getMcontent();
                             		      }
      		        				    %>
      		        				    <td>
      		        				      <textarea name="content1<%=i%><%=j%>" cols="70" rows="5"><%=mcontent1%></textarea>
      		        				      <br><span class="T10">    (至多500個中文字）</span>
      		        				    </td>
      		        				  </tr>
      		        			  <%} 
      		        		  }
      		        	 }%>
      		        	 <input type="hidden" name="rcount<%=i%>" value="<%=rcount%>">
      		        	 <input type="hidden" name="unitcount" value="<%=qunits.size()%>">
      		         <%}%>      		       
      		    </table>
      		  </td>
      		</tr>
    	<%}      		
    }%>    
</table>  

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>
