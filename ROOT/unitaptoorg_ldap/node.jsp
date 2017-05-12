<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：node.jsp
說明：系統權限設定
開發者：chmei
開發日期：97.02.11
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>

<html lang="zh-TW">
<head>

<title>系統權限設定</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<link href="../../css/text.css" rel="stylesheet" type="text/css" />

<script>
  function save()
  {
    document.mform.action="nodeupd.jsp";
    document.mform.method="post";
    document.mform.submit();
  }
</script>
</head>

<body>
<form name="mform">
<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>系統權限設定</h2>
</div>
<p></p>
<a class="md" href="javascript:save()">更新權限設定</a>

<%
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");
  
  //判斷OS版本
  String Ldap_PATH = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Ldap_PATH = sysRoot + "\\WEB-INF\\ldap.properties";
  else
	  Ldap_PATH = sysRoot + "/WEB-INF/ldap.properties";

  Properties ldap = new Properties();
  ldap.load(new FileInputStream(Ldap_PATH) );
  String ds_server = ldap.getProperty("ds_server");
  String port = ldap.getProperty("ds_port");
  String ds_user = ldap.getProperty("ds_user");
  String ds_pwd = ldap.getProperty("ds_pwd");
  
  int ds_port=Integer.parseInt(port);

  
  //接收來自aptoorg/aplist/totree1.jsp檔案的變數
  String apdn = ( String )request.getParameter( "dn" );
  String unitdn = ( String )request.getParameter( "unitdn" );
  //接收來自aptoorg/entrymng/totree.jsp檔案的變數
  String morgdn = ( String )request.getParameter( "orgdn" );
  if ( apdn != null ) {
	  //新的應用系統將session釋放
	  session.removeAttribute("session_morgdn");
	  session.removeAttribute("session_allow");
	  session.setAttribute("apdn1",String.valueOf(apdn));
  }else{
	  apdn = ( String )session.getAttribute("apdn1");
  }
  
  SvNetscapeLdap qap = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  String attrib="dn,ou,sysname,url,acitarget,acitargetattr,aciname,aciallowuserdn,aciuserdn";
  boolean qdata = qap.query( apdn, attrib, "objectclass=aptree", SvLdap.QUERYBASE );
  if ( qdata == false )  { %>
	  <h1>ERROR:<%=qap.getErrorMsg()%></h1> <%
	  return;
  }
  
  while ( qap.next() )  { %>
	  <!-------傳變數--------->
	  <input type="hidden" name="dn" value="<%=apdn%>" />
	  <input type="hidden" name="ou" value="<%=qap.getString( "ou" )%>" />
      <input type="hidden" name="unitdn" value="<%=unitdn%>"/>
	  
	  <table width="100%" align="center" cellpadding="0" cellspacing="0" class="table02">
	    <tr>
	      <th>系統名稱</th>
	    </tr>
	    <tr>
	      <td><div align="center"><%=qap.getString( "sysname" )%></div></td>
	    </tr>
	  </table>
	  <p></p>
	  
	  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
	    <tr align="center">
	      <th width="5%">#</th>
	      <th width="20%"><img src="../../img/users.png" alt="USER" width="22" height="22" align="absmiddle"/>使用者姓名</th>
	      <th width="15%">帳 號</th>
	      <th width="25%">單 位</th>
	      <th colspan="2"> 權 限 設 定 </th>
	    </tr>
	    <%

       //取出該單位DS的值
       String ds_aciallowuserdn = "";
       String ds_aciuserdn = "";
       String old_aciuserdn = "";
       String old_userallow = "";
       //比對使用者權限為該站台單位
       
       if ( qap.getString("aciuserdn") != null && !qap.getString("aciuserdn").equals("null") ) {
        String[] arry_tempdn = SvString.split(qap.getString("aciuserdn"),"$");
           for ( int temp=0; temp<arry_tempdn.length; temp++ ) {
            String tempdn1 = arry_tempdn[temp];
            
            String[] arry_tempdn1 = SvString.split(arry_tempdn[temp],",");
            
            if ( arry_tempdn1.length > 4 ) {
             for ( int i=0; i<arry_tempdn1.length-4; i++ ) {
              tempdn1 = SvString.right(tempdn1,",");
             }
             if ( tempdn1.equals(unitdn) ) {
            	 
              if ( ds_aciuserdn.equals("") ) {
               ds_aciuserdn = arry_tempdn[temp];
              }else{
               ds_aciuserdn = ds_aciuserdn + "$" + arry_tempdn[temp];
              }
             }else{
              if ( old_aciuserdn.equals("") ) {
               old_aciuserdn = arry_tempdn[temp];
               old_userallow = "allow";
              }else{
               old_aciuserdn = old_aciuserdn + "$" + arry_tempdn[temp];
               old_userallow = old_userallow + "," + "allow";
              }
             }
             
            }
           }
           
       }  
          ds_aciallowuserdn = qap.getString( "aciallowuserdn" );
          
          //自session取出新加入擁有此應用系統權限的人(因新加入人員暫未寫入DS)
          String session_tempmorgdn = ( String )session.getAttribute("session_morgdn");
          String session_tempeallow = ( String )session.getAttribute("session_allow");
          
          if ( session_tempmorgdn != null )
          {
           if ( ds_aciuserdn != null && !ds_aciuserdn.equals("") )
           {
            ds_aciuserdn = ds_aciuserdn + "$" + session_tempmorgdn;
            ds_aciallowuserdn = ds_aciallowuserdn + "," + session_tempeallow;
           }else{
            ds_aciuserdn = session_tempmorgdn;
            ds_aciallowuserdn = session_tempeallow;
           }
          }
          
        //宣告陣列  
          String array_aciuserdn[];
          String array_aciallowuserdn[];
          if ( morgdn != null )
          {
        	  //將字串分割成陣列
        	  array_aciuserdn = SvString.split(ds_aciuserdn,'$');  
        	  array_aciallowuserdn = SvString.split(ds_aciallowuserdn,',');
        	  
        	  //自陣列搜尋字串(為了找尋此user是否已擁有此應用系統權限)
        	  boolean find_aci = SvString.contain(array_aciuserdn,morgdn);
        	  if ( find_aci == false )
        	  {
        		  String orgdn = morgdn.substring(0,3);
        		  if (!orgdn.equals("uid"))
        			  morgdn = "uid=*," + morgdn; 
        		  //將新加入此權限的人員放在session(因為暫未寫入DS內)
        		  if ( session_tempmorgdn != null )
        		  {
        			  session_tempmorgdn = session_tempmorgdn + "$" + morgdn; 
        			  session_tempeallow = session_tempeallow + ",allow";
        		  }else{
        			  session_tempmorgdn = morgdn; 
        			  session_tempeallow = "allow";
        		  }
        		  if ( ds_aciuserdn != null && !ds_aciuserdn.equals("") )
        		  {
        			  ds_aciuserdn = ds_aciuserdn + "$" + morgdn;
        			  ds_aciallowuserdn = ds_aciallowuserdn + ",allow";
        		  }else{
        			  ds_aciuserdn = morgdn;
        			  ds_aciallowuserdn = "allow";
        		  }
        		  
        		  //將新加入權限的人存入session內
        		  session.setAttribute("session_morgdn",String.valueOf(session_tempmorgdn));
        		  session.setAttribute("session_allow",String.valueOf(session_tempeallow));
        	  }
          }
          
        //將字串分割成陣列
          if ( ds_aciuserdn != null && !ds_aciuserdn.equals("") )
          {
        	  array_aciuserdn = SvString.split(ds_aciuserdn,'$');  
        	  array_aciallowuserdn = SvString.split(ds_aciallowuserdn,',');
        	  
        	  int dnlen = array_aciuserdn.length;
        	  for (int cnt=0; cnt<dnlen; cnt++)
        	  {
        		  String tempuid = SvString.left(array_aciuserdn[cnt],',');
        		  String muid = SvString.right(tempuid,'=');
        		  String usdn = SvString.right(array_aciuserdn[cnt],','); 
        		  String usdn1 = SvString.right(usdn,',');
        		  String[] ary_usdn1 = SvString.split(usdn1,',');  %>
        		  
        		  <tr align="center" class="tr01" onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
        		    <td><%=cnt+1%></td>
        		    <%
        		      String funit="";
        		      String fuser="";
        		      String fgroup="";
        		      String unit_title = "";
        		      String uid = "";
        		      String name = "";
        		      if ( !tempuid.equals( "uid=*" ) )  {
        		    	  //尋找此人的服務單位名稱
        		    	  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
        		    	  boolean qunit = qou.query( usdn, "chinesetitle", "objectclass=department", SvLdap.QUERYBASE );
        		    	  if ( qunit == true )
        		    		  funit = "Y";
        		    	  else
        		    		  funit = "N";
        		    	  if ( funit.equals("N") ) { %>
        		    		  unit_title = "<font color='red'><b>查無此單位</b>&nbsp;&nbsp;&nbsp;</font>";
        		    	  <%}else{
        		    		  while ( qou.next() )  {
        		    			  unit_title = qou.getString( "chinesetitle" );
        		    			  if ( ary_usdn1.length > 4 ) {
        		    				  //尋找此人的服務單位名稱
        		    				  SvNetscapeLdap qpou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
        		    				  boolean qpunit = qpou.query( usdn1, "chinesetitle", "objectclass=department", SvLdap.QUERYBASE );
        		    				  if ( qpunit ) {
        		    					  while ( qpou.next() )  {
      		        						unit_title = qpou.getString( "chinesetitle" ) + unit_title;
      		        					  }
        		    				  }
        		    			  }
        		    		  }
        		    	  }
        		    	  
        		    	  //尋找此人的姓名及帳號
        		    	  SvNetscapeLdap entry = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE  );
        		    	  boolean qname = entry.query( array_aciuserdn[cnt], "dn,cn", SvLdap.QUERYBASE );
        		    	  if ( qname == true )
        		    		  fuser = "Y";
        		    	  else
        		    		  fuser = "N";
        		    	  
        		    	  if ( fuser.equals("N") )  {
        		    		  name = "<font color='red'><b>查無此人</b>&nbsp;&nbsp;&nbsp;</font>";
        		    	  }else{
        		    		  while ( entry.next())  {
        		    			  uid = muid;
        		    			  name = entry.getString( "cn" );
        		    		  }
        		    	  }
        		      }else{
        		    	  SvNetscapeLdap qou1 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
        		    	  boolean qgroup = qou1.query( usdn, "chinesetitle", "objectclass=department", SvLdap.QUERYBASE );
        		    	  if ( qgroup == true )
        		    		  fgroup = "Y";
        		    	  else
        		    		  fgroup = "N";
        		    	  if ( fgroup.equals("N") )  { 
        		    		  name = "<font color='red'><b>查無群組</b>&nbsp;&nbsp;&nbsp;</font>";
        		    	  }else{
        		    		  while ( qou1.next() )  {
        		    			  name = qou1.getString( "chinesetitle" ) + "<b>【所有人】&nbsp;&nbsp;&nbsp;</b>";
        		    		  }
        		    	  }
        		      }%>
        		      <td><%=name%></td>
        		      <td><%=uid%></td>
        		      <td><%=unit_title%></td>
        		      <td>
        		        <input type="radio" name="ad<%=cnt%>" value="allow" <%if (array_aciallowuserdn[cnt].equals("allow")) {%> checked <%}%>>
        		        <img src="../img/allow.png" alt="allow" width="25" height="25" align="absmiddle" />
        		      </td>
        		      <td>
        		        <input type="radio" name="ad<%=cnt%>" value="delete" <%if ( (array_aciallowuserdn[cnt].equals("delete")) || (funit.equals("N")) || (fuser == "N") ) {%> checked <%}%>>
        		        <img src="../img/del.png" alt="del" width="25" height="25" align="absmiddle" />
        		      </td>
        		    </tr>
        	  <%}
          }%>
          <tr class="tr01">
            <th colspan="6" >&nbsp;</th>
          </tr>
      </table>
      <input type="hidden" name="aciuserdnt" value="<%=ds_aciuserdn%>">
      <input type="hidden" name="oldaciuserdnt" value="<%=old_aciuserdn%>">
      <input type="hidden" name="olduserallow" value="<%=old_userallow%>">
      
  <%}%>
  <p></p>
  
  <a class="md" href="#top">回頁首</a>

</form>
</body>
</html>
