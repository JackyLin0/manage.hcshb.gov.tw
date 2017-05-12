<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：maildata101_mdysave.jsp
說明：訂戶資料維護
開發者：chmei
開發日期：97.03.16
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String pubunitname = ( String )request.getParameter( "pubunitname" );
  
  String murl = ( String )request.getParameter( "murl" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值    
  String serno = ( String )request.getParameter( "serno" );
  String email = ( String )request.getParameter( "email" );
  if ( email == null || email.equals("null") )
	  email = "";
  
  String name = ( String )request.getParameter( "name" );
  if ( name == null || name.equals("null") )
	  name = "";
  
  String sex = ( String )request.getParameter( "sex" );
  if ( sex == null || sex.equals("null") )
	  sex = "";
  
  String myear = ( String )request.getParameter( "myear" );
  if ( myear == null || myear.equals("null") || myear.lastIndexOf("請輸入") != -1 )
	  myear = "";
  
  String mmonth = ( String )request.getParameter( "mmonth" );
  if ( mmonth == null || mmonth.equals("null") || mmonth.lastIndexOf("請輸入") != -1 )
	  mmonth = "";
  if ( mmonth.length() == 1 )
	  mmonth = "0" + mmonth;  
  
  String mday = ( String )request.getParameter( "mday" );
  if ( mday == null || mday.equals("null") || mday.lastIndexOf("請輸入") != -1 )
	  mday = "";
  if ( mday.length() == 1 )
	  mday = "0" + mday;
  
  String birthday = "";
  if ( !myear.equals("") && !mmonth.equals("") && !mday.equals("") )
	  birthday = myear + mmonth + mday;
  
  String edu = ( String )request.getParameter( "edu" );
  if ( edu == null || edu.equals("null") )
	  edu = "";  
  
  String occupation = ( String )request.getParameter( "occupation" );
  if ( occupation == null || occupation.equals("null") || occupation.lastIndexOf("請輸入") != -1 )
	  occupation = "";
  
  String fond = ( String )request.getParameter( "fond" ); 
  if ( fond == null || fond.equals("null") || fond.lastIndexOf("請輸入") != -1 )
	  fond = "";
  
  //取得訂閱者者IP
  String hostIP = request.getRemoteHost();
  
  EpaperMailData obj = new EpaperMailData();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setEmail(email);
  obj.setName(name);
  obj.setSex(sex);
  obj.setBirthday(birthday);
  obj.setEdu(edu);
  obj.setOccupation(occupation);
  obj.setFond(fond);
  obj.setIp(hostIP); 

  //網站維運統計共用參數(WebSiteLog)
  obj.setSerno(serno);                 //序號
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(email);               //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename("EpaperMailData");  //table名稱
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

<form name="mform" action="maildata101.jsp" method="post">
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
  
