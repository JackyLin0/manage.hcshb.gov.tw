<!--
程式名稱：address.jsp
說明：地址輸入
開發者：chmei
開發日期：96.07.29
修改者：
修改日期：
版本：ver1.0
-->

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tw.com.sysview.dba.*"%>
<%@ page import="java.util.ArrayList"%>

<%
	request.setCharacterEncoding("UTF-8");
	//type==>add:新增地址;upd:修改地址
	String type = request.getParameter( "type" );
	String area = request.getParameter( "area" );
	String cityno = request.getParameter( "cityno" );
	String townsno = request.getParameter( "townsno" );
	String addr = request.getParameter( "addr" );
	
	if(type == null){
		type = "add";
	}
	
	ArrayList address = AddressData.getAddressData();	
	String citys = (String)address.get(0);
	String areas = (String)address.get(1);
%>

<script>
	var citys = "<%=citys%>".split(",");
	var cityAreas = "<%=areas%>".split(";");
	
	function createCitys(){
		document.all("cityno").length = citys.length + 1;
		document.all("cityno").options[0].value = "";
		document.all("cityno").options[0].text = "--請選擇--";
		document.all("cityno").selectedIndex = 0;
		var count = document.all("cityno").length;
		
		for(i = 1; i < count; i++){
			var city = citys[i-1].split("||");
			document.all("cityno").options[i].value = city[0];
			document.all("cityno").options[i].text = city[1];
		}
	}
	
	function createAreas(cityno){
		var index = 0;
		for(i = 0; i < citys.length; i++){
			var city = citys[i].split("||");
			if(city[0] == cityno){
				index = i;
				break;
			}
		}		
		var areas = cityAreas[index].split(",");
		document.all("townsno").length = areas.length + 1;
		document.all("townsno").options[0].value = "";
		document.all("townsno").options[0].text = "--請選擇--";
		document.all("townsno").selectedIndex = 0;
		var count = document.all("townsno").length;
		for(i = 1; i < count; i++){
			var area = areas[i-1].split("||");
			document.all("townsno").options[i].value = area[0] + "||" + area[1];
			document.all("townsno").options[i].text = area[2];
		}
	}
	
	function changeCity(){
		var cityno = document.all("cityno").value;
		if( cityno != "" ){
			document.all("AddrCity").value = document.all("cityno").value + "||" + document.all("cityno").options[document.all("cityno").selectedIndex].text;
			createAreas(cityno);
		}else{
			document.all("AddrCity").value = "||";
			document.all("townsno").length = 0;
			document.all("AddrArea").value = "||";
		}
	}
	
	function changeArea(){
		var townsno = document.all("townsno").value;
		if( townsno != "" ){
		    var areas = townsno.split("||");
		    document.all("AddrZone").value = areas[0];
			document.all("AddrArea").value = document.all("townsno").value + "||" + document.all("townsno").options[document.all("townsno").selectedIndex].text;
		}else{
			document.all("AddrArea").value = "||";
		}
	}
	
	function setAddressValue(){
		document.all("AddrZone").value = "<%=area%>";
		document.all("cityno").value = "<%=cityno%>";
		changeCity();
		document.all("townsno").value = "<%=townsno%>";
		changeArea();
		document.all("Addr").value = "<%=addr%>";
	}
</script>

郵遞區號
<label for="AddrZone"><input id="AddrZone" name="AddrZone" size="5" maxlength="5" value="請輸入郵遞區號" onFocus="javascript: if (this.value=='請輸入郵遞區號') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入郵遞區號';"></label>

<input type="hidden" name="AddrCity" value="||">
<input type="hidden" name="AddrArea" value="||">
<label for="cityno"><select id="cityno" name="cityno" onChange="javascript:changeCity();">
</select></label>
<script>
	createCitys();
</script>
<label for="townsno"><select id="townsno" name="townsno" onChange="javascript:changeArea();">
</select></label>
<br>

<label for="Addr"><input id="Addr" name="Addr" size="50" maxlength="100" value="請輸入地址" onFocus="javascript: if (this.value=='請輸入地址') this.value='';" onBlur="javascript: if(this.value=='') this.value='請輸入地址';"></label>

<% if(type.equals("upd")){ %>
<script>
		setAddressValue();
</script>
<% } %>

