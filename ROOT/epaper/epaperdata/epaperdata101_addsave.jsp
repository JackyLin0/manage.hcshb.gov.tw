<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaper101_addsave.jsp
說明：電子報資料維護
開發者：chmei
開發日期：97.03.01
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數  
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String subject = ( String )request.getParameter( "subject" );
  String punit = ( String )request.getParameter( "punit" );  
  String[] ary_punit = SvString.split(punit,"||");
  String mclass = ( String )request.getParameter( "mclass" );  
  String[] ary_class = SvString.split(mclass,"-");
  
  String author = ( String )request.getParameter( "author" );
  String publisher = ( String)request.getParameter( "publisher" );
  String examiner = ( String )request.getParameter( "examiner" );
  String mfsort = ( String )request.getParameter( "fsort" );
  int fsort = 2;
  if ( !mfsort.equals("") && mfsort != null && !mfsort.equals("null") )
	  fsort = Integer.parseInt(mfsort);
  
  //項目
  String allcontent = "";
  int num = Integer.parseInt(( String )request.getParameter( "rec" ));
  if ( num == 1 ) { %>
	  <script>
	     alert("您未輸入任何項目！");
	     history.go(-1);
	  </script>
  <%}else{	  
	  for ( int i=0; i<num-1; i++ ) {
		  String mcontent = ( String )request.getParameter( "content" + (i+1) );	
		  if ( mcontent != null && !mcontent.equals("null") && !mcontent.equals("") ) {
			  if ( allcontent.equals("") )
				  allcontent = mcontent;
			  else
				  allcontent = allcontent + "||" + mcontent;
		  }
	  }
  }

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  EpaperData obj = new EpaperData();

  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setMserno(ary_class[0]);
  obj.setMclassname(ary_class[1]);
  obj.setFsort(fsort);
  obj.setAuthor(author);
  obj.setPublisher(publisher);
  obj.setExaminer(examiner);
  obj.setContent(allcontent);

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
	  showAlert="新增成功！";
  }

 %>

<form name="mform" action="epaperdata101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
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
  
