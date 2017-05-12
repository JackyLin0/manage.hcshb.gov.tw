<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities102_print.jsp
說明：線上報名表
開發者：chmei
開發日期：97.12.05
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }

  String role = ( String )session.getAttribute("role");
  if ( role != null && !role.equals("null") && !role.equals("") )
	  pubunitdn = "";

  //尋找已新增報名表
  ActivityExcelData query = new ActivityExcelData();
  ArrayList qlists = query.findByday(pubunitdn);
  int rcount = query.getAllrecordCount();
  
  String msubject = ( String )request.getParameter( "msubject" );
  String[] activityserno = null;
  if ( msubject != null && !msubject.equals("null") && !msubject.equals("") ) {
	  activityserno = SvString.split(msubject,"||");
  }
  
  ArrayList qrecords = null;
  int rcount1 = 0;
  if ( msubject != null && !msubject.equals("null") && !msubject.equals("") ) {
	  ActivityExcelData qmrecord = new ActivityExcelData();
	  qrecords = qmrecord.findByrecord(activityserno[0]);
	  rcount1 = qmrecord.getAllrecordCount();
  }

%>  

<script>
  function qry()
  {
     document.mform.action = "activities102_print.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }
  
  function excel(rcount)
  {
     var num = rcount;
     var pfield = "N";
     for ( i=0; i<rcount.length; i++ ) {
        if ( document.mform.field[i].checked ) {
           pfield = "Y";
           break;
        }   
     }
     if ( pfield == "N" ) {
        alert("您未勾選【列印欄位】，請勾選！");
        document.mform.field[0].focus();
        return;
     }
     
     document.mform.action = "activities102_excel.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
  
  function onechangeall(rcount)
  {
     var num = rcount
     if ( document.mform.allfield.checked )
     {
        for ( i=0; i<num; i++ ) {
           if ( !(document.mform.field[i].checked) )
              document.mform.field[i].checked = true;
        }
     }else{
        for ( i=0; i<num; i++ ) {
          if ( document.mform.field[i].checked )
             document.mform.field[i].checked = false;
       }
     }
  } 
  
</script>

<body>
<form name="mform">
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>

<%
  if ( msubject != null && !msubject.equals("null") && !msubject.equals("") ) { %>
	  <a class="md" href="javascript:excel('<%=rcount1%>')">轉EXCEL檔</a>
  <%}%>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">&nbsp;</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="20%"><span class="T12red">※</span>活動訊息標題</td>
    <td colspan="3">
      <select name="msubject" onchange="qry()">
        <option value="">請選擇欲轉EXCEL報表之活動</option>
        <%
          if ( qlists != null ) {
        	  for ( int i=0; i<rcount; i++ ) {
        		  ActivityExcelData qlist = ( ActivityExcelData )qlists.get( i );
        		  String datavalue = qlist.getSerno() + "||" + qlist.getSubject();
        		  String isSelected = "";
        		  if ( msubject != null && !msubject.equals("null") ) {
        			  if ( qlist.getSerno().equals(activityserno[0]) )
        				  isSelected = "selected";
        		  }%>
        		  <option value="<%=datavalue%>" <%=isSelected%>><%=qlist.getSubject()%></option>
        	  <%}
          }%>
      </select> 
    </td>
  </tr>    
  <%
    if ( msubject != null && !msubject.equals("null") && !msubject.equals("") ) {
    	if ( qlists != null ) { %>
    	    <tr>
    	      <td class="T12b" width="20%">是否加印簽名欄</td>
    	      <td colspan="3">
    	        <input type="radio" name="sign" value="Y" />是&nbsp;&nbsp;
    	        <input type="radio" name="sign" value="N" checked />否
    	      </td>
    	    </tr>
    		<tr class="tr">
    		  <td class="T12b" width="20%"><span class="T12red">※</span>選擇排序欄位</td>
    		  <td colspan="3">
    		    <select name="qsort">
    		      <option value="">--- 請選擇 ---</option>
    		    <%
    		      for ( int s=0; s<rcount1; s++ ) {
    		    	  ActivityExcelData qlist = ( ActivityExcelData )qrecords.get( s );
    		    	  ActivityExcelData qsort = new ActivityExcelData();
    		    	  boolean srtn = qsort.load(qlist.getFieldserno());
    		    	  if ( srtn ) { %>
    		    		  <option value="<%=qsort.getSerno()%>"><%=qsort.getFieldname()%></option>
    		    	  <%}
    		      }%>
    		  </td>
    		</tr>  
    		<tr>
    		  <td class="T12b" width="20%"><span class="T12red">※</span>選擇列印欄位</td>
    		  <td colspan="3">
    		    <table border="0" width="97%">
    		      <tr>
    		        <td><input type="checkbox" name="allfield" value="" onclick="onechangeall('<%=rcount1%>')"></input>&nbsp;全選</td>
    		      </tr>
    		      <%
    		        int k = 0;
    		        for ( int i=0; i<rcount1; i++ ) {
    		        	ActivityExcelData qlist = ( ActivityExcelData )qrecords.get( i );
    		        	ActivityExcelData qdata = new ActivityExcelData();
    		        	boolean rtn = qdata.load(qlist.getFieldserno());
    		        	if ( rtn ) {
    		        		k = k + 1;
    		        		if ( k > 3 ) {
    		        			k = 1; %>
    		        			</tr>
    		        		<%}
    		        		if ( k == 1 ) { %>
    		        			<tr>
    		        		<%}%>
    		        		<td><input type="checkbox" name="field" value="<%=qlist.getFieldserno()%>" /><%=qdata.getFieldname()%></td>
    		        	<%}
    		        }%>
    		    </table>
    		  </td>
    		</tr>        		 
    	<%}
    }
  %>
  
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
  
</table>  

</form>
</body>
</html>
