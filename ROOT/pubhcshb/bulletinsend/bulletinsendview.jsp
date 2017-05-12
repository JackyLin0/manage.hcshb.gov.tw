<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<!--
程式名稱：nulletinsendview.jsp
說明：新聞稿預覽
開發者：yclai
開發日期：103.08.25
修改者：
修改日期：
版本：ver1.0
-->


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%> 
<%@ page import="tw.com.sysview.dba.*" %>


<body>
<div class=WordSection1>

<%
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
  String ndate = fmt.format(Calendar.getInstance().getTime());

  String subject = ( String )request.getParameter( "subject" );
  String serno = ( String )request.getParameter( "serno" );
  String language = ( String )request.getParameter( "language" );
  
//   response.setHeader("Content-disposition","attachment; filename="+serno+".doc");
  
  int widthnum = 1;
  int mwidth = 92 / widthnum;
  
  
   //尋找縣府新聞資料
   BulletinSendData qdata = new BulletinSendData();
   boolean rtn = qdata.load("Bulletinsend", serno);
       
      %>
       <table width="100%" border="1" cellpadding="1" cellspacing="1" style="font-size:14px;font-family:新細明體">
         <thead>
           <tr align="center" height="40">
             <td colspan="6"><font size="5">新竹縣政府<%=qdata.getPubunitname()%>新聞稿 </font></td>
           </tr>
          <tr align="center">
               <td colspan="1" width="10%" align="center"><font size="4">日期</font></td>
               <td colspan="1" width="20%" align="center"><%=tw.com.sysview.function.Datestr.date_chinese(qdata.getPosterdate(),"")%></td>
               <td colspan="1" width="15%" align="center"><font size="4">撰稿單位</font></td>
               <td colspan="1" width="15%" align="center"></td>
               <td colspan="1" width="15%" align="center"><font size="4">聯絡人</font></td>
               <td colspan="1" width="15%" align="center"></td>
             </tr>
             <tr align="center" height="45">
               <td colspan="1" align="left" align="center"><font size="4">標 題</font></td>
               <td colspan="5" align="left"><font size="4"><%=qdata.getSubject()%></font></td>
             </tr>
             <tr align="center" height="45">
               <td colspan="1" align="left" align="center"><font size="4">公告<br>方式</font></td>
               <td colspan="5" align="left"><font size="5">□</font><font size="4">本局網頁</font><font size="5">□</font><font size="4">新聞稿 </font></td>
             </tr>
            </thead>
       </table>
     <%if ( qdata.getContent() != null && !qdata.getContent().equals("null") ) { %>
          <p ><%=qdata.getContent().replaceAll("\n","<br>").replaceAll(" ","&nbsp;")%></p>
     <%}%>
     
     <%if ( qdata.getRelateurl() != null && !qdata.getRelateurl().equals("null") && !qdata.getRelateurl().equals("") && !qdata.getRelateurl().equals("http://") ) { %>
     <br>
                      相關資訊連結：<a href="<%=qdata.getRelateurl()%>"><%=qdata.getRelatename()%></a>
     <%}%>  
       
       
          <jsp:include page="../../pubprogram/upload/file_list1.jsp">
            <jsp:param name="serno" value="<%=qdata.getSerno()%>"/>
            <jsp:param name="table" value="BulletinsendFile"/>
            <jsp:param name="path" value="/pubhcshb/bulletinsend"/>
          </jsp:include>
          
      <br>  
      <table width="100%" border="1" cellpadding="1" cellspacing="1" style="font-size:14px;font-family:新細明體">
        <tr align="center" height="40">
         <td width="10%"><font size="4">承辦人 </font></td>
         <td width="10%" align="center"> </td>
         <td width="10%"><font size="4"> 科長 </font></td>
         <td width="10%" align="center"> </td>
         <td width="10%"><font size="4">秘書</font></td>
         <td width="10%" align="center"> </td>
         <td width="10%"><font size="4">副局長 </font></td>
         <td width="10%" align="center"> </td>
         <td width="10%"><font size="4">局長 </font></td>
         <td width="10%" align="center"> </td>
        </tr>
      </table>
                                                                                                                                          
  
</div>            

</body>
</html>
