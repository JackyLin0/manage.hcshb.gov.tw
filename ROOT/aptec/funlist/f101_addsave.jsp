<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：f101_addsave.jsp
說明：網站功能維護
開發者：tswenyaw
開發日期：96.08.06
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
  String mpunit = ( String )request.getParameter( "mpunit" );
  String logincn = ( String )session.getAttribute( "logincn" );
  //  out.println(table);
  //form值    
   String page_name      = ( String )request.getParameter("page_name");
   String uppage_url    = ( String )request.getParameter("uppage_url");
   String page_url  = ( String )request.getParameter("page_url");
   if(page_url==null||page_url.equals(""))page_url=uppage_url;
   String tblname= ( String )request.getParameter("tblname");
   String tblclassname     = ( String )request.getParameter("tblclassname");
   String tblposname     = ( String )request.getParameter("tblposname");
   if(tblposname==null||tblposname.equals(""))tblposname=tblname;
   
  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  APList obj = new APList();
  
  boolean rtn = true ;
  String errMsg="0";     
  obj.setTblclassname(tblclassname);
   obj.setPage_name(page_name);
   obj.setPage_url(page_url);
   obj.setUppage_url(uppage_url);
   obj.setTblname(tblname);
   obj.setTblposname(tblposname);



  //網站維運統計共用參數(WebSiteLog)
  //obj.setPubunitdn(apunit);      //發布單位DN
  //obj.setPubunitname(apunit1);    //發布單位名稱
  //obj.setSubject(subject);             //標題
  obj.setPostname(logincn);            //最後更新者姓名
  //obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  //obj.setWebip(hostIP);                //登入者IP
  //obj.setStatus("A");                  //狀態
  
  //執行動作(新增資料)  
  rtn = obj.create();    
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "新增失敗！" + errMsg;
  }else{
	  showAlert="新增成功！";
  }

 %>

<form name="mform" action="f101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value=<%=murl%>>
  <input type="hidden" name="mpunit" value="<%=mpunit%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
