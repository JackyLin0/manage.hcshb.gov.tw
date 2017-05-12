<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- 
Programming Name: 駕駛人員休假、值班 - 列表
Programming File: drive102.jsp
Copyright © SYSTEX B17E By Peilun 2012-04-06
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
<link href="css/calendar.css" rel="stylesheet" type="text/css"/>

<script>
  function add(mdate)
  {
	  document.mform.mdate.value = mdate;
	  document.mform.action="drive102_add.jsp";
      document.mform.method="post";
      document.mform.submit();
  }
  
  function mdy(mdate)
  {
	  document.mform.mdate.value = mdate;
	  document.mform.action="drive102_mdy.jsp";
	  document.mform.method="post";
	  document.mform.submit();
  }
</script>
</head>

<%@ page import="java.util.*"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  //取login者單位(第四層)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
 
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());
  
  String role = ( String )session.getAttribute("role");
  
  int currYear = 0;
  int currMonth = 0;

  Calendar c = Calendar.getInstance();
  Calendar cal = Calendar.getInstance();

  String month = ( String )request.getParameter( "month" );
  String year = ( String )request.getParameter( "year" );
  String upyear = ( String )request.getParameter( "upyear" );
  
  if ( upyear == null || upyear.equals("null") ) {
	  if ( year == null || year.equals("null") ) {
		  currYear = c.get(Calendar.YEAR);
	  }else{
		  currYear = Integer.parseInt(year);
	  }
	  
	  if ( month == null || month.equals("null") ) {
		  currMonth = c.get(Calendar.MONTH);
	  }else{
		  cal.set(currYear, Integer.parseInt(month)-1 ,1);
		  currMonth = cal.get(Calendar.MONTH);
	  }
	  cal.set(currYear, currMonth,1);
  }else{
	  if ( year == null || year.equals("null") ) {
		  currYear = c.get(Calendar.YEAR);
	  }else{
		  currYear = Integer.parseInt(year);
	  }
	  
	  if ( month == null || month.equals("null") ) {
		  currMonth = c.get(Calendar.MONTH);
	  }else{
		  cal.set(currYear, Integer.parseInt(month)-1 ,1);
		  currMonth = cal.get(Calendar.MONTH);
	  }	
	  
	  if ( upyear.equals("1") ) {
		  cal.set(currYear, currMonth, 1);
		  cal.add(Calendar.YEAR, 1);
		  currYear = cal.get(Calendar.YEAR);
	  }else if ( upyear.equals("0") ) {
		  cal.set(currYear, currMonth ,1);
		  cal.add(Calendar.YEAR, -1);
		  currYear = cal.get(Calendar.YEAR);
	  }
  }

  String mhref = "drive102.jsp?t=" + table + "&language=" + language + "&year=" + currYear;
  String lmhref = mhref + "&upyear=0&month=" + month;
  String nmhref = mhref + "&upyear=1&month=" + month;
%>


<body>
<form name="mform">
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="language" value="<%=language %>"/>
<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
<input type="hidden" name="mdate"/>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
      <fieldset>
       <table width="100%" border="0" cellpadding="0" cellspacing="0">
         <tr class="in02">
           <td width="50%">
            說明：<img src="images/holiday.png" style="vertical-align:middle"/>&nbsp;休假人員、<img src="images/onshift.gif" style="vertical-align:middle"/>&nbsp;值班人員
           </td>
           <td width="">&nbsp;</td>
         </tr>
       </table>
      </fieldset>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF" align="center">
      <table width="50%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center" valign="top" class="calendar_month">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left" valign="middle" class="calendar_fnot"><a href="<%=lmhref%>" title="上一年">上一年</a></td>
              </tr>
            </table>
          </td>
          <td align="center" valign="top" class="main_font13b"><%=cal.get(Calendar.YEAR)%>&nbsp;年</td>
          <td align="center" valign="top" class="calendar_month2">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left" valign="middle" class="calendar_fnot"><a href="<%=nmhref%>" title="下一年">下一年</a></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="99%" align="left" background="images/ssl/bg_r1_c1.jpg">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="5%"><img src="images/ssl/<%=cal.get(Calendar.MONTH)+1%>m.gif" width="165" height="79" alt="<%=cal.get(Calendar.MONTH)+1%>月"></td>
                <td width="95%" align="left" valign="bottom">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left">
                        <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center"><a href="<%=mhref%>&month=1" class="bt">1</a></td>
                            <td align="center"><a href="<%=mhref%>&month=2" class="bt">2</a></td>
                            <td align="center"><a href="<%=mhref%>&month=3" class="bt">3</a></td>
                            <td align="center"><a href="<%=mhref%>&month=4" class="bt">4</a></td>
                            <td align="center"><a href="<%=mhref%>&month=5" class="bt">5</a></td>
                            <td align="center"><a href="<%=mhref%>&month=6" class="bt">6</a></td>
                            <td align="center"><a href="<%=mhref%>&month=7" class="bt">7</a></td>
                            <td align="center"><a href="<%=mhref%>&month=8" class="bt">8</a></td>
                            <td align="center"><a href="<%=mhref%>&month=9" class="bt">9</a></td>
                            <td align="center"><a href="<%=mhref%>&month=10" class="bt">10</a></td>
                            <td align="center"><a href="<%=mhref%>&month=11" class="bt">11</a></td>
                            <td align="center"><a href="<%=mhref%>&month=12" class="bt">12</a></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td><img src="images/ssl/0.gif" width="27" height="10" alt="*"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="1%" align="right"><img src="images/ssl/bg_r1_c2.jpg" width="16" height="79" alt="*"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><img src="images/ssl/0.gif" alt="*" width="27" height="5"></td>
        </tr>
        <tr> 
          <td>
            <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#ACC1F4">
              <tr>
                <td align="center" valign="top" bgcolor="#FFCCFF" class="in02">日</td>
                <td align="center" valign="top" bgcolor="#FFCCFF" class="c003">一</td>
                <td align="center" valign="top" bgcolor="#FFCCFF" class="c003">二</td>
                <td align="center" valign="top" bgcolor="#FFCCFF" class="c003">三</td>
                <td align="center" valign="top" bgcolor="#FFCCFF" class="c003">四</td>
                <td align="center" valign="top" bgcolor="#FFCCFF" class="c003">五</td>
                <td align="center" valign="top" bgcolor="#FFCCFF" class="in02">六</td>
              </tr>
              <%
                //取得本月最後一天是幾日
                int last = cal.getActualMaximum(Calendar.DATE);
              
                //取得本月第一天是星期幾(0~6，0:日、1:一)
                int m = currMonth;
                cal.set(currYear,m,1);
                int firstw = cal.get(Calendar.DAY_OF_WEEK)-1;
                
                //取得本月最後一天是星期幾(0~6，0:日、1:一)
                cal.set(currYear,m,last);
                int lastw = cal.get(Calendar.DAY_OF_WEEK)-1;
                
                //取得本月共有幾週
                int monthweek = cal.get(Calendar.WEEK_OF_MONTH);
                
                int WeekDay = 1;
                String datayear = String.valueOf(cal.get(Calendar.YEAR));
                String datamonth = String.valueOf(cal.get(Calendar.MONTH) + 1);
                if ( datamonth.length() == 1 )
                	datamonth = "0" + datamonth;
                
                for ( int w=1; w<=monthweek; w++ ) { %>
                	<tr>
                	  <%
                	    for ( int d=0; d<7; d++ ) {                	    	
                	    	if ( w == 1 && d < firstw ) { %>
                	    		<td width="10%" align="left" valign="top" bgcolor="#DFEFFF">&nbsp;</td>
                	    	<%}else if ( w == monthweek && d > lastw ) { %>
                	    		<td width="10%" align="left" valign="top" bgcolor="#DFEFFF">&nbsp;</td>
                	    	<%}else{
                	    		String mday = String.valueOf(WeekDay);
                	    		if ( mday.length() == 1 )
                	    			mday = "0" + mday;
                	    		String mdate = datayear + datamonth + mday;
                	    		//String mdates = datayear + datamonth + mday;

                	    		DriveData query = new DriveData();
                	    		ArrayList qlists = query.findByDriverState( table, mdate );

                	    		String count = "";
                	    		if ( qlists != null && qlists.size() > 0 ) {
                	    			count = String.valueOf(qlists.size());
                	    		}

                	    		String fontcolor = "";
                	    		String efont = "";
                	    		if ( d == 0 ) {
                	    			fontcolor = "<font color='#FF0000'>";
                	    			efont = "</font>";
                	    		}
                	    	    if ( d == 6 ) {
                	    	    	fontcolor = "<font color='#FF0000'>";
                	    			efont = "</font>";
                	    	    }%>
                	    	    <td width="10%" align="left" valign="top" bgcolor="#FFFFFF">
                	    	      <table width="98%" border="0" cellspacing="0" cellpadding="0">
                	    	        <tr>
                	    	          <td align="left" valign="top" class="day"><%=fontcolor%><%=WeekDay%><%=efont%></td>
                	    	        </tr>
                	    	        <%
                	    	          if ( qlists != null && qlists.size() > 0 ) {
                	    	        	  int num = qlists.size();
                	    	        	  /*
                	    	        	  if ( num > 3 )
                	    	        		  num = 3;
                	    	        	  */
                	    	        	  for ( int i=0; i<num; i++ ) {
                	    	        		  DriveData qlist = ( DriveData )qlists.get( i );
                	    	        		  //String ohref = onehref + "&dataserno=" + qlist.getSerno(); %>
                	    	        		  <tr>
                	    	        		    <td align="left"> 
                	    	        		      <font size="2" color="#333333">
                	    	        		      <%
                	    	        		        String pic_display = "holiday.png";
                	    	        		        if ( qlist.getState().equals("2") ) {
                	    	        		        	pic_display = "onshift.gif";
                	    	        		        } %>
                	    	        		      <img src="images/<%=pic_display %>" style="vertical-align:middle"/>
                	    	        		      <%=qlist.getName() %>
                	    	        		      </font>
                	    	        		    </td>
                	    	        		  </tr>
                	    	        	  <%}
                	    	        	  if ( qlists.size() >= 6 ) {
                	    	        		  for ( int j=0; j<5; j++ ) { %>
                	    	        			  <tr>
                	    	        			    <td align="left">&nbsp;</td>
                	    	        			  </tr>
                	    	        		  <%}
                	    	        	  }else{
                	    	        		  for ( int j=0; j<6-qlists.size(); j++ ) { %>
                	    	        			  <tr>
                	    	        			    <td align="left">&nbsp;</td>
                	    	        			  </tr>
                	    	        		  <%}
                	    	        	  }%>

                	    	          <%}else{
                	    	        	  for ( int i=0; i<6; i++ ) { %>
                	    	        		  <tr>
                	    	        		    <td align="left">&nbsp;</td>
                	    	        		  </tr>
                	    	        	  <%}
                	    	          }%>
                	    	        <tr>
                	    	          <td align="right">
                	    	            <%
                	    	              if ( qlists != null && qlists.size() > 0 ) { %>
                	    	            	  <a href="javascript:mdy('<%=mdate %>')" class="in02">編輯</a>
                	    	            <%
                	    	              } else { %>
                	    	            	  <a href="javascript:add('<%=mdate %>')" class="in02">新增</a>
                	    	            <%
                	    	              } %>
                	    	          </td>
                	    	        </tr>
                	    	      </table>
                	    	    </td>
                	    	    <%
                	    	    WeekDay += 1;
                	    	}
                	    }%>
                	</tr>    
                <%}%>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</form>
</body>
</html>