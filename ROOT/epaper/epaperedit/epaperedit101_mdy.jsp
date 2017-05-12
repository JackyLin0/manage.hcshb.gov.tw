<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：epaperedit101_mdy.jsp
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

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String language = ( String )request.getParameter( "language" );
  String pubunitdn = ( String )request.getParameter( "pubunitdn" );
  String pubunitname = ( String )request.getParameter( "pubunitname" );

  String serno = ( String )request.getParameter( "serno" );
  
  //查詢主檔(EpaperEditMaster)
  EpaperEditData query = new EpaperEditData();
  boolean rtn = query.load(serno);
  String msubject = "";
  String periodical = "";
  if ( rtn ) {
	  msubject = query.getSubject();
	  periodical = query.getPeriodical();
  }

  //查詢此期刊選用的類別
  EpaperEditData query2 = new EpaperEditData();
  ArrayList qlists1 = query2.findByclass(serno);
  int rcount1 = query2.getAllrecordCount();
  String mclassvalue = "";
  if ( qlists1 != null ) {
	  for ( int i=0; i<rcount1; i++ ) {
		  EpaperEditData qlist1 = ( EpaperEditData )qlists1.get( i );
		  if ( mclassvalue.equals("") )
			  mclassvalue = qlist1.getMserno();
		  else
			  mclassvalue = mclassvalue + "||" + qlist1.getMserno();
	  }
  }  
  
  //查詢未被使用類別(包含此期刊使用的類別)
  EpaperEditData query1 = new EpaperEditData();
  ArrayList qlists = query1.findByallclass(mclassvalue);  
  int rcount = query1.getAllrecordCount();
  

%>  

<script>
  function back()
  {
     document.mform.action="epaperedit101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }

  function save()
  {
     if ( document.mform.subject.value == '' ) {
        alert("【標題】欄位，不可空白，請輸入！");
        document.mform.subject.focus();
        return;
     }
     document.mform.action = "epaperedit101_mdysave.jsp";
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
  <input type="hidden" name="pubunitdn" value="<%=pubunitdn%>"/>
  <input type="hidden" name="pubunitname" value="<%=pubunitname%>"/>
  <input type="hidden" name="periodical" value="<%=periodical%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:window.document.mform.reset()">取消</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>
 	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>標題</td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="50" maxlength="50" value="<%=msubject%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>期刊別</td>
    <td colspan="3"><%=periodical.substring(0,4)%>&nbsp;年&nbsp;<%=periodical.substring(4,6)%>&nbsp;月&nbsp;</td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>本期派送類別</td>
    <td colspan="3">
      <%
        String[] ary_mclassvalue = SvString.split(mclassvalue,"||");
        String bdatavalue = "200803220001||訊息快遞";
        String isSelected1 = "";
        if ( SvString.contain(ary_mclassvalue,"200803220001") )
        	isSelected1 = "checked";
      %>
      <input type="checkbox" name="bulletin" value="<%=bdatavalue%>" <%=isSelected1%>>&nbsp;訊息快遞<br>
      <%
        if ( qlists != null ) {
        	
        	for ( int j=0; j<rcount; j++ ) {
        		EpaperEditData qlist = ( EpaperEditData )qlists.get( j );
        		String isSelected = "";
        		if ( SvString.contain(ary_mclassvalue,qlist.getMserno()) )
        			isSelected = "checked";
        		String datavalue = qlist.getMserno() + "||" + qlist.getMclassname();  %>
        		<input type="checkbox" name="class" value="<%=datavalue%>" <%=isSelected%>>&nbsp;<%=qlist.getMclassname()%><br>
        	<%}
        }%>
    </td>
  </tr>
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>

<p><div align="center"><a class="md" href="javascript:save()">下一步</a></div>

</form>
</body>
</html>

