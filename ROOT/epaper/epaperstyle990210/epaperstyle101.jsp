<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperstyle101.jsp
說明：首頁內容版型設定
開發者：chmei
開發日期：97.03.02
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String table = ( String )request.getParameter( "t" );
  
  EpaperStyleData query = new EpaperStyleData();
  ArrayList qlists = query.findByday();
  int rcount = query.getAllrecordCount();

%>  

<script>
  function save()
  {
     document.mform.action = "epaperstyle101_save.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="25%" align="center">首頁擺放位置</th>
    <th align="left">分類名稱</th>
  </tr>
  <tr width="100%" onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center">1.</td>
    <td align="center">左邊區塊一</td>
    <td>
      <%
        if ( qlists != null ) { 
        	boolean rtn1 = query.load("left",1); %>
        	<select name="left1">
        	   <%
        	     for ( int i=0; i<rcount; i++ ) {        	    	 
        	    	 EpaperStyleData qlist = ( EpaperStyleData )qlists.get( i );
        	    	 String isSelected = "";
        	    	 if ( qlist.getMserno().equals(query.getMserno()) )
        	    		 isSelected = "selected";
        	    	 String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getMclassname()%></option>
        	     <%}%>
        	</select>     
        <%}%>
    </td>
  </tr>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center">2.</td>
    <td align="center">左邊區塊二</td>
    <td>
      <%
        if ( qlists != null ) {
        	boolean rtn1 = query.load("left",2); %>
        	<select name="left2">
        	   <%
        	     for ( int i=0; i<rcount; i++ ) {
        	    	 EpaperStyleData qlist = ( EpaperStyleData )qlists.get( i );
        	    	 String isSelected = "";
        	    	 if ( qlist.getMserno().equals(query.getMserno()) )
        	    		 isSelected = "selected";
        	    	 String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getMclassname()%></option>
        	     <%}%>
        	</select>     
        <%}%>
    </td>
  </tr>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center">3.</td>
    <td align="center">左邊區塊三</td>
    <td>
      <%
        if ( qlists != null ) {
        	boolean rtn1 = query.load("left",3); %>
        	<select name="left3">
        	   <%
        	     for ( int i=0; i<rcount; i++ ) {
        	    	 EpaperStyleData qlist = ( EpaperStyleData )qlists.get( i );
        	    	 String isSelected = "";
        	    	 if ( qlist.getMserno().equals(query.getMserno()) )
        	    		 isSelected = "selected";
        	    	 String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getMclassname()%></option>
        	     <%}%>
        	</select>     
        <%}%>
    </td>
  </tr>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center">4.</td>
    <td align="center">中間區塊一</td>
    <td>
      <%
        if ( qlists != null ) { 
        	boolean rtn1 = query.load("middle",1); %>
        	<select name="middle1">
        	   <%
        	     for ( int i=0; i<rcount; i++ ) {
        	    	 EpaperStyleData qlist = ( EpaperStyleData )qlists.get( i );
        	    	 String isSelected = "";
        	    	 if ( qlist.getMserno().equals(query.getMserno()) )
        	    		 isSelected = "selected";
        	    	 String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getMclassname()%></option>
        	     <%}%>
        	</select>     
        <%}%>
    </td>
  </tr>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center">5.</td>
     <td align="center">中間區塊二</td>
     <td>
      <%
        if ( qlists != null ) {
        	boolean rtn1 = query.load("middle",2); %>
        	<select name="middle2">
        	   <%
        	     for ( int i=0; i<rcount; i++ ) {
        	    	 EpaperStyleData qlist = ( EpaperStyleData )qlists.get( i );
        	    	 String isSelected = "";
        	    	 if ( qlist.getMserno().equals(query.getMserno()) )
        	    		 isSelected = "selected";
        	    	 String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getMclassname()%></option>
        	     <%}%>
        	</select>     
        <%}%>
    </td>
  </tr>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center">6.</td>
     <td align="center">中間區塊三</td>
     <td>
      <%
        if ( qlists != null ) { 
        	boolean rtn1 = query.load("middle",3); %>
        	<select name="middle3">
        	   <%
        	     for ( int i=0; i<rcount; i++ ) {
        	    	 EpaperStyleData qlist = ( EpaperStyleData )qlists.get( i );
        	    	 String isSelected = "";
        	    	 if ( qlist.getMserno().equals(query.getMserno()) )
        	    		 isSelected = "selected";
        	    	 String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getMclassname()%></option>
        	     <%}%>
        	</select>     
        <%}%>
    </td>
  </tr>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center">7.</td>
     <td align="center">中間區塊四</td>
     <td>
      <%
        if ( qlists != null ) { 
        	boolean rtn1 = query.load("middle",4); %>
        	<select name="middle4">
        	   <%
        	     for ( int i=0; i<rcount; i++ ) {
        	    	 EpaperStyleData qlist = ( EpaperStyleData )qlists.get( i );
        	    	 String isSelected = "";
        	    	 if ( qlist.getMserno().equals(query.getMserno()) )
        	    		 isSelected = "selected";
        	    	 String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getMclassname()%></option>
        	     <%}%>
        	</select>     
        <%}%>
    </td>
  </tr>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td align="center">8.</td>
     <td align="center">中間區塊五</td>
     <td>
      <%
        if ( qlists != null ) { 
        	boolean rtn1 = query.load("middle",5); %>
        	<select name="middle5">
        	   <%
        	     for ( int i=0; i<rcount; i++ ) {
        	    	 EpaperStyleData qlist = ( EpaperStyleData )qlists.get( i );
        	    	 String isSelected = "";
        	    	 if ( qlist.getMserno().equals(query.getMserno()) )
        	    		 isSelected = "selected";
        	    	 String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        	    	 <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getMclassname()%></option>
        	     <%}%>
        	</select>     
        <%}%>
    </td>
  </tr>
</table>

</form>
</body>
</html>

