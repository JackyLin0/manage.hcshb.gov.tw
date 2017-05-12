<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：piclibrary101_save.jsp
說明：圖庫管理
開發者：chmei
開發日期：97.06.07
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新竹縣衛生局服務網後端管理系統</title>


<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="sysview.zhiren.servlet.mime.SvMultipartRequest" %>
<%@ page import="tw.com.sysview.upload.*" %>


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
  String syspath = upload.getProperty("picpath");
  String imageresize = upload.getProperty("imageresize");
  
  String filepath = syspath + path; 

  //目錄不存在時，建立目錄
  File f = new File(filepath);  
  if (!f.exists()) 
     f.mkdirs();

  //接受上一頁Form內的所有欄位值
  SvMultipartRequest req = new SvMultipartRequest(request);  
  
  int size = 52428800;
  if ( !req.process(filepath,size) )
  { 
	 System.out.println(req.getErrorMsg());
     session.setAttribute("AlertMessage", "檔案無法上傳！");
     response.sendRedirect("piclibrary.jsp");
     return;
  }
  
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
  String ndate = fmt.format(Calendar.getInstance().getTime());

  PicLibraryFileData obj = new PicLibraryFileData();
  
  boolean rtn = true ;
  String errMsg="0"; 
  
  //URL 參數
  String table = ( String )req.getParameter( "t", "" );  
  String intpage = ( String )req.getParameter( "intpage", "" );
  String pagesize = ( String )req.getParameter( "pagesize", "" );
    
  File[] reqfile = req.getFiles();  
  //取得上傳檔案的個數 
  int num = reqfile.length;    
  
  //宣告陣列
  String filename[] = new String[3];  
  String originfile[] = new String[3];
  String mserver = "";
  String mclient = "";
  String msmallimg = "";
  String exp = "";
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
		  
		  if ( mserver.equals("") ) {
			  mserver = rename;
			  mclient = originfile[i];
			  exp = ( String )req.getParameter( "mfileexp1", "" );
			  if ( autoresize.equals("Y") )
				  msmallimg = smallimagename;
			  else
				  msmallimg = rename;
		  }else{
			  mserver = mserver + "||" + rename;
			  mclient = mclient + "||" + originfile[i];
			  exp = exp + "||" + ( String )req.getParameter( "mfileexp1", "" );
			  if ( autoresize.equals("Y") )
				  msmallimg = msmallimg + "||" + smallimagename;
			  else
				  msmallimg = msmallimg + "||" + rename;
		  }
	  }else if ( i==1 ) { 
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
		  
		  if ( mserver.equals("") ) {
			  mserver = rename;
			  mclient = originfile[i];
			  exp = ( String )req.getParameter( "mfileexp2", "" );
			  if ( autoresize.equals("Y") )
				  msmallimg = smallimagename;
			  else
				  msmallimg = rename;
		  }else{
			  mserver = mserver + "||" + rename;
			  mclient = mclient + "||" + originfile[i];
			  exp = exp + "||" + ( String )req.getParameter( "mfileexp2", "" );
			  if ( autoresize.equals("Y") )
				  msmallimg = msmallimg + "||" + smallimagename;
			  else
				  msmallimg = msmallimg + "||" + rename;
		  }
	  }else if ( i==2 ) {
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
		  
		  if ( mserver.equals("") ) {
			  mserver = rename;
			  mclient = originfile[i];
			  exp = ( String )req.getParameter( "mfileexp3", "" );
			  if ( autoresize.equals("Y") )
				  msmallimg = smallimagename;
			  else
				  msmallimg = rename;
		  }else{
			  mserver = mserver + "||" + rename;
			  mclient = mclient + "||" + originfile[i];
			  exp = exp + "||" + ( String )req.getParameter( "mfileexp3", "" );
			  if ( autoresize.equals("Y") )
				  msmallimg = msmallimg + "||" + smallimagename;
			  else
				  msmallimg = msmallimg + "||" + rename;
		  }
	  }
  }

  String logincn = ( String )session.getAttribute("logincn");
  String language = ( String )req.getParameter( "language", "" );
  
  obj.setFlag("pic");
  obj.setPostname(logincn);
  obj.setClientfile(mclient);
  obj.setServerfile(mserver);
  obj.setExpfile(exp);
  obj.setImagemagick(msmallimg);

  //執行動作(新增資料)  
  rtn = obj.create(table);  
  
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "新增失敗！" + errMsg;
  }else{
	  showAlert="新增成功！";
  }

 %>

<form name="mform" action="piclibrary101.jsp" method="post">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>
