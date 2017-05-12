<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="library.jsp" %>
<%
	String total_subsystem = request.getParameter("total_subsystem");
 	Integer order = Integer.valueOf(request.getParameter("order"));
 	Integer i ;
 	ResultSet subsystem ;
 	subsystem = f.query("select caption from menu_subsystem where sn = "+f.sql_string(request.getParameter("sn"))) ;
 	String caption = "" ;
 	if(subsystem.next())
 	{
 		caption = subsystem.getString("caption");
 	}
 	 
	subsystem = f.query("select * from menu_subsystem , limit_menu where limit_menu.menu_sn = menu_subsystem.sn and limit_menu.menu_type = 'menu_subsystem' and limit_menu.limit_group_sn = " + session.getAttribute("session_limit_group_sn") + " order by menu_subsystem.sort") ;
	
	subsystem.last() ;
	Integer record_count = subsystem.getRow() ;
	subsystem.beforeFirst() ;
	
	String Rows = "" ;
	for( i = 0 ; i < record_count+1 ; i ++ )
	{
		if( i == order ) Rows += "*"  ;
		else Rows += "22" ;

		if( i != record_count ) Rows += "," ;
	}
	
	ResultSet rs = f.query("SELECT menu_collection.* FROM menu_collection , limit_menu where limit_menu.menu_sn = menu_collection.sn and limit_menu.menu_type = 'menu_collection' and limit_menu.limit_group_sn = " + session.getAttribute("session_limit_group_sn") + " AND menu_collection.menu_subsystem_sn = "+request.getParameter("sn")+" ORDER BY menu_collection.sort") ;
%>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="fonran.css">
			<script language="JavaScript">

	function over1()
	{    
	    title.className = "iconover";	
	}

	function out1()
	{    
		title.className = "icon";
	}
	
	function down1()
	{    
		title.className = "icondown";
		
	}

	function over2()
	{
		var currid ;
	    
	    currid = document.all('b' + event.srcElement.id) ;
	    currid.className = "iconovera2" ;
	}

	function out2()
	{    
	    currid = document.all('b' + event.srcElement.id) ;
	    currid.className = "icona2" ;
	}
	
	function dow2()
	{
	    currid = document.all('b' + event.srcElement.id);
	    currid.className = "iconoverb2";
	}
	
	function nomove()
	{
		window.event.returnValue = false;
	}

	document.onmousemove = nomove;

			</script>
	</head>
	<body STYLE="margin-top:0pt ; margin-left:0pt ; margin-right:0pt ; background-Color: gray">
		<center>

			<div id="title" onmouseover="over1()" onmouseout="out1()" onmousedown="down1()" onmouseup="out1()" class="icon" style="background:'#c0c0c0';color:'#000000'">
				<%=caption%>
			</div>

			<% i = 0 ; %>

			<div id="inFloder" style="position:absolute;top:22;left:0px;width:125px">

				<% while( rs.next() ) { %>

				<div id="bicon<%=i%>" class="icona2" style="width:36px;height:36px;">
					<a href="menu_collection.jsp?sn=<%=rs.getInt("sn")%>&caption=<%=f.urlencode(rs.getString("caption"))%>&Time=<%=f.urlencode(f.now())%>" target="main">
						<img src="icon/<%=rs.getString("icon_file_name")%>" border="0" onmouseover="over2()" onmouseout="out2()" onmousedown="dow2()" onmouseup="over2()" id="icon<%=i%>" class="hand1">
					</a>
				</div>
				<a href="menu_collection.jsp?sn=<%=rs.getInt("sn")%>&caption=<%=f.urlencode(rs.getString("caption"))%>&Time=<%=f.urlencode(f.now())%>" target="main">
					<font color="#000000"><span onmouseover="over2()" onmouseout="out2()" onmousedown="dow2()" onmouseup="over2()" id="icon<%=i%>" class="hand1">
							<%=rs.getString("caption")%>
						</span></font></a>
				<br>
				<br>

				<% i ++ ; %>

				<% } %>

			</div>
			<img id="up2" src="images/r_02off.gif" name="r_02" onclick="onc();" style="position:absolute;display:'none';z-index:1" onmouseover="img_act('r_02')" onmouseout="img_inact('r_02')" onmousedown="img_inact1('r_02');miny();" onmouseup="img_inact2('r_02');stop();" WIDTH="16" HEIGHT="16">
			<img id="down2" src="images/r_01off.gif" name="r_01" onclick="onc();" style="position:absolute;display:'none';z-index:1" onmouseover="img_act('r_01')" onmouseout="img_inact('r_01')" onmousedown="img_inact1('r_01');addy();" onmouseup="img_inact2('r_01');stop();" WIDTH="16" HEIGHT="16">
	<script language="VBScript">

	sub title_onclick()
	
		window.Parent.frm1.rows =  "<%=Rows%>"
		
	end sub	

	sub title_OnMouseOver()
	
		title.style.cursor = "hand"
		
	end sub

			</script>
	</body>
</html>
<script LANGUAGE="JavaScript">

	browserName = navigator.appName;
	browserVer = parseInt(navigator.appVersion);
		
	if (browserName == "Netscape" && browserVer >= 3)
	{
		version = "n3";
	}
	else
	{
		if (browserName == "Microsoft Internet Explorer" && browserVer >= 4)
		{
			version = "n3";
		}
		else
		{
			version = "n2";
		}
	}
		
	if (version == "n3")
	{
		r_01on = new Image(20, 100);
		r_01on.src = "images/r_01on.gif";
		r_01off = new Image(20, 100);
		r_01off.src = "images/r_01off.gif";
		r_01down = new Image(20, 100);
		r_01down.src = "images/r_01down.gif";
		r_01up = new Image(20, 100);
		r_01up.src = "images/r_01on.gif";
		
		r_02on = new Image(20, 100);
		r_02on.src = "images/r_02on.gif";
		r_02off = new Image(20, 100);
		r_02off.src = "images/r_02off.gif";
		r_02down = new Image(20, 100);
		r_02down.src = "images/r_02down.gif";
		r_02up = new Image(20, 100);
		r_02up.src = "images/r_02on.gif";
	}
	
	function img_act(imgName)
	{
		if(version == "n3")
		{
			imgOn = eval(imgName + "on.src");
			document [imgName].src = imgOn;
			//document[imgName].style.cursor = "hand"
		}
	}
	
	function img_inact(imgName)
	{
		if(version == "n3")
		{
			imgOff = eval(imgName + "off.src");
			document [imgName].src = imgOff;
			//document[imgName].style.cursor = "hand"
		}
	}
	
	function img_inact1(imgName)
	{
		if(version == "n3")
		{
			imgDown = eval(imgName + "down.src");
			document [imgName].src = imgDown;
			//document[imgName].style.cursor = "hand"
		}
	}
	
	function img_inact2(imgName)
	{
		if(version == "n3")
		{
			imgup = eval(imgName + "on.src");
			document [imgName].src = imgup;
			//document[imgName].style.cursor = "hand"
		}
	}

	var mov;
	var no1 = 0;
	var apk = -22;
	
	window.onresize = doOnresize;
	setTimeout('ini()',0);
	
	function doOnresize()
	{
		ini();
	}

	function over11()
	{    
	    title1.className = "iconover";	
	}

	function out11()
	{    
		title1.className = "icon";	
	}
	
	function down11()
	{    
	
		title1.className = "icondown";	
	}
	
	function ini()
	{
		maxy =380
		//alert(document.body.offsetHeight)
		//alert(maxy)
		if (maxy > document.body.offsetHeight - 22)
		{
			down2.style.display = '';
		}
		else
		{
			down2.style.display = 'none';
		}
		
		up2.style.pixelLeft = document.body.offsetWidth - 17
		down2.style.pixelLeft = document.body.offsetWidth - 17
		up2.style.pixelTop = 39
		down2.style.pixelTop = document.body.offsetHeight - 39
	}
	
	function addy()
	{
		no1 = 0;
		//mov = document.body.offsetHeight - 5;
		mov = maxy;
		ik = apk;
		addygo();
		//alert(document.body.offsetHeight);
	}
	
	function onc()
	{
		mov = 75;
		no1 = 1;
	}
	
	function stop()
	{
		mov = 0;
		no1 = 1;
	}
	
	function addygo()
	{
		k = apk;
		inFloder.style.clip = 'rect(' + (k + 22) + ' 100% ' + (k+380) + ' 0)';
		inFloder.style.top = (0 - k) ;
		
		if ((k < ik + mov) && k<(380-10))
		{
			apk = (k + 5);
			up2.style.display = '';
			setTimeout('addygo()');
		}
		
		if (apk>=380-10)
		{
			down2.style.display = 'none';
		}
	}
	
	function miny()
	{
		//mov = document.body.offsetHeight - 30;
		mov = maxy;
		no1 = 0;
		ih = apk;
		minygo();
	}
	
	function minygo()
	{
		h = apk
		inFloder.style.clip = 'rect(' + (h + 22) + ' 100% ' + (h+380) + ' 0)';
		inFloder.style.top = (0 - h) ;
		
		if ((h > ih - mov) && ( h >= -20))
		{
			apk = (h - 5);
			down2.style.display = '';
			setTimeout('minygo()');
		}
		
		if (apk<=-20)
		{
			up2.style.display = 'none';
		}
	}
	
	function logout()
	{
		if(confirm('您確定要登出系統嗎？')==true)
		{
			window.open('conn.asp?logout=t','Default');
		}
	}

</script>
