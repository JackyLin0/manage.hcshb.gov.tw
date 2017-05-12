<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 駕駛人員維護 - 新增儲存
Programming File: drive101_addsave.jsp
Copyright © SYSTEX B17E By Peilun 2012-04-06
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
  
  String serno[] = request.getParameterValues( "serno" );
  String pubunitdn = ( String )request.getParameter( "punit" );  
  String pubunitname = ( String )request.getParameter( "pubunitname" ); 
  String name[] = request.getParameterValues( "name" );
  String mdate = ( String )request.getParameter( "mdate" );
  /*
  String statedate = "";
  if ( mdate != null && !mdate.equals("") && !mdate.equals("null") ) {
	  statedate = mdate.substring(0,4) + mdate.substring(5,7) + mdate.substring(8,10);
  }
  */
  String state[] = request.getParameterValues( "state" );
    
  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  DriveData obj = new DriveData();  
  
  boolean rtn = true ;
  String errMsg="0";     
  
  for ( int i=0; i<serno.length; i++ ) {
	  obj.setSerno(serno[i]);
	  obj.setName(name[i]);
	  obj.setStatedate(mdate);
	  obj.setState(state[i]);

	  //網站維運統計共用參數(WebSiteLog)
	  obj.setPubunitdn(pubunitdn);      	//發布單位DN
	  obj.setPubunitname(pubunitname);    	//發布單位名稱
	  obj.setSubject(name[i]);              //標題
	  obj.setPostname(logincn);            	//最後更新者姓名
	  obj.setUnitname(title);              	//單元名稱
	  obj.setTablename(table);              //table名稱
	  obj.setWebip(hostIP);                	//登入者IP
	  obj.setLanguage(language);           	//語系
	  obj.setStatus("A");                  	//狀態
	  
	  //執行動作(新增資料)  
	  rtn = obj.createDriverState();  
  }

  String showAlert = null;  
  String program = "drive102.jsp";
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "新增失敗！" + errMsg;
  }else{	  
	  showAlert="新增成功！";
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

