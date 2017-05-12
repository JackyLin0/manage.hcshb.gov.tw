<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：menu.jsp
說明：選單目錄管理
開發者：chmei
開發日期：97.02.18
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import="sysview.zhiren.servlet.mime.SvMultipartRequest" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //取檔案上傳路徑，位於各局室content folder 之下
  String webdn1 = ( String )session.getAttribute("webdn");
  String[] ary_webdn = SvString.split(webdn1,",");
  String org = SvString.right(ary_webdn[2],"=");
  
  //取設定檔路徑
  String sysRoot = (String) getServletConfig().getServletContext().getRealPath("");

  //判斷OS版本
  String Siiemap_PATH = "";
  String Menu_PATH = "";
  if ( sysRoot.indexOf("/") == -1 ) {
	  Siiemap_PATH = sysRoot + "\\WEB-INF\\updatesitemap.properties";
	  Menu_PATH = sysRoot + "\\WEB-INF\\menu.properties";
  }else{
	  Siiemap_PATH = sysRoot + "/WEB-INF/updatesitemap.properties";
	  Menu_PATH = sysRoot + "/WEB-INF/menu.properties";
  }

  Properties sitemap = new Properties();
  sitemap.load(new FileInputStream(Siiemap_PATH) );
  String sitemappath = sitemap.getProperty("updatepath");
  
  Properties mess = new Properties();
  mess.load(new FileInputStream(Menu_PATH) );
  String menupath = mess.getProperty("menupath");    

  String mflag = ( String )request.getParameter( "mflag" );
  String oldflag = ( String )request.getParameter( "oldflag" );
  
  String filepath = menupath + "/" + org + "/";
  if ( mflag.equals("1") ) {
	  filepath = filepath + "ap";
  }if ( mflag.equals("3") ) {
	  filepath = filepath + "content";
  }
 
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
     response.sendRedirect("menu.jsp");
     return;
  }

  MenuData obj = new MenuData();  
  
  //動態程式及自行編輯網頁
  File[] reqfile = req.getFiles();  
  //取得上傳檔案的個數 
  int num = reqfile.length;    
  
  //宣告陣列
  String filename[] = new String[1];  
  String originfile[] = new String[1];
  String linkfile = "";
  for (int i=0; i<num; i++)
  {
	  filename[i] = reqfile[i].getName();
	  originfile[i] = req.getOriginFile(filename[i]);
	  if ( i==0 ) {
		  obj.setServerfile1(filename[i]);
		  obj.setClientfile1(originfile[i]);
		  linkfile = filename[i];
	  }
  }    

  //屬性與原本不相同
  if ( !mflag.equals(oldflag) ) {
	  //刪除原本檔案
	  if ( oldflag.equals("0") ) {
		  String oldislevellink = ( String )req.getParameter( "oldislevellink","" );
		  String[] ary_old = SvString.split(oldislevellink,"/");
		  String delpath = menupath + "/" + ary_old[0] + "/" + ary_old[1];
		  File d0 = new File(delpath,ary_old[2]);               
		  if (d0.exists())
			  d0.delete(); 
	  }else if ( oldflag.equals("1") ) {
		  String osfile1 = ( String )req.getParameter( "osfile1","" );
		  String delpath = menupath + "/" + org + "/ap";
		  File d1 = new File(delpath,osfile1);               
		  if (d1.exists())
			  d1.delete();
	  }else if ( oldflag.equals("3") ) {
		  String osfile2 = ( String )req.getParameter( "osfile2","" );
		  String delpath = menupath + "/" + org + "/ap";
		  File d3 = new File(delpath,osfile2);               
		  if (d3.exists())
			  d3.delete();
	  }	  
  }else if ( mflag.equals(oldflag) ) {
	  if ( mflag.equals("1") ) {
		  String nsfile1 = ( String )req.getParameter( "nsfile1","" );
		  //表示無更新檔案
		  if ( nsfile1.equals("") ) {
			  String osfile1 = ( String )req.getParameter( "osfile1","" );
			  String orfile1 = ( String )req.getParameter( "orfile1","" );
			  obj.setServerfile1(osfile1);
			  obj.setClientfile1(orfile1);
			  linkfile = osfile1;
		  }			  
	  }else if ( mflag.equals("3") ) {
		  String nsfile2 = ( String )req.getParameter( "nsfile2","" );
		  //表示無更新檔案
		  if ( nsfile2.equals("") ) {
			  String osfile2 = ( String )req.getParameter( "osfile2","" );
			  String orfile2 = ( String )req.getParameter( "orfile2","" );
			  obj.setServerfile1(osfile2);
			  obj.setClientfile1(orfile2);
			  linkfile = osfile2;
		  }			  
	  }
  }
  //接受查詢條件
  String islevelcontent = ( String )req.getParameter( "islevelcontent", "" );
  
  //參數
  String table = ( String )req.getParameter( "t", "" );
  String logindn = ( String )req.getParameter( "logindn", "" );
  String pagesize = ( String )req.getParameter( "pagesize", "" );
  String language = ( String )req.getParameter( "language", "" );
  String murl = ( String )req.getParameter( "murl", "");
  String title = ( String )req.getParameter( "title", "" );
  
  String logincn = ( String )session.getAttribute("logincn");
  
  //form值
  int islevel = Integer.parseInt(( String )req.getParameter( "islevel", "" ));
  String mislevelcontent = ( String )req.getParameter( "mislevelcontent", "" );
  String mserno = ( String )req.getParameter( "toplevel", "" );

  String startusing = ( String )req.getParameter( "startusing", "" );
  String showlink = ( String )req.getParameter( "showlink", "" );
  if ( islevel == 1 )
	  showlink = "0";
  int fsort = 0;
  String fsort1 = ( String )req.getParameter( "fsort", "" );
  if ( fsort1 != null && !fsort1.equals("") )
	  fsort = Integer.parseInt(fsort1);
  String mtarget = ( String )req.getParameter( "mtarget", "" );
  String serno = ( String )req.getParameter( "serno", "" );
  //MetaTag
  String theme = (String)req.getParameter( "theme", "");
  String cake = (String)req.getParameter( "cake", "");
  String service = (String)req.getParameter( "service", "");

  //使用網頁版型
  String islevellink1 = ( String )req.getParameter( "islevellink1", "" );
   
  //超連結
  String islevellink2 = ( String )req.getParameter( "islevellink2", "" );
  
  boolean rtn = true ;
  String errMsg="0";     

  if ( mflag.equals("0") ) {                     //使用網頁版型
	  obj.setIslevellink(islevellink1);
  }else if ( mflag.equals("1") || mflag.equals("3") ) {     //動態網頁及自行編輯網頁
	  String mlink = org + "/" + SvString.lastRight(filepath, "/") + "/" + linkfile;
	  obj.setIslevellink(mlink);
  }else if ( mflag.equals("2") ) {               //超連結
	  obj.setIslevellink(islevellink2);
  }  
  
  obj.setSerno(serno);
  obj.setIslevel(islevel);
  obj.setIslevelcontent(mislevelcontent);
  obj.setFlag(mflag);
  obj.setTarget(mtarget);
  obj.setTopserno(mserno);
  obj.setStartusing(startusing);
  obj.setFsort(fsort);
  obj.setShowlink(showlink);
  obj.setPostname(logincn);
  obj.setThemeclass(theme);
  obj.setCakeclass(cake);
  obj.setServiceclass(service);

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

<form name="mform" action="menu.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="islevelcontent" value="<%=islevelcontent%>"/>
</form>
 
<script>
   newwin=window.open('../../updatesitemap/updatesitemap.jsp?menudata=<%=table%>','','width=10,height=10,scrollbars=yes,left=10000,top=10000');
   window.newwin.close();
   newwin=window.open('<%=sitemappath%>/updatesitemap/updatesitemap.jsp?menudata=<%=table%>','','width=10,height=10,scrollbars=yes,left=10000,top=10000');
   window.newwin.close();
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
 