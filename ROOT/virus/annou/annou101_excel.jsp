<%@ page contentType="application/vnd.ms-excel;charset=Big5" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
�{���W�١Gannou101.jsp
�����G�q����ƺ��@
�}�o�̡Ghank
�}�o����G98.07.29
�ק�̡G
�ק����G
�����Gver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=Big5"/>
<title>�s�˿��åͧ��A�Ⱥ���ݺ޲z�t��</title>
</head>

<%@ page import="java.util.*"%>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="java.io.*" %>

<%
  String table = ( String )request.getParameter( "t" );
  String language = ( String )request.getParameter( "language" );
  
  int pagesize = Integer.parseInt(request.getParameter( "pagesize" ));
  String intpage1 = ( String )request.getParameter( "intpage" );

  if ( intpage1 == null || intpage1.equals("") )
	  intpage1 = "1";
  int intpage = Integer.parseInt(intpage1);
  
  //���t�θ��|
  String sysRoot1 = (String) application.getRealPath("");
  
  String Ldap_PATH1 = sysRoot1 + "/WEB-INF/ldap.properties";
  Properties ldap1 = new Properties();
  ldap1.load(new FileInputStream(Ldap_PATH1) );
  String hcshb = ldap1.getProperty("hcshb");
  
  String logindn = ( String )session.getAttribute("logindn");
  //��login�̳��(�ĥ|�h)
  String pubunitdn = logindn;
  String[] ary_pubunitdn = SvString.split(pubunitdn,",");
  if ( ary_pubunitdn.length > 4 ) {
	  for ( int i=0; i<ary_pubunitdn.length-4; i++ ) {
		  pubunitdn = SvString.right(pubunitdn,",");
	  }
  }
  if ( pubunitdn.equals(hcshb) )
	  pubunitdn = "";
  
  //�����d�߱���
  //����r�M����D�B�Ƽ��D�B���e�T�����
  String schName = ( String )request.getParameter( "mschName" );
  if ( schName == null || schName.equals("") )
	  schName = "";
  
  String keyword = ( String )request.getParameter( "keyword" );
  if ( keyword == null || keyword.lastIndexOf("�п�J") != -1 )
	  keyword = "";

  String qptdate = ( String )request.getParameter( "qptdate" );
  String sdate1 = qptdate;
  if ( qptdate == null || qptdate.equals("") )
  {	  
	  qptdate = "";
	  sdate1 = "00000000";
  }	  
  String qdldate = ( String )request.getParameter( "qdldate" ); 
  String sdate2 = qdldate;
  if ( qdldate == null || qdldate.equals("") )
  {
	  qdldate = "";
	  sdate2 = "99999999";
  }
  
  AnnouData query = new AnnouData();   
  ArrayList qlists = query.findByday(table,keyword,schName,pubunitdn,sdate1,sdate2);
  int rcount = query.getAllrecordCount();

  //�p���`����
  int maxpage=0;
  
  //���l��
  maxpage=rcount%pagesize;               
  if (maxpage==0)
     maxpage=rcount/pagesize;
  else
     maxpage=(rcount/pagesize)+1;

%>


<body>
<%
  //����Excel��
  response.setHeader("Content-disposition", "attachment; filename=area.xls");
%>
<table width="100%" border="1" cellpadding="0" cellspacing="0" class="table01">
  <tr>
    <th colspan="11">
      71���z�f�r��ҽа��լd��
    </th>
  </tr>
  <tr align="center">
    <th width="200">�ǮզW��</th>
    <th width="100">�Z�ŦW��</th>
    <th width="50">�ǵ��`��</th>
    <th width="50">�а��H��</th>
    <th width="50" align="center">�s��</th>
    <th width="200" align="center">�z�f�r�ǵ��W�r</th>
    <th width="200" align="center">�a���s���q��</th>
    <th width="100" align="center">�N����</th>
    <th width="200" align="center">�N����|</th>
    <th width="200" align="center">�Ƶ�</th>
    <th width="200" align="center">�X���O��</th>
  </tr>

<%
  for(int i = 0 ; i < rcount ; i++){
      AnnouData qlist = ( AnnouData )qlists.get(i);
      String serno = qlist.getSerno();
      String qschName = qlist.getSchName();      
      String annouDate = qlist.getAnnouDate();      
      String className = qlist.getClassName();
      String stuNum = qlist.getStuNum();
      String sickNum = qlist.getSickNum();
      
      AnnouItemData querys = new  AnnouItemData();    
      ArrayList list = querys.findByday(serno);    
      int rcounts = querys.getAllrecordCount();
      
      AnnouItemData aid = (AnnouItemData)list.get(0);
	  String stuName = aid.getStuName();
	  String famPhone = aid.getFamPhone();
	  String docdate = "";
	  if(aid.getDocdate() != null){
		  docdate = aid.getDocdate().substring(0,4) + "." + aid.getDocdate().substring(4,6) + "." + aid.getDocdate().substring(6,8);
	  }
	  String docName = "";;
	  if(aid.getDocName() != null){
		  docName = aid.getDocName();
	  }
	  String remark = "";
	  if(aid.getRemark()!= null){
		  remark = aid.getRemark().replaceAll("\n","<br>");
	  }
	  String record = "";
	  if(aid.getRecord()!= null){
		  record = aid.getRecord().replaceAll("\n","<br>");
	  }
%>
  <tr onMouseOver="this.style.backgroundColor='#f4f4f4';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#ffffff';">
    <td rowspan="<%= sickNum %>" align="center"><%=qschName%></td>
    <td rowspan="<%= sickNum %>" align="center"><%=className%></td>
    <td rowspan="<%= sickNum %>" align="center"><%=stuNum%></td>    	  
    <td rowspan="<%= sickNum %>" align="center"><%=sickNum%></td>
    <td align="center">1</td>
    <td align="center"><%=stuName%></td>
    <td align="center"><%=famPhone%></td>
    <td align="center"><%=docdate%></td>
    <td align="center"><%=docName%></td>
    <td align="center"><%=remark%></td>
    <td align="center"><%=record%></td>
  </tr>
    <%
      for(int j = 1 ; j < rcounts ; j++){ 
    	  AnnouItemData aids = (AnnouItemData)list.get(j);
    	  String stuNames = aids.getStuName();
    	  String famPhones = aids.getFamPhone();
    	  String docdates = "";
    	  if(aid.getDocdate() != null){
    		  docdates = aid.getDocdate().substring(0,4) + "." + aid.getDocdate().substring(4,6) + "." + aid.getDocdate().substring(6,8);
    	  }
    	  String docNames = "";;
    	  if(aid.getDocName() != null){
    		  docNames = aid.getDocName();
    	  }
    	  String remarks = "";
    	  if(aid.getRemark()!= null){
    		  remarks = aid.getRemark().replaceAll("\n","<br>");
    	  }
    	  String records = "";
    	  if(aid.getRecord()!= null){
    		  records = aid.getRecord().replaceAll("\n","<br>");
    	  }
    %>
    <tr>
      <td align="center"><%=j+1%></td>
      <td align="center"><%=stuNames%></td>
      <td align="center"><%=famPhones%></td>
      <td align="center"><%=docdates%></td>
      <td align="center"><%=docNames%></td>
      <td align="center"><%=remarks%></td>
      <td align="center"><%=record%></td>
    </tr> 
    <%
      }
    %>
  
<%
  }
%>
</table>
</body>
</html>