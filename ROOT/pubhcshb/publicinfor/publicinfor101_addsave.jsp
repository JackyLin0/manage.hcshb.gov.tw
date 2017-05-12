<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：publicinfor101_addsave.jsp
說明：公開資訊
開發者：chmei
開發日期：99.05.25
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公開資訊</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="sysview.zhiren.servlet.mime.SvMultipartRequest" %>
<%@ page import="tw.com.sysview.upload.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<body>

<%
  String path = ( String )request.getParameter( "path" );

  //取系統路徑
  String sysRoot = (String) application.getRealPath("");
  //判斷OS版本
  String Upload_PATH = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Upload_PATH = sysRoot+"\\WEB-INF\\uploadpath.properties";
  else
	  Upload_PATH = sysRoot+"/WEB-INF/uploadpath.properties";


  Properties upload = new Properties();
  upload.load(new FileInputStream(Upload_PATH) );
  String syspath = upload.getProperty("filepath");
  
  String filepath = syspath + path; 

  //目錄不存在時，建立目錄
  File f = new File(filepath);  
  if (!f.exists()) 
     f.mkdirs();

  //接受上一頁Form內的所有欄位值
  SvMultipartRequest req = new SvMultipartRequest(request);  
  
  if ( !req.process(filepath) )
  { 
	 System.out.println(req.getErrorMsg());
     session.setAttribute("AlertMessage", "檔案無法上傳！");
     response.sendRedirect("publicinfor101.jsp");
     return;
  }
  
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
  String ndate = fmt.format(Calendar.getInstance().getTime());

  PublicInforData obj = new PublicInforData();  
  
  boolean rtn = true ;
  String errMsg="0"; 
  
  //參數
  String table = ( String )req.getParameter( "t", "" );
  String language = ( String )req.getParameter( "language", "" );
  if ( language.equals("ch") )
	  language = "chinese";
  else if ( language.equals("en") )
	  language = "english";
  else if ( language.equals("jp") )
	  language = "japan";
  
  String websitedn = ( String )req.getParameter( "websitedn", "" );  
  String websitename = "";
  WebSiteData qwebname = new WebSiteData();
  boolean mrtn = qwebname.load(websitedn,language);
  if ( mrtn )
	  websitename = qwebname.getWebsitename();
  
  String title = ( String )req.getParameter( "title", "" );
  String logindn = ( String )req.getParameter( "logindn", "" );
  String pagesize = ( String )req.getParameter( "pagesize", "" );
  String intpage = ( String )req.getParameter( "intpage", "" );
  String murl = ( String )req.getParameter( "murl", "" );
    
  File[] reqfile = req.getFiles();  
  //取得上傳檔案的個數 
  int num = reqfile.length;    
  
  //宣告陣列
  String filename[] = new String[1];  
  String originfile[] = new String[1];
  
  for (int i=0; i<num; i++)
  {
	  filename[i] = reqfile[i].getName();      
	  originfile[i] = req.getOriginFile(filename[i]);
	  if ( i==0 ) {
		  obj.setServerfile(filename[i]);
		  obj.setClientfile(originfile[i]);
		  String mfileexp = ( String )req.getParameter( "fileexp1", "" );
		  obj.setExpfile(mfileexp);
	  }
  }  

  String logincn = ( String )session.getAttribute("logincn");
  
  //form 資料
  String stdate = ( String )req.getParameter( "stdate", "" );
  String startusing = ( String )req.getParameter( "startusing", "" );
  String endate = ( String )req.getParameter( "endate", "" );
  if ( startusing.equals("1") )
	  endate = "";
  String subject = ( String )req.getParameter( "subject", "" );
  String punit = ( String )req.getParameter( "punit", "" );
  String[] ary_punit = SvString.split(punit,"||");
  String mclass = ( String )req.getParameter( "qclass", "" );
  String[] ary_mclass = SvString.split(mclass,"-");
  
  String flag = ( String )req.getParameter( "flag", "" );
  String mrelateurl = "";
  String mrelatename = "";
  String menuserno = "";
  String content = "";
  if ( flag.equals("1") ) {
	  mrelateurl = ( String )req.getParameter( "relateurl", "" );
	  mrelatename = ( String )req.getParameter( "relatename", "" );
  }else if ( flag.equals("2") ) {
	  String menuvalue = ( String )req.getParameter( "menu", "" );
	  String[] ary_menuvalue = SvString.split(menuvalue,"||");
	  mrelateurl = ary_menuvalue[0];
	  mrelatename = ary_menuvalue[1];
	  menuserno = ary_menuvalue[2];
  }else if ( flag.equals("4") ) {
	  content = ( String )req.getParameter( "content", "" );
  }
  
  int fsort = 2;
  String mfsort = ( String )req.getParameter( "fsort", "" );
  if ( mfsort != null && !mfsort.equals("") )
	  fsort = Integer.parseInt(mfsort);

  //取得修改者IP
  String hostIP = request.getRemoteHost();

  obj.setMserno(ary_mclass[0]);
  obj.setMclassname(ary_mclass[1]);
  obj.setWebsitedn(websitedn);
  obj.setWebsitename(websitename);
  obj.setFlag(flag);
  obj.setMenuserno(menuserno);
  obj.setPosterdate(stdate);
  obj.setStartusing(startusing);  
  obj.setClosedate(endate);
  obj.setRelateurl(mrelateurl);
  obj.setRelatename(mrelatename);
  obj.setContent(content);
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

<form name="mform" action="publicinfor101_add.jsp" method="post">
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>" />
  <input type="hidden" name="path" value="<%=path%>" />
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>

</body>
</html>

