<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：outpatient101_mdy.jsp
說明：門診時間表
開發者：chmei
開發日期：99.05.22
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>門診時間表</title>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  
  //參數
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String murl = ( String )request.getParameter( "murl" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String serno = ( String )request.getParameter( "serno" );
  String stdate = ( String )request.getParameter( "stdate" );
  String startusing = ( String )request.getParameter( "startusing" );
  String endate = ( String )request.getParameter( "endate" );
  if ( startusing.equals("1") )
	  endate = "";
  String subject = ( String )request.getParameter( "subject" );
  String secsubject = ( String )request.getParameter( "secsubject" );
  String pubunitdn = ( String )request.getParameter( "punit" );  
  String pubunitname = ( String )request.getParameter( "pubunitname" );
  
  String content = ( String )request.getParameter( "content" );

  String city = ( String )request.getParameter( "AddrCity" );
  String towns = ( String )request.getParameter( "AddrArea" );
  
  String[] cityvalue = new String[2];
  if ( city != null && !city.equals("null") && !city.equals("||") ) {
	  cityvalue = SvString.split(city,"||");
  }else{
	  cityvalue[0] = "";
	  cityvalue[1] = "";
  }
  String[] townsvalue =new String[3];
  if ( towns != null && !towns.equals("null") && !towns.equals("||") ) {
	  townsvalue = SvString.split(towns,"||");
  }else{
	  townsvalue[1] = "";
	  townsvalue[2] = "";
  }
  
  String area = ( String )request.getParameter( "AddrZone" );
  if ( area.indexOf("請輸入") != -1 ) {
	  area = "";
  }
  String addr = ( String )request.getParameter( "Addr" );
  if ( addr.indexOf("請輸入") != -1 ) {
	  addr = "";
  }
  
  String liaisonper = ( String )request.getParameter( "liaisonper" );
  String liaisontel = ( String )request.getParameter( "liaisontel" );
  String liaisonemail = ( String )request.getParameter( "liaisonemail" );
  
  String mfsort = ( String )request.getParameter( "fsort" );
  int fsort = 2;
  if ( !mfsort.equals("") && mfsort != null && !mfsort.equals("null") )
	  fsort = Integer.parseInt(mfsort);

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  OutpatientTimeData obj = new OutpatientTimeData();
  
  boolean rtn = true ;
  String errMsg="0";
  
  obj.setSecsubject(secsubject);
  obj.setPosterdate(stdate);
  obj.setContent(content);
  obj.setStartusing(startusing);
  obj.setArea(area); 
  obj.setCityno(cityvalue[0]); 
  obj.setCityname(cityvalue[1]); 
  obj.setTownsno(townsvalue[1]); 
  obj.setTownsname(townsvalue[2]); 
  obj.setAddress(addr);
  obj.setClosedate(endate);
  obj.setLiaisonper(liaisonper);
  obj.setLiaisontel(liaisontel);
  obj.setLiaisonemail(liaisonemail);
  obj.setFsort(fsort);

  //網站維運統計共用參數(WebSiteLog)
  obj.setSerno(serno);                 //序號
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(subject);             //標題
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

<form name="mform" action="outpatient101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
</body>
</html>