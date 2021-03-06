<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：indexbanner101_addsave.jsp
說明：首頁活動預告
開發者：chmei
開發日期：2016.11.21
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局服務網後端管理系統</title>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="sysview.zhiren.servlet.mime.SvMultipartRequest" %>
<%@ page import="tw.com.sysview.upload.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //取系統路徑
  String sysRoot1 = (String) application.getRealPath("");
  //判斷OS版本
  String Upload_PATH = "";
  if ( sysRoot1.indexOf("/") == -1 )
	  Upload_PATH = sysRoot1+"\\WEB-INF\\uploadpath.properties";
  else
	  Upload_PATH = sysRoot1+"/WEB-INF/uploadpath.properties";

  Properties upload = new Properties();
  upload.load(new FileInputStream(Upload_PATH) );
  String filepath = upload.getProperty("indexbannerpath");
  String imageresize = "230";

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
     response.sendRedirect("indexbanner101.jsp");
     return;
  }
  
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
  String ndate = fmt.format(Calendar.getInstance().getTime());

  IndexBannerData obj = new IndexBannerData();  
  
  boolean rtn = true ;
  String errMsg="0"; 
  
  //參數
  String table = ( String )req.getParameter( "t", "" );
  String language = ( String )req.getParameter( "language", "" );
  if ( language.equals("ch") )
	  language = "chinese";
  else if ( language.equals("en") )
	  language = "english";
  else if ( language.equals("en") )
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
		  String subfile = SvString.right(filename[i],'.');
		  String filename2 = ndate + i + "." + subfile;
		  File oldfile = new File(filepath + "/" + filename[i]);
		  File newfile = new File(filepath + "/" + filename2);
		  String rename = filename[i];

		  if ( oldfile.renameTo(newfile) )
			  rename = filename2;
		  
		  //自動縮圖 start
		  String autoresize = "N";
		  String smallimagename = SvString.left(rename,".") + i + "_small" + "." + subfile;
		  String bigimg = filepath + "/" + rename;
		  String smallimg = filepath + "/" + SvString.left(rename,".") + i + "_small" + "." + subfile;
		  
		  ImageMagick checkimage = new ImageMagick();
		  boolean smallimage = checkimage.check(imageresize,bigimg);
		  
		  if ( smallimage ) {
			  ImageMagick image = new ImageMagick();		  
			  image.converImage(imageresize,bigimg,smallimg);
			  autoresize = "Y";
		  }
		  //自動縮圖 end
		  
		  if ( oldfile.renameTo(newfile) )
			  rename = filename2;
		  obj.setServerfile(rename);
		  obj.setClientfile(originfile[i]);
		  String mfileexp1 = ( String )req.getParameter( "mfileexp1", "" );
		  obj.setExpfile(mfileexp1);
		  if ( autoresize.equals("Y") )
			  obj.setImagemagick(smallimagename);		  
		  else
			  obj.setImagemagick(rename);
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
  String mrelateurl = ( String )req.getParameter( "relateurl", "" );
  String mrelatename = ( String )req.getParameter( "relatename", "" );
  
  int fsort = 2;
  String mfsort = ( String )req.getParameter( "fsort", "" );
  if ( mfsort != null && !mfsort.equals("") )
	  fsort = Integer.parseInt(mfsort);

  //取得修改者IP
  String hostIP = request.getRemoteHost();

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


<form name="mform" action="indexbanner101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="websitedn" value="<%=websitedn%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  

</html>
