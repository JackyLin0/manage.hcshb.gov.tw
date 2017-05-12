<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：file_mdysave.jsp
說明：檔案管理(文件檔案)
開發者：chmei
開發日期：97.02.15
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
  String syspath = upload.getProperty("filepath");
  
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
     response.sendRedirect("file_list.jsp");
     return;
  }

  UploadData obj = new UploadData();
  
  boolean rtn = true ;
  String errMsg="0"; 
  
  //URL 參數
  String serno = ( String )req.getParameter( "serno", "" );
  String table = ( String )req.getParameter( "table", "" );  
  String intpage = ( String )req.getParameter( "intpage", "" );
  String pagesize = ( String )req.getParameter( "pagesize", "" );
    
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
	  }
  }
  
  String nsfile = ( String )req.getParameter( "nsfile", "" );
  String osfile = ( String )req.getParameter( "osfile", "" );
  
  String ocfile = ( String )req.getParameter( "ocfile", "" );
  if ( nsfile.equals("") ) {
	  obj.setServerfile(osfile);
	  obj.setClientfile(ocfile);
  }else{
	  if (!osfile.equals("")) {
		  File d1 = new File(filepath,osfile);
          if (d1.exists()) {
        	  d1.delete();
          } 
      }
  }

  String logincn = ( String )session.getAttribute("logincn");
  String language = ( String )req.getParameter( "language", "" );
  int detailno = Integer.parseInt(( String )req.getParameter( "detailno", "" ));
  String fileexp = ( String )req.getParameter( "fileexp1", "" );
      
  obj.setSerno(serno);
  obj.setDetailno(detailno);
  obj.setFlag("doc");
  obj.setPostname(logincn);
  obj.setExpfile(fileexp);

  //執行動作(修改資料)  
  rtn = obj.store(table);   
  
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="file_list.jsp" method="post">
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="table" value="<%=table%>"/>
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>
