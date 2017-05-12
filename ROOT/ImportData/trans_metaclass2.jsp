<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>轉分類檢索第二層分類</title>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jxl.*"%>
<%@ page import="tw.com.sysview.ImportData.*" %>

<body>


<%
  InputStream mfile = new FileInputStream("/webapps/class2.XLS");
  Workbook w_excel = Workbook.getWorkbook(mfile);
  
  for ( int s=0; s<1; s++ ) {
	  Sheet rs = w_excel.getSheet(s);
	  int rsRows = rs.getRows();
	  String excelname = rs.getName();
	  out.println("excelname="+excelname);
	  out.println("<br>");
	  out.println("rsRows="+rsRows);
	  for ( int i=1; i<rsRows; i++ ) {
		  Cell c01 = rs.getCell(0,i);
		  String strc01 = c01.getContents();
		  
		  Cell c11 = rs.getCell(1,i);
		  String strc11 = c11.getContents();
		  
		  Cell c21 = rs.getCell(2,i);
		  String strc21 = c21.getContents();
		  
		  Cell c31 = rs.getCell(3,i);
		  String strc31 = c31.getContents();
		  
		  Cell c41 = rs.getCell(4,i);
		  String strc41 = c41.getContents();
		  
		  Cell c51 = rs.getCell(5,i);
		  String strc51 = c51.getContents();
		  
		  MetaClassData obj = new MetaClassData();
		  obj.setSerno(Integer.parseInt(strc01));
		  obj.setCategory(strc11);
		  obj.setClassno1(strc21);
		  obj.setClassno2(strc31);
		  obj.setClasscname(strc41);
		  obj.setClassename(strc51);

		  boolean rtn = obj.create2();
		  if ( !rtn ) {
			  out.println("轉入失敗行數：" + i + "(" + strc01 + ")");
			  out.println("Error="+obj.getErrorMsg());
		  }
		  
	  }
  }

%>

</body>
</html>
