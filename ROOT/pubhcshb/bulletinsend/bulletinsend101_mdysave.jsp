<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：bulletinsend101_mdysave.jsp
說明：最新消息維護(可發布至縣府入口網的一般公告)
開發者：chmei
開發日期：97.02.17
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.metatag.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //接收查詢條件 
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );
  String qptdate = ( String )request.getParameter( "qptdate" );
  String qdldate = ( String )request.getParameter( "qdldate" );

  //參數
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String table2 = ( String )request.getParameter( "t2" );
  String title = ( String )request.getParameter( "title" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值    
  String serno = ( String )request.getParameter( "serno" );
  String stdate = ( String )request.getParameter( "stdate" );
  String phour = ( String )request.getParameter( "phour" );
  String pminute = ( String )request.getParameter( "pminute" );
  String postertime = phour + pminute;
//   String startusing = ( String )request.getParameter( "startusing" );
//   String endate = ( String )request.getParameter( "endate" );
//   if ( startusing.equals("1") )
// 	  endate = "";
  String subject = ( String )request.getParameter( "subject" );
  String secsubject = ( String )request.getParameter( "secsubject" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );  
  String pubunitname = ( String )request.getParameter( "pubunitname" ); 
  String content = ( String )request.getParameter( "content" );
  String relateurl = ( String )request.getParameter( "relateurl" );
  String relatename = ( String )request.getParameter( "relatename" );
  String liaisonunit = ( String )request.getParameter( "liaisonunit" );
  String liaisonper = ( String )request.getParameter( "liaisonper" );
  
  String aptable = ( String )request.getParameter( "aptable" );
  String[] ary_aptable = SvString.split(aptable,"||");
  String aplistdn = ( String )request.getParameter( "webdn" );
  

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  out.println("ip:"+hostIP);
  
  BulletinSendData obj = new BulletinSendData();
  
  boolean rtn = true ;
  String errMsg="0";     

  obj.setSerno(serno);
  obj.setPosterdate(stdate);
  obj.setPostertime(postertime);
//   obj.setStartusing(startusing);  
//   obj.setClosedate(endate); 
  obj.setSecsubject(secsubject);
  obj.setContent(content);
  obj.setRelateurl(relateurl);
  obj.setRelatename(relatename);
  obj.setLiaisonper(liaisonunit);
  obj.setLiaisonper(liaisonper);
  obj.setAptable(aptable);
  obj.setExamtable(table1);
  obj.setAplistdn(aplistdn);
  
  
  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(subject);             //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename("Bulletinsend");    //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("U");                  //狀態
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");
  
  //執行動作(修改資料)  
  rtn = obj.store(sysRoot);    
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="bulletinsend101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="t2" value="<%=table2%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
  <input type="hidden" name="qptdate" value="<%=qptdate%>"/>
  <input type="hidden" name="qdldate" value="<%=qdldate%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
