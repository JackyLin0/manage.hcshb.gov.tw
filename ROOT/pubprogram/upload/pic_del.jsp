<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：pic_del.jsp
說明：檔案管理(圖片檔案)
開發者：chmei
開發日期：97.02.15
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.upload.*" %>

<%
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String serno = ( String )request.getParameter( "serno" );
  String tablename = ( String )request.getParameter( "table" ); 
  String path = ( String )request.getParameter( "path" );
  String language = ( String )request.getParameter( "language" );

  String delserno = "";
  String[] chk = request.getParameterValues("check");
  
  if ( chk == null || chk.equals("null") ) { %>
	  <script>
	     alert("【您未勾選任何一項】");
	     window.history.go(-1);
	  </script>
  <%}else{
	  for ( int i=0; i<chk.length; i++ ) {
		  if ( delserno.equals("") )
			  delserno = chk[i];
		  else
			  delserno = delserno + "&" + chk[i];
	  }
	  
	  //取設定檔路徑
	  String sysRoot = (String) getServletConfig().getServletContext().getRealPath("");
	  
	  UploadData obj = new UploadData();
	  
	  boolean rtn = true ;
	  String errMsg="0";
	  
	  obj.setSerno(delserno);
	  obj.setFlag("pic");
	  
	  //執行動作(刪除資料) 
	  rtn = obj.remove(tablename,sysRoot,path);
	  
	  String showAlert = null;  
	  if ( rtn == false ) {
		  errMsg = obj.getErrorMsg();
		  showAlert = "刪除失敗！" + errMsg;
	  }else{
		  showAlert="刪除成功！";
	  }  %>
	  
	  <form name="mform" action="pic_list.jsp" method="post">
	    <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
	    <input type="hidden" name="intpage" value="<%=intpage%>"/>
	    <input type="hidden" name="serno" value="<%=serno%>"/>
	    <input type="hidden" name="table" value="<%=tablename%>"/>
	    <input type="hidden" name="path" value="<%=path%>"/>
	    <input type="hidden" name="language" value="<%=language%>"/>
	  </form>
	  
	  <script>
	    alert("<%=showAlert%>");
	    document.mform.submit();
	  </script>

  <%}%>
  