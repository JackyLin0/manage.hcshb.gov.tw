<%@page import="java.util.ArrayList"%>
<%@page import="tw.com.sysview.upload.UploadData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：bulletin101_mdysave.jsp
說明：最新消息維護(可發布至縣府入口網的一般公告)
開發者：chmei
開發日期：97.02.17
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
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
  String startusing = ( String )request.getParameter( "startusing" );
  String endate = ( String )request.getParameter( "endate" );
  if ( startusing.equals("1") ) {
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	  Calendar specialDate = Calendar.getInstance();
	  specialDate.setTime(sdf.parse(stdate));
	  specialDate.add(Calendar.YEAR, 1);
	  endate = sdf.format(specialDate.getTime());
  }
	
  String subject = ( String )request.getParameter( "subject" );
  String secsubject = ( String )request.getParameter( "secsubject" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );  
  String pubunitname = ( String )request.getParameter( "pubunitname" ); 
  String content = ( String )request.getParameter( "content" );
  String relateurl = ( String )request.getParameter( "relateurl" );
  String relatename = ( String )request.getParameter( "relatename" );
  String mfsort = ( String )request.getParameter( "fsort" );
  int fsort = 2;
  if ( !mfsort.equals("") && mfsort != null && !mfsort.equals("null") )
	  fsort = Integer.parseInt(mfsort);
  String liaisonper = ( String )request.getParameter( "liaisonper" );
  String liaisontel = ( String )request.getParameter( "liaisontel" );
  String liaisonemail = ( String )request.getParameter( "liaisonemail" );
  String modflag = ( String )request.getParameter( "modflag" );
  String noteflag = ( String )request.getParameter( "noteflag" );
  String newsflag = ( String )request.getParameter( "newsflag" );
  
  String aptable = ( String )request.getParameter( "aptable" );
  String[] ary_aptable = SvString.split(aptable,"||");
  String aplistdn = ( String )request.getParameter( "webdn" );
  
  //多站台資料
  String webrcount = ( String )request.getParameter( "webrcount" );
  int mcount = 0;
  if ( !webrcount.equals("") )
	  mcount = Integer.parseInt(webrcount);
  
  String website = "";
  String classdata = "";
  for ( int i=0; i<mcount; i++ ) {
	  String mweb = ( String )request.getParameter( "websitedn"+i );
	  String mclass = ( String )request.getParameter( "webclass"+i );
	  if (  (mweb != null) && !mweb.equals("null") && !mweb.equals("") ) {
		  if ( website.equals("") ) {
			  website = mweb;
			  classdata = mclass;
		  }else{
			  website = website + "&" + mweb;
			  classdata = classdata + "&" +mclass;
		  }
	  }	  
  }

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  BulletinData obj = new BulletinData();
  
  boolean rtn = true ;
  String errMsg="0";     

  obj.setSerno(serno);
  obj.setPosterdate(stdate);
  obj.setPostertime(postertime);
  obj.setStartusing(startusing);  
  obj.setClosedate(endate); 
  obj.setSecsubject(secsubject);
  obj.setContent(content);
  obj.setRelateurl(relateurl);
  obj.setRelatename(relatename);
  obj.setFsort(fsort);
  obj.setLiaisonper(liaisonper);
  obj.setLiaisontel(liaisontel);
  obj.setLiaisonemail(liaisonemail);
  obj.setAptable(aptable);
  obj.setExamtable(table1);
  obj.setAplistdn(aplistdn);
  obj.setWebsitedata(website);
  obj.setWebclassdata(classdata);
  obj.setModflag(modflag);
  obj.setNoteflag(noteflag);
  obj.setNewsflag(newsflag);
  obj.setOlddocpath("/webapps/downfile/doc/pubhcshb/bulletin");
  obj.setNewdocpath("/webapps/downfile/doc/pubhcshb/bulletinsend");
  obj.setOldpicpath("/webapps/downfile/pic/pubhcshb/bulletin");
  obj.setNewpicpath("/webapps/downfile/pic/pubhcshb/bulletinsend");

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(subject);             //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(ary_aptable[1]);    //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("U");                  //狀態
  
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");
  
  //執行動作(修改資料)  
  rtn = obj.storesend(sysRoot);    
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
	  String metaserno = serno;
	  String theme = ( String )request.getParameter( "theme" );
	  String cake = ( String )request.getParameter( "cake" );
	  String service = ( String )request.getParameter( "service" );
	  
	  MetaTagData objmdy = new MetaTagData();
	  objmdy.setSerno(metaserno);
	  objmdy.setThemeclass(theme);
	  objmdy.setCakeclass(cake);
	  objmdy.setServiceclass(service);
	  objmdy.store(table2);
      
      //附件轉檔
      UploadData uploadData = new UploadData();
      ArrayList qfiles = uploadData.findByday("BulletinFile", serno, "doc");
	  String mserver = "";
	  String mclient = "";
	  String msmallimg = "";
	  String exp = "";
	  if(uploadData.getAllrecordCount() > 0){
    	  for (int i = 0; i < uploadData.getAllrecordCount(); i++) {
    		  UploadData qfile = ( UploadData )qfiles.get( i );
        
    		  if(mserver.equals(""))
    			  mserver = qfile.getServerfile();
    		  else
    			  mserver = mserver + "||" + qfile.getServerfile();
    		  
    		  if(mclient.equals(""))
    			  mclient = qfile.getClientfile();
    		  else
    			  mclient = mclient + "||" + qfile.getClientfile();
    		  
    		  if(exp.equals(""))
    			  exp = qfile.getExpfile();
    		  else 
    			  exp = exp + "||" + qfile.getExpfile();
          }
       
    	  UploadData transDoc = new UploadData();
    	  transDoc.setSerno(obj.getSerno());
    	  transDoc.setFlag("doc");
    	  transDoc.setPostname(logincn);
    	  transDoc.setClientfile(mclient);
    	  transDoc.setServerfile(mserver);
    	  transDoc.setExpfile(exp);
    
          transDoc.create("BulletinsendFile");
	  }
      
      //圖片轉檔
      UploadData picuploadData = new UploadData();
      ArrayList qpics = picuploadData.findByday("BulletinFile", serno, "pic");
	  mserver = "";
	  mclient = "";
	  msmallimg = "";
	  exp = "";
      if(picuploadData.getAllrecordCount() > 0){
    	  for (int i = 0; i < picuploadData.getAllrecordCount(); i++) {
    		  UploadData qpic = ( UploadData )qpics.get( i );
        
    		  if(mserver.equals(""))
    			  mserver = qpic.getServerfile();
    		  else
    			  mserver = mserver + "||" + qpic.getServerfile();
    		  
    		  if(mclient.equals(""))
    			  mclient = qpic.getClientfile();
    		  else
    			  mclient = mclient + "||" + qpic.getClientfile();
    		  
    		  if(exp.equals(""))
    			  exp = qpic.getExpfile();
    		  else 
    			  exp = exp + "||" + qpic.getExpfile();
    		  
    		  if(msmallimg.equals(""))
    			  msmallimg = qpic.getImagemagick();
    		  else
    			  msmallimg = msmallimg + "||" + qpic.getImagemagick();
    	  }
    	  showAlert =mserver;
    	  UploadData transPic = new UploadData();
          transPic.setSerno(obj.getSerno());
          transPic.setFlag("pic");
          transPic.setPostname(logincn);
          transPic.setClientfile(mclient);
          transPic.setServerfile(mserver);
          transPic.setExpfile(exp);
          transPic.setImagemagick(msmallimg);
          transPic.create("BulletinsendFile");
      }
      
      
  }

 %>
<form name="mform" action="bulletin101.jsp" method="post">
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
  
