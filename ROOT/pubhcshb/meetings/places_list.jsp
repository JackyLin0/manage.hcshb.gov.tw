<%@page import="tw.com.sysview.dba.meeting.PlaceData"%>
<%@page import="tw.com.sysview.dba.meeting.MeetingData"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!--
程式名稱： activites.jsp
說明：活動訊息
開發者：chmei
開發日期：97.02.24
修改者：
修改日期：
版本：ver1.0
-->
<noscript>若您的瀏覽器無法支援script，並不會影響到網頁的閱讀</noscript>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.filter.qfilterSql" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //參數
  String intpage1 = ( String )request.getParameter( "intpage" );
  
  if ( intpage1 == null || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);

  //接收查詢條件
  String day1 = ( String )request.getParameter( "day1" );
	  
  MeetingData visit = new MeetingData();
  visit=new MeetingData();
  ArrayList vqlists=visit.findByday("Meetings", "", day1, "Y");
  int rcount = visit.getAllrecordCount();
  
  //計算總頁數
//   int pagesize = 15;
//   int maxpage=0;
  
  //取餘數
//   maxpage=rcount%pagesize;               
//   if (maxpage==0)
//      maxpage=rcount/pagesize;
//   else
//      maxpage=(rcount/pagesize)+1;
  
%>  

<form name="mform" action="activites_list.jsp" method="post">
<%--   <input type="hidden" name="pagesize" value="<%=pagesize%>"/> --%>
  <input type="hidden" name="dataserno"/>
  
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <caption><span class="main_font13"><%=tw.com.sysview.function.Datestr.date_chinese(day1,"") %> 場地租借資料  共<%=rcount%>筆</span></caption>
    <tr>
      <td colspan="4" align="left" valign="top" background="img/line.gif">&nbsp;</td>
    </tr>
    <%
      if ( vqlists != null ) { %>
    	  <tr>
    	    <td align="left" valign="top">
    	      <table width="99%" border="0" cellspacing="0" cellpadding="0">
    	        <tr>
    	          <th colspan="2" align="left" valign="baseline" class="table_color">&nbsp;&nbsp;&nbsp;活動主題</th>
                  <th width="15%" align="left" valign="baseline" class="table_color">租借場地</th>
    	          <th width="15%" align="left" valign="baseline" class="table_color">租借人員</th>
                  <th width="10%" align="left" valign="baseline" class="table_color">分機號碼</th>
                  <th width="15%" align="left" valign="baseline" class="table_color">租借時間</th>
    	          <th width="5%" align="center" valign="baseline" class="table_color"></th>
    	        </tr>
    	        <%
    	          if ( (request.getParameter("page") != null) && (!request.getParameter("page").equals("null")) && (!request.getParameter("page").equals("")) )  
    	        	  intpage = Integer.parseInt(request.getParameter("page"));
//     	          int startpage=(intpage-1)*pagesize+1;
//     	          int endpage=startpage+pagesize-1;    
    	          for ( int i = 0; i < rcount ; i ++ )  {
    	        	  MeetingData qlist = ( MeetingData )vqlists.get( i );
    	       %>
    	        	  
    	        	  <tr>
    	        	    <td width="2%" align="left" valign="top" class="main_font80"><img src="img/icon03.gif" alt="*" width="15" height="19"></td>
    	        	    <td width="25%" align="left" valign="top" class="main_font80"><a href="places_view.jsp?dataserno=<%=qlist.getSerno()%>&day1=<%=day1%>"><%=qlist.getSubject()%></a></td>
                        <td width="15%"align="left" valign="top" class="main_font80">
                 <%
                 PlaceData query = new PlaceData();
                 boolean rtn = query.load(qlist.getPlaceSerno() , "PlaceData");
                 %>
                 <%=query.getPlacename()%>
                        
                        </td>
                        <td width="10%" align="left" valign="top" class="main_font80"><%=qlist.getLiaisonPer()%></td>
    	        	    <td width="15%" align="left" valign="top" class="main_font80"><%=qlist.getLiaisonTel()%></td>
    	        	    <td width="20%" align="center" valign="top" class="main_font80">
    	        	      <%=tw.com.sysview.function.Datestr.timeformat(qlist.getSchedulSTime(),"2") %>~
                          <%=tw.com.sysview.function.Datestr.timeformat(qlist.getSchedulETime(),"2") %>&nbsp;&nbsp;
    	        	    </td>
    	        	  </tr>
    	              <tr>
    	                <td colspan="6" align="left" valign="top" background="img/line.gif">&nbsp;</td>
    	              </tr>
    	          <%}%>
    	      </table>
    	    </td>
    	  </tr>
<%--     	  <input type="hidden" name="intpage" value="<%=intpage%>"/>  --%>
<!--     	  <tr> -->
<!--     	    <td align="left" valign="top"> -->
<%--     	      <jsp:include page="../../pubprogram/page.jsp"> --%>
<%--     	          <jsp:param name="startpage" value="<%=startpage%>"/> --%>
<%--     	          <jsp:param name="pagesize" value="<%=pagesize%>"/> --%>
<%--     	          <jsp:param name="intpage" value="<%=intpage%>"/> --%>
<%--     	          <jsp:param name="maxpage" value="<%=maxpage%>"/> --%>
<%--     	          <jsp:param name="endpage" value="<%=endpage%>"/> --%>
<%--     	          <jsp:param name="rcount" value="<%=rcount%>"/> --%>
<%--     	          <jsp:param name="formname" value="mform"/> --%>
<%--     	      </jsp:include> --%>
<!--     	    </td> -->
<!--     	  </tr> -->
      <%}else{%>
    	  <tr>
    	    <td colspan="4">&nbsp;</td>
    	  </tr>
    	  <tr>
    	    <td colspan="4" align="center" valign="top" class="main_title80">目前無場地租借資料</td>
    	  </tr>
      <%}%>
    <tr>
      <td align="left" valign="top">&nbsp;</td>
      <td align="left" valign="top">&nbsp;</td>
      <td align="left" valign="top">&nbsp;</td>
      <td align="center" valign="top">&nbsp;</td>
    </tr>
</table>

</form>

