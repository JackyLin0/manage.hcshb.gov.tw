<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：infor101_save.jsp
說明：聯絡資訊
開發者：chmei
開發日期：97.02.21
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>

<%
  //參數
  String title = ( String )request.getParameter( "title" );
  String logindn = ( String )request.getParameter( "logindn" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String pubunitname = ( String )request.getParameter( "pubunitname" );
  String language = ( String )request.getParameter( "language" );
  
  String murl = ( String )request.getParameter( "murl" );
  String logincn = ( String )session.getAttribute( "logincn" );
  
  int rcount = Integer.parseInt(( String )request.getParameter( "tot" ));
  
  String serno = "";
  String unitdn = "";
  String unitname = "";
  String tel = "";
  String extension = "";
  String fax = "";
  String email = "";
  String fsort = "";
  for ( int i=0; i<rcount; i++ ) {
	  String mserno = ( String )request.getParameter( "serno"+(i+1) );
	  String munitdn = ( String )request.getParameter( "unitdn"+(i+1) );
	  String munitname = ( String )request.getParameter( "unitname"+(i+1) );
	  String mtel = ( String )request.getParameter( "tel"+(i+1) );
	  String mextension = ( String )request.getParameter( "extension"+(i+1) );
	  String mfax = ( String )request.getParameter( "fax"+(i+1) );
	  String memail = ( String )request.getParameter( "email"+(i+1) );
	  String mfsort = ( String )request.getParameter( "fsort"+(i+1) );
	  
	  if ( !munitname.equals("") ) {
		  if ( !mserno.equals("") ) {
			  if ( serno.equals("") )
				  serno = mserno;
			  else
				  serno = serno + "||" + mserno;
		  }else{
			  if ( serno.equals("") )
				  serno = "a";
			  else
				  serno = serno + "||" + "a";
		  }
		  
		  if ( !munitdn.equals("") ) {
			  if ( unitdn.equals("") )
				  unitdn = munitdn;
			  else
				  unitdn = unitdn + "||" + munitdn;
		  }else{
			  if ( unitdn.equals("") )
				  unitdn = "a";
			  else
				  unitdn = unitdn + "||" + "a";
		  }
		  if ( !munitname.equals("") ) {
			  if ( unitname.equals("") )
				  unitname = munitname;
			  else
				  unitname = unitname + "||" + munitname;
		  }else{
			  if ( unitname.equals("") )
				  unitname = "a";
			  else
				  unitname = unitname + "||" + "a";
		  }
		  if ( !mtel.equals("") ) {
			  if ( tel.equals("") )
				  tel = mtel;
			  else
				  tel = tel + "||" + mtel;
		  }else{
			  if ( tel.equals("") )
				  tel = "a";
			  else
				  tel = tel + "||" + "a";
		  }
		  if ( !mextension.equals("") ) {
			  if ( extension.equals("") )
				  extension = mextension;
			  else
				  extension = extension + "||" + mextension;
		  }else{
			  if ( extension.equals("") )
				  extension = "a";
			  else
				  extension = extension + "||" + "a";
		  }
		  if ( !mfax.equals("") ) {
			  if ( fax.equals("") )
				  fax = mfax;
			  else
				  fax = fax + "||" + mfax;
		  }else{
			  if ( fax.equals("") )
				  fax = "a";
			  else
				  fax = fax + "||" + "a";
		  }
		  if ( !memail.equals("") ) {
			  if ( email.equals("") )
				  email = memail;
			  else
				  email = email + "||" + memail;
		  }else{
			  if ( email.equals("") )
				  email = "a";
			  else
				  email = email + "||" + "a";
		  }
		  if ( fsort.equals("") )
			  fsort = mfsort;
		  else
			  fsort = fsort + "||" + mfsort;
	  }
	  
  }

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  OrganizeData obj = new OrganizeData();  
  
  boolean rtn = true ;
  String errMsg="0";     

  obj.setMserno(serno);
  obj.setUnitdn(unitdn);
  obj.setUnitname1(unitname);  
  obj.setTel(tel);
  obj.setExtension(extension);
  obj.setFax(fax);
  obj.setEmail(email);
  obj.setMfsort(fsort);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(pubunitdn);         //發布單位DN(局)
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename("OrganLiaise");     //table名稱
  obj.setWebip(hostIP);                //登入者IP
  
  //執行動作(修改資料)   
  rtn = obj.storeinfor();    
    
  String showAlert = null;  
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "儲存失敗！" + errMsg;
  }else{
	  showAlert="儲存成功！";
  }

 %>

<form name="mform" action="infor101_list.jsp" method="post">
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="murl" value=<%=murl%>>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  

