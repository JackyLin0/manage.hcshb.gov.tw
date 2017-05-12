<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：manager101_addsave.jsp
說明：主管簡介
開發者：chmei
開發日期：97.02.21
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
<%@ page import="tw.com.sysview.dba.*" %>


<%
  String path = ( String )session.getAttribute("path");
  
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
     response.sendRedirect("manager101.jsp");
     return;
  }
  
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
  String ndate = fmt.format(Calendar.getInstance().getTime());

  ManagerData obj = new ManagerData();  
  
  boolean rtn = true ;
  String errMsg="0"; 
  
  //參數
  String pubunitdn = ( String )req.getParameter( "pubunitdn", "" );
  String language = ( String )req.getParameter( "language", "" ); 
  String pagesize = ( String )req.getParameter( "pagesize", "" ); 
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )req.getParameter( "murl", "" ); 
    
  File[] reqfile = req.getFiles();  
  //取得上傳檔案的個數 
  int num = reqfile.length;    
  
  //宣告陣列
  String filename[] = new String[1];  
  String originfile[] = new String[1];
  String mserver = "";
  String mclient = "";
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
		  if ( mserver.equals("") ) {
			  mserver = rename;
			  mclient = originfile[i];
			  exp = ( String )req.getParameter( "mfileexp1", "" );
		  }else{
			  mserver = mserver + "||" + rename;
			  mclient = mclient + "||" + originfile[i];
			  exp = exp + "||" + ( String )req.getParameter( "mfileexp1", "" );
		  }
	  }
  }  

  String logincn = ( String )session.getAttribute("logincn");
  
  //form 資料
  String punit = ( String )req.getParameter( "punit", "" );
  String[] ary_punit = SvString.split(punit,"||");
  String name = ( String )req.getParameter( "name", "" );
  String proftitle = ( String )req.getParameter( "proftitle", "" );
  String item1 = ( String )req.getParameter( "item1", "" );
  if ( item1 == null || item1.equals("null") )
	  item1 = "";
  String content1 = ( String )req.getParameter( "mcontent1", "" );
  if ( content1 == null || content1.equals("null") )
	  content1 = "";
  String item2 = ( String )req.getParameter( "item2", "" );
  if ( item2 == null || item2.equals("null") )
	  item2 = "";
  String content2 = ( String )req.getParameter( "mcontent2", "" );
  if ( content2 == null || content2.equals("null") )
	  content2 = "";
  String item3 = ( String )req.getParameter( "item3", "" );
  if ( item3 == null || item3.equals("null") )
	  item3 = "";
  String content3 = ( String )req.getParameter( "mcontent3", "" );
  if ( content3 == null || content3.equals("null") )
	  content3 = "";
  String item4 = ( String )req.getParameter( "item4", "" );
  if ( item4 == null || item4.equals("null") )
	  item4 = "";
  String content4 = ( String )req.getParameter( "mcontent4", "" );
  if ( content4 == null || content4.equals("null") )
	  content4 = "";
  String item5 = ( String )req.getParameter( "item5", "" );
  if ( item5 == null || item5.equals("null") )
	  item5 = "";
  String content5 = ( String )req.getParameter( "mcontent5", "" );
  if ( content5 == null || content5.equals("null") )
	  content5 = "";
  String item6 = ( String )req.getParameter( "item6", "" );
  if ( item6 == null || item6.equals("null") )
	  item6 = "";
  String content6 = ( String )req.getParameter( "mcontent6", "" );
  if ( content6 == null || content6.equals("null") )
	  content6 = "";
  String item7 = ( String )req.getParameter( "item7", "" );
  if ( item7 == null || item7.equals("null") )
	  item7 = "";
  String content7 = ( String )req.getParameter( "mcontent7", "" );
  if ( content7 == null || content7.equals("null") )
	  content7 = "";
  String item8 = ( String )req.getParameter( "item8", "" );
  if ( item8 == null || item8.equals("null") )
	  item8 = "";
  String content8 = ( String )req.getParameter( "mcontent8", "" );
  if ( content8 == null || content8.equals("null") )
	  content8 = "";
  String item9 = ( String )req.getParameter( "item9", "" );
  if ( item9 == null || item9.equals("null") )
	  item9 = "";
  String content9 = ( String )req.getParameter( "mcontent9", "" );
  if ( content9 == null || content9.equals("null") )
	  content9 = "";
  String item10 = ( String )req.getParameter( "item10", "" );
  if ( item10 == null || item10.equals("null") )
	  item10 = "";
  String content10 = ( String )req.getParameter( "mcontent10", "" );
  if ( content10 == null || content10.equals("null") )
	  content10 = ""; 
  String iscurrent = ( String )req.getParameter( "iscurrent", "" );
  
  int fsort = 0;
  String fsort1 = ( String )req.getParameter( "fsort", "" );
  if ( fsort1 != null && !fsort1.equals("") )
	  fsort = Integer.parseInt(fsort1);

  obj.setPubunitdn(ary_punit[0]);
  obj.setPubunitname(ary_punit[1]);
  obj.setName(name);
  obj.setProftitle(proftitle);
  obj.setItem1(item1);
  obj.setContent1(content1);
  obj.setItem2(item2);
  obj.setContent2(content2);
  obj.setItem3(item3);
  obj.setContent3(content3);
  obj.setItem4(item4);
  obj.setContent4(content4);
  obj.setItem5(item5);
  obj.setContent5(content5);
  obj.setItem6(item6);
  obj.setContent6(content6);
  obj.setItem7(item7);
  obj.setContent7(content7);
  obj.setItem8(item8);
  obj.setContent8(content8);
  obj.setItem9(item9);
  obj.setContent9(content9);
  obj.setItem10(item10);
  obj.setContent10(content10);
  obj.setIscurrent(iscurrent);
  obj.setFsort(fsort);
  obj.setPostname(logincn);
  obj.setClientfile1(mclient);
  obj.setServerfile1(mserver);
  obj.setExpfile1(exp);

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

<form name="mform" action="manager101_add.jsp" method="post">
  <input type="hidden" name="path" value="<%=path%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>
