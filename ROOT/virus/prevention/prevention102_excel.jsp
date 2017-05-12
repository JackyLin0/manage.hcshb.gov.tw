<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：prevention102_excel.jsp
說明：產生Excel
開發者：chmei
開發日期：97.03.08
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>

</head>

<!-- 產生word檔 -->
<!-- %@ page contentType="application/msword;charset=UTF-8" % -->
<!-- 產生Excel檔 -->
<%@ page contentType="application/vnd.ms-excel;charset=UTF-8" %>


<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  String organization = ( String )request.getParameter( "o" );
  
  //產生word檔
  //response.setHeader("Content-disposition","inline; filename=aa.doc");
  //產生Excel檔
  response.setHeader("Content-disposition", "attachment; filename="+organization+".xls");
    
  String qptdate = ( String )request.getParameter( "qptdate" );
  String sdate1 = qptdate;
  if ( qptdate == null || qptdate.equals("") )
  {	  
	  qptdate = "";
	  sdate1 = "00000000";
  }
  String mptdate = qptdate.substring(0,4) + "." + qptdate.substring(4,6) + "." + qptdate.substring(6,8);
  
  String qdldate = ( String )request.getParameter( "qdldate" ); 
  String sdate2 = qdldate;
  if ( qdldate == null || qdldate.equals("") )
  {
	  qdldate = "";
	  sdate2 = "99999999";
  }
  String mdldate = qdldate.substring(0,4) + "." + qdldate.substring(4,6) + "." + qdldate.substring(6,8);
  
  String punit = ( String )request.getParameter( "punit" );
  String mpunit = "";
  String mpunitname = "";
  if ( punit != null && !punit.equals("null") && !punit.equals("") ) {
	  String[] ary_punit = SvString.split(punit,"||");
	  mpunit = ary_punit[0];
	  mpunitname = ary_punit[1];
  }
	
  
  VirusExcelData qmsubjectno = new VirusExcelData();
  ArrayList qsubjectnos = qmsubjectno.findBysubjectno(table,mpunit,sdate1,sdate2);
  int rsubjectno = qmsubjectno.getAllrecordCount();

%>


<body>
	
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr align="center">
    <td colspan="24"><font size="4">新竹縣<%=Integer.parseInt(qptdate.substring(0,4))-1911%>年度幼教保育機構腸病毒防治措施設備查核結果紀錄表</font></td>
  </tr>
  <tr align="center">
    <td colspan="24"><font size="4">查核日期：<%=mptdate%>&nbsp;至&nbsp;<%=mdldate%></font></td>
  </tr>
  <tr align="left">
    <td colspan="24"><font size="3"><%=mpunitname%></font></td>
  </tr>
</table>

<table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr height="22" align="center" valign="center">
    <td rowspan="3">園所<br>序號</td>
    <td rowspan="3">園所名稱</td>
    <td colspan="11">初查</td>
    <td colspan="11">複查</td>
  </tr>
  <tr height="22" align="center" valign="center">
    <td rowspan="2" height="44">初查時間</td>
    <td colspan="2">洗手設備</td>
    <td colspan="2">正確洗手時機</td>
    <td colspan="2">正確洗手動作</td>
    <td colspan="2">健康篩檢</td>
    <td colspan="2">納入課程</td>
    <td rowspan="2">複查時間</td>
    <td colspan="2">洗手設備</td>
    <td colspan="2">正確洗手時機</td>
    <td colspan="2">正確洗手動作</td>
    <td colspan="2">健康篩檢</td>
    <td colspan="2">納入課程</td>
  </tr>
  <tr height="22" align="center" valign="center">
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
    <td>合格</td>
    <td>不合格</td>
  </tr>
  <%
    if ( qsubjectnos != null ) {
    	for ( int i=0; i<rsubjectno; i++ ) {
    		VirusExcelData qsubjectno = ( VirusExcelData )qsubjectnos.get( i );    		
    		VirusExcelData query = new VirusExcelData();
    		ArrayList qlists = query.findByday(table,mpunit,qsubjectno.getSubjectno(),sdate1,sdate2);    		
    		int rcount = query.getAllrecordCount();
    		
    		String[] posterdate = new String[2];
    		int[] equipmentqual = new int[2];
    		int[] equipmentnoqual = new int[2];
    		int[] opportunityqual = new int[2];
    		int[] opportunitynoqual = new int[2];
    		int[] movementqual = new int[2];
    		int[] movementnoqual = new int[2];
    		int[] healthsiftqual = new int[2];
    		int[] healthsiftnoqual = new int[2];
    		int[] coursequal = new int[2];
    		int[] coursenoqual = new int[2];
    		if ( qlists != null ) {
    			posterdate[0] = "";
    			posterdate[1] = "";
    			for ( int j=0; j<rcount; j++ ) {
    				VirusExcelData qlist = ( VirusExcelData )qlists.get( j );
    				if ( qlist.getIscheck().equals("1") ) {
    					if ( !mpunit.equals("") ) {
        					VirusExcelData qposterdate = new VirusExcelData();
        					boolean rtn = qposterdate.load(table,mpunit,qlist.getSubjectno(),qlist.getIscheck());
        					if ( rtn )
        						posterdate[0] = qposterdate.getPosterdate().substring(0,4) + "." + qposterdate.getPosterdate().substring(4,6) + "." + qposterdate.getPosterdate().substring(6,8);
        				}
    					equipmentqual[0] = qlist.getEquipmentqual();
    					equipmentnoqual[0] = qlist.getEquipmentnoqual();
    					opportunityqual[0] = qlist.getOpportunityqual();
    					opportunitynoqual[0] = qlist.getOpportunitynoqual();
    					movementqual[0] = qlist.getMovementqual();
    					movementnoqual[0] = qlist.getMovementnoqual();
    					healthsiftqual[0] = qlist.getHealthsiftqual();
    					healthsiftnoqual[0] = qlist.getHealthsiftnoqual();
    					coursequal[0] = qlist.getCoursequal();
    					coursenoqual[0] = qlist.getCoursenoqual();
    				}else{
    					if ( !mpunit.equals("") ) {
        					VirusExcelData qposterdate = new VirusExcelData();
        					boolean rtn = qposterdate.load(table,mpunit,qlist.getSubjectno(),qlist.getIscheck());
        					if ( rtn )
        						posterdate[1] = qposterdate.getPosterdate().substring(0,4) + "." + qposterdate.getPosterdate().substring(4,6) + "." + qposterdate.getPosterdate().substring(6,8);
        				}
    					equipmentqual[1] = qlist.getEquipmentqual();
    					equipmentnoqual[1] = qlist.getEquipmentnoqual();
    					opportunityqual[1] = qlist.getOpportunityqual();
    					opportunitynoqual[1] = qlist.getOpportunitynoqual();
    					movementqual[1] = qlist.getMovementqual();
    					movementnoqual[1] = qlist.getMovementnoqual();
    					healthsiftqual[1] = qlist.getHealthsiftqual();
    					healthsiftnoqual[1] = qlist.getHealthsiftnoqual();
    					coursequal[1] = qlist.getCoursequal();
    					coursenoqual[1] = qlist.getCoursenoqual();
    				}
    			}%>
    			<tr height="22" align="center" valign="center">
    			  <td><%=i+1%></td>
    			  <td align="left"><%=qsubjectno.getSubject()%></td>
    			  <td height="44"><%=posterdate[0]%></td>
    			  <td><%=equipmentqual[0]%></td>
    			  <td><%=equipmentnoqual[0]%></td>
    			  <td><%=opportunityqual[0]%></td>
    			  <td><%=opportunitynoqual[0]%></td>
    			  <td><%=movementqual[0]%></td>
    			  <td><%=movementnoqual[0]%></td>
    			  <td><%=healthsiftqual[0]%></td>
    			  <td><%=healthsiftnoqual[0]%></td>
    			  <td><%=coursequal[0]%></td>
    			  <td><%=coursenoqual[0]%></td>
    			  <td height="44"><%=posterdate[1]%></td>    			  
    			  <td><%=equipmentqual[1]%></td>
    			  <td><%=equipmentnoqual[1]%></td>
    			  <td><%=opportunityqual[1]%></td>
    			  <td><%=opportunitynoqual[1]%></td>
    			  <td><%=movementqual[1]%></td>
    			  <td><%=movementnoqual[1]%></td>
    			  <td><%=healthsiftqual[1]%></td>
    			  <td><%=healthsiftnoqual[1]%></td>
    			  <td><%=coursequal[1]%></td>
    			  <td><%=coursenoqual[1]%></td>
    			</tr>
    		<%}
    	}
    	String end = String.valueOf(6 + rsubjectno);  %>
        <tr height="22" align="center" valign="center">
          <td>合計</td>
          <td align="right"><%=rsubjectno%></td>
          <td height="44"></td>
          <td>=SUM(D7:D<%=end%>)</td>
          <td>=SUM(E7:E<%=end%>)</td>
          <td>=SUM(F7:F<%=end%>)</td>
          <td>=SUM(G7:G<%=end%>)</td>
          <td>=SUM(H7:H<%=end%>)</td>
          <td>=SUM(I7:I<%=end%>)</td>
          <td>=SUM(J7:J<%=end%>)</td>
          <td>=SUM(K7:K<%=end%>)</td>
          <td>=SUM(L7:L<%=end%>)</td>
          <td>=SUM(M7:M<%=end%>)</td>
          <td height="44">&nbsp;</td>
          <td>=SUM(O7:O<%=end%>)</td>
          <td>=SUM(P7:P<%=end%>)</td>
          <td>=SUM(Q7:Q<%=end%>)</td>
          <td>=SUM(R7:R<%=end%>)</td>
          <td>=SUM(S7:S<%=end%>)</td>
          <td>=SUM(T7:T<%=end%>)</td>
          <td>=SUM(U7:U<%=end%>)</td>
          <td>=SUM(V7:V<%=end%>)</td>
          <td>=SUM(W7:W<%=end%>)</td>
          <td>=SUM(X7:X<%=end%>)</td>
        </tr>
    <%}else{%>
    	<tr>
    	  <td colspan="24" align="center" valign="center" height="60"><font size="4">目前查無資料</font></td>
    	</tr>
    <%}%>
</table>

</body>
</html>
