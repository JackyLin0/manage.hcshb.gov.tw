<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：question101_addsave.jsp
說明：問題反應
開發者：hank
開發日期：98.07.31
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="sysview.zhiren.mail.SvMail" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%
	//參數  
  String table = request.getParameter( "t" );
  String loginuid = request.getParameter( "loginuid" );
  String pagesize = request.getParameter( "pagesize" );
  String intpage = request.getParameter( "intpage" );
  String language = request.getParameter( "language" );
  
  //取系統路徑
  String sysRoot1 = (String) application.getRealPath("");
  
  String Ldap_PATH1 = sysRoot1 + "/WEB-INF/ldap.properties";
  Properties ldap1 = new Properties();
  ldap1.load(new FileInputStream(Ldap_PATH1) );
  String hcshb = ldap1.getProperty("hcshb");
  
  String logindn = ( String )session.getAttribute("logindn");
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }

  //form值
  String question = request.getParameter( "question" ); 
  String answer = request.getParameter( "answer" ); 
  String schName = request.getParameter("mschName");
  
  String punit = ( String )request.getParameter( "mqpunit" );  
  String[] ary_punit = SvString.split(punit,"||");

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  QuesresponseData obj = new QuesresponseData();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setQuestion(question);
  obj.setAnswer(answer);
  obj.setSchName(schName);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(ary_punit[0]);      //發布單位DN
  obj.setPubunitname(ary_punit[1]);    //發布單位名稱
  obj.setSubject(question);             //標題
  obj.setPostname(loginuid);            //最後更新者姓名
  obj.setUnitname("問題反應");              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("A");

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

<form name="mform" action="question101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="loginuid" value="<%=loginuid%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
