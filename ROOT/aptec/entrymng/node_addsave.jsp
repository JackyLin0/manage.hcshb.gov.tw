<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--
程式名稱：node_addsave.jsp
說明：人員組織設定
開發者：chmei
開發日期：2017.02.23
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人員組織設定</title>

</head>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tw.com.econcord.ds.*" %>

<body>

<%
  String logincn = ( String )session.getAttribute( "logincn" );
  String loginap = ( String )session.getAttribute( "loginap" );
  String mdn = ( String )request.getParameter( "mdn" );
  String id = ( String )request.getParameter( "id" );
  String parentpath1 = ( String )request.getParameter( "parentpath" );
  String parentid = id;
  String parentpath = parentpath1 + "," + id;

  String ou = ( String )request.getParameter( "ou" );
  String unitdn = "ou=" + ou + "," + mdn;
  String chinesetitle = ( String )request.getParameter( "chinesetitle" );
  String englishtitle = ( String )request.getParameter( "englishtitle" );
  String japantitle = ( String )request.getParameter( "japantitle" );
  
  ArrayList<DSItem> result = new ArrayList<DSItem>();
  DSItem setdata = new DSItem();
  
  setdata.setOu(ou);  
  setdata.setChinesetitle(chinesetitle);
  setdata.setEnglishtitle(englishtitle);
  setdata.setJapantitle(japantitle);
  setdata.setUnitdn(unitdn);
  setdata.setLogincn(logincn);
  setdata.setLoginap(loginap);;
  setdata.setParentid(Integer.parseInt(parentid));
  setdata.setParentpath(parentpath);
  
  result.add(setdata);

  DepartmentTree obj = new DepartmentTree();
  obj.setAdddata(result);
  
  boolean rtn  = obj.create();
  
  String showAlert = null;
  if ( rtn )
	  showAlert = "本單位新增成功！";
  else
	  showAlert = "本單位新增失敗！" + obj.getErrorMsg();

 %>

  <script>
     alert("<%=showAlert%>");
     parent.treeleft.location.reload();
     window.location.href="node_upd.jsp?mdn=<%=mdn%>";
  </script>  

  
</body>
</html>

