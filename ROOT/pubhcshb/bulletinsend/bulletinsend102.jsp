<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：bulletinsend102.jsp
說明：新聞稿統計查詢
開發者：chmei
開發日期：96.11.11
修改者：
修改日期：
版本：ver1.0
-->


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>雲林縣政府全球資訊網網站後端管理</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<script>
   function qry()
   {
	  if(document.mform.myear.value == '')
	  {
		alert("【請選擇年份】查詢，請選擇欲查詢之年度！");
		return;
	  }
	  if(document.mform.month.value == '')
	  {
		alert("【請選擇月份】查詢，請選擇欲查詢之月份！");
		return;
	  }
      document.mform.action="bulletinsend102.jsp";
      document.mform.method="post";
      document.mform.submit();
   }
   
   function trans()
   {
	  if(document.mform.myear.value == '')
	  {
		alert("【請選擇年份】查詢，請選擇欲查詢之年度！");
		return;
	  }
	  if(document.mform.month.value == '')
	  {
		alert("【請選擇月份】查詢，請選擇欲查詢之月份！");
		return;
	  }
      document.mform.action="bulletinsend102_excel.jsp";
      document.mform.method="post";
      document.mform.target="_blank";
      document.mform.submit();
   }
</script>

<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
	  
<%
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());
  String table2 = ( String )request.getParameter( "t2" );

  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );
  
  if ( intpage1 == null || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);

  //接收查詢條件
  String myear = ( String )request.getParameter( "myear" );
  if ( myear == null || myear.equals("null") ) 
	  myear = ndate.substring(0,4);
  
  String month = ( String )request.getParameter( "month" );
  if ( month == null || month.equals("null") || month.equals("") )
	  month = ndate.substring(4,6);
  
  String startmonth = "";
  String endmonth = "";
  if ( month == null || month.equals("null") || month.equals("") ) {
	  startmonth = ndate.substring(0, 6) +"01";
	  endmonth =  ndate.substring(0, 6) +"31";
  } else {
	  startmonth = myear + month +"01";
	  endmonth =  myear + month +"31";
  }
  
   
  BulletinSendData query = new BulletinSendData();  
  query.setTablename(table2);
  ArrayList qlists = query.findBymonth(startmonth, endmonth);
  int rcount = query.getAllrecordCount();
  
  //計算總頁數
  int maxpage=0;
  
  //取餘數
  maxpage=rcount%pagesize;               
  if (maxpage==0)
	  maxpage=rcount/pagesize;
  else
	  maxpage=(rcount/pagesize)+1;

%>

<body>
<form name="mform">
  <!-- 應用系統名稱 -->
   <%@ include file="../../pubprogram/qtitle.jsp"%>

   <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
   <input type="hidden" name="intpage" value="<%=intpage%>"/>
   <input type="hidden" name="t2" value="<%=table2%>"/>
   
   <div id="title">
      <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
   </div>
   <%
   BulletinSendData query1 = new BulletinSendData();
   query1.setTablename(table2);
     ArrayList qyears = query1.findByyear();
     int rcount1 = query1.getAllrecordCount();
   %>
   <div>
   <span class="T11b">年　　度：</span>
   <select name="myear">
     <option value="">-- 請選擇 --</option>
     <%
       if ( qyears != null ) {
    	   for ( int i=0; i<rcount1; i++ ) {
    		   BulletinSendData qyear = ( BulletinSendData )qyears.get( i );
    		   String isSelected = "";
    		   if ( qyear.getYear().equals(myear) )
    			   isSelected = "selected";  %>
    		   <option value="<%=qyear.getYear()%>" <%=isSelected%>><%=Integer.parseInt(qyear.getYear())-1911%>&nbsp;年度</option>
    	   <%}
       }
     %>
   </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <span class="T11b">月　　份：</span>
   <select name="month">
     <%
       for ( int j=1; j<=12; j++ ) {
    	   String isSelected = "";
    	   if ( Integer.parseInt(month) == j )
    		   isSelected = "selected";  %>
    	   <option value="<%=SvNumber.format( j, "00" )%>" <%=isSelected%>><%=SvNumber.format( j, "00" )%></option>	   
       <%}%>
   </select><br>
   &nbsp;&nbsp;&nbsp;<a class="md2" href="javascript:qry()">查詢</a>&nbsp;&nbsp;
   <a class="md2" href="javascript:trans()">轉出Excel</a>
   </div>
   
   <p>

   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
     <tr align="center">
       <th width="5%">&nbsp;</th>
       <th width="5%">&nbsp;</th>
       <%
         String subject = "年度／月別";
       %>
       <th width="30%"><%=subject%></th>
       <th width="30%">單位名稱</th>
       <th width="30%">新聞稿發佈件數</th>
     </tr>
     <%
       if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  {
    	   intpage = Integer.parseInt(request.getParameter("page"));
       }
     
       int startpage=(intpage-1)*pagesize+1;
       int endpage=startpage+pagesize-1;    
       
       for ( int i = (startpage-1); ( ( i < endpage ) && ( i < rcount ) ); i ++ )  {
    	   BulletinSendData qlist = ( BulletinSendData )qlists.get( i ); %>
    	   <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    	     <td align="center"><%=i+1%></td>
    	     <td align="center">&nbsp;</td>
    	     <td align="center"><%=Integer.parseInt(myear.substring(0,4)) - 1911%>年度&nbsp;<%=month%>月份</td>
             <td align="center"><%=qlist.getPubunitname()%></td>   	       
    	     <td align="center"><%=qlist.getPosterCount()%></td>  
    	   </tr> 
       <%}%>
       
       <input type="hidden" name="page"/> 
       <input type="hidden" name="intpage" value="<%=intpage%>"/> 
       <!-- 分頁 -->
       <tr class="tr01">
         <th colspan="11">
           <jsp:include page="../../pubprogram/page.jsp">
               <jsp:param name="startpage" value="<%=startpage%>"/>
               <jsp:param name="pagesize" value="<%=pagesize%>"/>
               <jsp:param name="intpage" value="<%=intpage%>"/>
               <jsp:param name="maxpage" value="<%=maxpage%>"/>
               <jsp:param name="endpage" value="<%=endpage%>"/>
               <jsp:param name="rcount" value="<%=rcount%>"/>
               <jsp:param name="formname" value="mform"/>
           </jsp:include>
         </th>
       </tr>  
     </table>
     
     <p>
     <a class="md" href="#top">回頁首</a>
     <div id="page"><span class="T8-5">頁數:</span> <span class="T8-5c"> <%=intpage%> / <%=maxpage%> </span><span class="T8-5">； 資料每頁以15筆展現；共有</span><span class="T8-5c"> <%=rcount%> </span> <span class="T8-5">筆資料</span></div>
     
</form>
</body>
</html>
 
  