<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：prize101_prizesave.jsp
說明：產生中獎名單
開發者：chmei
開發日期：97.12.14
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
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  
  String table = ( String )request.getParameter( "t" );

  String logincn = ( String )session.getAttribute( "logincn" );
   
  String serno = ( String )request.getParameter( "serno" );
  
  String num = ( String )request.getParameter( "num" );
  String flag = ( String )request.getParameter( "flag" );
  QuestionData query = new QuestionData();
  query.setNum(Integer.parseInt(num));
  query.setFlag(Integer.parseInt(flag));
  ArrayList qlists = query.findByRprize(serno);
  int rcount = query.getAllrecordCount();

  boolean rtn = true ;
  String errMsg="0"; 
  String showAlert = null; 
  
  if ( qlists != null ) {
	  String prizedata = "";
	  String mserno = "";
	  for ( int i=0; i<rcount; i++ ) {
		  QuestionData qlist = ( QuestionData )qlists.get( i );
		  mserno = qlist.getSerno();
		  String mprize = qlist.getSerno() + "||" + qlist.getDetailno() +  "||" + qlist.getName() + "||" + qlist.getPid();
		  if ( prizedata.equals("") ) {
			  prizedata = mprize;
		  }else{
			  prizedata = prizedata + "&" + mprize;
		  }
	  }
	  
	  QuestionData obj = new QuestionData();
	  
	  obj.setSerno(mserno);
	  obj.setPrizedata(prizedata);	  
	  obj.setCreatename(logincn);

	  //執行動作(新增資料)  
	  rtn = obj.create();

	  if ( rtn == false ) {
		  errMsg = obj.getErrorMsg();
		  showAlert = "名單產生失敗！" + errMsg;
	  }else{
		  showAlert="名單產生成功！";
	  }

  }

%>  

<form name="mform" action="prize101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  

