<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：menu_tempmdysave.jsp
說明：選單目錄管理
開發者：chmei
開發日期：96.02.12
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import="sysview.zhiren.servlet.mime.SvMultipartRequest" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  MenuData obj = new MenuData();

  //接受查詢條件
  String islevelcontent = ( String )request.getParameter( "islevelcontent" );
  
  //參數
  String table = ( String )request.getParameter( "t" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String language = ( String )request.getParameter( "language" );
  String murl = ( String )request.getParameter( "murl" );
  String title = ( String )request.getParameter( "title" );
  
  String logincn = ( String )session.getAttribute("logincn");
  
  //form值
  int islevel = Integer.parseInt(( String )request.getParameter( "islevel" ));
  String mislevelcontent = ( String )request.getParameter( "mislevelcontent" );
  String mserno = ( String )request.getParameter( "toplevel" );

  String startusing = ( String )request.getParameter( "startusing" );
  int fsort = 0;
  String fsort1 = ( String )request.getParameter( "fsort" );
  if ( fsort1 != null && !fsort1.equals("") )
	  fsort = Integer.parseInt(fsort1);
  String target = ( String )request.getParameter( "target" );
  String mflag = ( String )request.getParameter( "mflag" );
  String serno = ( String )request.getParameter( "serno" );

  String link = "";
  if ( mflag.equals("0") ) {
	  link = ( String )request.getParameter( "islevellink0" );
  }else if ( mflag.equals("1") ) {
	  link = ( String )request.getParameter( "islevellink1" );
	  String[] ary_link = SvString.split(link,"/");
	  obj.setServerfile1(ary_link[2]);
	  obj.setClientfile1(ary_link[2]);
  }else if ( mflag.equals("2") ) {
	  link = ( String )request.getParameter( "islevellink2" );
  }else if ( mflag.equals("3") ) {
	  link = ( String )request.getParameter( "islevellink3" );
	  String[] ary_link = SvString.split(link,"/");
	  obj.setServerfile1(ary_link[2]);
	  obj.setClientfile1(ary_link[2]);
  }
  
  boolean rtn = true ;
  String errMsg="0";     
  
  obj.setSerno(serno);
  obj.setIslevel(islevel);
  obj.setIslevelcontent(mislevelcontent);
  obj.setIslevellink(link);
  obj.setFlag(mflag);
  obj.setTarget(target);
  obj.setTopserno(mserno);
  obj.setStartusing(startusing);
  obj.setFsort(fsort);
  obj.setPostname(logincn);

  //執行動作(修改資料)  
  rtn = obj.store(table);
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="menu.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="islevelcontent" value="<%=islevelcontent%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
 