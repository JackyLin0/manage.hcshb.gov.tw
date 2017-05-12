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
  response.setHeader("Content-disposition", "attachment; filename=prevention103.xls");
    
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
  String mpunitname = "新竹縣";
  if ( punit != null && !punit.equals("null") && !punit.equals("") ) {
	  String[] ary_punit = SvString.split(punit,"||");
	  mpunit = ary_punit[0];
	  mpunitname = ary_punit[1];
  }
  System.out.println("mpunit="+mpunit);
  //尋找學校數目
  VirusExcelData qnum = new VirusExcelData();
  //國小
  boolean rtnp = qnum.loadnum("VirusPrimarySchool",mpunit,sdate1,sdate2);
  int nump = qnum.getNum();
  //幼稚園
  boolean rtnk = qnum.loadnum("VirusKindergarten",mpunit,sdate1,sdate2);
  int numk = qnum.getNum();
  //托兒所
  boolean rtnn = qnum.loadnum("VirusNursery",mpunit,sdate1,sdate2);
  int numn = qnum.getNum();
  int totnum = nump + numk + numn;
  
  String msubject = "VirusPrimarySchool||VirusKindergarten||VirusNursery";
  String[] ary_subject = SvString.split(msubject,"||");
  
%>


<body>
	
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr align="center">
    <td colspan="12"><font size="4"><%=Integer.parseInt(mptdate.substring(0,4))-1911%>年　　<%=mpunitname%>　　幼教保育機構腸病毒防治洗手設備及衛教宣導成效查核表(附件一)</font></td>
  </tr>
  <tr align="center">
    <td colspan="12"><font size="4">查核日期：<%=mptdate%>&nbsp;至&nbsp;<%=mdldate%></font></td>
  </tr>
  <tr align="left">
    <td colspan="12"><font size="3"><%=mpunitname%></font></td>
  </tr>
</table>

<table width="100%" border="1" cellpadding="0" cellspacing="0">
  <tr align="center" valign="center">
     <td rowspan=3>學校</td>
     <td rowspan=3>轄區內學校數目(A)</td>
     <td colspan=5><font color="red">初查( 每月5日前 )</font></td>
     <td colspan=4><font color="red">複查( 每月25日前 )</font></td>
     <td rowspan=3>備註</td>
   </tr>
   <tr align="center">
     <td colspan=3>洗手設備查核</td>
     <td colspan=2>衛教宣導成效查核</td>
     <td colspan=2>洗手設備查核</td>
     <td colspan=2>衛教宣導成效查核</td>
   </tr>
   <tr align="center">
     <td>檢查合格數(B)</td>
     <td>檢查未合格數</td>
     <td>合格率(B/A)</td>
     <td>正確洗手時機<br>認知度(%)</td>
     <td>執行洗手動作<br>正確率(%)</td>
     <td>檢查合格數</td>
     <td>檢查未合格數</td>
     <td>正確洗手時機<br>認知度(%)</td>
     <td>執行洗手動作<br>正確率(%)</td>
   </tr>
   <%
     String subjectname = "";
     int num = 0;
     int mfield = 7;
     int[] allopportunityqual = new int[2];
	 int[] allmovementqual = new int[2];
     for ( int i=0; i<ary_subject.length; i++ ) {
    	 mfield = mfield + 1;
    	 System.out.println("mfield="+mfield);
    	 if ( ary_subject[i].equals("VirusPrimarySchool") ) {
    		 subjectname = "國小";
    		 num = nump;
    	 }else if ( ary_subject[i].equals("VirusKindergarten") ) {
    		 subjectname = "幼稚園";
    		 num = numk;
    	 }else if ( ary_subject[i].equals("VirusNursery") ) {
    		 subjectname = "托兒所";
    		 num = numn;
    	 }	 
    	 
    	 VirusExcelData query = new VirusExcelData();
    	 ArrayList qlists = query.findBysum(ary_subject[i],mpunit,sdate1,sdate2);
    	 int rcount = query.getAllrecordCount();
    	 
    	 int[] equipmentqual = new int[2];
    	 int[] equipmentnoqual = new int[2];
    	 int[] opportunityqual = new int[2];
    	 int[] movementqual = new int[2];
    	 if ( qlists != null ) {
    		 for ( int j=0; j<rcount; j++ ) {
    			 VirusExcelData qlist = ( VirusExcelData )qlists.get( j );
    			 if ( qlist.getIscheck().equals("1") ) {
    				 equipmentqual[0] = qlist.getEquipmentqual();
    				 equipmentnoqual[0] = qlist.getEquipmentnoqual();
    				 opportunityqual[0] = qlist.getOpportunityqual();
    				 movementqual[0] = qlist.getMovementqual();
    				 allopportunityqual[0] = allopportunityqual[0] + qlist.getOpportunityqual();
    				 allmovementqual[0] = allmovementqual[0] + qlist.getMovementqual();
    			 }else if ( qlist.getIscheck().equals("2") ) {
    				 equipmentqual[1] = qlist.getEquipmentqual();
    				 equipmentnoqual[1] = qlist.getEquipmentnoqual();
    				 opportunityqual[1] = qlist.getOpportunityqual();
    				 movementqual[1] = qlist.getMovementqual();
    				 allopportunityqual[1] = allopportunityqual[1] + qlist.getOpportunityqual();
    				 allmovementqual[1] = allmovementqual[1] + qlist.getMovementqual();
    			 }
    		 }%>
    		 <tr align="right">
    		   <td align="center"><%=subjectname%></td>
    		   <td><%=num%></td>
    		   <td><%=equipmentqual[0]%></td>
    		   <td><%=equipmentnoqual[0]%></td>
    		   <td style='mso-number-format:0%'>=(C<%=mfield%>/B<%=mfield%>)*100%</td>
    		   <td style='mso-number-format:0%'>=(<%=opportunityqual[0]%>/B<%=mfield%>)*100%</td>
    		   <td style='mso-number-format:0%'>=(<%=movementqual[0]%>/B<%=mfield%>)*100%</td>
    		   <td><%=equipmentqual[1]%></td>
    		   <td><%=equipmentnoqual[1]%></td>
    		   <td style='mso-number-format:0%'>=(<%=opportunityqual[1]%>/B<%=mfield%>)*100%</td>
    		   <td style='mso-number-format:0%'>=(<%=movementqual[1]%>/B<%=mfield%>)*100%</td>
    		   <td>&nbsp;</td>
    		 </tr>
    	 <%}else{%>
    		 <tr align="right">
    		   <td align="center"><%=subjectname%></td>
    		   <td><%=num%></td>
    		   <td>0</td>
    		   <td>0</td>
    		   <td style='mso-number-format:0%'>0%</td>
    		   <td style='mso-number-format:0%'>0%</td>
    		   <td style='mso-number-format:0%'>0%</td>
    		   <td>0</td>
    		   <td>0</td>
    		   <td style='mso-number-format:0%'>0%</td>
    		   <td style='mso-number-format:0%'>0%</td>
    		   <td>&nbsp;</td>
    		 </tr>
    	 <%}
    	 if ( i == ary_subject.length-1 ) {
    		 mfield = mfield + 1;  %>
    		 <tr align="right">
    		   <td align="center">總計</td>
    		   <td>=SUM(B8:B10)</td>
    		   <td>=SUM(C8:C10)</td>
    		   <td>=SUM(D8:D10)</td>
    		   <td style='mso-number-format:0%'>=(C<%=mfield%>/B<%=mfield%>)*100%</td>
    		   <td style='mso-number-format:0%'>=(<%=allopportunityqual[0]%>/B<%=mfield%>)*100%</td>
    		   <td style='mso-number-format:0%'>=(<%=allmovementqual[0]%>/B<%=mfield%>)*100%</td>
    		   <td>=SUM(H8:H10)</td>
    		   <td>=SUM(I8:I10)</td>
    		   <td style='mso-number-format:0%'>=(<%=allopportunityqual[1]%>/B<%=mfield%>)*100%</td>
    		   <td style='mso-number-format:0%'>=(<%=allmovementqual[1]%>/B<%=mfield%>)*100%</td>
    		   <td>&nbsp;</td>
    		 </tr>
    	 <%}
     }%>
   
</table>  
<br>   
<table border="0">
  <tr>
    <td colspan="12">請勾選本次執行查核方式為下列項?<td>
  </tr>  
  <tr>
    <td colspan="12">
      <table border="0">
        <tr>
          <td colspan="2">
            <input type="checkbox">　　採聯合查核方式【協同單位：
          </td>
          <td align="left">
            <input type="checkbox">　　教育局
          </td>
          <td align="left">
            <input type="checkbox">　　社會局
          </td>
          <td colspan="2" align="left">
            <input type="checkbox">　　其他<input type="text" size="25">
          </td>
          <td align="center">】</td>
        </tr>
        <tr>
          <td colspan="12">
            <input type="checkbox">　　衛生所自行查核
          </td>
        </tr>
      </table>
     </td>
   </tr>
   <tr>
     <td colspan="12">備註：</td>
   </tr>
   <tr>
     <td colspan="12">
       1.洗手設備查核包括：有無提供肥皂或洗手乳、有無提供擦手紙或學童自備手帕、洗手檯高度符合學童身高或備有墊高板供幼小學童使用、是否張貼預防腸病毒衛教宣導海報。
     </td>
   </tr>
   <tr>
     <td colspan="12">
       2.衛教宣導成效查核包括：每校至少抽測五名學童了解是否能<span style='text-decoration:underline'>正確執行洗手動作</span>&nbsp;並&nbsp;<span style='text-decoration:underline'>正確回答洗手時機</span>
     </td>
   </tr>
   <tr>
     <td colspan="12">&nbsp;&nbsp;&nbsp;&nbsp;
       *正確洗手時機 : 回到家後、吃東西前、上完廁所後、玩遊戲後&nbsp;&nbsp;*正確執行洗手步驟：濕、搓（至少20秒）、沖、捧、擦
     </td>
   </tr>
   <tr>
     <td colspan="12">&nbsp;&nbsp;&nbsp;&nbsp;上述 1與2項內容均符合者為合格，不合格之學校或園所應要求立即改進，並再予複查</td>
   </tr>
 </table>


</body>
</html>
