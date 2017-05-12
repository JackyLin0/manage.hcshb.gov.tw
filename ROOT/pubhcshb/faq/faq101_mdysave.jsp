<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：faq101_mdy.jsp
說明：FAQ答客問
開發者：chmei
開發日期：97.02.17
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );

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
  String startusing = ( String )request.getParameter( "startusing" );
  String endate = ( String )request.getParameter( "endate" );
  if ( startusing.equals("1") )
	  endate = "";
  String subject = ( String )request.getParameter( "subject" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );  
  String pubunitname = ( String )request.getParameter( "pubunitname" ); 
  String content = ( String )request.getParameter( "content" );
  String mfsort = ( String )request.getParameter( "fsort" );
  int fsort = 2;
  if ( !mfsort.equals("") && mfsort != null && !mfsort.equals("null") )
	  fsort = Integer.parseInt(mfsort);
  String liaisonper = ( String )request.getParameter( "liaisonper" );
  String liaisontel = ( String )request.getParameter( "liaisontel" );
  String liaisonemail = ( String )request.getParameter( "liaisonemail" );
  
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
  
  FAQData obj = new FAQData();
  
  boolean rtn = true ;
  String errMsg="0";     

  obj.setSerno(serno);
  obj.setContent(content);
  obj.setStartusing(startusing);  
  obj.setClosedate(endate); 
  obj.setFsort(fsort);
  obj.setLiaisonper(liaisonper);
  obj.setLiaisontel(liaisontel);
  obj.setLiaisonemail(liaisonemail);
  obj.setAptable(aptable);
  obj.setExamtable(table1);
  obj.setAplistdn(aplistdn);
  obj.setWebsitedata(website);
  obj.setWebclassdata(classdata);

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

<form name="mform" action="faq101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="t1" value="<%=table1%>"/>
  <input type="hidden" name="t2" value="<%=table2%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
</form>
 
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
  
