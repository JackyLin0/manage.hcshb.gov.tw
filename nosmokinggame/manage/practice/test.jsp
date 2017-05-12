<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../fonran.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
	try{     
		
		Integer i , count = 0;
		mySmartUpload.initialize(pageContext);
		mySmartUpload.upload();
		
			
			out.print(mySmartUpload.getRequest().getParameter("sn")+"<br>");
			//out.print(request.getParameter("sn")+"<br>");
			com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(1);

			if( ! myFile.isMissing() )
			{
				myFile.saveAs("/files/movie/" + myFile.getFileName());

				out.print("FieldName = " + myFile.getFieldName() + "<BR>");
				out.print("Size = " + myFile.getSize() + "<BR>");
				out.print("FileName = " + myFile.getFileName() + "<BR>");
				out.print("FileExt = " + myFile.getFileExt() + "<BR>");
				out.print("FilePathName = " + myFile.getFilePathName() + "<BR>");
				out.print("ContentType = " + myFile.getContentType() + "<BR>");
				out.print("ContentDisp = " + myFile.getContentDisp() + "<BR>");
				out.print("TypeMIME = " + myFile.getTypeMIME() + "<BR>");
				out.print("SubTypeMIME = " + myFile.getSubTypeMIME() + "<BR><BR>");

				count ++;
			}
	}catch(Exception e){out.print(e);}
%>
<HTML>
<BODY BGCOLOR="white">

<H1>上傳範例</H1>
<HR>

<FORM METHOD="POST" ACTION="test.jsp" ENCTYPE="multipart/form-data">
   <INPUT TYPE="text" NAME="test" value=""><BR>
	<INPUT TYPE="FILE" NAME="FILE1" SIZE="50"><BR>
   <INPUT TYPE="FILE" NAME="FILE2" SIZE="50"><BR>
   <INPUT TYPE="FILE" NAME="FILE3" SIZE="50"><BR>
   <INPUT TYPE="FILE" NAME="FILE4" SIZE="50"><BR>
   <INPUT TYPE="SUBMIT" VALUE="Upload">
</FORM>

</BODY>
</HTML>
