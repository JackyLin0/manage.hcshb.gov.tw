<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：webunit101_mdysave.jsp
說明：單位資料維護
開發者：chmei
開發日期：97.02.27
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );

  //參數
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String serno = ( String )request.getParameter( "serno" );
  String subject = ( String )request.getParameter( "subject" );
  String pubunitdn = ( String )request.getParameter( "punit" );  
  String pubunitname = ( String )request.getParameter( "pubunitname" );  
  String mclass = ( String )request.getParameter( "mclass" );  
  String[] ary_class = SvString.split(mclass,"-");
  
  String relateurl = ( String )request.getParameter( "relateurl" );
  String relatename = ( String )request.getParameter( "relatename" );
  String startusing = ( String )request.getParameter( "startusing" );
  String mfsort = ( String )request.getParameter( "fsort" );
  int fsort = 2;
  if ( !mfsort.equals("") && mfsort != null && !mfsort.equals("null") )
	  fsort = Integer.parseInt(mfsort);

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  WebUnitData obj = new WebUnitData();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setMserno(ary_class[0]);
  obj.setMclassname(ary_class[1]);
  obj.setStartusing(startusing);
  obj.setRelateurl(relateurl);
  obj.setRelatename(relatename);
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

<form name="mform" action="webunit101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
