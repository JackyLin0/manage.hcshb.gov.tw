<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：indexreload.jsp
說明：管理端登入畫面
開發者：chmei
開發日期：97.02.13
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.SvString" %>

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

  //自session取得登入者的資料
  String logindn = ( String )session.getAttribute("logindn");
  String passwd = ( String )session.getAttribute("passwd");
  String logincn = ( String )session.getAttribute("logincn");
  
  if ( (logindn == null) || (logindn.equals("null")) ||(logincn == null) || (logincn.equals("null")) )
  {  %>
	  <script>
	     alert("您已超過時間未使用本系統，為了維護個人資料請重新登錄！");	     
	     window.open("index.jsp","_parent");
	  </script>
  <%}else{	
	  String relmydn = ( String )request.getParameter( "mydn" );
	  
	  //計算本次欲顯示的層數
	  String array_relmydn[] = SvString.split( relmydn,',' );
	  int nowlen = array_relmydn.length - 4;
	  String nowdn4 = relmydn;
	  for ( int d=0; d<nowlen; d++ )
		  nowdn4 = SvString.right(nowdn4,',');
	  //int len_relmydn = array_relmydn.length + 1;
	  
	  //接受menu.jsp傳過來的變數
	  String string_udn = ( String )request.getParameter( "string_udn" );
	  String string_uname = ( String )request.getParameter( "string_uname" );
	  String string_uurl = ( String )request.getParameter( "string_uurl" );
	  String string_upunit = ( String )request.getParameter( "string_upunit" );
	  String string_unumber = ( String )request.getParameter( "string_unumber" );
	  int urcount = Integer.parseInt(request.getParameter( "urcount" ));
	  
	  //宣告陣列
	  String ary_udn4[] = new String[urcount];
	  String ary_uname4[] = new String[urcount];
	  String ary_uurl4[] = new String[urcount];
	  String ary_upunit4[] = new String[urcount];
	  String ary_unumber4[] = new String[urcount];
	  
	  //切割變數成陣列
	  ary_udn4 = SvString.split( string_udn,'&' );
	  ary_uname4 = SvString.split( string_uname,'&');
	  ary_uurl4 = SvString.split( string_uurl,'&');
	  ary_upunit4 = SvString.split( string_upunit,'&');
	  ary_unumber4 = SvString.split( string_unumber,'&');
	  int show_udn4 = ary_udn4.length;
	  
	  String show_makesudn = "";
	  String show_makesudn1 = "";
	  String temp_relmydn = relmydn;
	  
	  //組欲show的層次DN
	  //本次點選的下一層DN
	  SvNetscapeLdap qdn1 = new SvNetscapeLdap( ds_server, ds_port, logindn, passwd, SvLdap.ENCODEUNICODE );
	  if ( qdn1.query( relmydn, "dn,sysname,objectclass,url,punit,number", "objectclass=aptree", SvLdap.QUERYSUBTREE ) )
      {
			String ary_temp_relmydn1[] = SvString.split(temp_relmydn,',');
	      	if ( show_makesudn1.equals("") )
	      	  show_makesudn1 = temp_relmydn;
	      	else
	      	  show_makesudn1 = show_makesudn1 + "&" + temp_relmydn;  
	      	while ( qdn1.next() )
	      	{
	      		String temp_show_makesudn1 = qdn1.getString( "dn" );
	      	    String ary_temp_show_makesudn1[] = SvString.split(temp_show_makesudn1,',');
	      	    if ( ary_temp_show_makesudn1.length == (ary_temp_relmydn1.length+1) )
	      	    {
	      	    	if ( show_makesudn1.equals("") )
	      	    		show_makesudn1 = temp_show_makesudn1;
	      	    	else
	      	    		show_makesudn1 = show_makesudn1 + "&" + temp_show_makesudn1;
	      	    }else{
	      	    	String ary_show_makesudn1[] = SvString.split(show_makesudn1,'&');
	      	    	int forlen = ary_temp_show_makesudn1.length - ary_temp_relmydn1.length - 1;
	      	    	for ( int d=0; d<forlen; d++ )
	      	    		temp_show_makesudn1 = SvString.right(temp_show_makesudn1,',');
	      	    	boolean rtn = SvString.contain(ary_show_makesudn1,temp_show_makesudn1);
	      	    	if ( rtn == false )
	      	    	{
	      	    		if ( show_makesudn1.equals("") )
	      	    			show_makesudn1 = temp_show_makesudn1;
	      	    		else
	      	    			show_makesudn1 = show_makesudn1 + "&" + temp_show_makesudn1;
	      	    	}
	      	    }
	      	}
      }
	  
	  //由第四層至本次點選的DN
	  String ary_show_makesudn1[] = SvString.split(show_makesudn1,'&');
	  String temp_relmydn1 = relmydn;
	  String ary_temp_relmydn1[] = SvString.split(temp_relmydn1,',');
	  String temp_relmydn2 = SvString.right(temp_relmydn1,',');
	  //String ary2_temp_relmydn[] = SvString.split(temp_relmydn2,','); 
	  int forlen = ary_temp_relmydn1.length - 4 - 1;
	  if ( forlen > 0 )
	  {
		  for ( int l=0; l<forlen; l++ )
          {
			  temp_relmydn2 = SvString.right(temp_relmydn2,',');
			  SvNetscapeLdap qdn = new SvNetscapeLdap( ds_server, ds_port, logindn, passwd, SvLdap.ENCODEUNICODE );
			  if ( qdn.query( temp_relmydn2, "dn,sysname,objectclass,url,punit,number", "objectclass=aptree", SvLdap.QUERYSUBTREE ) )
			  {
				  while ( qdn.next() )
				  {
					  String temp_qdn = qdn.getString( "dn" );
					  String[] ary_temp_qdn = SvString.split(temp_qdn,',');
					  String[] ary_temp_show_makesudn1 = SvString.split(ary_show_makesudn1[0],',');
					  String right_temp_qdn = SvString.right(temp_qdn,',');
					  String right_ary_show_makesudn1 = SvString.right(ary_show_makesudn1[0],',');
					  
					  if ( temp_qdn.equals(ary_show_makesudn1[0]) )  {
						  if ( show_makesudn.equals("") )
							  show_makesudn = show_makesudn1;
						  else
							  show_makesudn = show_makesudn + "&" + show_makesudn1;
					  }else if ( ary_temp_qdn.length < ary_temp_show_makesudn1.length ) {
						  if ( show_makesudn.equals("") )
							  show_makesudn = temp_qdn;
						  else
							  show_makesudn = show_makesudn + "&" + temp_qdn;
					  }else if ( (ary_temp_qdn.length == ary_temp_show_makesudn1.length) && (right_temp_qdn.equals(right_ary_show_makesudn1))  ) {
						  if ( show_makesudn.equals("") )
							  show_makesudn = temp_qdn;
						  else
							  show_makesudn = show_makesudn + "&" + temp_qdn;
					  }
				  }
			  }
		  }
	  }else{
		  String qdn = SvString.right(temp_relmydn1,',');
		  String ary_qdn[] = SvString.split(qdn,',');
		  SvNetscapeLdap qdn3 = new SvNetscapeLdap( ds_server, ds_port, logindn, passwd, SvLdap.ENCODEUNICODE );
		  if ( qdn3.query( temp_relmydn2, "dn,sysname,objectclass,url,punit,number", "objectclass=aptree", SvLdap.QUERYSUBTREE ) )
		  {
			  while ( qdn3.next() )
			  {
				  String temp_qdn = qdn3.getString( "dn" );
				  String ary_temp_qdn[] = SvString.split(temp_qdn,',');
				  int forlen1 = ary_temp_qdn.length - ary_qdn.length - 1;             
				  for ( int d=0; d<forlen1; d++ )
					  temp_qdn = SvString.right(temp_qdn,',');
				  
				  if ( temp_qdn.equals(ary_show_makesudn1[0]) )
				  {
					  if ( show_makesudn.equals("") )
						  show_makesudn = show_makesudn1;
					  else{
						  String ary_show_makesudn[] = SvString.split(show_makesudn,'&');	
						  boolean rtn = SvString.contain(ary_show_makesudn,temp_qdn);
						  if ( rtn == false )
							  show_makesudn = show_makesudn + "&" + show_makesudn1;
					  }
				  }else{
					  if ( show_makesudn.equals("") )
						  show_makesudn = temp_qdn;
					  else{
						  String ary_show_makesudn[] = SvString.split(show_makesudn,'&');	
						  boolean rtn = SvString.contain(ary_show_makesudn,temp_qdn);
						  if ( rtn == false )
							  show_makesudn = show_makesudn + "&" + temp_qdn;
					  }
				  }
              }
			  String ary_qdn1[] = SvString.split(qdn,','); 
			  if ( (!show_makesudn.equals("")) && (ary_qdn1.length != 3) )
				  show_makesudn = qdn + "&" + show_makesudn;
		  }
	  }
	  
	  if ( show_makesudn.equals("") )
		  show_makesudn = show_makesudn1;

	  %>	  
	  
	  <html>
	  <head>
	  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	  <title>新竹縣衛生局服務網後端管理系統</title>
	  
	  <link href="css/scrollbar.css" rel="stylesheet" type="text/css" />
	  <link href="css/text1.css" rel="stylesheet" type="text/css" />
	  
	  <style type="text/css">
	  <!--
	  body {
	     margin-left: 0px;
	     margin-top: 0px;
	     margin-right: 0px;
	     margin-bottom: 0px;
	     background-image: url(images/leftbt_bg.jpg);
	     background-repeat: repeat-y;
	  }
	  -->
	  </style>
	  
	  <style type="text/css">
	  <!--
	  .md2 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
	  }
	  .md21 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
	  }
	  .md22 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
	  }
	  .md23 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
	  }
	  .md24 {BORDER-RIGHT: #b5cbd0 1px solid; BORDER-TOP: #b5cbd0 1px solid; BACKGROUND: #fff; MARGIN-BOTTOM: 10px; BORDER-LEFT: #b5cbd0 1px solid; BORDER-BOTTOM: #b5cbd0 1px solid; ZOOM: 1; POSITION: relative
	  }
	  -->
	  </style>	  
	  
	  <script type="text/javascript">
         function go(para)
         {
            document.indexreload.action="indexreload.jsp?mydn="+para;
            document.indexreload.target="leftFrame";
            document.indexreload.method="post";
            document.indexreload.submit();
         }
         
         function run(murl,mpunit,mnum)
         {
            //執行AP，改變顏色
            var tempmurl = document.mrun.murl1.value;
            if ( tempmurl != '' ) {
               var obj1 = document.getElementById(tempmurl.valueOf());
               obj1.style.color = "";
            }            
            var obj = document.getElementById(murl.valueOf());
            //改變字顏色
            obj.style.color = "#ee0000";
            //改變底顏色
            //obj.style.backgroundColor = "#ee0000";
            document.mrun.murl1.value = murl;

            if ( mpunit != 'null' ) {
                document.mrun.mpunit.value=mpunit;
            }
            if ( mnum != 'null' )
                document.mrun.pagesize.value=mnum;
            else
                document.mrun.pagesize.value="15";
            
            document.mrun.murl.value=murl;            
            document.mrun.action=murl;
            document.mrun.target="mainFrame";
            document.mrun.method="post";
            document.mrun.submit();
              
         } 
         
         var mLeftbarWidth = "38";
         var mLeftbarOpenWidth = "218";
         
         function fCloseFrame()
         {
            top.menuFram.cols = mLeftbarWidth + ",*";
         }
         
         function fOpenFrame()
         {
            top.menuFram.cols = mLeftbarOpenWidth + ",*";
         }
      </script>
      
      </head>
	  
      <body>
      <form name="mrun">
         <input type="hidden" name="mpunit" value="">
         <input type="hidden" name="pagesize">
         <input type="hidden" name="murl">
         <input type="hidden" name="murl1">
      </form>
      <form name="indexreload">
         <input type="hidden" name="string_udn" value="<%=string_udn%>">
         <input type="hidden" name="string_uname" value="<%=string_uname%>">
         <input type="hidden" name="string_uurl" value="<%=string_uurl%>">
         <input type="hidden" name="string_upunit" value="<%=string_upunit%>">
         <input type="hidden" name="string_unumber" value="<%=string_unumber%>">
         <input type="hidden" name="urcount" value="<%=urcount%>">
         
        <table width="10%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="100%" colspan="2" align="left">
              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td><img src="images/left2.jpg" alt="" width="199" height="34"></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="2" align="left" valign="top" >
              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="left" valign="top" class="left_bg">
                    <table width="100%" border="0">
                      <tr>
                        <td><img src="images/d.gif" alt="" width="16" height="5"></td>
                      </tr>
                      <tr>
                        <td><a href="javascript:fOpenFrame()"><img src="images/left_over1.gif" alt="*" width="14" height="15" border="0"></a></td>
                      </tr>
                      <tr>
                        <td><a href="javascript:fCloseFrame()"><img src="images/left_bu2.gif" alt="*" width="14" height="15" border="0"></a></td>
                      </tr>
                    </table>
                  </td>
                  <td align="left" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <%
	                    String ary_show_makesudn[] = SvString.split(show_makesudn,'&');
	                    for ( int scount=0; scount<show_udn4; scount++ ) {
	                    	if ( ary_udn4[scount].equals(nowdn4) ) {
	                    		if ( (ary_uurl4[scount]).equals("http://") ) { %>
	                    			<tr>
	                    			  <td valign="middle" class="butonbg">
	                    			    <a href="javascript:go('<%=ary_udn4[scount]%>')" class="link-title"><%=ary_uname4[scount]%></a>
	                    			  </td>
	                    			</tr>
	                    		<%}else{%>
	                    			<tr>
	                    			  <td valign="middle" class="butonbg">
	                    			    <a id="<%=ary_uurl4[scount]%>" href="javascript:run('<%=ary_uurl4[scount]%>','<%=ary_upunit4[scount]%>','<%=ary_unumber4[scount]%>')" class="link-title"><%=ary_uname4[scount]%></a>
	                    			  </td>
	                    			</tr>
	                    		<%}%>
	                    		<tr>
	                    		  <td>
	                    		    <table border="0" cellpadding="0" cellspacing="0">
	                    		      <%
	                    		        for ( int mscount=1; mscount<ary_show_makesudn.length; mscount++ ) { 
	                    		        	String now_show_makesudn = ary_show_makesudn[mscount];
	                    		        	
	                        		    	SvNetscapeLdap qdn2 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
	                        		    	boolean rtn = qdn2.query( now_show_makesudn, "dn,sysname,objectclass,url,punit,number", "objectclass=aptree", SvLdap.QUERYBASE );
	                        		    	String ary_now_show_makesudn[] = SvString.split( now_show_makesudn,',' );
	                        		    	
	                        		    	if ( rtn ) {
	                        		    		while ( qdn2.next() ) {
	                        		    			String qdn2_dn = qdn2.getString( "dn" );	                        		    			
	                        		    			String qdn2_sysname = qdn2.getString( "sysname" );
	                        		    			String qdn2_url = qdn2.getString( "url");
	                        		    			String qdn2_punit = qdn2.getString( "punit");
	                        		    			String qdn2_number = qdn2.getString( "number");
	                        		    			if ( ary_now_show_makesudn.length == 5 ) {
	                        		    				if ( qdn2_url.equals("http://") ) { %>
	                        		    					<tr>
	                        		    					  <td>
	                        		    					    <table border="0" cellpadding="3" cellspacing="0">
	                        		    					      <tr>
	                        		    					        <td align="right" valign="baseline">
	                        		    					          <img src="images/ss.gif" alt="*" width="13" height="11" />
	                        		    					        </td>
	                        		    					        <td>
	                        		    					          <a href="javascript:go('<%=qdn2_dn%>')" class="link-left"><%=qdn2_sysname%></a>
	                        		    					        </td>
	                        		    					      </tr>
	                        		    					    </table>
	                        		    					  </td>
	                        		    					</tr>
	                        		    				<%}else{%>
	                        		    					<tr>
	                        		    					  <td>
	                        		    					    <table border="0" cellpadding="3" cellspacing="0">
	                        		    					      <tr>
	                        		    					        <td align="right" valign="baseline">
	                        		    					          <img src="images/ss.gif" alt="*" width="13" height="11" />
	                        		    					        </td>
	                        		    					        <td>
	                        		    					          <a id="<%=qdn2_url%>" href="javascript:run('<%=qdn2_url%>','<%=qdn2_punit%>','<%=qdn2_number%>')" class="link-left"><%=qdn2_sysname%></a>
	                        		    					        </td>
	                        		    					      </tr>
	                        		    					    </table>
	                        		    					  </td>
	                        		    					</tr>
	                        		    				<%}%>
	                        		    				<tr>
	                        		    				  <td><img src="images/left_line.gif" width="176" height="4" /></td>
	                        		    				</tr>
	                        		    			<%}
	                        		    			if ( ary_now_show_makesudn.length == 6 ) {
	                        		    				if ( qdn2_url.equals("http://") ) { %>
	                        		    					<tr>
	                        		    					  <td>
	                        		    					    <table border="0" cellpadding="3" cellspacing="0">
	                        		    					      <tr>
	                        		    					        <td valign="baseline">&nbsp;</td>
	                        		    					        <td align="right" valign="baseline"><img src="images/iocn.gif" alt="*" width="6" height="6"></td>
	                        		    					        <td valign="baseline">
	                        		    					          <a href="javascript:go('<%=qdn2_dn%>')" class="link-left"><%=qdn2_sysname%></a>
	                        		    					        </td>
	                        		    					      </tr>
	                        		    					    </table>
	                        		    					  </td>
	                        		    					</tr>    
	                        		    				<%}else{%>
	                        		    					<tr>
	                        		    					  <td>
	                        		    					    <table border="0" cellpadding="3" cellspacing="0">
	                        		    					      <tr>
	                        		    					        <td valign="baseline">&nbsp;</td>
	                        		    					        <td align="right" valign="baseline"><img src="images/iocn.gif" alt="*" width="6" height="6"></td>
	                        		    					        <td valign="baseline">
	                        		    					          <a id="<%=qdn2_url%>" href="javascript:run('<%=qdn2_url%>','<%=qdn2_punit%>','<%=qdn2_number%>')" class="link-left"><%=qdn2_sysname%></a>
	                        		    					        </td>
	                        		    					      </tr>
	                        		    					    </table>
	                        		    					  </td>
	                        		    					</tr>    
	                        		    				<%}%>
	                        		    				<tr>
	                        		    				  <td><img src="images/left_line2.jpg" width="176" height="4" /></td>
	                        		    				</tr>
	                        		    			<%}
	                        		    			if ( ary_now_show_makesudn.length >= 7 ) {
	                        		    				if ( qdn2_url.equals("http://") ) { %>
	                        		    					<tr>
	                        		    					  <td>
	                        		    					    <table border="0" cellpadding="3" cellspacing="0">
	                        		    					      <tr>
	                        		    					        <td valign="baseline">&nbsp;</td>
	                        		    					        <td valign="baseline">&nbsp;</td>
	                        		    					        <td align="right" valign="baseline"><img src="images/55.gif" alt="*" width="4" height="6"></td>
	                        		    					        <td valign="baseline">
	                        		    					          <a href="javascript:go('<%=qdn2_dn%>')" class="link-left"><%=qdn2_sysname%></a>
	                        		    					        </td>
	                        		    					      </tr>
	                        		    					    </table>
	                        		    					  </td>
	                        		    					</tr>
	                        		    				<%}else{%>
	                        		    					<tr>
	                        		    					  <td>
	                        		    					    <table border="0" cellpadding="3" cellspacing="0">
	                        		    					      <tr>
	                        		    					        <td valign="baseline">&nbsp;</td>
	                        		    					        <td valign="baseline">&nbsp;</td>
	                        		    					        <td align="right" valign="baseline"><img src="images/55.gif" alt="*" width="4" height="6"></td>
	                        		    					        <td valign="baseline">
	                        		    					          <a id="<%=qdn2_url%>" href="javascript:run('<%=qdn2_url%>','<%=qdn2_punit%>','<%=qdn2_number%>')" class="link-left"><%=qdn2_sysname%></a>
	                        		    					        </td>
	                        		    					      </tr>
	                        		    					    </table>
	                        		    					  </td>
	                        		    					</tr>
	                        		    				<%}%>
	                        		    				<tr>
	                        		    				  <td><img src="images/left_line.gif" width="176" height="4" /></td>
	                        		    				</tr>
	                        		    			<%}
	                        		    		}
	                        		    	}
	                    		        }%>
	                    		    </table>
	                    		  </td>
	                    		</tr>
	                    	<%}else{
	                    		if ( (ary_uurl4[scount]).equals("http://") ) { %>
	                    			<tr>
	                    			  <td align="left" class="butonbg">
	                    			    <a href="javascript:go('<%=ary_udn4[scount]%>')" class="link-title"><%=ary_uname4[scount]%></a>
	                    			  </td>
	                    			</tr>
	                    		<%}else{%>
	                    			<tr>
	                    			  <td align="left" class="butonbg">
	                    			    <a id="<%=ary_uurl4[scount]%>" href="javascript:run('<%=ary_uurl4[scount]%>','<%=ary_upunit4[scount]%>','<%=ary_unumber4[scount]%>')" class="link-title"><%=ary_uname4[scount]%></a>
	                    			  </td>
	                    			</tr>
	                    		<%}
	                    	}
	                    }%>
	                    <tr>
	                      <td align="left"></td>
	                    </tr>
	                  </table>
	              </td>
	            </tr>
	          </table>
	        </td>
          </tr>
          
        </table>
        
      </form>
     </body>
    </html>              
      
  <%}%>
  
         