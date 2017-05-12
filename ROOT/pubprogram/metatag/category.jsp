<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分類檢索</title>

<link href="../../css/text.css" rel="stylesheet" type="text/css"/>

<link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
<link rel="STYLESHEET" type="text/css" href="css/dhtmlxtree.css" />

<script>
  function saveclass(datavalue,formname,colname) {
	  var viewvalue = "";
	  var ary_one = datavalue.split(",");
	  for ( i=0; i<ary_one.length; i++ ) {
		  var ary_two = ary_one[i].split("-");
		  var temp1 = "";
		  for ( j=0; j<ary_two.length; j++ ) {
			  var ary_data = ary_two[j].split("||");
			  if ( temp1 == '' ){
				  temp1 = ary_data[1];
			  }else{
				  temp1 = temp1 + "-" + ary_data[1];
			  }	  	  
		  }
		  if ( viewvalue == '' ) {
			  viewvalue = temp1;
		  }else{
			  viewvalue = viewvalue + "," + temp1;
		  }	  	  
	  }
	  var thisform = "window.parent.opener." + formname + "." + colname;
	  var thisformview = "window.parent.opener." + formname + "." + colname + "view";
	  eval(thisform).value = datavalue;
	  eval(thisformview).value = viewvalue;
	  window.parent.close();
  }	  
</script>

</head>

<%
  String formname = ( String )request.getParameter( "formname" );
  String colname = ( String )request.getParameter( "colname" );
  String category = ( String )request.getParameter( "category" );
  String mtitle = "分類檢索";
  String xml = "theme.xml";
  if ( category.equals("1") ) {
	  mtitle = "主題分類";
	  xml = "theme.xml";
  }else if ( category.equals("2") ) {
	  mtitle = "施政分類";
	  xml = "cake.xml";
  }else if ( category.equals("3") ) {
	  mtitle = "服務分類";
	  xml = "service.xml";
  }
  
%>

<body>
<br>

<center><a class="md" href="javascript:saveclass(tree2.getAllChecked(),'<%=formname%>','<%=colname%>')">確　定</a></center>

	<script  src="js/dhtmlxcommon.js"></script>
	<script  src="js/dhtmlxtree.js"></script>
	
	<table>
	  <tr>
	    <td valign="top">
	      <div id="treeboxbox_tree2"></div>
	    </td>
	  </tr>
	</table>	

<p>
<center><a class="md" href="javascript:saveclass(tree2.getAllChecked(),'<%=formname%>','<%=colname%>')">確　定</a></center>

  <script>
    tree2=new dhtmlXTreeObject("treeboxbox_tree2","100%","100%",0);

    tree2.setSkin('dhx_vista');
    tree2.setImagePath("imgs/");
    tree2.enableCheckBoxes(1);
    tree2.enableThreeStateCheckboxes(true);
    tree2.loadXML("<%=xml%>");
  </script>
  
</body>

</html>