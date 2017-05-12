<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：content.jsp
說明：單元內容管理
開發者：chmei
開發日期：96.02.12
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
	function goUpdate(fckpath,path,mserno,serno,table){
		var url = fckpath + "fckeditor.jsp?source=" + path + "&encoding=utf-8&fckpath=" + fckpath + "&mserno=" + mserno + "&serno=" + serno + "&table=" + table;
		window.open(url);
	}
</script>

</head>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="tw.com.sysview.dba.*" %>


<body>
<form name="mform">

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<%
  String table = ( String )request.getParameter( "t" );
  //FCKedit路徑(如www.hsinchu.gov.tw)
  String path = ( String )request.getParameter( "path" );
  //content路徑，預覽
  String content = ( String )request.getParameter( "content" );

  ContentData query = new ContentData();    
  ArrayList<Object> qlists = query.findByday(table);
  int rcount = query.getAllrecordCount();

%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<table width="98%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="30%"><%=lang.getToplevelcontent()%></th>
    <th width="30%" align="left"><%=lang.getIslevelcontent()%></th>
    <th width="10%"><%=lang.getIslevel()%></th>    
    <th width="10%"><%=lang.getFlag()%></th>
    <th width="20%">&nbsp;</th>
  </tr>
  <%
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) { 
    		ContentData qlist = ( ContentData )qlists.get( i );  %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td align="center"><%=qlist.getToplevelcontent()%>&nbsp;</td>
    		  <td align="left"><%=qlist.getIslevelcontent()%></td>
    		  <td align="center"><%=qlist.getIslevel()%></td>    		  
    		  <%
    		    String mflag = "";
    		     if ( qlist.getFlag().equals("0") )
    		    	 mflag = "靜態網頁(版型)";
    		     else if ( qlist.getFlag().equals("1") )
    		    	 mflag = "動態AP";
    		     else if ( qlist.getFlag().equals("2") )
    		    	 mflag = "超連結";
    		     else if ( qlist.getFlag().equals("3") )
    		    	 mflag = "靜態網頁(自行編輯)";  %>	 
    		  <td align="left"><%=mflag%></td>
    		  <td align="center">
    		    <%
    		      //FCK 路徑(修改)
    		      //判斷OS版本
    			  String FCK_PATH = "";
    			  if ( sysRoot.indexOf("/") == -1 )
    				  FCK_PATH = sysRoot + "\\WEB-INF\\FCKpath.properties";
    			  else
    				  FCK_PATH = sysRoot + "/WEB-INF/FCKpath.properties";

    		      Properties f = new Properties();
    		      f.load(new FileInputStream(FCK_PATH) );
    		      //fckpath 路徑【www.hsinchu.gov.tw/fckeditor】
    		      String fckpath = f.getProperty(path);
    		      //fckpath 路徑【www.hsinchu.gov.tw】
    		      //String fckpath1 = f.getProperty("FCKpath");
    	  	      //String fckpath = fckpath1 + "/" + fordername + "/" + "fckeditor";
    		    
    		      if ( qlist.getFlag().equals("0") || qlist.getFlag().equals("3") ) { %>
    		         <a href="javascript:goUpdate('<%=fckpath%>','<%=qlist.getIslevellink()%>','<%=qlist.getTopserno()%>','<%=qlist.getSerno()%>','<%=table%>')"><img src="../../img/b_edit.png" border="0" />&nbsp;修改</a>&nbsp;
    		      <%}
    		      
    		      //取fordername及link路徑(預覽)
  		          if ( qlist.getIslevellink().indexOf('/') > 0 && qlist.getIslevellink().indexOf("http://") < 0 ) { 
  		        	  int param = qlist.getIslevellink().indexOf('/');
  		        	  String fordername = qlist.getIslevellink().substring(0,param);
  		        	  
  		        	  String contlink = qlist.getIslevellink().substring(param+1,qlist.getIslevellink().length());
  		        	  if(table.contains("HcshbMenu")){
  		        	  	contlink = "hcshb/" + contlink;
  		        	  }
  		        	  String PRO_PATH = "";
  		        	  if ( sysRoot.indexOf("/") == -1 )
  		        		  PRO_PATH = sysRoot + "\\WEB-INF\\" + content;
  		        	  else
  		        		PRO_PATH = sysRoot + "/WEB-INF/" + content;
  		        	  
  		        	  Properties c = new Properties();
  		        	  c.load(new FileInputStream(PRO_PATH));
  		        	  String linkpath = c.getProperty(fordername);   %>
  		        	  <a href="<%=linkpath%>/home.jsp?contlink=<%=contlink%>&mserno=<%=qlist.getTopserno()%>&serno=<%=qlist.getSerno()%>&menudata=<%=table%>" target="new"><img src="../../img/b_search.png" border="0" />&nbsp;預覽</a>
  		          <%}else{%>
    		    	  <a href="<%=qlist.getIslevellink()%>" target="new"><img src="../../img/b_search.png" border="0" />&nbsp;預覽</a>
    		      <%}%>
    		  </td>
    		</tr> 
    	<%}
    }%>	

</table>

<p></p>

<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>