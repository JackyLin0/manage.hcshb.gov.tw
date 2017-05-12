<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 派車系統管理 - 修改儲存
Programming File: car102_mdysave.jsp
Copyright © SYSTEX B17E By Peilun 2012-04-24
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值    
  String serno = ( String )request.getParameter( "serno" );
  String pubunitdn = ( String )request.getParameter( "punit" );  
  String pubunitname = ( String )request.getParameter( "pubunitname" ); 
  String subject = ( String )request.getParameter( "subject" );
  String licenseplate = ( String )request.getParameter( "licenseplate" );
  String driver = ( String )request.getParameter( "driver" );
  String state = ( String )request.getParameter( "state" );  
  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  CarData obj = new CarData();  
  
  boolean rtn = true ;
  String errMsg="0";     

  obj.setLicenseplate(licenseplate);
  obj.setDriver(driver);
  obj.setState(state);
  
  //網站維運統計共用參數(WebSiteLog)
  obj.setSerno(serno);				   //序號
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(subject);             //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);    		   //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("U");                  //狀態
  
  //執行動作(新增資料)  
  rtn = obj.storeManage();    
    
  String showAlert = null;  
  String program = "car102.jsp";
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{	  
	  showAlert="修改成功！";
  }
%>

  <form name="mform" action="<%=program%>" method="post">
     <input type="hidden" name="t" value="<%=table%>"/>
     <input type="hidden" name="title" value="<%=title%>"/>
     <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
     <input type="hidden" name="intpage" value="<%=intpage%>"/>
     <input type="hidden" name="murl" value="<%=murl%>"/>
     <input type="hidden" name="language" value="<%=language%>"/>
     <input type="hidden" name="flag"/>
  </form>
  
  <script>
     alert("<%=showAlert%>");
     document.mform.submit();
  </script>

