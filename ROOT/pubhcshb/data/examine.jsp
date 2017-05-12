<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：examine.jsp
說明：接收資料審核
開發者：chmei
開發日期：97.03.08
修改者：chmei
修改日期：96.12.19
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
  function qry()
  {
    document.mform.action="examine.jsp";
    document.mform.method="post";
    document.mform.submit();
  }  
   
  function exam(table,serno,poster)
  {
     document.mform.tablename.value=table;
     document.mform.mserno.value=serno;
     document.mform.poster.value=poster;
     document.mform.action="examine_news.jsp";
     document.mform.method="post";
     document.mform.submit();
  } 
    
  function clean()
  {
      document.mform.qap.value = "";
      document.mform.qexamine.value = "N"; 
  }     

</script>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接收查詢條件
  String qap = ( String )request.getParameter( "qap" );
  String[] ary_qapdn = null;
  if ( qap != null && !qap.equals("null") )  {
	  ary_qapdn = SvString.split(qap,"&");
	  qap = ary_qapdn[0];
  }else{
	  qap = ""; 
  }
  
  String qexamine = ( String )request.getParameter( "qexamine" );
  if ( qexamine == null )
	  qexamine = "N";
  
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  
  String logindn = ( String )session.getAttribute("logindn");
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  
  String website = ( String )request.getParameter( "website" );

  //尋找多向發布AP
  PublishData qaplist = new PublishData();  
  ArrayList qaps = qaplist.findByAP(table1,"");  
  int aprcount = qaplist.getAllrecordCount();
  
  String mposter = "";
  String mdata = "";
  String mclass = "";
  String apname = "";
  String apdn = "";
  if ( qaps != null ) {
	  for ( int i=0; i<aprcount; i++ ) {
		  PublishData qap1 = ( PublishData )qaps.get( i );
		  String[] ary_aptable = SvString.split(qap1.getAplisttable(),"||");
		  if ( mposter.equals("") ) {
			  mclass = ary_aptable[0];
			  mdata = ary_aptable[1];
			  mposter = ary_aptable[2];
			  apname = qap1.getAplistname();
			  apdn = qap1.getAplistdn();
		  }else{
			  mclass = mclass + "||" + ary_aptable[0];
			  mdata = mdata + "||" + ary_aptable[1];
			  mposter = mposter + "||" + ary_aptable[2];
			  apname = apname + "||" + qap1.getAplistname();
			  apdn = apdn + "||" + qap1.getAplistdn();
		  }			  
	  }
  }

%>


<body>
<form name="mform">
<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="t1" value="<%=table1%>"/>
<input type="hidden" name="website" value="<%=website%>"/>
<input type="hidden" name="tablename"/>
<input type="hidden" name="mserno"/>
<input type="hidden" name="poster"/>

<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%@ include file="../../pubprogram/language.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<div>
  <span class="T11b"><%=lang.getPublishapname()%></span>
  <%
    //尋找多向發布AP
    PublishData qapdn = new PublishData();
    ArrayList qaplistdns = qapdn.findByAP(table1,"");
    int apdnrcount = qapdn.getAllrecordCount();  
  %>
  <select name="qap">
     <option value="" selected>--請選擇--</option>
     <%
       if ( qaplistdns != null ) {
    	   for ( int i=0; i<apdnrcount; i++ ) { 
    		   PublishData qaplistdn = ( PublishData )qaplistdns.get( i );
    		   String isSelected = "";
    		   String[] ary_qap = SvString.split(qap,"&");
    		   if ( qaplistdn.getAplistdn().equals(ary_qap[0]) )
    			   isSelected = "selected";
    		   String datavalue = qaplistdn.getAplistdn() + "&" + qaplistdn.getAplisttable(); %>
    		   <option value="<%=datavalue%>" <%=isSelected%>><%=qaplistdn.getAplistname()%></option>    		      		   
    	   <%}
       }%>
  </select>&nbsp;&nbsp;
  <span class="T11b"><%=lang.getExamine()%></span>
  <select name="qexamine">
     <option value="Y" <%=(qexamine.equals("Y") ? "selected" : "")%>>已審核</option>
     <option value="N" <%=(qexamine.equals("N") ? "selected" : "")%>>未審核</option>
  </select>
  &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()"><%=lang.getQry()%></a>&nbsp;
  <a class="md2" href="javascript:clean()"><%=lang.getReset()%></a>
</div>
<p>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="15%" align="left"><%=lang.getExamine()%></th>
    <th width="20%" align="left"><%=lang.getAplistname()%></th>
    <th width="30%"><%=lang.getSubject()%></th>
    <th width="15%"><%=lang.getPubunitname()%></th>
    <th width="15%"><%=lang.getPosterdate()%></th>
  </tr>
  <%
    String[] ary_class = SvString.split(mclass,"||");
    String[] ary_data = SvString.split(mdata,"||");
    String[] ary_poster = SvString.split(mposter,"||");
    String[] ary_apname = SvString.split(apname,"||");
    int num = 1;
    
    for ( int i=0; i<ary_poster.length; i++ ) {
    	ExamineData query = new ExamineData();    	
    	ArrayList qexams = query.findByday(ary_poster[i],table,website,qexamine);    	
    	int rcount = query.getAllrecordCount();
    	if ( qexams != null ) {
    		for (int k=0; k<rcount; k++ ) {
    			ExamineData qexam = ( ExamineData )qexams.get( k ); 
    			ExamineData qdata = new ExamineData();
    			boolean mrtn = qdata.load(ary_data[i],qexam.getSerno()); %>    			
    			<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	    	  <td align="center"><%=num%></td>
    	    	  <%
    	    	    String exam = "";   
    	    	    if ( qexam.getWebsiteexam() != null ) {
    	    	    	if ( qexam.getWebsiteexam().equals("0") )
        	    	    	exam = "待審核";
        	    	    else if ( qexam.getWebsiteexam().equals("Y") )
        	    	    	exam = "同意";
        	    	    else if ( qexam.getWebsiteexam().equals("N") )
        	    	    	exam = "不同意";
    	    	    }    	    	    
    	    	  %>
    	    	  <td align="left"><%=exam%></td>
    	    	  <td align="left"><%=ary_apname[i]%></td>
    	    	  <td align="leftr"><a href="javascript:exam('<%=ary_data[i]%>','<%=qexam.getSerno()%>','<%=ary_poster[i]%>','<%=website%>')"><%=qdata.getSubject()%></a></td>
    	    	  <td align="center"><%=qdata.getPubunitname()%></td>
    	    	  <td align="center"><%=qdata.getPosterdate().substring(0,4)%>.<%=qdata.getPosterdate().substring(4,6)%>.<%=qdata.getPosterdate().substring(6,8)%></td>
    	    	</tr> 
    	    	<%
    	    	  num = num + 1;
    		}
    	}
    }%>

  <tr>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
  </tr>
</table>

<p>
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>