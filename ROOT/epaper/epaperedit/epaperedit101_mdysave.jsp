<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperedit101_mdysave.jsp
說明：電子報派送編輯
開發者：chmei
開發日期：97.03.20
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數  
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String pubunitname = ( String )request.getParameter( "pubunitname" );
  
  String logincn = ( String )session.getAttribute( "logincn" );
  String serno = ( String )request.getParameter( "serno" );

  //form值
  String subject = ( String )request.getParameter( "subject" );
  String periodical = ( String )request.getParameter( "periodical" );
  
  //本期派送類別
  String[] mclass = request.getParameterValues("class");
  
  String epaperclass = "";
  if ( mclass == null || mclass.equals("null") ) { %>
	  <script>
	     alert("【您未勾選任何一項】");
	     window.history.go(-1);
	  </script>
  <%}else{
	  String bbulletin = ( String )request.getParameter( "bulletin" );
	  if ( bbulletin != null && !bbulletin.equals("null") ) {
		  if( epaperclass.equals("") )
			  epaperclass = bbulletin;
		  else
			  epaperclass = epaperclass + "&" + bbulletin;
	  }
	  for ( int i=0; i<mclass.length; i++ ) {
		  if( epaperclass.equals("") )
			  epaperclass = mclass[i];
		  else
			  epaperclass = epaperclass + "&" + mclass[i];
	  }
	  
	  //取得修改者IP
	  String hostIP = request.getRemoteHost();
	  
	  EpaperEditData obj = new EpaperEditData();
	  
	  boolean rtn = true ;
	  String errMsg="0";     

	  obj.setPeriodical(periodical);
	  obj.setEpaperclass(epaperclass);
	  
	  //網站維運統計共用參數(WebSiteLog)
	  obj.setPubunitdn(pubunitdn);             //發布單位DN
	  obj.setPubunitname(pubunitname);         //發布單位名稱
	  obj.setSubject(subject);                 //標題
	  obj.setPostname(logincn);                //最後更新者姓名
	  obj.setUnitname(title);                  //單元名稱
	  obj.setTablename("EpaperSendMaster");    //table名稱
	  obj.setWebip(hostIP);                    //登入者IP
	  obj.setLanguage(language);               //語系  
	  obj.setStatus("U");                      //狀態

	  //執行動作(修改資料)  
	  rtn = obj.store();  
	    
	  String showAlert = null; 
	  String program = "";
	  if ( rtn == false ) {
		  errMsg = obj.getErrorMsg();
		  showAlert = "此步驟失敗！" + errMsg;
		  program = "epaperedit101_mdy.jsp";
	  }else{
		  program = "epaperedit101_continue_mdy.jsp";
	  }

	 %>

	<form name="mform" action="<%=program%>" method="post">
	  <input type="hidden" name="title" value="<%=title%>"/>
	  <input type="hidden" name="logindn" value="<%=logindn%>"/>
	  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
	  <input type="hidden" name="intpage" value="<%=intpage%>"/>
	  <input type="hidden" name="murl" value="<%=murl%>"/>
	  <input type="hidden" name="language" value="<%=language%>"/>
	  <input type="hidden" name="serno" value="<%=serno%>"/>
	</form>
	 
	<%
	  if ( showAlert == null || showAlert.equals("null") ) { %>
		  <script>
		     document.mform.submit();
		  </script>  
	  <%}else{%>
		  <script>
		     alert("<%=showAlert%>");
		     document.mform.submit();
		  </script>  
	  <%}
  }%>
  
  
