<%@page import="tw.com.sysview.dba.meeting.MeetingData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<%@ page import="tw.com.sysview.dba.*"%>
<%@ page import="sysview.zhiren.function.*"%>
<%
 String table = (String) request.getParameter("t");
 String table1 = (String) request.getParameter("t1");
 String logindn = (String) session.getAttribute("logindn");
 //取login者單位(第四層)
 String pubunitdn = logindn;
 String[] ary_pubunitdn = SvString.split(pubunitdn, ",");
 if (ary_pubunitdn.length > 4) {
  for (int i = 0; i < ary_pubunitdn.length - 4; i++) {
   pubunitdn = SvString.right(pubunitdn, ",");
  }
 }
 
 //單位DN與站台DN對照
 WebsiteUnitData qweb = new WebsiteUnitData();
 boolean webrtn = qweb.load(pubunitdn);
 String website = "";
 if (webrtn)
  website = qweb.getWebsitedn();
 

 String y1 = (String) request.getParameter("y1");
 String m1 = (String) request.getParameter("m1");
 String place = (String) request.getParameter("place");
 
 if (place != null && !place.equals("")) {
  session.setAttribute("place", place);
 } else {
  place = (String) session.getAttribute("place");
 }
 if (place == null || place.equals("")) {

  session.setAttribute("place", place);
 }
 
//  place = "201108070001";
 // VistPlace vp=new VistPlace();
 // ArrayList pqlist=vp.findByday();

 // vp=new VistPlace();
 // vp.load(place);

 //取系統日期
 SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
 String ndate = fmt.format(Calendar.getInstance().getTime());
 // FunHolidayData fh=new FunHolidayData();
 String startday = ndate;//fh.getPreDate(place,ndate,3,false);
 String thisyy = "";
 String thismonth = "";
 String preyy = "";
 String premm = "";
 String nextyy = "";
 String nextmm = "";
 if (y1 == null || y1.equals("")) {
  thisyy = ndate.substring(0, 4);
  int mon1 = Integer.parseInt(ndate.substring(4, 6));
  thismonth = String.valueOf(mon1);
  y1=thisyy;
  m1=thismonth;
 } else {
  thisyy = y1;
  thismonth = m1;
 }
 int mon = Integer.parseInt(thismonth);
 if (mon == 1) {
  preyy = String.valueOf(Integer.parseInt(thisyy) - 1);
  premm = "12";
 } else {
  preyy = thisyy;
  premm = String.valueOf(mon - 1);
 }
 if (mon == 12) {
  nextyy = String.valueOf(Integer.parseInt(thisyy) + 1);
  nextmm = "1";
 } else {
  nextyy = thisyy;
  nextmm = String.valueOf(mon + 1);
 }
 MeetingData visit=new MeetingData();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="img/css.css" type=text/css rel=stylesheet>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<!-- 欄位名稱(語系)，每支程式需include，且需放在form內 -->
<%-- <%@ include file="../../pubprogram/language.jsp"%> --%>


  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/>會議室預約行事曆</h2>

<SCRIPT>
 function link(y1,m1) {
  document.mform.y1.value=y1;
  document.mform.m1.value=m1;
  if(document.mform.place.value == '') {
	  alert("請選擇場地");
	  return;
  }
  
  document.mform.action = "place.jsp";
  document.mform.method = "post";
  document.mform.submit();
 }
 
 function link1(){
  document.mform.y1.value = document.mform.myear.value;
  document.mform.m1.value = document.mform.mmonth.value;
  if(document.mform.place.value == '') {
	  alert("請選擇場地");
	  return;
  }
  document.mform.action = "place.jsp";
  document.mform.method = "post";
  document.mform.submit();
  return;
 }
 
 function visit(scheduledate)
 {
   if(document.mform.place.value == '') {
	  alert("請選擇場地");
	  return;
   }
   document.mform.scheduledate.value=scheduledate;
   document.mform.action="placevisit201_add.jsp";
   document.mform.method="post";
   document.mform.submit();
 }
 
 function mdy(serno)
 {
   if(document.mform.place.value == '') {
	  alert("請選擇場地");
	  return;
   }
   document.mform.serno.value=serno;
   document.mform.action="placevisit201_mdy.jsp";
   document.mform.method="post";
   document.mform.submit();
 }
 
 function changplace(){
   if(document.mform.place.value == '') {
	alert("請選擇場地");
	return;
   }
	  
   document.mform.action = "place.jsp";
   document.mform.method = "post";
   document.mform.submit();
 }
 
</SCRIPT>
<STYLE type=text/css>
BODY {
 MARGIN: 0px;
 BACKGROUND-COLOR: #e0dfe3
}

.f2 {
 FONT-SIZE: 12px;
 COLOR: #000000;
 FONT-FAMILY: "新細明體"
}

.f3 {
 FONT-SIZE: 10px;
 COLOR: #009900;
 FONT-FAMILY: "細明體"
}

.f4 {
 FONT-SIZE: 10px;
 COLOR: #ff0000;
 FONT-FAMILY: "細明體"
}
</STYLE>
<BODY>
<form name="mform">
<input type="hidden" name="m1" value="<%=m1%>" />
<input type="hidden" name="y1" value="<%=y1%>" />
<input type="hidden" name="t" value="<%=table%>"/>
<input type="hidden" name="t1" value="<%=table1%>"/>
<input type="hidden" name="qwebsite" value="<%=website%>"/>
<input type="hidden" name="serno" value=""/>
<input type="hidden" name="scheduledate" value=""/>


 <TABLE cellSpacing=1 cellPadding=0 width=100% align=center bgColor=#C1C1C1 border=0>
  <TBODY>
   <tr>
    <td class="T12b" align="center"><span class="T12red">※</span>場地選擇 
     <jsp:include page="qplace.jsp">
       <jsp:param name="colname" value="place" />
       <jsp:param name="qwebsite" value="<%=website%>" />
       <jsp:param name="t" value="<%=table%>" />
       <jsp:param name="datavalue" value="<%=place%>" />
       <jsp:param name="onchange" value="onchange='changplace()'" />
       <jsp:param name="language" value="ch" />
     </jsp:include>
     <a href="http://manage.hcshb.gov.tw/pubhcshb/meetings/activityplace.jsp?t=PlaceData&t1=Meetings&y1=<%=y1%>&m1=<%=m1%>" target="_blank">活動行事曆</a>
    </td>
   </tr>
   <TR>
    <TD width="10%" align=middle vAlign=top bgcolor="#FFFFFF">
     <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
      <TBODY>
       <TR>
        <TD align="middle">
         <TABLE width="50%" border="0" align="center" cellPadding="0" cellSpacing="0">
          <TBODY>
           <TR>
            <TD bgColor="#e0dfe4">
             <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
              <TBODY>
               <TR>
                <TD><IMG height="48" alt="*" src="img/img_r6_c2.jpg" width="207"></TD>
                <TD vAlign="top">
                 <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                  <TBODY>
                   <TR>
                    <TD><IMG height="13" alt="*" src="img/img_r6_c5.jpg" width="351"></TD>
                   </TR>
                   <TR>
                    <TD>
                     <TABLE cellSpacing="0"cellPadding="0" width="100%" border="0">
                      <TBODY>
                       <TR>
                        <TD align="left" width="28%" >
                         <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                          <TBODY>
                           <TR>
                            <TD width="30%">
                            <A href="javascript:link(<%=preyy%>,<%=premm%>)" alt="上個月" >
                            <img src="img/img_r7_c5_1.jpg" height="25" border="0" ></A></TD>
                            <TD width="70%" background="img/img_r7_c5_2.jpg">
                              <A href="javascript:link(<%=preyy%>,<%=premm%>)" alt="上個月" class="f1">上個月</A>
                            </TD>
                           </TR>
                          </TBODY>
                         </TABLE>
                        </TD>
                        <TD><IMG height=25 alt=* src="img/img_r7_c8.jpg" width=14></TD>
                        <TD class="f1" align="middle" width="36%" background="img/img_r7_c9.jpg">
                        <select name="myear" onchange="link1()">
                        <%
                        for(int i=4; i>= 0; i--) {
                        	String isSelected = "";
                        	if ( thisyy.equals("" + (Integer.parseInt(thisyy)-i)) ){
                 			   isSelected = "selected";
                        	}
                       	%>
                          <option value="<%=Integer.parseInt(thisyy)-i%>" <%=isSelected%>><%=Integer.parseInt(thisyy)-i%></option>
                          
                        <%}
                        for(int i=1; i< 5; i++) {
                       	%>
                          <option value="<%=Integer.parseInt(thisyy)+i%>" ><%=Integer.parseInt(thisyy)+i%></option>
                          
                        <%} %>
                         </select>
                         
                         <select name="mmonth" onchange="link1()">
                          <option value="1" <%=thismonth.equals("1") ? "selected" :"" %>>1</option>
                          <option value="2" <%=thismonth.equals("2") ? "selected" :"" %>>2</option>
                          <option value="3" <%=thismonth.equals("3") ? "selected" :"" %>>3</option>
                          <option value="4" <%=thismonth.equals("4") ? "selected" :"" %>>4</option>
                          <option value="5" <%=thismonth.equals("5") ? "selected" :"" %>>5</option>
                          <option value="6" <%=thismonth.equals("6") ? "selected" :"" %>>6</option>
                          <option value="7" <%=thismonth.equals("7") ? "selected" :"" %>>7</option>
                          <option value="8" <%=thismonth.equals("8") ? "selected" :"" %>>8</option>
                          <option value="9" <%=thismonth.equals("9") ? "selected" :"" %>>9</option>
                          <option value="10" <%=thismonth.equals("10") ? "selected" :"" %>>10</option>
                          <option value="11" <%=thismonth.equals("11") ? "selected" :"" %>>11</option>
                          <option value="12" <%=thismonth.equals("12") ? "selected" :"" %>>12</option>
                         </select>
                        </TD>
                        <TD><IMG height=25 alt=* src=img/img_r7_c10.jpg width=15></TD>
                        <TD align=right width="28%" >
                         <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                          <TBODY>
                           <TR>
                            <TD align="center" width="70%" background="img/img_r7_c11_2.jpg">
                               <A href="javascript:link(<%=nextyy%>,<%=nextmm%>)" alt="下個月" class="f1">下個月</A>
                            </TD>
                            <TD width="30%">
                            <A href="javascript:link(<%=nextyy%>,<%=nextmm%>)" alt="下個月" >
                            <img src="img/img_r7_c11_1.jpg" height="25" border="0" ></A></TD>
                           </TR>
                          </TBODY>
                         </TABLE>
                        </TD>
                       </TR>
                      </TBODY>
                     </TABLE>
                    </TD>
                   </TR>
                   <TR>
                    <TD><IMG height="10" alt="*" src="img/img_r8_c5.jpg" width="351"></TD>
                   </TR>
                  </TBODY>
                 </TABLE>
                </TD>
                <TD align="right"><IMG height="48" alt="*" src="img/img_r6_c12.jpg" width="202"></TD>
               </TR>
              </TBODY>
             </TABLE>
            </TD>
           </TR>
           <TR>
            <TD bgColor="#e0dfe4">
             <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
              <TBODY>
               <TR>
                <TD vAlign=bottom width="1%" background="img/img_r10_c2.jpg"></TD>
                <TD width="98%" bgColor=#e0dfe4>
                 <%
                  Calendar cal = Calendar.getInstance();
                  int sdatey = Integer.parseInt(thisyy);
                  int sdatem = Integer.parseInt(thismonth);
                  //         FunHolidayData qday = new FunHolidayData();
                  //         ArrayList qlists = qday.findByday(place,thisyy+SvNumber.format(sdatem,"00"));
                  //         int rcount = qday.getAllrecordCount();    //取得假日總天數

                  cal.set(sdatey, sdatem - 1, 1); //設定選定的年月(註:月-->0~11)

                  //取得本月最後一天是幾日
                  int last = cal.getActualMaximum(Calendar.DATE);

                  //取得本月第一天是星期幾(0~6，0:日、1:一)
                  int m = sdatem - 1;
                  cal.set(sdatey, m, 1);
                  int firstw = cal.get(Calendar.DAY_OF_WEEK) - 1;

                  //取得本月最後一天是星期幾(0~6，0:日、1:一)
                  cal.set(sdatey, m, last);
                  int lastw = cal.get(Calendar.DAY_OF_WEEK) - 1;
                  //取得假日的日期(只取日)
                  String bday1 = "";
                  //             for ( int i=0; i<rcount; i ++ ){
                  //              FunHolidayData qlist = ( FunHolidayData )qlists.get( i );
                  //              if ( bday1.equals("") )
                  //               bday1 = (qlist.getHoliday()).substring(6,8);
                  //              else
                  //               bday1 = bday1 + "&" + (qlist.getHoliday()).substring(6,8);
                  //             }

 String ary_bday1[] = SvString.split(bday1, '&');
%>
<TABLE cellSpacing=1 cellPadding=5 width="100%" bgColor=#999999 border=0>
 <TBODY>
  <TR>
   <TD class="t1" vAlign="center" align="middle" width="14%" bgColor="#dfe9ff">星期日</TD>
   <TD class="t1" vAlign="center" align="middle" width="14%" bgColor="#dfe9ff">星期一</TD>
   <TD class="t1" vAlign="center" align="middle" width="14%" bgColor="#dfe9ff">星期二</TD>
   <TD class="t1" vAlign="center" align="middle" width="14%" bgColor="#dfe9ff">星期三</TD>
   <TD class="t1" vAlign="center" align="middle" width="14%" bgColor="#dfe9ff">星期四</TD>
   <TD class="t1" vAlign="center" align="middle" width="14%" bgColor="#dfe9ff">星期五</TD>
   <TD class="t1" vAlign="center" align="middle" width="14%" bgColor="#dfe9ff">星期六</TD>
  </TR>
<!-- I create a line -->
  <TR>
<!-- affiche une case vide -->
<%
//放空白
for (int i = 0; i < firstw; i++) {
%>
 <TD class="d1" vAlign="middle" align="center" width="14%" bgColor="#fffbec">&nbsp;</TD>
<%
}
int k = 0;
String isSelected = "";
//第一個星期之日
for (int i = firstw; i < 7; i++) {
	k = k + 1;
//自陣列搜尋字串(為了找尋此日是否為假日)
    String mk = SvNumber.format(k, "00");
    String day1 = thisyy + SvNumber.format(sdatem, "00") + mk;
    boolean find_day = SvString.contain(ary_bday1, mk);
    if (find_day == true)
    isSelected = "checked";
%>
  <TD class=d1 vAlign=top align=left width=14% bgColor=#ffffcc><SPAN class=t2><%=k%> <%
  if (find_day == false) {
    if (day1.compareTo(startday) >= 0) {
     %>
      <a href="javascript:visit(<%=day1%>)">我要預約</a>
      <%
    }
  }
 %> <BR> <%
 if(place != null){
 visit=new MeetingData();
 ArrayList vqlists=visit.findByday(table1, place, day1, "");
 if(visit.getAllrecordCount()>0){
   for(int vi=0;vi<visit.getAllrecordCount();vi++){
     MeetingData one=(MeetingData)vqlists.get(vi);
 %> 
    <IMG height="10" alt="*" src="img/icon_f1.png" /><a href="javascript:mdy(<%=one.getSerno()%>)" class="f6"><%=tw.com.sysview.function.Datestr.timeformat(one.getSchedulSTime(),"4")%>~<%=tw.com.sysview.function.Datestr.timeformat(one.getSchedulETime(),"4") %></a><br>
<%
   }
 }
 }
%> </SPAN></TD>
<%
   isSelected = "";
}
%>
  </TR>
<!-- I create a line -->
<%
 int bday = (last - k) / 7;
 for (int i = 0; i < bday; i++) {
%>
 <TR>
<%
//取其他日數(不含第一星期及最後一星期)
  isSelected = "";
  for (int j = 0; j < 7; j++) {
    k = k + 1;
	//自陣列搜尋字串(為了找尋此日是否為假日)
	String mk = SvNumber.format(k, "00");
	String day1 = thisyy + SvNumber.format(sdatem, "00") + mk;
	boolean find_day = SvString.contain(ary_bday1, mk);
%>
  <TD class=d1 vAlign=top align=left width=14% bgColor=#ffffcc><SPAN class=t2><%=k%> <%
   if (find_day == false) {
     if (day1.compareTo(startday) >= 0) {
 %> 
    <a href="javascript:visit(<%=day1%>)">我要預約</a>
 <%
     }
   }
  %> <BR> <%
 if(place != null){
 visit=new MeetingData();
 ArrayList vqlists=visit.findByday(table1, place, day1, "");
 if(visit.getAllrecordCount()>0){
   for(int vi=0;vi<visit.getAllrecordCount();vi++){
     MeetingData one=(MeetingData)vqlists.get(vi);
 %> 
    <IMG height="10" alt="*" src="img/icon_f1.png" /><a href="javascript:mdy(<%=one.getSerno()%>)" class="f6"><%=tw.com.sysview.function.Datestr.timeformat(one.getSchedulSTime(),"4")%>~<%=tw.com.sysview.function.Datestr.timeformat(one.getSchedulETime(),"4") %></a><br>
 <%
   }
 }
 }
%> </SPAN></TD>
<%
}
%>
  </TR>
<!-- I create a line -->
<%
 }
//取最後一星期
isSelected = "";
if (k < last) {
%>
  <TR>
<%
for (int i = 0; i <= lastw; i++) {
   k = k + 1;
   //自陣列搜尋字串(為了找尋此日是否為假日)
   String mk = SvNumber.format(k, "00");
   String day1 = thisyy + SvNumber.format(sdatem, "00") + mk;
   boolean find_day = SvString.contain(ary_bday1, mk);
%>
  <TD class=d1 vAlign=top align=left width=14% bgColor=#ffffcc><SPAN class=t2><%=k%> <%
  if (find_day == false) {
     if (day1.compareTo(startday) >= 0) {
 %> 
<a href="javascript:visit(<%=day1%>)">我要預約</a>
  <%
  }
    }
 %> <BR> <%
 if(place != null){
 visit=new MeetingData();
 ArrayList vqlists=visit.findByday(table1, place, day1, "");
 if(visit.getAllrecordCount()>0){
   for(int vi=0;vi<visit.getAllrecordCount();vi++){
     MeetingData one=(MeetingData)vqlists.get(vi);
 %> 
   <IMG height="10" alt="*" src="img/icon_f1.png" /><a href="javascript:mdy(<%=one.getSerno()%>)" class="f6"><%=tw.com.sysview.function.Datestr.timeformat(one.getSchedulSTime(),"4")%>~<%=tw.com.sysview.function.Datestr.timeformat(one.getSchedulETime(),"4") %></a><br>
 <%
    }
  }
 }
%> </SPAN></TD>
<%
}
//取空白
for (int i = lastw + 1; i < 7; i++) {
%>
	<TD class=d1 vAlign=top align=left width=14% bgColor=#fffbec>&nbsp;</TD>
<%
}
%>
  </TR>
<!-- I create a line -->
<%
}
%>
                  </TBODY>
                 </TABLE>
                </TD>
                <TD vAlign=bottom width="1%" background="img/img_r10_c2.jpg"></TD>
               </TR>
              </TBODY>
             </TABLE>
            </TD>
           </TR>
           <TR>
            <TD bgColor=#e0dfe4><IMG height="19" alt="*" src="img/img_r11_c2.jpg" width="760"></TD>
           </TR>
          </TBODY>
         </TABLE>
        </TD>
       </TR>
       <TR>
        <TD align=middle>&nbsp;</TD>
       </TR>
      </TBODY>
     </TABLE>
    </TD>
   </TR>
  </TBODY>
 </TABLE>
 </form>
</BODY>
</HTML>
