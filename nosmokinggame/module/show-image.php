<%
	include("../fonran.php") ;
	
	$pic = new recordset("select $field from $table where sn = $sn");

	echo $pic->f[ $field ] ;
%>