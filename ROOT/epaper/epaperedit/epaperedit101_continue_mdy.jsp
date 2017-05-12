<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperedit101_continue_mdy.jsp
說明：電子報派送編輯
開發者：chmei
開發日期：97.03.20
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //參數  
  String logindn = ( String )request.getParameter( "logindn" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  
  String serno = ( String )request.getParameter( "serno" );
  
  //尋找EpaperSendMaster
  EpaperEditData query = new EpaperEditData();
  boolean rtn = query.load(serno);
  String subject = "";
  String periodical = "";
  if ( rtn ) {
	  subject = query.getSubject();
	  periodical = query.getPeriodical();
  }
  
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());

%>  

<script>
   function choice(num,mserno,serno) {
      thisform = "document.mform.textarea" + num;
      var contentStr = eval(thisform).value;
      while (contentStr.indexOf("\n") != -1) {
          contentStr = contentStr.replace("\n","||");
      }
      while (contentStr.indexOf("　") != -1) {
          contentStr = contentStr.replace("　","|");
      }
      var eserno = "";
      mcontent = contentStr.split("||");
      for ( i=0; i<mcontent.length; i++ ) {
         if ( mcontent[i] != '' ) {
            mcontent1 = mcontent[i].split("|");
            if ( eserno == '' )
               eserno = mcontent1[0];
            else
               eserno = eserno + "||" + mcontent1[0];
         }
      }
      window.open('../epaperdata.jsp?mserno='+mserno+'&eserno='+eserno+'&serno='+serno+'&thisform='+thisform+'&num='+num,'epaper','width=550,height=350,scrollbars=yes,left=200,top=150');
   }
     
  function chg()
  {
     for ( var i=0; i<document.all.senddate.length; i++ )
     {
        if ( document.all.senddate[i].checked )
        {
           var senddate_value = document.all.senddate[i].value;           
           switch(senddate_value)
           {
              case "1": //永久有效
                   window.type.style.display='none';
                   break;
              case "0": //截止日期
                   window.type.style.display='block';
                   break;
           }
        }
     }                  
  }
    
  function preview()
  {
     var mserno = document.mform.epaperimg.value;
     window.open('imgpreview.jsp?serno='+mserno,'epaper','width=600,height=250,scrollbars=yes,left=150,top=120');
  }
      
  function save(rcount)
  {
     if ( document.mform.senddate[1].checked ) 
     {
        if ( document.mform.endate.value == '' )
        {
           alert("【其他日期】欄位，不可空白，請選擇！");
           document.mform.date2.focus();
           return;
        }
        if ( document.mform.endate.value < <%=ndate%> )
        {
           alert("【派送日期】不可小於【今日日期】！");
           document.mform.date2.focus();
           return;       
        }
     }
     for ( i=0; i<rcount; i++ ) {
        thisform = "document.mform.textarea"+i;
        cthisform = "document.mform.mcontent"+i;
        classname = "document.mform.mclassname"+i;
        if ( window.eval(thisform) ) {
           var contentStr = eval(thisform).value;
           if ( contentStr == '' ) {
              alert("【"+eval(classname).value+"】未選擇資料，請選擇！");
              eval(thisform).focus();
              return;
           }else{
              while (contentStr.indexOf("\n") != -1) {
                 contentStr = contentStr.replace("\n","||");
              }
              while (contentStr.indexOf("　") != -1) {
                 contentStr = contentStr.replace("　","|");
              }
              eval(cthisform).value = contentStr;
           }
        }else{
           if ( document.mform.qptdate.value == '' ) {
              alert("【訊息快遞(起)】欄位，不可空白，請選擇！");
              return;
           }
           if ( document.mform.qdldate.value == '' ) {
              alert("【訊息快遞(迄)】欄位，不可空白，請選擇！");
              return;
           }
           if ( document.mform.qdldate.value < document.mform.qptdate.value ) {
              alert("【訊息快遞(起)不可大於(迄)】，請重新選擇！");
              return;
           }
        }
     }
     
     document.mform.rcount.value = rcount;
     document.mform.action = "epaperedit101_continue_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
  }    
</script>

<body>
<form name="mform">
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name="periodical" value="<%=periodical%>"/>
  <input type="hidden" name="rcount"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">電子報資料選用</th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>標題</td>
    <td colspan="3"><%=subject%></td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>期刊別</td>
    <td colspan="3"><%=periodical.substring(0,4)%>&nbsp;年&nbsp;<%=periodical.substring(4,6)%>&nbsp;月&nbsp;</td>
  </tr>
  <%
    EpaperEditData qdata = new EpaperEditData();
    ArrayList qlists = qdata.findByclass(query.getSerno());
    int rcount = qdata.getAllrecordCount();
    String oldeserno = "";
    String oldtablename = "";
    if ( qlists != null ) {
    	for ( int i=0; i<rcount; i++ ) {
    		EpaperEditData qlist = ( EpaperEditData )qlists.get( i );
    		String classvalue = qlist.getMserno() + "||" + qlist.getMclassname();
    		String mclass="";
    		if ( (i+1)%2 != 0 )
    			mclass = "class='tr'";  %>
    		<tr <%=mclass%>>
    		  <%
    		    if ( qlist.getMclassname().equals("訊息快遞") ) { 
    		    	String qptdate = "";
    		    	String qdldate = "";
    		    	EpaperEditData qmdate = new EpaperEditData();
    		    	ArrayList qdates = qmdate.findBydetail(qlist.getSerno(),qlist.getMserno());
    		    	if ( qdates != null ) {
    		    		for (int j=0; j<1; j++ ) {
    		    			EpaperEditData qdate = ( EpaperEditData )qdates.get( j );
    		    			qptdate = qdate.getStartdate();
    		    			qdldate = qdate.getEnddate();
    		    			//舊資料
    		    			if ( oldeserno.equals("") ) {
    		    				oldeserno = qdate.getESerno();
    		    				oldtablename = qdate.getTablename();
    		    			}else{
    		    				oldeserno = oldeserno + "||" + qdate.getESerno();
    		    				oldtablename = oldtablename + "||" + qdate.getTablename();
    		    			}
    		    		}
    		    	} %>
    		        <td class="T12b"><span class="T12red">※</span><%=qlist.getMclassname()%></td>
    		    	<td colspan="3">
    		    	  <jsp:include page="../../pubprogram/bdate.jsp">
    		    	      <jsp:param name="sdatevalue" value="<%=qptdate%>" />
    		    	      <jsp:param name="edatevalue" value="<%=qdldate%>" />
    		    	  </jsp:include>
    		    	  <br>
    		    	  <span class="T10">資料來自衛生局的活動訊息</span>
    		    	</td>
    		    	<input type="hidden" name="classname<%=i%>" value="<%=classvalue%>">
    		    <%}else{
    		    	EpaperEditData qmclass = new EpaperEditData();
    		    	ArrayList qclasss = qmclass.findBydetail(qlist.getSerno(),qlist.getMserno());
    		    	int rcount1 = qmclass.getAllrecordCount();
    		    	String mcontent = "";    		    	
    		    	if ( qclasss != null ) {
    		    		for ( int k=0; k<rcount1; k++ ) {
    		    			EpaperEditData qclass = ( EpaperEditData )qclasss.get( k );
    		    			if ( mcontent.equals("") )
    		    				mcontent = qclass.getESerno() + "%" + qclass.getSubject().trim();
    		    			else
    		    				mcontent = mcontent + "&" + qclass.getESerno() + "%" + qclass.getSubject().trim();
    		    			//舊資料
    		    			if ( oldeserno.equals("") ) {
    		    				oldeserno = qclass.getESerno();
    		    				oldtablename = qclass.getTablename();
    		    			}else{
    		    				oldeserno = oldeserno + "||" + qclass.getESerno();
    		    				oldtablename = oldtablename + "||" + qclass.getTablename();
    		    			}
    		    		}
    		    		
    		    		mcontent = mcontent.trim().replaceAll("&","\n");
    		    		mcontent = mcontent.trim().replaceAll("%","　");    		    		
    		    	}  %>
    		        <td class="T12b"><span class="T12red">※</span><%=qlist.getMclassname()%>清單</td>
    		    	<td colspan="3">
    		    	  <textarea name="textarea<%=i%>" rows="8" cols="70" readonly><%=mcontent%></textarea>
    		    	  <br>
    		    	  <a class="md" href="javascript:choice('<%=i%>','<%=qlist.getMserno()%>','<%=query.getSerno()%>')">選擇<%=qlist.getMclassname()%>資料</a>
    		    	</td>
    		    	<input type="hidden" name="mclassname<%=i%>" value="<%=qlist.getMclassname()%>">
    		    	<input type="hidden" name="classname<%=i%>" value="<%=classvalue%>">
    		    	<input type="hidden" name="mcontent<%=i%>">
    		    <%}%>
    		</tr>
    	<%}
    	EpaperEditData qmimg = new EpaperEditData();
    	ArrayList qimgs = qmimg.findBylogoimg();
    	int rcountimg = qmimg.getAllrecordCount();	%>
    	<tr class="tr">
    	  <td class="T12b"><span class="T12red">※</span>Logo圖片選用</td>
    	  <td colspan="3">
    	    <select name="epaperimg">
    	    <%
    	      if ( qimgs != null ) {
    	    	  for ( int i=0; i<rcountimg; i++ ) {
    	    		  EpaperEditData qimg = ( EpaperEditData )qimgs.get( i );
    	    		  String isSelected = "";
    	    		  if ( qimg.getSerno().equals(query.getImgserno()) )
    	    			  isSelected = "selected";  %>
    	    		  <option value="<%=qimg.getSerno()%>" <%=isSelected%>><%=qimg.getClientfile()%></option>
    	    	  <%}
    	      }%>
    	      </select>&nbsp;&nbsp;&nbsp;
    	      <a class="md" href="javascript:preview()">預覽</a>
    	  </td>
    	</tr>
    	<%
    	  String msenddate = query.getSenddate();
    	  if ( msenddate == null || msenddate.equals("null") )
    		  msenddate = ndate;
    	  
    	  String mstyle = "style='display:none'";
    	  if ( !msenddate.equals(ndate) )
    		  mstyle = "style='display:block'";
    	%>
    	<tr class="tr">
    	  <td class="T12b"><span class="T12red">※</span>派送日期</td>
    	  <td colspan="3">
    	    <input type="radio" name="senddate" value="1" onclick="chg()" <%=(msenddate.equals(ndate) ? "checked" : "")%>>今日&nbsp;&nbsp;&nbsp;
    	    <input type="radio" name="senddate" value="0" onclick="chg()" <%=(!msenddate.equals(ndate) ? "checked" : "")%>>其他&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    	    <span class="T10">派送時間會在下午6:30，由系統自動派送。</span>
    	  </td>
    	</tr>
    	<tr id='type' <%=mstyle%>>
    	  <td class="T12b" width="20%"><span class="T12red">※</span>其他日期</td>
    	  <td colspan="3">
    	    <jsp:include page="../../pubprogram/choicedate.jsp"> 
    	        <jsp:param name="buttonname" value="date2"/>
    	        <jsp:param name="colname" value="endate"/>
    	        <jsp:param name="colnameview" value="endateview"/>
    	        <jsp:param name="datevalue" value="<%=query.getSenddate()%>" />
    	    </jsp:include>  
    	  </td>
    	</tr>
    <%}%>
  
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<p>
<div align="center">
<a class="md" href="javascript:window.history.go(-2)">上一步</a>&nbsp;&nbsp;
<a class="md" href="javascript:save('<%=rcount%>')">完成</a>
</div>

<input type="hidden" name="oldeserno" value="<%=oldeserno%>"/>
<input type="hidden" name="oldtablename" value="<%=oldtablename%>"/>

</form>
</body>
</html>




