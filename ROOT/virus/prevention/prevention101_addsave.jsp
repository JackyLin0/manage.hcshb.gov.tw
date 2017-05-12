<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：prevention101_addsave.jsp
說明：各機構查核紀錄表
開發者：chmei
開發日期：97.03.08
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數  
  String table = ( String )request.getParameter( "t" );
  String organization = ( String )request.getParameter( "o" );
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String stdate = ( String )request.getParameter( "stdate" );
  String subject = ( String )request.getParameter( "subject" );
  String[] ary_subject = SvString.split(subject,"||");
  String punit = ( String )request.getParameter( "punit" );  
  String[] ary_punit = SvString.split(punit,"||");
  String ischeck = ( String )request.getParameter( "ischeck" );
  String equipmentqual = ( String )request.getParameter( "equipmentqual" );
  String equipmentnoqual = ( String )request.getParameter( "equipmentnoqual" );
  String opportunityqual = ( String )request.getParameter( "opportunityqual" );
  String opportunitynoqual = ( String )request.getParameter( "opportunitynoqual" );
  String movementqual = ( String )request.getParameter( "movementqual" );
  String movementnoqual = ( String )request.getParameter( "movementnoqual" );
  String healthsiftqual = ( String )request.getParameter( "healthsiftqual" );
  String healthsiftnoqual = ( String )request.getParameter( "healthsiftnoqual" );
  String coursequal = ( String )request.getParameter( "coursequal" );
  String courseqnoual = ( String )request.getParameter( "coursenoqual" );

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  PreventionData obj = new PreventionData();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setPosterdate(stdate);
  obj.setIscheck(ischeck);
  obj.setSubjectno(ary_subject[0]);
  obj.setEquipmentqual(Integer.parseInt(equipmentqual));
  obj.setEquipmentnoqual(Integer.parseInt(equipmentnoqual));
  obj.setOpportunityqual(Integer.parseInt(opportunityqual));
  obj.setOpportunitynoqual(Integer.parseInt(opportunitynoqual));
  obj.setMovementqual(Integer.parseInt(movementqual));
  obj.setMovementnoqual(Integer.parseInt(movementnoqual));
  obj.setHealthsiftqual(Integer.parseInt(healthsiftqual));
  obj.setHealthsiftnoqual(Integer.parseInt(healthsiftnoqual));
  obj.setCoursequal(Integer.parseInt(coursequal));
  obj.setCoursenoqual(Integer.parseInt(courseqnoual));

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(ary_punit[0]);      //發布單位DN
  obj.setPubunitname(ary_punit[1]);    //發布單位名稱
  obj.setSubject(ary_subject[1]);      //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP  
  obj.setLanguage(language);           //語系
  obj.setStatus("A");                  //狀態

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

<form name="mform" action="prevention101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="o" value="<%=organization%>"/>
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
  
