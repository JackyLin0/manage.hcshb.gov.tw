<%@page import="tw.com.sysview.dba.meeting.MeetingData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：placevisit201_addsave.jsp
說明：會議室預約
開發者：yclai
開發日期：103.08.26
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@page import="tw.com.sysview.dba.meeting.PlaceData"%>

<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );

  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String punit = ( String )request.getParameter( "punit" );  
  String[] ary_punit = SvString.split(punit,"||");
  String subject = ( String )request.getParameter( "subject" );
  String placeSerno = ( String )request.getParameter( "placeSerno" );
  String liaisonPer = ( String )request.getParameter( "liaisonPer" );
  String liaisonTel = ( String )request.getParameter( "liaisonTel" );
  String schedulnum = ( String )request.getParameter( "schedulnum" );
  String scheduldate = ( String )request.getParameter( "scheduldate" );
  String serno = ( String )request.getParameter( "serno" );
  String stime = ( String )request.getParameter( "stime" );
  String etime = ( String )request.getParameter( "etime" );
  String activityflag = ( String )request.getParameter( "activityflag" );
  String place = (String)request.getParameter( "place" );
  String y1 = (String) request.getParameter("y1");
  String m1 = (String) request.getParameter("m1");
  
  
  
  
  //取得修改者IP
  String hostIP = request.getRemoteHost();
    
  MeetingData obj = new MeetingData();    
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setSerno(serno);
  obj.setLiaisonPer(liaisonPer);
  obj.setLiaisonTel(liaisonTel);
  obj.setLimitNum(schedulnum);
  obj.setSchedulSTime(stime);
  obj.setSchedulETime(etime);
  obj.setActivityFlag(activityflag);
  obj.setTablename(table1);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(ary_punit[0]);        //發布單位DN
  obj.setPubunitname(ary_punit[1]);      //發布單位名稱
  obj.setSubject(subject);               //標題
  obj.setPostname(logincn);              //最後更新者姓名
  obj.setUnitname(title);                //單元名稱
  obj.setTablename(table1);               //table名稱
  obj.setWebip(hostIP);                  //登入者IP
  obj.setLanguage("ch");                 //語系
  obj.setStatus("U");                    //狀態
  
//   out.println(ary_punit[0] + ";" +ary_punit[1]+";"+logincn+ ";" + title+ ";" + table+ ";" + hostIP);
  
  //執行動作(新增資料)  
  rtn = obj.store();  
    
  String showAlert = null; 
  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="place.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="y1" value="<%=y1%>"/>
  <input type="hidden" name="m1" value="<%=m1%>"/>
  <input type="hidden" name="place" value="<%=place%>"/>
  <input type="hidden" name="language" value="ch"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>
 