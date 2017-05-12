<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：quote101_save.jsp
說明：資料引用主網話說健康
開發者：chmei
開發日期：97.03.01
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
    
  //form 資料
  String classdata = ( String )request.getParameter( "classdata" );
  String[] ary_classdata = SvString.split(classdata,"||");
  
  String talkserno = "";
  String[] chk = request.getParameterValues("check");
  if ( chk == null ) { %>
	  <script>
	     alert("【您未勾選任何一項】");
	     window.history.go(-1);
	  </script>
  <%}else{
	  for ( int i=0; i<chk.length; i++ ) {
		  if ( talkserno.equals("") )
			  talkserno = chk[i];
		  else
			  talkserno = talkserno + "||" + chk[i];
	  }
  }
  
  EpaperData obj = new EpaperData();

  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setTablename("TalkHealth");
  obj.setMserno(ary_classdata[0]);
  obj.setMclassname(ary_classdata[1]);
  obj.setFlag("Y");
  obj.setTalkserno(talkserno);

  //執行動作(新增資料)  
  rtn = obj.storetalk();  
    
  String showAlert = null; 
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "引用失敗！" + errMsg;
  }else{
	  showAlert="引用成功！";
  }

 %>

<form name="mform" action="quote101.jsp" method="post">
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
  
