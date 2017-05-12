<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.io.*" %>
<%@ page import="jxl.*"%>
<%@ page import="tw.com.sysview.ImportData.*" %>

<%
  InputStream mfile = new FileInputStream("d:/2.xls");
  Workbook w_excel = Workbook.getWorkbook(mfile);
  int sheets = w_excel.getNumberOfSheets();
  
  for ( int s=0; s<sheets; s++ ) {
	  Sheet rs = w_excel.getSheet(s);
	  int rsRows = rs.getRows();
	  
	  for ( int i=0; i<rsRows; i++ ) {
		  Cell c00 = rs.getCell(0,i);
		  String strc00 = c00.getContents();
		  Cell c10 = rs.getCell(1,i);
		  String strc10 = c10.getContents();
		  
		  if ( strc10.indexOf("@") != -1 ) {
			  ImportMailData obj = new ImportMailData();
			  obj.setName(strc00.trim());
			  obj.setEmail(strc10.trim());
			  boolean rtn = obj.create();
			  if ( !rtn ) {
				  out.println("email="+strc10);
				  out.println("<br>");
			  }
		  }else{
			  out.println("email@="+strc10);
			  out.println("<br>");
		  }
	  }
	  
  }

  w_excel.close();
%>