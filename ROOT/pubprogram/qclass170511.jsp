<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：qclass.jsp
說明：分類程式
開發者：chmei
開發日期：96.03.18
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  String formname = ( String )request.getParameter( "formname" );
  String tablename = ( String )request.getParameter( "tablename" );
  String colname = ( String )request.getParameter( "colname" );
  String pcolname = ( String )request.getParameter( "pcolname" );

  String onchange1 = ( String )request.getParameter( "onchange1" );
  if ( onchange1 == null )
	  onchange1 = "";
  
  String datavalue = ( String )request.getParameter( "datavalue" );
  if ( datavalue == null )
	  datavalue="";
 
  String[] ary_qclass = null;
  if ( !datavalue.equals("")  )
     ary_qclass = SvString.split(datavalue,"-");
  
  ClassData qclassname = new ClassData();
  ArrayList<Object> qlists = qclassname.findByday(tablename);  
  int rcount = qclassname.getAllrecordCount();
  
  //out.println("[程式名稱]: "+"qclass.jsp");
  //out.println("[tablename]: "+tablename);
  //out.println("[資料筆數]: "+rcount);

%>


<script>
  arry_mpunitdn = new Array(99);
  <%
    String mclass = "";
    String mpunitdn = "";
    if ( qlists != null )
    {    	    	 
       for ( int k=0; k<rcount; k++ ) {
    	   ClassData qlist = ( ClassData )qlists.get( k );
    	   
    	   if ( mpunitdn.equals("") )
    		   mpunitdn = qlist.getPubunitdn();
    	   
    	   if ( !qlist.getPubunitdn().equals(mpunitdn) ) { %>
    		   arry_mpunitdn["<%=mpunitdn%>"] = "<%=mclass%>";
    		   <%
    		     mpunitdn = qlist.getPubunitdn();
    		     mclass = "";
    	   }
    	   
    	   if ( mclass.equals("") )
    		   mclass = qlist.getSerno() + "-" + qlist.getClassname();
    	   else
    		   mclass = mclass + "," + qlist.getSerno() + "-" + qlist.getClassname();
       }%>
       arry_mpunitdn["<%=mpunitdn%>"] = "<%=mclass%>";
    <%}%> 
</script>    

<script for="window" event="onload" language="JScript">
  var thisform = "document.<%=formname%>.<%=colname%>";
  var mform = "document.<%=formname%>"
  var mpunit = eval(mform).<%=pcolname%>.value; 

  eval(thisform).options.length = 1;
  eval(thisform).options[0].value = "";
  eval(thisform).options[0].text = "---請選擇---";
  
  ary_mpunit = mpunit.split("||");
  marypunit = ary_mpunit[0];
 
  ary_punit_length = ary_mpunit[0].split(",");
  
  if ( ary_punit_length.length > 4 ) {
     for ( i=0; i<ary_punit_length.length-4; i++ )
        strlen = marypunit.indexOf(",");
        marypunit = marypunit.substr(strlen+1);
  }
 
  mdata = arry_mpunitdn[marypunit];
  
  if ( mdata != null ) 
  {
     array_mdata = mdata.split(",");      
     eval(thisform).options.length = array_mdata.length+1;
      
     for ( k=0; k<array_mdata.length; k++ )
     { 
        len = array_mdata[k].indexOf("-");
        arry_class = array_mdata[k].substr(0,len);
        eval(thisform).options[k+1].value=array_mdata[k];
        eval(thisform).options[k+1].text=array_mdata[k].substr(len+1);

        <%
          if ( !datavalue.equals("") ) { %>
        	  if ( arry_class == "<%=ary_qclass[0]%>" )
        	     eval(thisform).options[k+1].selected=true;
          <%}%>
     }   
  }
</script>

<script>
  function qryclass(fname)
  {
     var thisform = "document.<%=formname%>.<%=colname%>"; 
     var mform = "document.<%=formname%>." + fname;
     var mpunit = eval(mform).value;
     eval(thisform).options.length = 1;
     eval(thisform).options[0].value = "";
     eval(thisform).options[0].text = "---請選擇---";
     ary_mpunit = mpunit.split("||");
     mdata = arry_mpunitdn[ary_mpunit[0]];
     if ( mdata != null ) 
     {
        array_mdata = mdata.split(",");
        eval(thisform).options.length = array_mdata.length+1;
        
        for ( k=0; k<array_mdata.length; k++ )
        { 
           len = array_mdata[k].indexOf("-");
           arry_class = array_mdata[k].substr(0,len);
           eval(thisform).options[k+1].value=array_mdata[k];
           eval(thisform).options[k+1].text=array_mdata[k].substr(len+1);
           <%
             if ( !datavalue.equals("") ) { %>
            	 if ( arry_class = <%=ary_qclass[0]%> )
            	    eval(thisform).options[k+1].selected=true;
             <%}%>   
        }
     }
  }   
</script>


<select name="<%=colname%>" <%=onchange1%>>
   <option value="">---請選擇---</option>
</select>
