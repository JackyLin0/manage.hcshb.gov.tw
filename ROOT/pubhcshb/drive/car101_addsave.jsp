<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 派車系統管理 - 新增儲存
Programming File: car101_addsave.jsp
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
  String punit = ( String )request.getParameter( "punit" );  
  String[] ary_punit = SvString.split(punit,"||");
  
  String name = ( String )request.getParameter( "name" );
  String department = ( String )request.getParameter( "department" );
  String subject = ( String )request.getParameter( "subject" );
  String usesdate = ( String )request.getParameter( "usesdate" );
  String carshour = ( String )request.getParameter( "carshour" );
  String carsminute = ( String )request.getParameter( "carsminute" );
  String usestime = carshour + carsminute;
  String useedate = ( String )request.getParameter( "useedate" );
  String carehour = ( String )request.getParameter( "carehour" );
  String careminute = ( String )request.getParameter( "careminute" );
  String useetime = carehour + careminute;
  String locationstart = ( String )request.getParameter( "locationstart" );
  String locationend = ( String )request.getParameter( "locationend" );
  String car = ( String )request.getParameter( "car" );
  String licenseplate = ( String )request.getParameter( "licenseplate" );
  String ride = ( String )request.getParameter( "ride" );
  String work = ( String )request.getParameter( "work" );
  String note = ( String )request.getParameter( "note" );
    
  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  CarData obj = new CarData();  
  
  boolean rtn = true ;
  String errMsg="0";     

  obj.setName(name);
  obj.setDepartment(department);
  obj.setUsesdate(usesdate);
  obj.setUsestime(usestime);
  obj.setUseedate(useedate);
  obj.setUseetime(useetime);
  obj.setLocationstart(locationstart);
  obj.setLocationend(locationend);
  obj.setCar(car);
  obj.setLicenseplate(licenseplate);
  obj.setRide(ride);
  obj.setWork(work);
  obj.setNote(note);
  obj.setDriver("");
  obj.setState("0");
  obj.setStatedate("");
  
  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(ary_punit[0]);      //發布單位DN
  obj.setPubunitname(ary_punit[1]);    //發布單位名稱
  obj.setSubject(subject);             //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);    //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("A");                  //狀態
  
  //執行動作(新增資料)  
  rtn = obj.create();    
    
  String showAlert = null;  
  String program = "car101.jsp";
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

