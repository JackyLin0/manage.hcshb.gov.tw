<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：marquee101_addsave.jsp
說明：跑馬燈維護
開發者：chmei
開發日期：99.05.23
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>跑馬燈維護</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  //參數
  String table = ( String )request.getParameter( "t" );;
  String language = ( String )request.getParameter( "language" );
  if ( language.equals("ch") )
	  language = "chinese";
  else if ( language.equals("en") )
	  language = "english";
  else if ( language.equals("jp") )
	  language = "japan";
  
  String websitedn = ( String )request.getParameter( "websitedn" );  
  String websitename = "";
  WebSiteData qwebname = new WebSiteData();
  boolean mrtn = qwebname.load(websitedn,language);
  if ( mrtn )
	  websitename = qwebname.getWebsitename();
  
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );

  String logincn = ( String )session.getAttribute("logincn");
  
  //form 資料
  String stdate = ( String )request.getParameter( "stdate" );
  String startusing = ( String )request.getParameter( "startusing" );
  String endate = ( String )request.getParameter( "endate" );
  if ( startusing.equals("1") )
	  endate = "";
  String subject = ( String )request.getParameter( "subject" );
  String punit = ( String )request.getParameter( "punit" );
  String[] ary_punit = SvString.split(punit,"||");
  String mrelateurl = ( String )request.getParameter( "relateurl" );
  String mrelatename = ( String )request.getParameter( "relatename" );
  
  int fsort = 2;
  String mfsort = ( String )request.getParameter( "fsort" );
  if ( mfsort != null && !mfsort.equals("") )
	  fsort = Integer.parseInt(mfsort);

  //取得修改者IP
  String hostIP = request.getRemoteHost();

  MarqueeData obj = new MarqueeData();  
  
  boolean rtn = true ;
  String errMsg="0"; 
  
  obj.setPosterdate(stdate);
  obj.setStartusing(startusing);  
  obj.setClosedate(endate);
  obj.setRelateurl(mrelateurl);
  obj.setRelatename(mrelatename);
  obj.setFsort(fsort);
  obj.setPostname(logincn);
  obj.setWebsitedn(websitedn);
  obj.setWebsitename(websitename);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(ary_punit[0]);      //發布單位DN
  obj.setPubunitname(ary_punit[1]);    //發布單位名稱
  obj.setSubject(subject);             //標題
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
	  showAlert = "新增成功！";
  }

 %>


<form name="mform" action="marquee101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>" />
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  


</body>
</html>

