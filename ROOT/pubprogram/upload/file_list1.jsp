<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：file_list1.jsp
說明：檔案管理(文件檔案)-衛生局主網使用
開發者：chmei
開發日期：97.02.24
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.sysview.upload.*" %>

<%  
  String serno = ( String )request.getParameter( "serno" );
  String tablename = ( String )request.getParameter( "table" ); 
  String path = ( String )request.getParameter( "path" );
  //主圖是否重複出現(是否需要再將已設定為主圖之圖檔顯示，若不需要請傳變數mainimage=N，若需要則不需傳此參數)
  String mainimage = ( String )request.getParameter( "mainimage" );
  if ( mainimage == null || mainimage.equals("null") || mainimage.equals("") )
	  mainimage = "";
  
  //相關附件
  UploadData qupload = new UploadData();    
  ArrayList qfiles = qupload.findByday(tablename,serno,"doc");
  int rcount = qupload.getAllrecordCount();

  if ( rcount > 0 ) { %>
	  <tr>
	    <td colspan="2" align="left" valign="top">
	      <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td width="2%" align="left" valign="middle"><img src="http://www.hcshb.gov.tw/common/img/icon3.gif" alt="*" width="19" height="15" align="absmiddle" /></td>
	          <td colspan="2" align="left" valign="top"><span> 相關附件：</span></td>
	        </tr>
	        <%
	          for ( int i=0; i<rcount; i++ ) {
	        	  UploadData qfile = ( UploadData )qfiles.get( i ); 
	        	  //String filedata = qfile.getSerno() + "||" + qfile.getDetailno();
	        	  String msfile = qfile.getServerfile();  %>
	        	  <tr>
	        	    <td align="left" valign="middle">&nbsp;</td>
	        	    <td width="2%" align="left" valign="top" >&nbsp;</td>
	        	    <td width="96%" align="left" valign="top" >
	        	                  》<a href="http://www.hcshb.gov.tw/uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=doc" title="<%=qfile.getClientfile()%>(您將開啟附件新視窗)" target="_blank"><%=qfile.getClientfile()%></a><br/>
	        	    </td>                   
	        	  </tr>
	          <%}%>	        
	      </table>
	    </td>
	  </tr>
	  <tr>
	    <td colspan="2" align="left" valign="top" background="hcshb/img/line.gif">&nbsp;</td>
	  </tr>
  <%}
    
  //相關圖片    
  UploadData qupload1 = new UploadData();
  ArrayList qfiles1 = qupload1.findByday(tablename,serno,"pic");
  int rcount1 = qupload1.getAllrecordCount();
  
  //取出預設縮圖之寬及高
  String sysRoot = (String) application.getRealPath("");
  sysRoot = sysRoot.replace('\\','/');
  String PRO_PATH = sysRoot+"/WEB-INF/uploadpath.properties";	
  Properties p = new Properties();
  p.load(new FileInputStream(PRO_PATH));
  //String syspath = p.getProperty("picpath");
  //int imagewsize = Integer.parseInt(p.getProperty("imagewsize"));
  //int imagehsize = Integer.parseInt(p.getProperty("imagehsize"));
  
  if ( rcount1 > 0 ) { %>
  <table>
	  <tr>
	    <td colspan="2" align="left" valign="top">
	      <table width="80%" border="1" cellspacing="1" cellpadding="1">
	        <tr>
	          <td width="2%" align="left" valign="middle"><img src="http://www.hcshb.gov.tw/common/img/icon3.gif" alt="*" width="19" height="15" align="absmiddle" /></td>
	          <td colspan="5" align="left" valign="top"><span >相關圖檔：</span></td>
	        </tr>
	        <%
	          int k = 0;
	          for ( int i=0; i<rcount1; i++ ) {	        	  
	        	  UploadData qfile1 = ( UploadData )qfiles1.get( i );
	        	
	        	  String msfile = qfile1.getServerfile();
// 	        	  if ( qfile1.getImagemagick() != null && !qfile1.getImagemagick().equals("null") && !qfile1.getImagemagick().equals("") )
// 	        		  msfile = qfile1.getImagemagick();
	        	  k = k + 1;
		    	  if ( k > 3 ) { %>
		    		  <%
		    		    k = 1;
		    	  }
		    	  
		    	  if ( k == 1 ) { %>
		    		  <tr>
		    	  <%}%>
		    	  
		    	  <td colspan="2">
		    	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		    	      <tr>
		    	        <td align="center" valign="top">
		    	          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="imagebox">
		    	            <tr>
		    	              <td align="center" valign="top" >
		    	                <%
		    	                  if ( qfile1.getImagemagick() != null && !qfile1.getImagemagick().equals("null") && !qfile1.getImagemagick().equals("") ) {%>
		    	                	  <a href='http://www.hcshb.gov.tw/pubprogram/upload/imgprview.jsp?file=<%=path%>/<%=java.net.URLEncoder.encode(qfile1.getServerfile(),"UTF-8")%>&flag=pic&tablename=<%=tablename%>&serno=<%=serno%>&detailno=<%=qfile1.getDetailno()%>' title="您將開啟圖檔新視窗" target='_blank'><img src="http://www.hcshb.gov.tw/uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic" alt="<%=qfile1.getExpfile()%>" width="170" height="200" border="0"/></a>
		    	                  <%}else{%>
		    	                	  <a href='http://www.hcshb.gov.tw/pubprogram/upload/imgprview.jsp?file=<%=path%>/<%=java.net.URLEncoder.encode(qfile1.getServerfile(),"UTF-8")%>&flag=pic&tablename=<%=tablename%>&serno=<%=serno%>&detailno=<%=qfile1.getDetailno()%>' title="您將開啟圖檔新視窗" target='_blank'><img src="http://www.hcshb.gov.tw/uploaddowndoc?file=<%=path%>/<%=java.net.URLEncoder.encode(msfile,"UTF-8")%>&flag=pic" alt="<%=qfile1.getExpfile()%>" width="170" height="200" border="0"/></a>
		    	                  <%}%>
		    	              </td>
		    	            </tr>
		    	          </table>
		    	        </td>
		    	      </tr>
		    	      <tr>
		    	        <td align="center" valign="top" ><%=qfile1.getExpfile()%></td>
		    	      </tr>
		    	    </table>
		    	  </td>
		      <%}%>	  
	        </tr>
	      </table>
	    </td>
	  </tr>  
   </table>
  <%}%>
 