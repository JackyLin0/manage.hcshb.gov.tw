<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities102_view.jsp
說明：線上報名表欄位預覽
開發者：chmei
開發日期：97.12.04
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<% try { %>
<%
  String dataserno = ( String )request.getParameter( "serno" );

  //找活動標題
  ActivitiesData qsubject = new ActivitiesData();
  boolean srtn = qsubject.load("Activities",dataserno);
  String msubject = "";
  if ( srtn )
	  msubject = qsubject.getSubject();

  //尋找報名表欄位
  ActivityViewData qdata = new ActivityViewData();
  ArrayList qlists = qdata.findByrecord(dataserno);
  int rcount = qdata.getAllrecordCount();

%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td align="left" valign="middle" width="10%"><img src="../../img/sign_img.jpg" width="71" height="52"/></td>
        <td align="left" valign="middle" class="main_title80">&nbsp;<%=msubject%>&nbsp;&nbsp;線上報名</td>
      </tr>
    </table>
    <br/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td class="main_title80">有【<font color="red">＊</font>】欄位，請務必填寫</td>
      </tr>
      <tr>
        <td align="center" valign="middle">
          <table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="dfdbcb">
            <%
              String fieldserno = "";
              String mfieldname = "";
              String mattribute = "";
              String misneed = "";
              String mfieldvalue = "";
              if ( qlists != null ) {
              	for ( int i=0; i<rcount; i++ ) {
              		ActivityViewData qlist = ( ActivityViewData )qlists.get( i );
              		if ( misneed.equals("") )
              			misneed = qlist.getIsneed();
              		else
              			misneed = misneed + "-" + qlist.getIsneed();
              		String mstyle = "";
              		if ( qlist.getIsneed().equals("Y") )
              			mstyle = "<font color='red'>＊</font>";
              		//尋找此欄位相關資訊
              		ActivityViewData qdata1 = new ActivityViewData();
              		boolean crtn = qdata1.load(qlist.getFieldserno());
              		String fieldname = "";
              		if ( crtn ) {
              			fieldname = qdata1.getFieldname();
              			if ( mattribute.equals("") ) {
              				fieldserno = qdata1.getSerno();
              				mfieldname = qdata1.getFieldname();
                  			mattribute = qdata1.getAttribute();
                  			mfieldvalue = qdata1.getFieldvalue();
              			}else{
              				fieldserno = fieldserno + "-" + qdata1.getSerno();
              				mfieldname = mfieldname + "-" + qdata1.getFieldname();
              				mattribute = mattribute + "-" + qdata1.getAttribute();
              				mfieldvalue = mfieldvalue + "-" + qdata1.getFieldvalue();
              			}
              		} %>
              		<tr>
  		              <td width="30%" align="right" class="main_title80" bgcolor="#FFFBDF"><%=mstyle%><%=fieldname%>：</td>
  		              <td width="70%" align="left" class="main_font80" bgcolor="#FFFFFF">
  		                <%
  		                  if ( qdata1.getSerno().equals("200812030001") ) { %>
  		                	 <input type="text" name="name" size="10" value="請輸入<%=fieldname%>" onFocus="javascript: if (this.value=='請輸入<%=fieldname%>') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入<%=fieldname%>';" /> 
  		                  <%}else if ( qdata1.getSerno().equals("200812030002") ) { %>
  		                	  西元<input type="text" name="byy" size="5" maxlength="4" value="請輸入生日西元年" onFocus="javascript: if (this.value=='請輸入生日西元年') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入生日西元年';" onclick="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" onkeypress="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />&nbsp;年
  		                	 <select name="bmm">
  		                	   <%
  		                	     for ( int m=1; m<=12; m++ ) { %>
  		                	    	 <option value="<%=SvNumber.format( m, "00" )%>"><%=SvNumber.format( m, "00" )%></option>
  		                	     <%}%>
  		                	 </select>&nbsp;月
  		                	 <select name="bdd">
  		                	   <%
  		                	     for ( int d=1; d<=31; d++ ) {  %>
  		                	    	 <option value="<%=SvNumber.format( d, "00" )%>"><%=SvNumber.format( d, "00" )%></option>
  		                	     <%}%>
  		                	 </select>&nbsp;日
  		                  <%}else if ( qdata1.getSerno().equals("200812030003") ) {%>
  		                     <input type="text" name="email" size="10" value="請輸入<%=fieldname%>" onFocus="javascript: if (this.value=='請輸入<%=fieldname%>') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入<%=fieldname%>';" />
  		                  <%}else if ( qdata1.getAttribute().equals("text") ) { 
  		                	  int msize = Integer.parseInt(qdata1.getFieldlength())/2 + 5;
  		                	  if ( Integer.parseInt(qdata1.getFieldlength()) > 80 )
  		                		  msize = 40; %>
  		                	  <input type="text" name="text<%=i%>" size="<%=msize%>" value="請輸入<%=fieldname%>" onFocus="javascript: if (this.value=='請輸入<%=fieldname%>') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入<%=fieldname%>';" />
  		                  <%}else if ( qdata1.getAttribute().equals("textarea") ) { %>
  		                	  <textarea name="textarea<%=i%>" cols="35" rows="4"></textarea>
  		                  <%}else if ( qdata1.getAttribute().equals("radio") ) { 
  		                	  String[] ary_radio = SvString.split(qdata1.getFieldvalue(),"、");
  		                	  for ( int r=0; r<ary_radio.length; r++ ) { %>
  		                		  <input type="radio" name="radio<%=i%>" value="<%=ary_radio[r]%>"><%=ary_radio[r]%>&nbsp;&nbsp;
  		                	  <%}
  		                  }else if ( qdata1.getAttribute().equals("checkbox") ) {
  		                	  String[] ary_check = SvString.split(qdata1.getFieldvalue(),"、");
  		                	  for ( int c=0; c<ary_check.length; c++ ) { %>
  		                		  <input type="checkbox" name="checkbox<%=i%>" value="<%=ary_check[c]%>"><%=ary_check[c]%><br/>
  		                	  <%}
  		                  }%>
  		              </td>
  		            </tr>
              	<%}
              }%>
            
          </table>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td align="center" class="title05">
          <input type="button" value="送出" onclick="javascript:send('<%=mattribute%>','<%=misneed%>','<%=mfieldname%>','<%=mfieldvalue%>','<%=fieldserno%>')" onkeypress="javascript:send('<%=mattribute%>','<%=misneed%>','<%=mfieldname%>','<%=mfieldvalue%>','<%=fieldserno%>')">&nbsp;&nbsp;
          <input type="button" value="重填" onclick="javascript:document.memberform.reset()" onkeypress="javascript:document.memberform.reset()">
        </td>
      </tr> 
    </table>

<% } catch(Exception Error) {
	out.print(Error.toString());
} %>
  