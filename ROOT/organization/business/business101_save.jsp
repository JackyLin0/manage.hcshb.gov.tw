<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：business101_save.jsp
說明：業務簡介
開發者：chmei
開發日期：97.02.21
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //參數
  String language = ( String )request.getParameter( "language" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String pubunitname = ( String )request.getParameter( "pubunitname" );
  String murl = ( String )request.getParameter( "murl" );
  
  //form
  //業務簡介
  String content = ( String )request.getParameter( "content" );
  
  String mserno = ( String )request.getParameter( "mserno" );
  
  //業務執掌
  String unitcount = ( String )request.getParameter( "unitcount" );
  String munitdn = "";
  String munitname = "";
  String msubject = "";
  String mcontent1 = "";
  
  if ( unitcount != null && !unitcount.equals("null") && !unitcount.equals("") ) {
	  for ( int i=0; i<Integer.parseInt(unitcount); i++ ) {
		  String rcount = ( String )request.getParameter( "num"+(i+1) );
		  String unitdn = ( String )request.getParameter( "unitdn"+(i+1) );
		  String unitname = ( String )request.getParameter( "unitname"+(i+1) );
		  if ( Integer.parseInt(rcount) > 0 ) {
			  if ( munitdn.equals("") ) {
				  munitdn = unitdn;
				  munitname = unitname;
			  }else{
				  munitdn = munitdn + "||" + unitdn;
				  munitname = munitname + "||" + unitname;
			  }
			  
			  String tempsubject = "";
			  String tempcontent1 = "";
			  for ( int j=0; j<Integer.parseInt(rcount); j++ ) {
				  String subject = ( String )request.getParameter( "subject"+(i+1)+j );
				  if ( subject == null || subject.equals("null") || subject.equals("") )
					  subject = "a";
				  String content1 = ( String )request.getParameter( "content1"+(i+1)+j );
				  if ( content1 == null || content1.equals("null") || content1.equals("") )
					  content1 = "a";
				  if ( tempsubject.equals("") ) {
					  tempsubject = subject;
					  tempcontent1 = content1;
				  }else{
					  tempsubject = tempsubject + "&" + subject;
					  tempcontent1 = tempcontent1 + "&" + content1;
				  }
			  }
			  if ( msubject.equals("") ) {
				  msubject = tempsubject;
				  mcontent1 = tempcontent1;
			  }else{
				  msubject = msubject + "||" + tempsubject;
				  mcontent1 = mcontent1 + "||" + tempcontent1;
			  }
		  }
	  }
  }
  
  String logincn = ( String )session.getAttribute("logincn");
  
  BusinessData obj = new BusinessData();  
  
  boolean rtn = true ;
  String errMsg="0"; 

  obj.setSerno(mserno);
  obj.setPubunitdn(pubunitdn);
  obj.setPubunitname(pubunitname);
  obj.setContent(content);
  obj.setUnitdn(munitdn);
  obj.setUnitname(munitname);
  obj.setSubject(msubject);
  obj.setContent1(mcontent1);
  obj.setPostname(logincn);

  //執行動作(新增資料)  
  rtn = obj.create();  
  
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "儲存失敗！" + errMsg;
  }else{
	  showAlert="儲存成功！";
  }

 %>

<form name="mform" action="business101.jsp" method="post">
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>
