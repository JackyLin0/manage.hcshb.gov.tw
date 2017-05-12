<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities105_delsave.jsp
說明：報名資料維護
開發者：chmei
開發日期：98.10.16
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.mail.SvMail" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%  
  //自web.xml檔讀取mailserver變數
  String mailserver = ( String )application.getInitParameter( "MailServer" );

  String msubject = ( String )request.getParameter( "msubject" );
  String actserno = ( String )request.getParameter( "actserno" );
  String serno = ( String )request.getParameter( "serno" );
  String mcontent = ( String )request.getParameter( "mcontent" );
  
  ActivityExcelData qdata = new ActivityExcelData();
  boolean rtn = qdata.remove(actserno,serno);
  
  String showAlert = null;  
  if ( rtn ) {
	  String msubject1 = "新竹縣衛生局-線上報名通知";
	  String mcontent1 = "";
	  if ( qdata.getEmail() != null && !qdata.getEmail().equals("null") && !qdata.getEmail().equals("") ) {
		  mcontent1 = "<html><head><title>" + msubject1 + "</title><meta http-equiv=Content-Type content='text/html; charset=big5'></head>";
		  mcontent1 = mcontent1 + "<body bgcolor=#FFFFFF text=#000000><div align=center>";
		  mcontent1 = mcontent1 + "<table border=0>";
		  mcontent1 = mcontent1 + "<tr><td align=left>親愛的【" + qdata.getName() + "】您好：</td></tr>";
		  mcontent1 = mcontent1 + "<tr><td align=left>" + mcontent.replaceAll("\n","<br>") + "</td></tr>";
		  mcontent1 = mcontent1 + "<tr><td align=left>&nbsp;</td></tr>";
		  
		  SvMail mail = new SvMail();
		  mail.sendHtml( mailserver, "epaper@hchg.gov.tw", qdata.getEmail(), "", "", msubject1, mcontent1);
		  
	  }
	  showAlert="刪除成功！";
  }else{
	  showAlert = "刪除失敗！";
  }%>

  <form name="mform" action="activities105_mdy.jsp" method="post">
    <input type="hidden" name="msubject" value="<%=msubject%>"/>
    <input type="hidden" name="actserno" value="<%=actserno%>"/>
    <input type="hidden" name="serno" value="<%=serno%>"/>
  </form>

   
  <script>
     alert("<%=showAlert%>");
     document.mform.submit();
  </script>  
   


