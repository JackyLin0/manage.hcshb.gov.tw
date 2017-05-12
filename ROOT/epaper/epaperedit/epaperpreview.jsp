<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<!--
程式名稱：epaperpreview.jsp
說明：電子報預覽
開發者：chmei
開發日期：97.03.22
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

<%
  String periodical = ( String )request.getParameter( "periodical" );

  //取系統路徑
  String sysRoot = (String) application.getRealPath("");

  //判斷OS版本
  String Upload_PATH = "";
  if ( sysRoot.indexOf("/") == -1 )
	  Upload_PATH = sysRoot + "\\WEB-INF\\epaper.properties";
  else
	  Upload_PATH = sysRoot + "/WEB-INF/epaper.properties";

  Properties upload = new Properties();
  upload.load(new FileInputStream(Upload_PATH) );
  String syspath = upload.getProperty("epaperpreview");
  
  EpaperPreviewData qmaster = new EpaperPreviewData();
  boolean prtn = qmaster.load(periodical);
  String serno = "";
  String imgserno = "";
  if ( prtn ) {
	  serno = qmaster.getSerno();
	  imgserno = qmaster.getImgserno();
  }
  
  //尋找Logo圖
  String imgfile = "index_02.jpg";
  String expfile = "健康新竹縣電子報";
  EpaperPreviewData qlogo = new EpaperPreviewData();
  boolean logortn = qlogo.loadlogo(imgserno);
  if ( logortn ) {
	  imgfile = qlogo.getServerfile();
	  expfile = qlogo.getExpfile();
  }	 
  
  //尋找此期刊之類別檔
  EpaperPreviewData qmclass = new EpaperPreviewData();
  ArrayList qclasss = qmclass.findByclass(serno);
  int crcount = qmclass.getAllrecordCount();
  
%>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #EBEAD3;
}
.top_bg {
	background-image: url(<%=syspath%>/images/<%=imgfile%>);
	background-repeat: no-repeat;
	background-position: left top;
	height: 98px;
	width: 836px;
}
.update {
	font-family: "新細明體";
	font-size: 80%;
	font-weight: normal;
	color: #000000;
	line-height: 18px;
}
.title_80 {
	font-family: "新細明體";
	font-size: 95%;
	font-weight: normal;
	color: #006699;
}
.buttom {
	font-family: "新細明體";
	font-size: 80%;
	color: #000000;
	text-decoration: none;
	display: block;
	font-weight: normal;
	height: 25px;
}
.buttom  A:link{
	color: #000000;
	text-decoration: none;
	display: block;
	background-repeat: no-repeat;
	background-position: left top;
	padding-top: 8px;
	padding-left: 10px;
	height: 25px;
}
.buttom A:visited{
	color: #000000;
	text-decoration: none;
	display: block;
	background-repeat: no-repeat;
	background-position: left top;
	padding-top: 8px;
	padding-left: 10px;
	height: 25px;
}
.buttom a:hover{
	color: #0033CC;
	text-decoration: underline;
	display: block;
	background-repeat: no-repeat;
	background-position: left top;
	padding-top: 8px;
	padding-left: 10px;
	height: 25px;
}
.font_black {	font-family: "新細明體";
	font-size: 95%;
	line-height: 18px;
	font-weight: normal;
	color: #000000;
	text-decoration: none;
}
.font_black {
	font-family: "新細明體";
	font-size: 95%;
	line-height: 18px;
	font-weight: normal;
	color: #000000;
	text-decoration: none;
}
.font_black  A:link{
	font-family: "新細明體";
	line-height: 18px;
	font-weight: normal;
	color: #000000;
	text-decoration: none;
}
.font_black A:visited{
	font-family: "新細明體";
	line-height: 18px;
	font-weight: normal;
	color: #000000;
	text-decoration: none;
}
.font_black a:hover{
	font-family: "新細明體";
	line-height: 18px;
	font-weight: normal;
	color: #797979;
	text-decoration: underline;
}
.font_80 {	font-family: "新細明體";
	font-size: 95%;
	color: #797979;
}
.font_black1 {	font-family: "新細明體";
	font-size: 95%;
	line-height: 18px;
	font-weight: normal;
	color: #000000;
	text-decoration: none;
}
-->
</style>

<body>
<table width="50%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width="1%" align="left" valign="top" background="<%=syspath%>/epapersend/img/index_01.jpg"><img src="<%=syspath%>/epapersend/img/index_01.jpg" alt="<%=expfile%>" width="13" height="13"></td>
    <td align="left" valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="left" valign="top" class="top_bg"><div><img src="<%=syspath%>/epapersend/img/logo.gif" alt="<%=expfile%>"/></div></td>
        </tr>
        <tr>
          <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="12%" align="left" valign="top" class="update">
                  <table width="10%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="<%=syspath%>/epapersend/img/index_04.jpg">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td colspan="2" align="left" valign="top"><img src="<%=syspath%>/epapersend/img/d.gif" alt="" width="102" height="5"/></td>
                          </tr>
                          <tr>
                            <td width="21%" align="left" valign="top"><img src="<%=syspath%>/epapersend/img/d.gif" alt="" width="5" height="60"/></td>
                            <td width="79%" align="left" valign="middle">發刊日期<%=qmaster.getSenddate().substring(0,4)%>.<%=qmaster.getSenddate().substring(4,6)%>.<%=qmaster.getSenddate().substring(6,8)%></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
                <td width="88%" align="left" valign="top">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left" valign="top" background="<%=syspath%>/epapersend/img/index_05.jpg">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                          <%
                            if ( qclasss != null ) { 
                            	int num = 0;
                            	for ( int i=0; i<crcount; i++ ) {
                            		num = num + 1;
                            		EpaperPreviewData qclass = ( EpaperPreviewData )qclasss.get( i );
                            		if ( num > 9 ) { %>
                            			</tr>
                            			<tr>
                            			<%
                            			  num = 0;
                            		}%>
                            		<td align="left" valign="top" class="buttom"><a href="#<%=qclass.getMserno()%>"><%=qclass.getMclassname()%></a></td>
                            	<%}
                            }%>
                          </tr>
                        </table>
                      </td>
                      <td width="1%" align="right" valign="top" background="<%=syspath%>/epapersend/img/index_05.jpg"><img src="<%=syspath%>/epapersend/img/index_07.jpg" alt="" width="14" height="65"/></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td align="left" valign="top"><img src="<%=syspath%>/epapersend/img/index_10.jpg" alt="" width="836" height="17"/></td>
        </tr>
        <%
          if ( qclasss != null ) {
        	  for ( int j=0; j<crcount; j++ ) {
        		  EpaperPreviewData qclass = ( EpaperPreviewData )qclasss.get( j );
        		  //尋找明細資料
        		  EpaperPreviewData qmdetail = new EpaperPreviewData();
    			  ArrayList qdetails = qmdetail.findBydetail(qclass.getSerno(),qclass.getMserno());
    			  int drcount = qmdetail.getAllrecordCount();
        		  if ( qclass.getMclassname().equals("訊息快遞") ) { 
        			  String startdate = "";
        			  String enddate = "";
        			  if ( qdetails != null ) {
        				  for ( int k=0; k<drcount; k++ ) {
        					  EpaperPreviewData qdetail = ( EpaperPreviewData )qdetails.get( k );
        					  startdate = qdetail.getStartdate();
        					  enddate = qdetail.getEnddate();
        				  }
        			  }
        			  //尋找活動訊息資料
        			  EpaperPreviewData qmact = new EpaperPreviewData();
        			  ArrayList qacts = qmact.findByact(startdate,enddate);
        			  int actrcount = qmact.getAllrecordCount();  %>
        			  <tr>
        			    <td align="left" valign="top">
        			      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        			        <tr>
        			          <td width="1%" align="left" valign="top"><img src="<%=syspath%>/epapersend/img/index_11.jpg" alt="單元：" width="86" height="49"/></td>
        			          <td align="left" valign="top">
        			            <table width="100%" border="0" cellspacing="0" cellpadding="0">
        			              <tr>
        			                <td align="left" valign="top"><img src="<%=syspath%>/epapersend/img/d.gif" alt="" width="5" height="25"/></td>
        			              </tr>
        			              <tr>
        			                <td align="left" valign="top" class="title_80"><a name="<%=qclass.getMserno()%>"><%=qclass.getMclassname()%></a></td>
        			              </tr>
        			            </table>
        			          </td>
        			        </tr>
        			        <tr>
        			          <td colspan="2" align="left" valign="top">
        			            <table width="100%" border="0" cellspacing="0" cellpadding="0">
        			              <%
        			                if ( qacts != null ) {
        			                	for ( int a=0; a<actrcount; a++ ) {
        			                		EpaperPreviewData qact = ( EpaperPreviewData )qacts.get( a );
        			                		String mactsdate = qact.getActsdate().substring(0,4) + "." + qact.getActsdate().substring(4,6) + "." + qact.getActsdate().substring(6,8);
        			                		String mactedate = qact.getActedate().substring(0,4) + "." + qact.getActedate().substring(4,6) + "." + qact.getActedate().substring(6,8);
        			                		String actdate = mactsdate + "～" + mactedate;
        			                		String msubject = qact.getSubject();
        			                		if ( msubject.length() > 30 )
        			                			msubject = qact.getSubject().substring(0,30) + "......";  %>
        			                		<tr>
        			                		  <td width="3%" align="left" valign="top" ><img src="<%=syspath%>/epapersend/img/icon.jpg" alt="*" width="27" height="14"/></td>
        			                		  <td width="97%" align="left" valign="top" class="font_black"><%=actdate%>　<%=msubject%></td>
        			                		</tr>
        			                	<%}
        			                }%>
        			            </table>
        			          </td>
        			        </tr>
        			      </table>
        			    </td>
        			  </tr>
        			  <tr>
        			    <td align="left" valign="top" background="<%=syspath%>/epapersend/img/index_16.jpg">&nbsp;</td>
        			  </tr>
        		  <%}else{        			  
        			  if ( qdetails != null ) {  %>
        				  <tr>
        				    <td align="left" valign="top">
        				      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        				        <tr>
        				          <td align="left" valign="top">
        				            <table width="100%" border="0" cellspacing="0" cellpadding="0">
        				              <tr>
        				                <td width="1%" align="left" valign="top"><img src="<%=syspath%>/epapersend/img/index_11.jpg" alt="單元：" width="86" height="49"/></td>
        				                <td align="left" valign="top">
        				                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
        				                    <tr>
        				                      <td align="left" valign="top"><img src="<%=syspath%>/epapersend/img/d.gif" alt="" width="5" height="25"/></td>
        				                    </tr>
        				                    <tr>
        				                      <td align="left" valign="top" class="title_80"><a name="<%=qclass.getMserno()%>"><%=qclass.getMclassname()%></a></td>
        				                    </tr>
        				                  </table>
        				                </td>
        				              </tr>
        				            </table>
        				          </td>
        				        </tr>
        				        <tr>
        				          <td align="left" valign="top">
        				            <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0">
        				              <%
        				                String dataserno = "";
        				                for ( int k=0; k<drcount; k++ ) {
        				                	EpaperPreviewData qdetail = ( EpaperPreviewData )qdetails.get( k );
        				                	//尋找資料
        				                	EpaperPreviewData qdata = new EpaperPreviewData();
        				                	boolean rtn = qdata.loaddata(qdetail.getTablename(),qdetail.getESerno());
        				                	String author = "";
        				                	String publisher = "";
        				                	String examiner = "";
        				                	String mcontent = "";
        				                	
        				                	if ( rtn ) {
        				                		dataserno = qdata.getSerno();
        				                		author = qdata.getAuthor();
        				                		publisher = qdata.getPublisher();
        				                		examiner = qdata.getExaminer();
        				                		mcontent = qdata.getContent();
        				                	}
        				                	if ( mcontent != null && !mcontent.equals("null") && !mcontent.equals("") ) {
        				                		if ( mcontent.length() > 200 )
        				                			mcontent = mcontent.substring(0,200) + "......";
        				                	}
        				                		
        				                	//尋找圖片
        				                	String filename = "EpaperFile";
        				                	String path = "/epaper/epaperdata";
        				                	if ( qdetail.getTablename().equals("TalkHealth") ) {
        				                		filename = "TalkHealthFile";
        				                		path = "/hcshb/talkhealth";
        				                	}
        				                		
        				                	EpaperPreviewData qfile = new EpaperPreviewData();
        				                	boolean frtn = qfile.loadfile(filename,qdetail.getESerno());
        				                	String msfile = "index_img05.jpg";
        				                	String mexp = "";
        				                	if ( frtn ) {
        				                		mexp = qfile.getExpfile();
        				                		if ( qfile.getImagemagick() != null && !qfile.getImagemagick().equals("null") && !qfile.getImagemagick().equals("") ) 
        				                			msfile = qfile.getImagemagick();
        				                		else
        				                			msfile = qfile.getServerfile();
        				                	}%>
        				        	        <tr>
        				        	          <td width="14%" align="left" valign="top"><img src="../../uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic" alt="<%=mexp%>" width="140" height="120"/></td>
        				        	          <td width="86%" align="left" valign="top">
        				        	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
        				        	              <%
        				        	                if ( author != null && !author.equals("null") && !author.equals("") ) { %>
        				        	                	<tr>
        				        	                	  <td width="2%" align="left" valign="top"><img src="<%=syspath%>/epapersend/img/icon2.jpg" alt="" width="16" height="14"/></td>
        				        	                	  <td width="98%" align="left" valign="top" class="font_black1"><%=author%></td>
        				        	                	</tr>
        				        	                <%}
        				        	                if ( publisher != null && !publisher.equals("null") && !publisher.equals("") ) {  %>
        				        	                	<tr>
        				        	                	  <td width="2%" align="left" valign="top"><img src="<%=syspath%>/epapersend/img/icon2.jpg" alt="" width="16" height="14"/></td>
        				        	                	  <td width="98%" align="left" valign="top" class="font_black1"><%=publisher%></td>
        				        	                	</tr>
        				        	                <%}
        				        	                if ( examiner != null && !examiner.equals("null") && !examiner.equals("") ) {  %>
        				        	                	<tr>
        				        	                	  <td width="2%" align="left" valign="top"><img src="<%=syspath%>/epapersend/img/icon2.jpg" alt="" width="16" height="14"/></td>
        				        	                	  <td width="98%" align="left" valign="top" class="font_black1"><%=examiner%></td>
        				        	                	</tr>
        				        	                <%}%>
        				        	              <tr>
        				        	                <td align="left" valign="top"><img src="<%=syspath%>/epapersend/img/icon2.jpg" alt="" width="16" height="14"/></td>
        				        	                <td align="left" valign="top">標題：<%=qdetail.getSubject()%></td>
        				        	              </tr>
        				        	              <%
        				        	                if ( mcontent != null && !mcontent.equals("null") && !mcontent.equals("") ) { %>
        				        	                	<tr>
        				        	                	  <td colspan="2" align="left" valign="top"><img src="hcshb/img/d.gif" alt="" width="1" height="4"></td>
        				        	                	</tr>
        				        	                	<tr>
        				        	                	  <td align="left" valign="top">&nbsp;</td>
        				        	                	  <td align="left" valign="top" class="font_80"><%=mcontent%></td>
        				        	                	</tr>
        				        	                <%}%>
        				        	            </table>
        				        	          </td>
        				        	        </tr>
        				        	        <%
        				        	          if ( k < drcount-1 ) {  %>
        				        	        	  <tr>
        				        	        	    <td colspan="2" align="right" valign="top">
        				        	        	      <table width="10%" border="0" cellspacing="0" cellpadding="0">
        				        	        	        <tr>
        				        	        	          <td align="left" valign="top"><a href="<%=syspath%>/epapersend/epaperpreview_view.jsp?dataserno=<%=dataserno%>&mserno=<%=qclass.getMserno()%>&periodical=<%=periodical%>&perserno=<%=serno%>&syspath=<%=syspath%>" target="_blank"><img src="<%=syspath%>/epapersend/img/index_17.jpg" alt="詳全文" width="63" height="28" border="0"/></a></td>
        				        	        	          <td align="left" valign="top"><a href="#"><img src="<%=syspath%>/epapersend/img/index_18.jpg" alt="top" width="76" height="28" border="0"/></a></td>
        				        	        	        </tr>
        				        	        	      </table>
        				        	        	    </td>
        				        	        	  </tr>
        				        	          <%}
        				        	    }%>
        				        	    <tr>
        				        	      <td colspan="2" align="right" valign="top" background="<%=syspath%>/epapersend/img/index_16.jpg">
        				        	        <table width="10%" border="0" cellspacing="0" cellpadding="0">
        				        	          <tr>
        				        	            <td><a href="<%=syspath%>/epapersend/epaperpreview_view.jsp?dataserno=<%=dataserno%>&mserno=<%=qclass.getMserno()%>&periodical=<%=periodical%>&perserno=<%=serno%>&syspath=<%=syspath%>" target="_blank"><img src="<%=syspath%>/epapersend/img/index_17.jpg" alt="詳全文" width="63" height="28" border="0"/></a></td>
        				        	            <td><a href="#"><img src="<%=syspath%>/epapersend/img/index_18.jpg" alt="top" width="76" height="28" border="0"/></a></td>
        				        	          </tr>
        				        	        </table>
        				        	      </td>
        				        	    </tr>
        				        	</table>
        				          </td>	    
        				        </tr>
        				      </table>
        				    </td>
        				  </tr> 
        			  <%}
        		  }
        	  }
          }%>
      </table>
    </td>
    <td width="1%" align="left" valign="top" background="<%=syspath%>/epapersend/img/index_03.jpg"><img src="<%=syspath%>/epapersend/img/index_03.jpg" alt="" width="13" height="13"></td>
  </tr>
</table>          	  

</body>
</html>
