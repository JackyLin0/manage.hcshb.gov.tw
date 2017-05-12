<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperstyle101_save.jsp
說明：首頁內容版型設定
開發者：chmei
開發日期：97.03.02
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數  
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  
  //form值
  String allleft = "";
  String allmiddle = "";
  String left1 = ( String )request.getParameter( "left1" );
  if ( allleft.equals("") )
	  allleft = left1 + "||left1";
  else
	  allleft = allleft + "&" + left1 + "||left1";
  String left2 = ( String )request.getParameter( "left2" );
  if ( allleft.equals("") )
	  allleft = left2 + "||left2";
  else
	  allleft = allleft + "&" + left2 + "||left2";
  String left3 = ( String )request.getParameter( "left3" );
  if ( allleft.equals("") )
	  allleft = left3 + "||left3";
  else
	  allleft = allleft + "&" + left3 + "||left3";
  String middle1 = ( String )request.getParameter( "middle1" );
  if ( allmiddle.equals("") )
	  allmiddle = middle1 + "||middle1";
  else
	  allmiddle = allmiddle + "&" + middle1 + "||middle1";
  String middle2 = ( String )request.getParameter( "middle2" );
  if ( allmiddle.equals("") )
	  allmiddle = middle2 + "||middle2";
  else
	  allmiddle = allmiddle + "&" + middle2 + "||middle2";
  String middle3 = ( String )request.getParameter( "middle3" );
  if ( allmiddle.equals("") )
	  allmiddle = middle3 + "||middle3";
  else
	  allmiddle = allmiddle + "&" + middle3 + "||middle3";
  String middle4 = ( String )request.getParameter( "middle4" );
  if ( allmiddle.equals("") )
	  allmiddle = middle4 + "||middle4";
  else
	  allmiddle = allmiddle + "&" + middle4 + "||middle4";
  String middle5 = ( String )request.getParameter( "middle5" );
  if ( allmiddle.equals("") )
	  allmiddle = middle5 + "||middle5";
  else
	  allmiddle = allmiddle + "&" + middle5 + "||middle5";
  
  String alldata = allleft + "&" + allmiddle;
  
  EpaperStyleData obj = new EpaperStyleData();

  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setAlldata(alldata);
  obj.setPostname(logincn);

  //執行動作(新增資料)  
  rtn = obj.create();  
    
  String showAlert = null; 
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "設定失敗！" + errMsg;
  }else{
	  showAlert="設定成功！";
  }

 %>

<form name="mform" action="epaperstyle101.jsp" method="post">
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
  
