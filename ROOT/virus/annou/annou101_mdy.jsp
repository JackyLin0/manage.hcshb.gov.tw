<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：annou101_mdy.jsp
說明：通報資料維護
開發者：hank
開發日期：98.07.31
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );  

  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  String language = ( String )request.getParameter( "language" );
  
  AnnouData qdata = new AnnouData();    
  qdata.load(serno,table);
  
  AnnouItemData querys = new  AnnouItemData();    
  ArrayList list = querys.findByday(serno);    
  int rcounts = querys.getAllrecordCount();

  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());
  
  String qpunit = ( String )request.getParameter( "mqpunit" );
  if ( qpunit == null )
	  qpunit = qdata.getPubunitdn()+"||"+qdata.getPubunitname();
%>  

<script>
function back(){
	document.mform.method = "post";
	document.mform.action = "annou101.jsp";
	document.mform.submit();
}

function save(){
	if(document.mform.mqpunit.value == ''){
    	alert("【隸屬單位】欄位，不可空白，請選擇！");
        document.mform.mqpunit.focus();
        return; 
    }
    
	if(document.mform.mschName.value == ''){
    	alert("【學校名稱】欄位，不可空白，請選擇！");
        document.mform.mschName.focus();
        return;
    }
    
	if(document.mform.stdate.value == ''){
    	alert("【通報日期】欄位，不可空白，請選擇！");
        document.mform.date1.focus();
        return;     
    }
    
    if(document.mform.className.value == ''){
        alert("【班級名稱】欄位，不可空白，請選擇！");
        document.mform.className.focus();
        return;
    }

    if(document.mform.stuNum.value == ''){
        alert("【學童總人數】欄位，不可空白，請選擇！");
        document.mform.mclass.focus();
        return;
    }else if(isNaN(document.mform.stuNum.value)){
    	alert("【學童總人數】欄位，請輸入數字！");
        document.mform.stuNum.focus();
        return;
    }else if(document.mform.sickNum.value == ''){
        alert("【請假人數】欄位，不可空白，請選擇！");
        document.mform.sickNum.focus();
        return;
    }else{
    	if(parseInt(document.mform.sickNum.value) <= 0){
        	alert("【請假人數】欄位，不可小於1，請選擇！");
            document.mform.sickNum.focus();
            return;
        }else if(parseInt(document.mform.sickNum.value) > parseInt(document.mform.stuNum.value)){
        	alert("【請假人數】欄位，不可大於【學童總人數】欄位，請選擇！");
            document.mform.sickNum.focus();
            return;
        }else{
        	var sickNum = document.mform.sickNum.value;
    		if(sickNum == 1){
                var stuName = document.mform.stuName.value;
                var famPhone = document.mform.famPhone.value;

                if(stuName == ''){
                	alert("【學生名字】欄位，不可空白，請選擇！");
                    document.mform.stuName.focus();
                    return;
                }

                if(famPhone == ''){
                	alert("【家長連絡電話】欄位，不可空白，請選擇！");
                    document.mform.famPhone.focus();
                    return;
                }else{
    				if(isNaN(famPhone) || (famPhone.length < 8 || famPhone.length > 10)){
    					alert("【家長連絡電話】欄位，格式錯誤，請選擇！");
    	                document.mform.famPhone.focus();
    	                return;
    				}
                }
    		}else{
    			for(i = 0 ; i < parseInt(sickNum) ; i++){
    				var stuNames = document.mform.stuName[i].value;
    	            var famPhones = document.mform.famPhone[i].value;

    	            if(stuNames == ''){
    	            	alert("【學生名字】欄位，不可空白，請選擇！");
    	                document.mform.stuName[i].focus();
    	                return;
    	            }

    	            if(famPhones == ''){
    	            	alert("【家長連絡電話】欄位，不可空白，請選擇！");
    	                document.mform.famPhone[i].focus();
    	                return;
    	            }else{
    					if(isNaN(famPhones) || (famPhones.length < 8 || famPhones.length > 10)){
    						alert("【家長連絡電話】欄位，格式錯誤，請選擇！");
    		                document.mform.famPhone[i].focus();
    		                return;
    					}
    	            }
    			}
    		}
        }    	
    }

    document.mform.action = "annou101_mdysave.jsp";
    document.mform.method = "post";
    document.mform.submit();
}

var nowNum = <%= qdata.getSickNum() %>;
var stuArray = new Array();
var famArray = new Array();
var remarkArray = new Array();
var docdateArray = new Array();
var docNameArray = new Array();
var recordArray = new Array();
function sickForm(){
	var sickNum = document.mform.sickNum.value;
	
	if(isNaN(sickNum)){
		alert("【請假人數】欄位，格式錯誤，請選擇！");
        document.mform.sickNum.focus();
        return;
	}
	var sickform = "<table width='100%' border='0' cellpadding='0' cellspacing='0' class='table01'>";
	
	for(i = 0 ; i < parseInt(sickNum) ; i++){
		
		var stuvalue = "";
		var famvalue = "";
		var remarkvalue = "";
		var docdatevalue = "";
		var docNamevalue = "";
		var recordvalue = "";
		if(i < stuArray.length){
			stuvalue = stuArray[i];
			famvalue = famArray[i];
			remarkvalue = remarkArray[i];
			docdatevalue = docdateArray[i];
			docNamevalue = docNameArray[i];
			recordvalue = recordArray[i];
		}
		sickform += "<tr>" + 
		  			  "<td width='2%'>" + 
		    			"<span class='T12red'>"+(i+1)+".</span>" +
		  			  "</td>" +
		  			  "<td width='28%'>" + 
					    "<span class='T12b'>名字：</span>" + 
						"<input name='stuName' type='text' size=9 class='lInput01' maxlength='10' value='"+stuvalue+"'/>" + 
		  			  "</td>" +
		  			  "<td width='21%'>" +
						"<span class='T12b'>電話：</span>" + 
						"<input name='famPhone' type='text' class='lInput01' size=9 maxlength='10' value='"+famvalue+"'/>　" + 
		  			  "</td>" +
		  			  "<td width='8%'>" +
						"<span class='T12b' align='right'>備註：</span>"+
		  			  "</td>" +
		  			  "<td width='23%' rowspan='2'>"+
						"<textarea name='remark' cols='12' rows='3'>"+remarkvalue+"</textarea><br><span class='T10'>(不可超過500個中文字）</span>" + 
		  			  "</td>" + 
		  			  "<td width='8%'>" +
						"<span class='T12b' align='right'>訪視：記錄</span>"+
		  			  "</td>" +
		  			  "<td width='12%' rowspan='2' valign='top'>"+
						"<textarea name='record' cols='12' rows='3'>"+recordvalue+"</textarea>" + 
		  			  "</td>" +
					"</tr>" +
					"<tr>" +
		  		      "<td>" + 
						"<span class='T12red'>&nbsp;</span>" +
		  			  "</td>" +
		  			  "<td>" +
						"<span class='T12b'>就醫日期：</span>" +
						"<input type='hidden' name='docdate"+i+"' value='"+docdatevalue+"' size='10' >" +
						"<input type='text' name='docdateview"+i+"' value='"+docdatevalue+"' size='9' readonly >  " +         
						"<img src='../../img/calendar.gif' name='date1' alt='calendar' width='21' height='21' border='0' onclick=\"javascript:window.open('../../pubprogram/date.jsp?colname=mform.docdate"+i+"&view=mform.docdateview"+i+"&datevalue=<%= ndate %>','Calendar', 'width=220,height=230,status=no,resizable=no,top=200,left=200')\" />" +
		  			  "</td>" +
		  			  "<td colspan='2'>" + 
						"<span class='T12b'>就醫醫院：</span>" +
						"<input name='docName' type='text' class='lInput01' size='9' class='lInput01' maxlength='10' value='"+docNamevalue+"'/>" + 
		  			  "</td>" +
					"</tr>";
	}
	//sickform += "</table>";

	document.getElementById("sickform").innerHTML = sickform + "<tr><td colspan='2' align='center'><span class='main_title80'>(電話輸入格式，如：0425222998、0915888888)</span></td></tr></table>";
}
  
function del(){
	x=window.confirm("確定刪除此筆資料嗎?")
    if(x){
    	document.mform.action="annou101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
    } 
}   

function cha(){
	document.mform.action="annou101_mdy.jsp";
    document.mform.method="post";
    document.mform.submit();
} 
</script>

<body>
<form name="mform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="punit" value="<%=qdata.getPubunitdn()+"||"+qdata.getPubunitname()%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name=language value="<%=language%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:del()">刪除</a>
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>隸屬單位</td>
    <td colspan="3">
      <jsp:include page="../qunit.jsp">
        <jsp:param name="colname" value="mqpunit"/>
        <jsp:param name="language" value="ch"/>
        <jsp:param name="datavalue" value="<%=qpunit%>"/>
        <jsp:param name="onchange" value="cha"/>
      </jsp:include>
      <span class="T11b">學校名稱</span>
      <jsp:include page="../../pubprogram/qschool.jsp">
        <jsp:param name="colname" value="mschName"/>
        <jsp:param name="datavalue" value="<%=qpunit%>"/>
        <jsp:param name="schName" value="<%=qdata.getSchName()%>"/>
      </jsp:include>
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b" width="20%"><span class="T12red">※</span>通報日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date1"/>
          <jsp:param name="colname" value="stdate"/>
          <jsp:param name="colnameview" value="stdateview"/>
          <jsp:param name="datevalue" value="<%= qdata.getAnnouDate() %>"/>
      </jsp:include>  
    </td>
  </tr>

  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>班級名稱</td>
    <td colspan="3">
      <input name="className" type="text" class="lInput01" maxlength="10" value="<%= qdata.getClassName() %>"/>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>學童總人數</td>
    <td colspan="3">
      <input name="stuNum" type="text" class="lInput01" size="1" maxlength="3" value="<%= qdata.getStuNum() %>"/>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>請假人數</td>
    <td colspan="3">
      <input name="sickNum" type="text" class="lInput01" size="1" maxlength="3" value="<%= qdata.getSickNum() %>" onchange="sickForm()"/>
    </td>
  </tr>       
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">‧學‧童‧資‧料‧</th>
  </tr>
  <%
    String sickform = "<table width='100%' border='0' cellpadding='0' cellspacing='0' class='table01'>";
    for(int i = 0 ; i < rcounts ; i++){
    	AnnouItemData aid = (AnnouItemData)list.get(i);
    	String remark = "";
    	if(aid.getRemark() != null){
    		remark = aid.getRemark();
    	}
    	String record = "";
    	if(aid.getRecord() != null){
    		record = aid.getRecord();
    	}
    	String docdate = "";
    	if(aid.getDocdate() != null){
    		docdate = aid.getDocdate();
    	}
    	String docName = "";
    	if(aid.getDocName() != null){
    		docName = aid.getDocName();
    	}
    	sickform += "<tr>" + 
		  			  "<td width='2%'>" + 
					    "<span class='T12red'>"+(i+1)+".</span>" +
		  			  "</td>" +
		  			  "<td width='28%'>" + 
		    			"<span class='T12b'>名字：</span>" + 
						"<input name='stuName' type='text' size=9 class='lInput01' maxlength='10' value='"+aid.getStuName()+"'/>" + 
		  			  "</td>" +
		  			  "<td width='21%'>" +
		    			"<span class='T12b'>電話：</span>" + 
						"<input name='famPhone' type='text' class='lInput01' size=9 maxlength='10' value='"+aid.getFamPhone()+"'/>　" + 
		  			  "</td>" +
		  			  "<td width='8%'>" +
		    			"<span class='T12b' align='right'>備註：</span>"+
		  			  "</td>" +
		  			  "<td width='16%' rowspan='2'>"+
		    			"<textarea name='remark' cols='12' rows='3'>"+remark+"</textarea><br><span class='T10'>(不超過500中文）</span>" + 
		  			  "</td>" + 
		  			  "<td width='8%'>" +
		    			"<span class='T12b' align='right'>訪視：記錄</span>"+
	      			  "</td>" +
	      			  "<td rowspan='2' valign='top'>"+
		    			"<textarea name='record' cols='12' rows='3'>"+record+"</textarea><br><span class='T10'>(不超過500中文）</span>" +
	      			  "</td>" +
					"</tr>" +
					"<tr>" +
		  			  "<td>" + 
						"<span class='T12red'>&nbsp;</span>" +
		  			  "</td>" +
		  			  "<td>" +
						"<span class='T12b'>就醫日期：</span>" +
						"<input type='hidden' name='docdate"+i+"' value='"+docdate+"' size='10' >" +
						"<input type='text' name='docdateview"+i+"' value='"+docdate+"' size='9' readonly >  " +         
						"<img src='../../img/calendar.gif' name='date1' alt='calendar' width='21' height='21' border='0' onclick=\"javascript:window.open('../../pubprogram/date.jsp?colname=mform.docdate"+i+"&view=mform.docdateview"+i+"&datevalue="+ndate+"','Calendar', 'width=220,height=230,status=no,resizable=no,top=200,left=200')\" />" +
		  			  "</td>" +
		  			  "<td colspan='2'>" + 
						"<span class='T12b'>就醫醫院：</span>" +
						"<input name='docName' type='text' class='lInput01' size='9' class='lInput01' maxlength='10' value='"+docName+"'/>" + 
		  			  "</td>" +
					"</tr>";
    	
  %>
  <script>
      stuArray.push(\'<%=aid.getStuName()%>\');
      famArray.push(\'<%= aid.getFamPhone() %>\');
      remarkArray.push(\'<%= remark %>\');
      docdateArray.push(\'<%= docdate %>\');
      docNameArray.push(\'<%= docName %>\');
      recordArray.push(\'<%= record %>\');
  </script>
  <%
    }
    sickform += "<tr><td colspan='7' align='center'><span class='main_title80'>(電話輸入格式，如：0425222998、0915888888)</span></td></tr></table></table>";
  %>
  <tr>
    <td colspan="7" valign="top" align="left">
      <div id="sickform" valign='top'>
      <%= sickform%>
      </div>
      
    </td>
  </tr>
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
</form>
</body>
</html>

