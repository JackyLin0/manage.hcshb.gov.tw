<%@page import="tw.com.sysview.dba.meeting.PlaceData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：place101_mdysave.jsp
說明：場地維護(適用單站台)
開發者：yclai
開發日期：103.08.26
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接受查詢條件
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qwebsite = ( String )request.getParameter( "qwebsite" );
  String qclassname = ( String )request.getParameter( "qclassname" );

  //參數
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  
  String title = ( String )request.getParameter( "title" );
  String murl = ( String )request.getParameter( "murl" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  String logincn = ( String )session.getAttribute( "logincn" );
  
  //form值
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String pubunitname = ( String )request.getParameter( "pubunitname" );
  String placename = ( String )request.getParameter( "placename" );
  String placeexplain = ( String )request.getParameter( "placeexplain" );
  
  String serno = ( String )request.getParameter( "serno" );
  
  //取得修改者IP
  String hostIP = request.getRemoteHost();
    
  PlaceData obj = new PlaceData();  
  
  boolean rtn = true ;
  String errMsg="0";     
  
  obj.setPlacename(placename);
  obj.setPlaceexplain(placeexplain);

  //網站維運統計共用參數(WebSiteLog)
  obj.setSerno(serno);                 //序號
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setWebsitedn("");         //使用站台DN
  obj.setWebsitename("");     //使用站台名稱
  obj.setSubject(placename);           //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("U");                  //狀態
  
  //執行動作(修改資料)  
  rtn = obj.store();
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="place101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qwebsite" value="<%=qwebsite%>"/>
  <input type="hidden" name="qclassname" value="<%=qclassname%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
 