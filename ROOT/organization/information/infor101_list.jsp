<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：infor101_list.jsp
說明：聯絡資訊
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
     document.mform.action="infor101_list.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function save()
  {
     rcount = document.mform.tot.value;
     for ( i=0; i<rcount; i++ ) {
        thisform = "document.mform.tel" + (i+1);
        thisform1 = "document.mform.extension" + (i+1);
        thisform2 = "document.mform.unitname" + (i+1);
        thisform3 = "document.mform.fsort" + (i+1);
        chinesetitle = eval(thisform2).value;
        
        if ( chinesetitle != null ) {
           if ( eval(thisform).value == '' ) {
              alert(chinesetitle+"的【電話】欄位，不可空白，請輸入！");
              eval(thisform).focus();
              return;
           }
           if ( eval(thisform3).value == '' ) {
              alert(chinesetitle+"的【排序】欄位，不可空白，請輸入數字！");
              eval(thisform3).focus();
              return;
           } 
        }
     }
     document.mform.action = "infor101_save.jsp?rcount="+rcount;
     document.mform.method = "post";
     document.mform.submit();
  } 

</script>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="tw.com.sysview.filter.qfilterSql"%>

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
  
  //尋找單位之外的聯絡資訊
  OrganizeData qinfo = new OrganizeData();
  ArrayList<Object> qlists = qinfo.findByday(pubunitdn);
  int rcount = qinfo.getAllrecordCount();

  int num = 0;
  String num1 = ( String )request.getParameter( "num" );

%>

<body>
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="language" value="<%=language%>"/>
<input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
<input type="hidden" name="pubunitname" value="<%=pubunitname%>"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>

<a class="md" href="javascript:save()">儲   存</a>
<br />新增欄位：
<select name="num" onchange="qrynum()">
   <option value="0">--請選擇--</option>
     <%
       int mrcount1 = rcount;
       if ( num1 != null && !num1.equals("null") )
    	   mrcount1 = Integer.parseInt(num1);
       for ( int k=1; k<31; k++ ) {
    	   String isSelected = "";    	   
    	   if ( k == mrcount1 )
    		   isSelected = "selected";  %>
    	   <option value="<%=k%>" <%=isSelected%>><%=k%></option>
       <%}%>
</select>
   	  	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr align="center">
    <th width="5%">&nbsp;</th>
    <th width="20%" align="left"><span class="T12red">※</span>名稱</th>
    <th width="15%"><span class="T12red">※</span>電話</th>
    <th width="12%"><span class="T12red">※</span>分機</th>
    <th width="20%">傳真</th>
    <th width="20%">E-Mail</th>
    <th width="8%"><span class="T12red">※</span>排序</th>
  </tr>
  <%
    int tot = 0;
    int i=0;
    if ( qunits != null && qunits.size() > 0 ) {
    	for ( int z=0; z<qunits.size(); z++ ) {
    		DSItem qunitdn = ( DSItem )qunits.get( z );
    		i = i + 1;
    		OrganizeData query = new OrganizeData();
    		boolean rtn = query.loadinfor(pubunitdn,qunitdn.getUnitdn());
    		String serno = "";
    		String tel = "";
    		String extension = "";
    		String fax = "";
    		String email = "";
    		String fsort = "";
    		if ( rtn ) {
    			serno = query.getSerno();    			
    			tel = query.getTel();
    			extension = query.getExtension();
    			fax = query.getFax();
    			email = query.getEmail();
    			fsort = String.valueOf(query.getFsort());
    		} %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td align="center"><%=i%></td>
    		  <td align="left"><%=qunitdn.getChinesetitle()%></td>
    		  <input type="hidden" name="unitdn<%=i%>" value="<%=qunitdn.getUnitdn()%>"/>
    		  <input type="hidden" name="unitname<%=i%>" value="<%=qunitdn.getChinesetitle()%>"/>
    		  <td align="center"><input type="text" name="tel<%=i%>" size="10" value="<%=tel%>"/></td>
    		  <td align="center"><input type="text" name="extension<%=i%>" size="10" value="<%=extension%>"/></td>
    		  <td align="center"><input type="text" name="fax<%=i%>" size="10" value="<%=fax%>"/></td>
    		  <td align="center"><input type="text" name="email<%=i%>" size="20" value="<%=email%>"/></td>
    		  <td align="center"><input type="text" name="fsort<%=i%>" size="3" value="<%=fsort%>" maxlength="2" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;"></td>
    		  <input type="hidden" name="serno<%=i%>" value="<%=serno%>"/>
    		</tr> 
    	<%}
    	tot = tot + i;
    }   
    if ( num1 != null && !num1.equals("null") )
      	num = Integer.parseInt(num1);
    else
    	num = rcount;
    tot = tot + num;
    //資料庫有資料
    if ( qlists != null ) {  
    	if ( rcount > num && num != 0 )
    		rcount = num;
    	
    	for ( int j=0; j<rcount; j++ ) {
    		OrganizeData qlist = ( OrganizeData )qlists.get( j ); %>
    		<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    		  <td align="center"><%=(qunits.size()-1)+j+1%></td>
    		  <td align="left"><input type="text" name="unitname<%=(qunits.size()-1)+j+1%>" value="<%=qlist.getUnitname()%>" /></td>
    		  <input type="hidden" name="unitdn<%=(qunits.size()-1)+j+1%>" value="<%=qlist.getUnitdn()%>" />
    		  <input type="hidden" name="unitname<%=(qunits.size()-1)+j+1%>" value="<%=qlist.getUnitname()%>" />
    		  <td align="center"><input type="text" name="tel<%=(qunits.size()-1)+j+1%>" size="10" value="<%=qlist.getTel()%>" /></td>
    		  <td align="center"><input type="text" name="extension<%=(qunits.size()-1)+j+1%>" size="10" value="<%=qlist.getExtension()%>" /></td>
    		  <td align="center"><input type="text" name="fax<%=(qunits.size()-1)+j+1%>" size="10" value="<%=qlist.getFax()%>" /></td>
    		  <td align="center"><input type="text" name="email<%=(qunits.size()-1)+j+1%>" size="20" value="<%=qlist.getEmail()%>" /></td>
    		  <td align="center"><input type="text" name="fsort<%=(qunits.size()-1)+j+1%>" size="3" value="<%=qlist.getFsort()%>" maxlength="2" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" /></td>
    		  <input type="hidden" name="serno<%=(qunits.size()-1)+j+1%>" value="<%=qlist.getSerno()%>" />
    		</tr> 
    	<%}
    }
    if ( num != 0 ) {
    	if ( num > rcount ) {
    		int mrcount = (qunits.size()-1) + rcount;
    		for ( int t=0; t<(num-rcount); t++ ) { %>    			
    			<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    			  <td align="center"><%=mrcount+t+1%></td>
    			  <td align="left"><input type="text" name="unitname<%=mrcount+t+1%>" /></td>
    			  <input type="hidden" name="unitdn<%=mrcount+t+1%>" value="<%=pubunitdn%>" />
    			  <td align="center"><input type="text" name="tel<%=mrcount+t+1%>" size="10" /></td>
    			  <td align="center"><input type="text" name="extension<%=mrcount+t+1%>" size="10" /></td>
    			  <td align="center"><input type="text" name="fax<%=mrcount+t+1%>" size="10" /></td>
    			  <td align="center"><input type="text" name="email<%=mrcount+t+1%>" size="20" /></td>
    			  <td align="center"><input type="text" name="fsort<%=mrcount+t+1%>" size="3" maxlength="2" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" /></td>
    			  <input type="hidden" name="serno<%=mrcount+t+1%>" value="" />
    			</tr> 
    		<%}
    	}
    	
    }%>

</table>

<p>
<input type="hidden" name="tot" value="<%=tot%>">
<a class="md" href="#top">回頁首</a>

</form>
</body>
</html>
