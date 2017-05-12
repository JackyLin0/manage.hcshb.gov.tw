<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities102_addsave.jsp
說明：線上報名表欄位編輯
開發者：chmei
開發日期：97.12.03
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數
  String title = ( String )request.getParameter( "title" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String msubject = ( String )request.getParameter( "msubject" );
  String[] chk = request.getParameterValues("check");
  String sorcefield = "200812030001||200812030002||200812030003";
  String sorceserial = "1||2||3";
  String sorceisneed = "Y||Y||Y";
  if ( chk != null ) {
	  for ( int i=0; i<chk.length; i++ ) {
		  sorcefield = sorcefield + "||" + chk[i];
		  String serial1 = ( String )request.getParameter( "serial" + chk[i] );
		  sorceserial = sorceserial + "||" + serial1;
		  String isneed1 = ( String )request.getParameter( "isneed" + chk[i] );
		  if ( isneed1 == null || isneed1.equals("null") || isneed1.equals("") )
			  sorceisneed = sorceisneed + "||N";
		  else
			  sorceisneed = sorceisneed + "||Y";
	  }
  }
  
  String num = ( String )request.getParameter( "fieldnum" );
  if ( num == null || num.equals("null") || num.equals("") )
	  num = "0";
  String misneed = "";
  String mfieldname = "";
  String mattribute = "";
  String mfieldvalue = "";
  String mlength = "";
  String mserial = "";
  if ( !num.equals("0") ) {
	  for ( int j=0; j<Integer.parseInt(num); j++ ) {
		  String isneed = ( String )request.getParameter( "isneed" + (j+1) );
		  if ( misneed.equals("") ) {
			  if ( isneed == null || isneed.equals("null") )
				  misneed = "N";
			  else
				  misneed = "Y";
		  }else{
			  if ( isneed == null || isneed.equals("null") )
				  misneed = misneed + "||N";
			  else
				  misneed = misneed + "||Y";
		  }
		  String fieldname = ( String )request.getParameter( "fieldname" + (j+1) );
		  if ( mfieldname.equals("") )
			  mfieldname = fieldname;
		  else
			  mfieldname = mfieldname + "||" + fieldname;
		  String attribute = ( String )request.getParameter( "attribute" + (j+1) );
		  if ( mattribute.equals("") )
			  mattribute = attribute;
		  else
			  mattribute = mattribute + "||" + attribute;
		  String fieldvalue = ( String )request.getParameter( "fieldvalue" + (j+1) );
		  if ( mfieldvalue.equals("") ) {
			  if ( fieldvalue == null || fieldvalue.equals("null") || fieldvalue.equals("") )
				  mfieldvalue = "a";
			  else
				  mfieldvalue = fieldvalue;
		  }else{
			  if ( fieldvalue == null || fieldvalue.equals("null") || fieldvalue.equals("") )
				  mfieldvalue = mfieldvalue + "||" + "a";
			  else
				  mfieldvalue = mfieldvalue + "||" + fieldvalue;
		  }
		
		  String length = ( String )request.getParameter( "length" + (j+1) );
		  if ( mlength.equals("") ) {
			  if ( length == null || length.equals("null") || length.equals("") )
				  mlength = "200";
			  else
				  mlength = length;
		  }else{
			  if ( length == null || length.equals("null") || length.equals("") )
				  mlength = mlength + "||200";
			  else
				  mlength = mlength + "||" + length;
		  }
		  String serial = ( String )request.getParameter( "serial" + (j+1) );
		  if ( mserial.equals("") )
			  mserial = serial;
		  else
			  mserial = mserial + "||" + serial;		  
	  }
  }
  
  ActivityColumnData obj = new ActivityColumnData();  
  
  boolean rtn = true ;
  String errMsg="0";     
  
  obj.setFieldnum(Integer.parseInt(num));
  obj.setActivityserno(msubject);
  obj.setSorcefield(sorcefield);
  obj.setSorceserial(sorceserial);
  obj.setSorceisneed(sorceisneed);
  obj.setMisneed(misneed);
  obj.setMfieldname(mfieldname);
  obj.setMattribute(mattribute);
  obj.setMfieldvalue(mfieldvalue);  
  obj.setMlength(mlength);
  obj.setMserial(mserial);
  obj.setPostname(logincn);
  
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

  <form name="mform" action="activities102.jsp" method="post">
     <input type="hidden" name="title" value="<%=title%>"/>
     <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
     <input type="hidden" name="intpage" value="<%=intpage%>"/>
     <input type="hidden" name="murl" value="<%=murl%>"/>
     <input type="hidden" name="language" value="<%=language%>"/>
     <input type="hidden" name="flag"/>
  </form>
  
  <script>
     alert("<%=showAlert%>");
     document.mform.submit();
  </script>

