<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：information101_mdysave.jsp
說明：衛生資訊
開發者：chmei
開發日期：97.02.22
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //接收查詢條件
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qclass = ( String )request.getParameter( "qclass" );
  
  //參數
  String table = ( String )request.getParameter( "t" );
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String murl = ( String )request.getParameter( "murl" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String serno = ( String )request.getParameter( "serno" );
  String stdate = ( String )request.getParameter( "stdate" );
  String startusing = ( String )request.getParameter( "startusing" );
  String endate = ( String )request.getParameter( "endate" );
  if ( startusing.equals("1") )
	  endate = "";
  String pubunitdn = ( String )request.getParameter( "punit" );  
  String pubunitname = ( String )request.getParameter( "pubunitname" ); 
  String mclass = ( String )request.getParameter( "mclass" );  
  String[] ary_class = SvString.split(mclass,"-");
  
  String relateurl = ( String )request.getParameter( "relateurl" );  
  String relatename = ( String )request.getParameter( "relatename" );
  String mfsort = ( String )request.getParameter( "fsort" );
  int fsort = 2;
  if ( !mfsort.equals("") && mfsort != null && !mfsort.equals("null") )
	  fsort = Integer.parseInt(mfsort);
  
  //項目
  String allitem = "";
  String allcontent = "";
  int num = Integer.parseInt(( String )request.getParameter( "rec" ));
  
  if ( num == 1 ) { %>
	  <script>
	     alert("您未輸入任何項目！");
	     history.go(-1);
	  </script>
  <%}else{	  
	  for ( int i=0; i<num-1; i++ ) {
		  String mitem = ( String )request.getParameter( "item" + (i+1) );
		  String mcontent = ( String )request.getParameter( "content" + (i+1) );	
		  if ( mitem != null && !mitem.equals("null") && !mitem.equals("") ) {
			  if ( allitem.equals("") ) 
				  allitem = mitem;
			  else
				  allitem = allitem + "||" + mitem;
			  if ( mcontent != null && !mcontent.equals("null") && !mcontent.equals("") ) {
				  if ( allcontent.equals("") )
					  allcontent = mcontent;
				  else
					  allcontent = allcontent + "||" + mcontent;
			  }else{
				  if ( allcontent.equals("") )
					  allcontent = "a";
				  else
					  allcontent = allcontent + "||" + "a";
			  }
		  }
	  }
  }

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  InformationData970425 obj = new InformationData970425();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setPosterdate(stdate);
  obj.setMserno(ary_class[0]);
  obj.setMclassname(ary_class[1]);
  obj.setStartusing(startusing);
  obj.setClosedate(endate); 
  obj.setRelateurl(relateurl);
  obj.setRelatename(relatename);
  obj.setFsort(fsort);
  obj.setItem(allitem);
  obj.setContent(allcontent);

  //網站維運統計共用參數(WebSiteLog)
  obj.setSerno(serno);                 //序號
  obj.setPubunitdn(pubunitdn);         //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(ary_class[1]);        //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
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

<form name="mform" action="information101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qclass" value="<%=qclass%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
