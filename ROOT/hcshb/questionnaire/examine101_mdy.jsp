<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：examine101_mdy.jsp
說明：問卷調查資料審核
開發者：chmei
開發日期：98.02.01
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
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qexamine = ( String )request.getParameter( "qexamine" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );  
  
  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  
  QuestionExamineData query = new QuestionExamineData();
  boolean rtn = query.load(serno,table);  

%>  

<script>
  function back()
  {
     document.mform.action="examine101.jsp";
     document.mform.method="post";
     document.mform.submit();
  }

  function save()
  {
     document.mform.action = "examine101_mdysave.jsp";
     document.mform.method = "post";
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
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="qexamine" value="<%=qexamine%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:back()">回上頁</a>
 
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料審核</th>
  </tr>
  <tr>
    <td>審核狀態</td>
    <td colspan="3">
      <input type="radio" name="examine" value="0" <%=query.getExamine().equals("0") ? "checked" : ""%>/>待審核&nbsp;&nbsp;&nbsp;
      <input type="radio" name="examine" value="Y" <%=query.getExamine().equals("Y") ? "checked" : ""%>/>通過&nbsp;&nbsp;&nbsp;
      <input type="radio" name="examine" value="N" <%=query.getExamine().equals("N") ? "checked" : ""%>/>不通過
    </td>
  </tr>
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<br/>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">問卷調查資料瀏覽</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="23%">發布日期</td>
    <td colspan="3"><%=query.getPosterdate().substring(0,4)%>.<%=query.getPosterdate().substring(4,6)%>.<%=query.getPosterdate().substring(6,8)%></td>
  </tr>
  <%
    String mstatus = "";
    if ( query.getStartusing().equals("1") )
    	mstatus = "永久有效";
    else if ( query.getStartusing().equals("0") )
    	mstatus = query.getClosedate().substring(0,4) + "." + query.getClosedate().substring(4,6) + "." + query.getClosedate().substring(6,8);
  %>
  <tr>
    <td class="T12b" width="20%">截止日期</td>
    <td colspan="3"><%=mstatus%></td>
  </tr>
  <tr class="tr">
    <td class="T12b">標題</td>
    <td colspan="3"><%=query.getSubject()%></td>
  </tr>
  <tr>
    <td class="T12b">發佈單位</td>
    <td colspan="3"><%=query.getPubunitname()%></td>
  </tr>
  <%
    String mcontent = "";
    if ( query.getContent() != null && !query.getContent().equals("null") )
    	mcontent = query.getContent().replaceAll("\n","<br>");
  %>
  <tr class="tr">
    <td valign="top" class="T12b">詳細內容</td>
    <td colspan="3"><%=mcontent%></td>
  </tr>
  <%
    String mquestiontype = "";
    if ( query.getQuestiontype().equals("1") )
    	mquestiontype = "問卷調查";
    else if ( query.getQuestiontype().equals("2") )
    	mquestiontype = "有獎徵答";
    String prizenumber = "無";
    if ( query.getPrizenumber() != 0 )
    	prizenumber = String.valueOf(query.getPrizenumber());
  %>
  <tr>
    <td class="T12b">問卷類型</td>
    <td colspan="3"><%=mquestiontype%></td>
  </tr>
  <tr class="tr">
    <td class="T12b">獎品數量</td>
    <td colspan="3"><%=prizenumber%></td>
  </tr>
  <tr>
    <td class="T12b" valign="top">獎品圖片</td>
    <td colspan="3">
      <%
        if ( query.getServerfile() != null && !query.getServerfile().equals("null") && !query.getServerfile().equals("") ) { %>
        	<img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(query.getServerfile(),"UTF-8")%>&flag=questionpath"/>
        	&nbsp;&nbsp;&nbsp;圖片說明：<%=query.getExpfile()%>
        <%}else{
        	out.println("無");
        }%>
    </td>
  </tr>
  <%
    String misbasic = query.getIsbasic();
    String mstyle2 = "style='display:none'";
    String[] ary_basic = null;
    if ( misbasic.equals("Y") ) {
    	mstyle2 = "style='display:block'";
    	ary_basic = SvString.split(query.getBasicfield(),"||");
    }
  %>
  <tr class="tr">
    <td valign="top" class="T12b">是否填寫基本資料</td>
    <td colspan="3">
      <input type="radio" name="isbasic" value="Y" onclick="chg2()" <%=misbasic.equals("Y") ? "checked" : ""%> disabled />是&nbsp;&nbsp;
      <input type="radio" name="isbasic" value="N" onclick="chg2()" <%=misbasic.equals("N") ? "checked" : ""%> disabled />否
    </td>
  </tr>
  <%
    if ( misbasic.equals("Y") ) { %>
    	<tr>
    	  <td valign="top" class="T12b">基本資料欄位</td>
    	  <td colspan="3">
    	    <table border="0" width="97%">
    	      <tr>
    	        <td><input type="checkbox" name="field" value="1" <%=(SvString.contain(ary_basic,"1") ? "checked" : "")%> disabled></input>&nbsp;姓名</td>
    	        <td><input type="checkbox" name="field" value="2" <%=(SvString.contain(ary_basic,"2") ? "checked" : "")%> disabled></input>&nbsp;身份證字號</td>
    	        <td><input type="checkbox" name="field" value="3" <%=(SvString.contain(ary_basic,"3") ? "checked" : "")%> disabled></input>&nbsp;性別　</td>
    	        <td><input type="checkbox" name="field" value="4" <%=(SvString.contain(ary_basic,"4") ? "checked" : "")%> disabled></input>&nbsp;E-MAIL</td>
    	        <td><input type="checkbox" name="field" value="5" <%=(SvString.contain(ary_basic,"5") ? "checked" : "")%> disabled></input>&nbsp;住址</td>
    	      </tr>
    	      <tr>
    	        <td><input type="checkbox" name="field" value="6" <%=(SvString.contain(ary_basic,"6") ? "checked" : "")%> disabled></input>&nbsp;電話</td>
    	        <td><input type="checkbox" name="field" value="7" <%=(SvString.contain(ary_basic,"7") ? "checked" : "")%> disabled></input>&nbsp;學歷</td>
    	        <td><input type="checkbox" name="field" value="8" <%=(SvString.contain(ary_basic,"8") ? "checked" : "")%> disabled></input>&nbsp;年齡</td>
    	        <td><input type="checkbox" name="field" value="9" <%=(SvString.contain(ary_basic,"9") ? "checked" : "")%> disabled></input>&nbsp;職業</td>
    	      </tr>
    	    </table>  
    	  </td>
    	</tr>
    <%}
    QuestionnaireData qdata = new QuestionnaireData();
    ArrayList qlists = qdata.findByday(query.getSerno());
    int rcount = qdata.getAllrecordCount();
  %>
  <tr class="tr">
    <td valign="top" class="T12b">本次問卷題數</td>
    <td colspan="3"><%=rcount%></td>
  </tr>
  <tr>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<br/>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="5">‧細‧項‧目‧設‧定‧</th>
  </tr>
  <tr align="center">
    <th width="5%">編號</th>
    <th width="59%">題　　　目</th>
    <th width="8%">複選</th>
    <th width="10%">提供民眾<br/>文字輸入</th>
    <th width="18%">解　答</th>
  </tr>
  <tr>
    <td colspan="5">
      <%
        if ( qlists != null ) {
        	for ( int n=0; n<rcount; n++ ) {
        		QuestionnaireData qlist = ( QuestionnaireData )qlists.get( n );
        	    String mchoicetype = qlist.getChoicetype(); %>
        		<table border="0" width="100%">
        		  <tr align="center" valign="top">
	        	    <td width="5%"><%=n+1%></td>
	        	    <td width="59%" align="left">
	        	      <input type="text" name="subject<%=n+1%>" size="60" value="<%=qlist.getMsubject()%>" disabled /><br/>
	        	      <input type="radio" name="choice<%=n+1%>" value="1" onclick="chg3('<%=n+1%>')" <%=qlist.getChoicetype().equals("1") ? "checked" : ""%> disabled />選項為文字&nbsp;&nbsp;&nbsp;
	        	      <input type="radio" name="choice<%=n+1%>" value="2" onclick="chg3('<%=n+1%>')" <%=qlist.getChoicetype().equals("2") ? "checked" : ""%> disabled />選項為圖片
	        	      <table border="0">
	        	        <tr>
	        	          <td>
	        	            <%
	        	              if ( qlist.getServerfile1() != null && !qlist.getServerfile1().equals("null") && !qlist.getServerfile1().equals("") ) {
	        	            	  if ( qlist.getRellection().equals("Y") ) { %>
	        	            		  <input type="checkbox" disabled/>
	        	            	  <%}else{%>
	        	            		  <input type="radio" disabled/>
	        	            	  <%}
	        	            	  if ( mchoicetype.equals("1") ) {%> 
	        	            		  <%=qlist.getServerfile1()%>
	        	            	  <%}else{%>
	        	            		  <img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile1(),"UTF-8")%>&flag=questionpath" />
	        	            		  &nbsp;&nbsp;&nbsp;圖片說明：<%=qlist.getExpfile1()%>
	        	            	  <%}
	        	            	  out.println("<br/>");
	        	        	  }
	        	              if ( qlist.getServerfile2() != null && !qlist.getServerfile2().equals("null") && !qlist.getServerfile2().equals("") ) {
	        	            	  if ( qlist.getRellection().equals("Y") ) { %>
	        	            		  <input type="checkbox" disabled/>
	        	            	  <%}else{%>
	        	            		  <input type="radio" disabled/>
	        	            	  <%}
	        	            	  if ( mchoicetype.equals("1") ) { %>
	        	            		  <%=qlist.getServerfile2()%>
	        	            	  <%}else{%>
	        	            		  <img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile2(),"UTF-8")%>&flag=questionpath" />
	        	            		  &nbsp;&nbsp;&nbsp;圖片說明：<%=qlist.getExpfile2()%>
	        	            	  <%}
	        	            	  out.println("<br/>");
	        	              }
	        	              if ( qlist.getServerfile3() != null && !qlist.getServerfile3().equals("null") && !qlist.getServerfile3().equals("") ) {
	        	            	  if ( qlist.getRellection().equals("Y") ) { %>
	        	            		  <input type="checkbox" disabled/>
	        	            	  <%}else{%>
	        	            		  <input type="radio" disabled/>
	        	            	  <%}
	        	            	  if ( mchoicetype.equals("1") ) { %> 
	        	            		  <%=qlist.getServerfile3()%>
	        	            	  <%}else{%>
	        	            		  <img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile3(),"UTF-8")%>&flag=questionpath" />
	        	            		  &nbsp;&nbsp;&nbsp;圖片說明：<%=qlist.getExpfile3()%>
	        	            	  <%}
	        	            	  out.println("<br/>");
	        	              }
	        	              if ( qlist.getServerfile4() != null && !qlist.getServerfile4().equals("null") && !qlist.getServerfile4().equals("") ) {
	        	            	  if ( qlist.getRellection().equals("Y") ) { %>
	        	            		  <input type="checkbox" disabled/>
	        	            	  <%}else{%>
	        	            		  <input type="radio" disabled/>
	        	            	  <%}
	        	            	  if ( mchoicetype.equals("1") ) { %>
	        	            		  <%=qlist.getServerfile4()%>
	        	            	  <%}else{%>
	        	            		  <img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile4(),"UTF-8")%>&flag=questionpath" />
	        	            		  &nbsp;&nbsp;&nbsp;圖片說明：<%=qlist.getExpfile4()%>
	        	            	  <%}
	        	            	  out.println("<br/>");
	        	              }
	        	              if ( qlist.getServerfile5() != null && !qlist.getServerfile5().equals("null") && !qlist.getServerfile5().equals("") ) {
	        	            	  if ( qlist.getRellection().equals("Y") ) { %>
	        	            		  <input type="checkbox" disabled/>
	        	            	  <%}else{%>
	        	            		  <input type="radio" disabled/>
	        	            	  <%}
	        	            	  if ( mchoicetype.equals("1") ) { %>
	        	            		  <%=qlist.getServerfile5()%>
	        	            	  <%}else{%>
	        	            		  <img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile5(),"UTF-8")%>&flag=questionpath" />
	        	            		  &nbsp;&nbsp;&nbsp;圖片說明：<%=qlist.getExpfile5()%>
	        	            	  <%}
	        	            	  out.println("<br/>");
	        	              }
	        	              if ( qlist.getServerfile6() != null && !qlist.getServerfile6().equals("null") && !qlist.getServerfile6().equals("") ) {
	        	            	  if ( qlist.getRellection().equals("Y") ) { %>
	        	            		  <input type="checkbox" disabled/>
	        	            	  <%}else{%>
	        	            		  <input type="radio" disabled/>
	        	            	  <%}
	        	            	  if ( mchoicetype.equals("1") ) { %>
	        	            		  <%=qlist.getServerfile6()%>
	        	            	  <%}else{%>
	        	            		  <img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile6(),"UTF-8")%>&flag=questionpath" />
	        	            		  &nbsp;&nbsp;&nbsp;圖片說明：<%=qlist.getExpfile6()%>
	        	            	  <%}
	        	            	  out.println("<br/>");
	        	              }
	        	              if ( qlist.getServerfile7() != null && !qlist.getServerfile7().equals("null") && !qlist.getServerfile7().equals("") ) {
	        	            	  if ( qlist.getRellection().equals("Y") ) { %>
	        	            		  <input type="checkbox" disabled/>
	        	            	  <%}else{%>
	        	            		  <input type="radio" disabled/>
	        	            	  <%}
	        	            	  if ( mchoicetype.equals("1") ) { %>
	        	            		  <%=qlist.getServerfile7()%>
	        	            	  <%}else{%>
	        	            		  <img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile7(),"UTF-8")%>&flag=questionpath" />
	        	            		  &nbsp;&nbsp;&nbsp;圖片說明：<%=qlist.getExpfile7()%>
	        	            	  <%}
	        	            	  out.println("<br/>");
	        	              }
	        	              if ( qlist.getServerfile8() != null && !qlist.getServerfile8().equals("null") && !qlist.getServerfile8().equals("") ) {
	        	            	  if ( qlist.getRellection().equals("Y") ) { %>
	        	            		  <input type="checkbox" disabled/>
	        	            	  <%}else{%>
	        	            		  <input type="radio" disabled/>
	        	            	  <%}
	        	            	  if ( mchoicetype.equals("1") ) { %> 
	        	            		  <%=qlist.getServerfile8()%>
	        	            	  <%}else{%>
	        	            		  <img src="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile8(),"UTF-8")%>&flag=questionpath" />
	        	            		  &nbsp;&nbsp;&nbsp;圖片說明：<%=qlist.getExpfile8()%>
	        	            	  <%}
	        	            	  out.println("<br/>");
	        	              }
	        	              if ( qlist.getInputtext().equals("Y") ) { %>
	        	            	  其他說明：<input type="text" name="inputtext" size="55" maxlength="50" disabled/>
	        	              <%}%>
        	              </td>
        	            </tr>
        	          </table>
        	        </td>
        	        <%
        	          String mchecked = "";
        	          if ( qlist.getRellection().equals("Y") )
        	        	  mchecked = "checked";
        	          String mchecked1 = "";
        	          if ( qlist.getInputtext().equals("Y") )
        	        	  mchecked1 = "checked";
        	        %>
        	        <td width="8%"><input type="checkbox" name="reelection<%=n+1%>" <%=mchecked%> disabled/></td>
        	        <td width="10%"><input type="checkbox" name="inputtext<%=n+1%>" <%=mchecked1%> disabled/></td>
        	        <td width="18%" align="center"><%=qlist.getAnswer()%>
        	        </td>
        	      </tr>        	  
        	    </table>
        	<%}
        }%>
    </td>
  </tr>
  <tr>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
  </tr>
</table>        

<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

