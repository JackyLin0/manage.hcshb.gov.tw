<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：epaperedit101_continue_mdysave.jsp
說明：電子報派送編輯
開發者：chmei
開發日期：97.03.20
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數  
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());

  //form值
  String serno = ( String )request.getParameter( "serno" );
  String periodical = ( String )request.getParameter( "periodical" );
  String epaperimg = ( String )request.getParameter( "epaperimg" );	
  int rcount = Integer.parseInt(( String )request.getParameter( "rcount" ));  
  String msenddate = ( String )request.getParameter( "senddate" );
  String senddate = ndate;
  if ( msenddate.equals("0") )
	  senddate = ( String )request.getParameter( "endate" );
  
  String allclassname = "";
  String allcontent = "";
  String allstartdate = "";
  String allenddate = "";
  for ( int i=0; i<rcount; i++ ) {
	  String classname = ( String )request.getParameter( "classname"+i );
	  String mcontent = ( String )request.getParameter( "mcontent"+i );
	  if ( mcontent == null || mcontent.equals("null") ) {
		  String[] temp_classname = SvString.split(classname,"||");
		  if ( temp_classname[1].equals("訊息快遞") ) {
			  String qptdate = ( String )request.getParameter( "qptdate" );
			  String qdldate = ( String )request.getParameter( "qdldate" );
			  if ( allclassname.equals("") ) {
				  allclassname = classname;
				  allcontent = "a";
				  allstartdate = qptdate;
				  allenddate = qdldate;
			  }else{
				  allclassname = allclassname + "&" + classname;
				  allcontent = allcontent + "&a";
				  allstartdate = allstartdate + "&" + qptdate;
				  allenddate = allenddate + "&" + qdldate;
			  }
		  }
	  }else{
		  if ( allclassname.equals("") ) {
			  allclassname = classname;
			  allcontent = mcontent;
			  allstartdate = "a";
			  allenddate = "a";
		  }else{
			  allclassname = allclassname + "&" + classname;
			  allcontent = allcontent + "&" + mcontent;
			  allstartdate = allstartdate + "&a";
			  allenddate = allenddate + "&a";
		  }
	  }
  }  
  
  String oldeserno = ( String )request.getParameter( "oldeserno" );
  String oldtablename = ( String )request.getParameter( "oldtablename" );
  
  EpaperEditData obj = new EpaperEditData();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setSerno(serno);
  obj.setPeriodical(periodical);
  obj.setImgserno(epaperimg);
  obj.setAllstartdate(allstartdate);
  obj.setAllenddate(allenddate);
  obj.setSenddate(senddate);
  obj.setAllclassname(allclassname);
  obj.setAllcontent(allcontent);
  obj.setOldeserno(oldeserno);
  obj.setOldtablename(oldtablename);

  //執行動作(新增資料)  
  rtn = obj.storedetail();  
    
  String showAlert = null; 
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "電子報編輯失敗！" + errMsg;
  }else{
	  showAlert="電子報編輯成功，您可以點選預覽電子報！";
  }

 %>

<form name="mform" action="epaperedit101.jsp" method="post">
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
