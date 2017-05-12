<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities102_add.jsp
說明：線上報名表欄位編輯
開發者：chmei
開發日期：97.12.03
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }

  String role = ( String )session.getAttribute("role");
  if ( role != null && !role.equals("null") && !role.equals("") )
	  pubunitdn = "";
    
  String activityserno = ( String )request.getParameter( "activityserno" );
  if ( activityserno == null || activityserno.equals("null") )
	  activityserno = "";
  
  //尋找未新增報名表
  ActivityColumnData query = new ActivityColumnData();
  ArrayList qlists = query.findByday(pubunitdn);
  int rcount = query.getAllrecordCount();
  
  //尋找目前現有欄位
  ActivityColumnData qcolumn = new ActivityColumnData();
  ArrayList qfields = qcolumn.findByField("Y");
  int frcount = qcolumn.getAllrecordCount();

%>  

<script>
  function back()
  {
     document.mform.action="activities102.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
      
  function change(obj)
  {
     window.type.style.display = 'block';
     window.type1.style.display = 'block';
     for ( k=1; k<=10; k++) {
        str = "document.getElementById('table"+k+"')";
        str1 = "document.getElementById('enterline"+k+"')";
        if ( k <= obj.value ) {   
           eval(str).style.display = "";
           eval(str1).innerHTML = "<br>";
        }else{
           eval(str).style.display = "none";
           eval(str1).innerHTML = "";
        }
     }    	    	
  }

  function save(frcount)
  {
     if ( document.mform.msubject.value == '' ) {
        alert("【活動訊息標題】欄位，不可空白，請選擇！");
        document.mform.msubject.focus();
        return;
     }
     if ( document.mform.fieldnum.value != '' ) {
        var num1 = document.mform.fieldnum.value;
        for ( i=1; i<=num1; i++ ) {
           var thisform = "document.mform.fieldname" + i;
           var thisform1 = "document.mform.attribute" + i;
           var thisform2 = "document.mform.fieldvalue" + i;
           var thisform3 = "document.mform.length" + i;
           var thisform4 = "document.mform.serial" + i;
           var num = eval(frcount) + i;
           if ( eval(thisform).value == '' ) {
               alert("第"+num+"列之【欄位名稱】欄位，不可空白，請輸入！");
               eval(thisform).focus();
               return;
           }
           if ( eval(thisform1).value == '' ) {
              alert("第"+num+"列之【屬性】欄位，不可空白，請選擇！");
              eval(thisform1).focus();
              return;
           }
           if ( eval(thisform1).value == 'radio' || eval(thisform1).value == 'checkbox' ) {
              if ( eval(thisform2).value == '' ){
                 alert("第"+num+"列之【屬性】選擇單選或複選時，【欄位值】欄位，不可空白，請輸入！");
                 eval(thisform2).focus();
                 return;
              }
           }
           if ( eval(thisform1).value == 'text' || eval(thisform1).value == 'textarea' ) {
              if ( eval(thisform3).value == '' ) {
                 alert("第"+num+"列之【屬性】選擇單行文字或多行文字時，【長度】欄位，不可空白，請輸入！");
                 eval(thisform3).focus();
                 return;
              }
           }
           
           if ( eval(thisform4).value == '' ) {
              alert("第"+num+"列之【排序】欄位，不可空白，請輸入！");
              eval(thisform4).focus();
              return;
           }
        }
     }
     
     document.mform.action = "activities102_addsave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

<body>
<form name="mform">
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle" /><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save('<%=frcount%>')">儲存</a>	
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>

<br/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="30%" align="right">活動訊息標題：</td>
    <td align="left">　
      <select name="msubject">
        <option value="">請選擇欲新增報名表之活動</option>
        <%
          if ( qlists != null ) {
        	  for ( int i=0; i<rcount; i++ ) {
        		  ActivityColumnData qlist = ( ActivityColumnData )qlists.get( i );
        		  String isSelected = "";
        		  if ( qlist.getSerno().equals(activityserno) )
        			  isSelected = "selected"; %>
        		  <option value="<%=qlist.getSerno()%>" <%=isSelected%>><%=qlist.getSubject()%></option>
        	  <%}
          }%>
      </select>    
    </td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">  
  <tr align="center">
    <th width="3%">&nbsp;</th>
    <th width="5%">欄位選取</th>
    <th width="6%">必填</th>
    <th width="22%" align="left">欄位名稱</th>
    <th width="15%" align="center">屬性</th>
    <th width="22%">欄位值</th>
    <th width="15%">長度</th>
    <th width="12%">排序</th>
  </tr>
  <%
    if ( qfields != null ) {
    	for ( int f=0; f<frcount; f++ ) {
        	ActivityColumnData qfield = ( ActivityColumnData )qfields.get( f );
        	String mdisable = "";
        	if ( qfield.getSerno().equals("200812030001")|| qfield.getSerno().equals("200812030003") )
//         		 || qfield.getSerno().equals("200812030002") 
        		mdisable = " checked disabled";  %>
        	<tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
        	  <td align="center"><%=f+1%></td>
        	  <td align="center"><input type="checkbox" name="check" value="<%=qfield.getSerno()%>" <%=mdisable%>></td>
        	  <td align="center"><input type="checkbox" name="isneed<%=qfield.getSerno()%>" value="<%=qfield.getSerno()%>" <%=mdisable%>></td>
        	  <td align="left"><%=qfield.getFieldname()%></td>
        	  <%
        	    String matribute = "";
        	    if ( qfield.getAttribute().equals("text") )
        	    	matribute = "單行文字";
        	    else if ( qfield.getAttribute().equals("radio") )
        	    	matribute = "單選";
        	    else if ( qfield.getAttribute().equals("checked") )
        	    	matribute = "複選";
        	    else if ( qfield.getAttribute().equals("textarea") )
        	    	matribute = "多行文字";
        	  %>
        	  <td align="center"><%=matribute%></td>
        	  <%
        	    String mfieldvalue = "";
        	    if ( qfield.getFieldvalue() != null && !qfield.getFieldvalue().equals("null") )
        	    	mfieldvalue = qfield.getFieldvalue();
        	  %>
        	  <td align="left"><%=mfieldvalue%></td>
        	  <td align="center"><%=qfield.getFieldlength()%></td>
        	  <%
        	    String mreadonly = "";
        	    if ( qfield.getSerno().equals("200812030001") || qfield.getSerno().equals("200812030003") )
//         	    	|| qfield.getSerno().equals("200812030002") 
        	    	mreadonly = "readonly";
        	  %>
        	  <td align="center"><input type="text" size="2" name="serial<%=qfield.getSerno()%>" maxlength="2" value="<%=f+1%>" <%=mreadonly%> onclick="if ((event.keyCode < 51) || (event.keyCode > 57)) event.returnValue = false;" onkeypress="if ((event.keyCode < 51) || (event.keyCode > 57)) event.returnValue = false;" /></td>
        <%}
    }%>

  <tr>
    <th colspan="8" >&nbsp;</th>
  </tr>
</table>
<br/>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <td class="T12b" width="20%">新增欄位數</td>
    <td colspan="3">
      <select name="fieldnum" onchange="change(this)">
        <option value="">--- 請選擇 ---</option>
        <%
          for ( int n=0; n<10; n++ ) { %>
        	  <option value="<%=n+1%>"><%=n+1%></option>
          <%}%>
      </select>      
    </td>
  </tr>
</table>
<br/>

<table border="0" style="display:none" id="type1">
  <tr>
    <td><font size="2" color="red">※&nbsp;說明：<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.屬性選擇單選或複選時，欄位值才需輸入；若多個值，以頓號(、)隔開<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.屬性選擇單行文字或多行文字時，長度欄位才需輸入
      </font>
    </td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01" style="display:none" id="type">  
  <tr align="center">
    <th width="3%">&nbsp;</th>
    <th width="6%">必填</th>
    <th width="32%" align="left">欄位名稱</th>
    <th width="13%" align="center">屬性</th>
    <th width="24%">欄位值</th>
    <th width="10%">長度</th>
    <th width="10%">排序</th>
  </tr>
  <tr>
    <td colspan="8">
      <%
        for ( int k=1; k<=10; k++ ) { %>
        	<span id="enterline<%=k%>"></span>
        	<table border="0" width="100%" style="display:none" id="table<%=k%>">
        	  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
        	    <td width="3%" align="center"><%=k+frcount%></td>
        	    <td width="6%" align="center"><input type="checkbox" name="isneed<%=k%>" value="">&nbsp;</td>
        	    <td width="32%" align="left">
        	      <input type="text" name="fieldname<%=k%>" size="35" maxlength="25" />
        	    </td>
        	    <td width="13%" align="center">
        	      <select name="attribute<%=k%>">
        	        <option value="">--請選擇--</option>
        	        <option value="text">單行文字</option>
        	        <option value="radio">單選</option>
        	        <option value="checkbox">複選</option>
        	        <option value="textarea">多行文字</option>
        	      </select>
        	    </td>
        	    <td width="24%" align="left">
        	      <textarea name="fieldvalue<%=k%>" rows="2" cols="19"></textarea>
        	      <br/><font size="2" color="red">※&nbsp;若多個值，以頓號(、)隔開
        	    </td>
        	    <td width="10%" align="center">
        	      <input type="text" size="2" name="length<%=k%>" maxlength="3" onclick="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" onkeypress="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
        	    </td>
        	    <td width="10%" align="center">
        	      <input type="text" size="2" name="serial<%=k%>" maxlength="2" value="<%=k+frcount%>" onclick="if ((event.keyCode < 51) || (event.keyCode > 57)) event.returnValue = false;" onkeypress="if ((event.keyCode < 51) || (event.keyCode > 57)) event.returnValue = false;" />
        	    </td>
        	  </tr>  
        	</table>
        <%}%>
    </td>
  </tr>    
</table>    

<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

