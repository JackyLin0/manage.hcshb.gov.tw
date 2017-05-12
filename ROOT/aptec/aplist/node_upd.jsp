<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：node_upd.jsp
說明：應用系統設定(客戶管理者使用)
開發者：chmei
開發日期：2017.02.24
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>應用系統設定</title>

<link href="../../css/text.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
  function chg() {
	  for ( var i=0;i<document.all.website.length;i++ ) {
		  if ( document.all.website[i].checked ) {
			  var mflag_value = document.all.website[i].value;
			  switch(mflag_value)
			  {
			     case "Y":
			    	 window.type0.style.display='block';
			    	 break;
			     case "N":  //動態網頁
			         window.type0.style.display='none';
			         break;
			  }
		  }
	  }
  }
  
  function add() {
	  document.treeform.action = "node_add.jsp";
	  document.treeform.method = "post";
	  document.treeform.submit();
  }
	 
  function save() {
	  if ( document.treeform.sysname.value == '' ) {
		  alert( "【應用系統名稱】欄位不能空白，請輸入!! " );
		  document.treeform.sysname.focus();
		  return;
	  }
	  
	  document.treeform.action = "node_updsave.jsp";
	  document.treeform.method = "post";
	  document.treeform.submit(); 
  }

  function del() {
	  x = window.confirm("確定刪除該應用系統嗎?");
	  if ( x ) {
		  document.treeform.action = "node_del.jsp";
		  document.treeform.method = "post";
		  document.treeform.submit();
	  }	  		  
  }
</script>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.econcord.common.PropertiesBean" %>
<%@ page import="tw.com.econcord.ds.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  String apnode = PropertiesBean.getBundle("tw.com.econcord.properties.project", "apnode", Locale.TAIWAN);

  String aplistdn = ( String )request.getParameter( "aplistdn" );
  String[] ary_aplistdn = SvString.split(aplistdn, ",");
    
  ApRootTree query = new ApRootTree();  
  ArrayList<DSItem> qlists = query.getAptree(aplistdn);
  String mcreateuid = "";
  String murl = "";
  String mlanguage = "";
  if ( qlists != null && qlists.size() > 0 ) {
	  DSItem qlist = ( DSItem )qlists.get(0);
	  murl = qlist.getAplisturl();
	  if ( murl.equals("http://") )
		  murl = "";
  }
  
  String loginrole = ( String )session.getAttribute( "userrole" );
  if ( loginrole == null || loginrole.equals("null") )
	  loginrole = "";

  String title = ( String )session.getAttribute( "title" );
  String loginap = ( String )session.getAttribute( "loginap" );

  //尋找單位
  DepartmentTree quserunit = new DepartmentTree();  
  quserunit.setParentId("1");
  ArrayList<DSItem> qunits = quserunit.getDepartment();
  
%>


<form name="treeform">
<input type="hidden" name="aplistdn" value="<%=aplistdn%>" />

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>應用系統設定</h2>
</div>

<br>

<div style="padding-left:12px;height:30px">
  <%
    if ( !aplistdn.equals(apnode) ) { %>
    	<input type="button" class="btn" value=" 儲存  " onclick="javascript:save()">
    	<input type="button" class="btn" value=" 重填  " onclick="javascript:window.document.treeform.reset()">
    	<input type="button" class="btn" value=" 刪除  " onclick="javascript:del()">
    <%}
    if ( murl.equals("") ) { %>
    	<input type="button" class="btn" value=" 新增系統  " onclick="javascript:add()">
    <%}%>
  
</div>

<table width="95%" cellpadding="0" cellspacing="0" border="0" class="table01">
  <%
    if ( qlists != null && qlists.size() > 0 ) {
    	DSItem qlist = ( DSItem )qlists.get(0); %>
    	<tr align="center">
    	  <th colspan="2"><%=qlist.getSysname()%>--應用系統設定</th>
    	</tr>
    	<tr class="tr">
    	  <td width="33%" class="T12b"><span class="T12red">※</span>應用系統DN</td>
    	  <td width="67%">
    	    <input type="text" name="aplistdn" class="lInput01" size="58" value="<%=qlist.getAplistdn()%>" readonly />
    	    <input type="hidden" name="id" value="<%=qlist.getId()%>" />
    	    <input type="hidden" name="parentpath" value="<%=qlist.getParentpath()%>" />
    	  </td>
    	</tr>
    	<tr>
    	  <td class="T12b"><span class="T12red">※</span>應用系統名稱</td>
    	  <td><input type="text" name="sysname" class="lInput01" size="50" value="<%=qlist.getSysname()%>" /></td>
    	</tr>
    	<tr class="tr">
    	  <td class="T12b"><span class="T12red">※</span>應用系統代碼</td>
    	  <td><input type="text" name="ou" class="lInput01" size="20" value="<%=qlist.getOu()%>" readonly /></td>
    	</tr>
    	<tr>
    	  <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>URL</td>
    	  <td><input type="text" name="aplisturl" class="lInput01" size="50" value="<%=qlist.getAplisturl()%>" /></td>
    	</tr>
    	<tr class="tr">
    	  <td class="T12b">主要負責局室</td>
    	  <td>
    	    <select name="punit" size="5" multiple>
    	      <%
    	        if ( qunits != null && qunits.size() > 0 ) {
    	        	for ( int u=0; u<qunits.size(); u++ ) {
    	        		DSItem qunit = ( DSItem )qunits.get( u );
    	        		String isSelected = "";
    	        		if ( qlist.getUserunit() != null && !qlist.getUserunit().equals("null") && !qlist.getUserunit().equals("") ) {
    	        			String[] ary_userunit = SvString.split(qlist.getUserunit(),"||");
    	        			if ( SvString.containIgnoreCase(ary_userunit,qunit.getUnitdn()) ) {
    	        				isSelected = "selected";
    	        			}
    	        		}
    	        		String[] ary_unitdn = SvString.split(qunit.getUnitdn(),",");
    	        		if ( ary_unitdn.length > 3 ) {  %>
    	        			<option value="<%=qunit.getUnitdn()%>" <%=isSelected%>><%=qunit.getChinesetitle()%></option>
    	        		<%}
    	        	}
    	        }%>
    	    </select><br />
    	    <font size="2" color="red">※ 按住【Ctrl】或【Shift】鍵再選擇單位，即可選取多個單位</font>
    	  </td>
    	</tr>
    	<tr>
    	  <td class="T12b"><span class="T12red">&nbsp;&nbsp;&nbsp;</span>顯示筆數</td>
    	  <td><input type="text" name="pagenumber" class="lInput01" size="20" value="<%=(qlist.getPagenumber() == null || qlist.getPagenumber().equals("null")) ? "15" : qlist.getPagenumber()%>" /></td>
    	</tr>
    	<%
    	  if ( ary_aplistdn.length == 4 ) {
    		  WebSiteData qwebsite = new WebSiteData();
    		  boolean rtn = qwebsite.load(aplistdn); %>
    		  <tr class="tr">
    		    <td class="T12b">WebSite</td>
    		    <td>
    		      <input type="radio" name="website" value="Y" onclick="chg()" <%=((rtn) ? "checked" : "")%> />是&nbsp;&nbsp;
    		      <input type="radio" name="website" value="N" onclick="chg()" <%=((!rtn) ? "checked" : "")%> />否
    		    </td>
    		  </tr>
    		  <%
    		    WebSiteData qwebunit = new WebSiteData();
    		    ArrayList<Object> qwebs = qwebunit.findByweb(aplistdn);
    		    String[] ary_website = null;
    		    String mwebsite = "";
    		    if ( qwebs != null && qwebs.size() > 0 ) {
    		    	for ( int i=0; i<qwebs.size(); i++ ) {
    		    		WebSiteData qweb1 = ( WebSiteData )qwebs.get( i );
    		    		if ( mwebsite.equals("") ) 
    		    			mwebsite = qweb1.getPubunitdn();
    		    		else
    		    			mwebsite = mwebsite + "||" + qweb1.getPubunitdn();
    		    	}
    		    	if ( !mwebsite.equals("") )
    		    		 ary_website = SvString.split(mwebsite,"||");
    		    }
    		    String style = "style='display:none'";
    		    if ( rtn )
    		    	style = "style='display:block'";  %>
    		    <tr id='type0' <%=style%>>
    		      <td class="T12b">網站對應局室</td>
    		      <td>
    		        <select name="punitweb" size="5" multiple>
    		          <%
    		            if ( qunits != null && qunits.size() > 0 ) {
    		            	for ( int wu=0; wu<qunits.size(); wu++ ) {
    		            		DSItem qunit = ( DSItem )qunits.get( wu );
    		            		String munitdn = (qunit.getUnitdn()).replace(',','*');
    		            		String datavalue = munitdn + "||" + qunit.getChinesetitle();
    		            		String isSelected = "";
    		            		if ( SvString.contain(ary_website, qunit.getUnitdn()) ) {
    		            			isSelected = "selected";
    		            		}%>
    		            		<option value=<%=datavalue%> <%=isSelected%>><%=qunit.getChinesetitle()%></option>
    		            	<%}
    		            }%>
    		        </select><br />&nbsp;
    		        <font size="2" color="red">※ 按住【Ctrl】或【Shift】鍵再選擇單位，即可選取多個單位</font>
    		      </td>
    		    </tr>
    		    <%
    		      if ( rtn ) { %>
    		    	  <tr class="tr">
    		    	    <td class="T12b">Language</td>
    		    	    <td colspan="3">
    		    	      <input type="radio" name="islanguage" value="Chinese" <%=((qwebsite.getIslanguage().equals("Chinese")) ? "checked" : "")%> />中文版&nbsp;&nbsp;
    		    	      <input type="radio" name="islanguage" value="English" <%=((qwebsite.getIslanguage().equals("English")) ? "checked" : "")%> />英文版&nbsp;&nbsp;
    		    	      <input type="radio" name="islanguage" value="Japan" <%=((qwebsite.getIslanguage().equals("Japan")) ? "checked" : "")%> />日文版&nbsp;&nbsp;
    		    	      <input type="radio" name="islanguage" value="" />無
    		    	    </td>
    		    	  </tr>
    		      <%}else{%>
    		    	  <tr class="tr">
    		    	    <td class="T12b">Language</td>
    		    	    <td colspan="3">
    		    	      <input type="radio" name="islanguage" value="Chinese" checked />中文版&nbsp;&nbsp;
    		    	      <input type="radio" name="islanguage" value="English" />英文版&nbsp;&nbsp;
    		    	      <input type="radio" name="islanguage" value="Japan" />日文版&nbsp;&nbsp;
    		    	      <input type="radio" name="islanguage" value="" />無
    		    	    </td>
    		    	  </tr>
    		      <%}
    		    String mstartusing = "N";
    		    if ( qwebsite.getStartusing() != null && !qwebsite.getStartusing().equals("null") && !qwebsite.getStartusing().equals("") )
    		    	mstartusing = qwebsite.getStartusing();  %>
    		    <tr>
    		      <td class="T12b">是否啟用</td>
    		      <td colspan="3">
    		        <input type="radio" name="startusing" value="Y" <%=(mstartusing.equals("Y") ? "checked" : "")%> />是&nbsp;&nbsp;
    		        <input type="radio" name="startusing" value="N" <%=(mstartusing.equals("N") ? "checked" : "")%> />否&nbsp;&nbsp;
    		        <span class="T10">(此站台是否有建站)</span>
    		      </td>
    		    </tr>	
    	  <%}    	
    }%>
  
</table>

</form>

</body>
</html>

