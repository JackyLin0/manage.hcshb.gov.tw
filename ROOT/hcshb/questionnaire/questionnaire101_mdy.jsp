<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：questionnaire101_mdy.jsp
說明：問卷調查資料維護
開發者：chmei
開發日期：97.12.09
修改者：
修改日期：
版本：ver1.0
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>新竹縣衛生局服務網後端管理系統</title>
<link href="../../css/text.css" rel="stylesheet" type="text/css"/>
</head>

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>

<%
  //接收查詢條件
  String keyword = ( String )request.getParameter( "keyword" );
  String qpunit = ( String )request.getParameter( "qpunit" );
  String qptdate = ( String )request.getParameter( "qptdate" );
  String qdldate = ( String )request.getParameter( "qdldate" );
  
  //參數
  String logindn = ( String )session.getAttribute("logindn");
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );  
  
  String table = ( String )request.getParameter( "t" );
  
  String serno = ( String )request.getParameter( "serno" );
  String language = ( String )request.getParameter( "language" );
  
  QuestionnaireData query = new QuestionnaireData();
  boolean rtn = query.load(serno,table);  

%>  

<script>
  function back()
  {
     document.backform.action="questionnaire101.jsp";
     document.backform.method="post";
     document.backform.submit();
  }

  function chg()
  {
     for ( var i=0; i<document.all.startusing.length; i++ )
     {
        if ( document.all.startusing[i].checked )
        {
           var startusing_value = document.all.startusing[i].value;           
           switch(startusing_value)
           {
              case "1": //永久有效
                   window.type.style.display='none';
                   break;
              case "0": //截止日期
                   window.type.style.display='block';
                   break;
           }
        }
     }                  
  }

  function chg1()
  {
     for ( var i=0; i<document.all.questiontype.length; i++ )
     {
        if ( document.all.questiontype[i].checked )
        {
           var questiontype_value = document.all.questiontype[i].value;           
           switch(questiontype_value)
           {
              case "1": //問卷調查
                   window.type1.style.display='none';
                   window.type11.style.display='none';
                   break;
              case "2": //有獎徵答
                   window.type1.style.display='block';
                   window.type11.style.display='block';
                   break;
           }
        }
     }                  
  }
  
  function chg2()
  {
     for ( var i=0; i<document.all.isbasic.length; i++ )
     {
        if ( document.all.isbasic[i].checked )
        {
           var isbasic_value = document.all.isbasic[i].value;           
           switch(isbasic_value)
           {
              case "Y": //是
                   window.type2.style.display='block';
                   break;
              case "N": //否
                   window.type2.style.display='none';
                   break;
           }
        }
     }                  
  }
    
  function chg3(k)
  {
     var thisform = "document.all.choice" + k;
     var windowform3 = "window.type3" + k;
     var windowform4 = "window.type4" + k; 
     for ( var i=0; i<eval(thisform).length; i++ )
     {          
        if ( eval(thisform)[i].checked )
        {
           var choice_value = eval(thisform)[i].value; 
           switch(choice_value)
           {
              case "1": //選項為文字
                   eval(windowform3).style.display='block';
                   eval(windowform4).style.display='none';
                   break;
              case "2": //選項為圖片
                   eval(windowform3).style.display='none';
                   eval(windowform4).style.display='block';
                   break;
           }
        }
     }                  
  }
  
  function onechangeall()
  {
     if ( document.mform.allfield.checked )
     {
        for ( i=0; i<9; i++ ) {
           if ( !(document.mform.field[i].checked) )
              document.mform.field[i].checked = true;
        }
     }else{
        for ( i=0; i<9; i++ ) {
          if ( document.mform.field[i].checked )
             document.mform.field[i].checked = false;
       }
     }
  } 
        
  function change(obj)
  {
     window.detail.style.display = 'block';
     for ( k=1; k<=20; k++) {
        str = "document.getElementById('table"+k+"')";
        str1 = "document.getElementById('enterline"+k+"')";
        if ( k <= obj.value ) {   
           eval(str).style.display = "";
           eval(str1).innerHTML = "<br>";
        }else{
           eval(str).style.display = "none";
           eval(str1).innerHTML = "";
        }
     }    	    	
  }
  
  function save()
  {
     if ( document.mform.stdate.value == '' )
     {
        alert("【發布日期】欄位，不可空白，請選擇！");
        document.mform.date1.focus();
        return;     
     }
     if ( document.mform.startusing[1].checked ) 
     {
        if ( document.mform.endate.value == '' )
        {
           alert("【截止日期】欄位，不可空白，請選擇！");
           document.mform.date2.focus();
           return;
        }
        if ( document.mform.stdate.value > document.mform.endate.value )
        {
           alert("【發布日期】不可大於【截止日期】！");
           document.mform.date1.focus();
           return;       
        }
     }
     if ( document.mform.subject.value == '' )
     {
        alert("【標題】欄位，不可空白，請選擇！");
        document.mform.subject.focus();
        return;
     }
     if ( document.mform.filename.value != "" )
     {
        var fn = document.mform.filename.value.toUpperCase();
        if( (fn.indexOf(".JPG") < 0) && (fn.indexOf(".JPEG") < 0) && (fn.indexOf(".GIF") < 0) && (fn.indexOf(".PNG") < 0) )
        {
           alert("您所選的圖片之副檔名不是【.JPG 或 .GIF 或 .JPEG 或 .PNG】，請重新選擇！");
           document.mform.filename.focus();
           return;
        }  
     }
     if ( (document.mform.filename.value != '') && (document.mform.expfile.value == '') )
     {
        alert("【圖片說明】欄位，不可空白，請輸入！");
        document.mform.expfile.focus();
        return;
     }else if ( document.mform.expfile.value.length > 150 ) {
        alert("【圖片說明】欄位，不可超過150個中文字，請重新輸入！");
        document.mform.expfile.focus();
        return;
     }
     if ( document.mform.questiontype[1].checked ) {
        if ( document.mform.isbasic[1].checked ) {
           alert("問卷類型為【有獎徵答】，必須填寫基本資料，請選擇！");
           document.mform.isbasic[0].focus();
           return;
        }
     } 
     if ( document.mform.isbasic[0].checked ) {
        var mfield = "N";
        for ( i=0; i<9; i++ ) {
           if ( document.mform.field[i].checked ) {
              mfield = "Y";
              break;
           }
        }
     }     
     if ( mfield == 'N' ) {
        alert("您未勾選【基本資料欄位】，請勾選！");
        document.mform.field[0].focus();
        return;
     }
     //姓名需勾選
     if ( document.mform.isbasic[0].checked ) {
        document.mform.field[0].checked = true;
     }
     //if ( document.mform.questiontype[1].checked ) {
     //   document.mform.field[1].checked = true;
     //}
     
     if ( document.mform.fieldnum.value == '' )
     {
        alert("【本次問卷題數】欄位，不可空白，請選擇！");
        document.mform.fieldnum.focus();
        return;
     }else{
        var num = document.mform.fieldnum.value;
        var subject1 = "N";
        for ( i=1; i<=num; i++ ) {
           var subjectform = "document.mform.subject" + i;   //題目
           var choiceform = "document.mform.choice" + i;     //選項類型
           var ansform = "document.mform.answer" + i;        //解答
           if ( eval(subjectform).value != '' ) {
              subject1 = "Y";
              var msubject = "N";
              var mfilename = "N";
              for ( j=1; j<=8; j++ ) {
                 var msubjectform = "document.mform.msubject" + j + i;
                 var mfilenameform = "document.mform.filename" + j + i;
                 var mexpfileform = "document.mform.expfile" + j + i;
                 var osfile = "document.mform.osfile" + j + i;                 
                 if ( eval(choiceform)[0].checked ) {
                    if ( eval(msubjectform).value != '' ) {
                       msubject = "Y";
                       break;
                    }
                 }else if ( eval(choiceform)[1].checked ) {
                    if ( eval(mfilenameform).value != '' || ( eval(osfile).value != 'null' && eval(osfile).value != '' ) ) {
                       if ( eval(mexpfileform).value == '' ) {
                          alert("【第"+i+"題】之【第"+j+"個選項】的圖片說明，欄位不可空白，請輸入！");
                          eval(mexpfileform).focus();
                          return;
                       }else{
                          mfilename = "Y";
                       }
                    }
                 }
              }
              if ( eval(choiceform)[0].checked ) {
                 var mchoice = "document.mform.msubject1" + i;
                 if ( msubject == "N" ) {
                    alert("第"+i+"題之【選項】欄位，至少需輸入一個，請輸入！");
                    eval(mchoice).focus();
                    return;
                 }
              }
              if ( eval(choiceform)[1].checked ) {
                 var mfile = "document.mform.filename1" + i;
                 if ( mfilename == "N" ) {
                    alert("第"+i+"題之【選項】欄位，至少需輸入一個，請輸入！");
                    eval(mfile).focus();
                    return;
                 }
              }
              if ( document.mform.questiontype[1].checked ) {
                 if ( eval(ansform).value == '' ) {
                    alert("【有獎徵答】之【解答】欄位，不可空白；\n第"+i+"題之【解答】欄位，不可空白，請輸入！");
                    eval(ansform).focus();
                    return;
                 }
              }
           }
           
        }
        if ( subject1 == "N" ) {
           alert("【至少需輸入一題】，請輸入！");
           document.mform.subject1.focus();
           return;
        }
     }

     if ( document.mform.filename.value != "" ) {
        document.mform.mfilename.value = document.mform.filename.value;
     }
     for ( n=1; n<=num; n++ ) {
        var msubjectform = "document.mform.subject" + n;
        var mchoiceform = "document.mform.choice" + n;
        if ( eval(msubjectform) != '' ) {
           if ( eval(mchoiceform)[1].checked ) {
              for ( f=1; f<=8; f++ ) {
                 var mfile1 = "document.mform.filename" + f + n;
                 var mfile2 = "document.mform.mfilename" + f + n;
                 eval(mfile2).value = eval(mfile1).value;
              }
           }
        }
     }
     
     //因上傳元件，需將換行等tag replace
     if ( document.mform.content.value != '' )
     {
        var contentStr = document.mform.content.value;
        while (contentStr.indexOf("\n") != -1)
        {
           contentStr = contentStr.replace("\n", "|");
        }
        while (contentStr.indexOf("\r") != -1)
        {
           contentStr = contentStr.replace("\r", "");
        }
        while (contentStr.indexOf("\t") != -1)
        {
           contentStr = contentStr.replace("\t", "");
        }
        document.mform.mcontent.value = contentStr;
        document.mform.content.value = "";
     }
     
     //因上傳元件，需將換行等tag replace
     if ( document.mform.expfile.value != '' )
     {
        var contentStr = document.mform.expfile.value;
        while (contentStr.indexOf("\n") != -1)
        {
           contentStr = contentStr.replace("\n", "|");
        }
        while (contentStr.indexOf("\r") != -1)
        {
           contentStr = contentStr.replace("\r", "");
        }
        while (contentStr.indexOf("\t") != -1)
        {
           contentStr = contentStr.replace("\t", "");
        }
        document.mform.mexpfile.value = contentStr;
        document.mform.expfile.value = "";
     }
     
     document.mform.action = "questionnaire101_mdysave.jsp";
     document.mform.method = "post";
     document.mform.submit();
     
  }    

  function del()
  {
     x=window.confirm("確定刪除此筆資料嗎?")
     if(x)
     {
        document.mform.action="questionnaire101_del.jsp?type=1";
        document.mform.method="post";
        document.mform.submit();
     } 
  }
</script>

<body>
<form name="backform">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name=language value="<%=language%>"/>
  <input type="hidden" name=qptdate value="<%=qptdate%>"/>
  <input type="hidden" name=qdldate value="<%=qdldate%>"/>
</form>

<form name="mform" enctype="multipart/form-data">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="keyword" value="<%=keyword%>"/>
  <input type="hidden" name="qpunit" value="<%=qpunit%>"/>
  <input type="hidden" name="serno" value="<%=serno%>"/>
  <input type="hidden" name=language value="<%=language%>"/>
  <input type="hidden" name=qptdate value="<%=qptdate%>"/>
  <input type="hidden" name=qdldate value="<%=qdldate%>"/>
  
<!-- 應用系統名稱 -->
<%@ include file="../../pubprogram/qtitle.jsp"%>

<div id="title">
  <h2><img src="../../img/addedit.png" width="48" height="48" align="middle"/><%=title%></h2>
</div>
<p></p>
 <a class="md" href="javascript:save()">儲存</a>
 <a class="md" href="javascript:del()">刪除</a>	
 <a class="md" href="javascript:window.document.mform.reset()">重設</a>	 		
 <a class="md" href="javascript:back()">回上頁</a>

<br/>
<span class="T12red">說明：資料異動，需再審核後，才可顯示在民眾端</span>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01">
  <tr class="tr">
    <th colspan="4">資料修改</th>
  </tr>
  <tr class="tr">
    <td class="T12b" width="23%"><span class="T12red">※</span>發布日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date1"/>
          <jsp:param name="colname" value="stdate"/>
          <jsp:param name="colnameview" value="stdateview"/>
          <jsp:param name="datevalue" value="<%=query.getPosterdate()%>" />
      </jsp:include>  
    </td>
  </tr>
  <%
    String mstartusing = query.getStartusing();
    String mstyle = "style='display:none'";
    if ( mstartusing.equals("0") )
    	mstyle = "style='display:block'";
  %>
  <tr>
    <td class="T12b" width="15%"><span class="T12red">※</span>啟用</td>
    <td colspan="3">
      <input type="radio" name="startusing" value="1" onclick="chg()" <%=(mstartusing.equals("1") ? "checked" : "")%>>永久有效&nbsp;&nbsp;&nbsp;
      <input type="radio" name="startusing" value="0" onclick="chg()" <%=(mstartusing.equals("0") ? "checked" : "")%>>截止日期
    </td>
  </tr>
  <tr id='type' <%=mstyle%>>
    <td class="T12b" width="20%"><span class="T12red">※</span>截止日期</td>
    <td colspan="3">
      <jsp:include page="../../pubprogram/choicedate.jsp"> 
          <jsp:param name="buttonname" value="date2"/>
          <jsp:param name="colname" value="endate"/>
          <jsp:param name="colnameview" value="endateview"/>
          <jsp:param name="datevalue" value="<%=query.getClosedate()%>" />
      </jsp:include>  
    </td>
  </tr>
  <tr class="tr">
    <td class="T12b"><span class="T12red">※</span>標題</td>
    <td colspan="3">
      <input name="subject" type="text" class="lInput01" size="50" maxlength="50" value="<%=query.getSubject()%>"/>
      &nbsp;&nbsp;&nbsp;<span class="T10">(不可超過50個中文字）</span>
    </td>
  </tr>
  <tr>
    <td class="T12b"><span class="T12red">※</span>發佈單位</td>
    <td colspan="3"><%=query.getPubunitname()%></td>
    <input type="hidden" name="punit" value=<%=query.getPubunitdn()%>>
    <input type="hidden" name="pubunitname" value=<%=query.getPubunitname()%>>
  </tr>
  <tr class="tr">
    <td valign="top" class="T12b">詳細內容</td>
    <td colspan="3"><textarea name="content" cols="72" rows="12"><%=query.getContent()%></textarea></td>
  </tr>
  <input type="hidden" name="mcontent" />
  <%
    String mquestiontype = query.getQuestiontype();
    String mstyle1 = "style='display:none'";
    if ( mquestiontype.equals("2") )
    	mstyle1 = "style='display:block'";
  %>
  <tr>
    <td class="T12b"><span class="T12red">※</span>問卷類型</td>
    <td colspan="3">
      <input type="radio" name="questiontype" value="1" onclick="chg1()" <%=(mquestiontype.equals("1") ? "checked" : "")%> />問卷調查&nbsp;&nbsp;
      <input type="radio" name="questiontype" value="2" onclick="chg1()" <%=(mquestiontype.equals("2") ? "checked" : "")%> />有獎徵答
    </td>
  </tr>
  <tr class="tr" id='type1' <%=mstyle1%>>
    <td class="T12b">獎品數量</td>
    <td colspan="3">
      <input name="prizenumber" type="text" class="lInput01" size="10" value="<%=query.getPrizenumber()%>" ONKEYPRESS="if ((event.keyCode < 47) || (event.keyCode > 57)) event.returnValue = false;" />
    </td>
  </tr>
  <tr id='type11' <%=mstyle1%>>
    <td class="T12b" valign="top">獎品圖片</td>
    <td colspan="3">
      <input name="filename" type="file" class="lInput01" size="20" /><br />
      <span class="T10">
      <%
        String expfile = "";
        if ( query.getExpfile() != null && !query.getExpfile().equals("null") && !query.getExpfile().equals("") )
        	expfile = query.getExpfile();
        if ( query.getServerfile() != null && !query.getServerfile().equals("null") && !query.getServerfile().equals("") ) { %>
        	<span class="T10">【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(query.getServerfile(),"UTF-8")%>&flag=questionpath"><%=query.getClientfile()%></a></span>
        	&nbsp;&nbsp;<input type="checkbox" name="delete" />&nbsp;刪除&nbsp;(若是更換圖片，此處不需勾選)<br />
        <%}%></span>
                 圖片說明：<br /><textarea name="expfile" rows="3" cols="50"><%=expfile%></textarea>
      <span class="T10">(不可超過150個中文字）</span>
      <input type="hidden" name="mexpfile" />
      <input type="hidden" name="mfilename" />
      <input type="hidden" name="oexpfile" value="<%=query.getExpfile()%>" />
      <input type="hidden" name="ocfile" value="<%=query.getClientfile()%>" />
      <input type="hidden" name="osfile" value="<%=query.getServerfile()%>" />
      <input type="hidden" name="oimagemagick" value="<%=query.getImagemagick()%>" />
    </td>
  </tr>
  <%
    String misbasic = query.getIsbasic();
    String mstyle2 = "style='display:none'";
    String[] ary_basic = null;
    if ( misbasic.equals("Y") ) {
    	mstyle2 = "style='display:block'";
    	ary_basic = SvString.split(query.getBasicfield(),"||");
    }
    
  %>
  <tr class="tr">
    <td valign="top" class="T12b"><span class="T12red">※</span>是否填寫基本資料</td>
    <td colspan="3">
      <input type="radio" name="isbasic" value="Y" onclick="chg2()" <%=(misbasic.equals("Y") ? "checked" : "")%> />是&nbsp;&nbsp;
      <input type="radio" name="isbasic" value="N" onclick="chg2()" <%=(misbasic.equals("N") ? "checked" : "")%> />否
    </td>
  </tr>
  <tr id='type2' <%=mstyle2%>>
    <td valign="top" class="T12b"><span class="T12red">※</span>基本資料欄位勾選</td>
    <td colspan="3">
      <table border="0" width="97%">
        <tr>
          <td><input type="checkbox" name="allfield" value="" onclick="onechangeall()"></input>&nbsp;全選</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="field" value="1" <%=(SvString.contain(ary_basic,"1") ? "checked" : "")%>></input>&nbsp;姓名</td>
          <td><input type="checkbox" name="field" value="2" <%=(SvString.contain(ary_basic,"2") ? "checked" : "")%>></input>&nbsp;身份證字號</td>
          <td><input type="checkbox" name="field" value="3" <%=(SvString.contain(ary_basic,"3") ? "checked" : "")%>></input>&nbsp;性別　</td>
          <td><input type="checkbox" name="field" value="4" <%=(SvString.contain(ary_basic,"4") ? "checked" : "")%>></input>&nbsp;E-MAIL</td>
          <td><input type="checkbox" name="field" value="5" <%=(SvString.contain(ary_basic,"5") ? "checked" : "")%>></input>&nbsp;住址</td>
        </tr>
        <tr>
          <td><input type="checkbox" name="field" value="6" <%=(SvString.contain(ary_basic,"6") ? "checked" : "")%>></input>&nbsp;電話</td>
          <td><input type="checkbox" name="field" value="7" <%=(SvString.contain(ary_basic,"7") ? "checked" : "")%>></input>&nbsp;學歷</td>
          <td><input type="checkbox" name="field" value="8" <%=(SvString.contain(ary_basic,"8") ? "checked" : "")%>></input>&nbsp;年齡</td>
          <td><input type="checkbox" name="field" value="9" <%=(SvString.contain(ary_basic,"9") ? "checked" : "")%>></input>&nbsp;職業</td>
        </tr>
      </table>  
    </td>
  </tr>
  <%
    QuestionnaireData qdata = new QuestionnaireData();
    ArrayList qlists = qdata.findByday(query.getSerno());
    int rcount = qdata.getAllrecordCount();
  %>
  <tr class="tr">
    <td valign="top" class="T12b"><span class="T12red">※</span>本次問卷題數</td>
    <td colspan="3">
      <select name="fieldnum" onchange="change(this)">
        <option value="">--- 請選擇 ---</option>
        <%
          for ( int n=0; n<20; n++ ) {
        	  String isSelected = "";
        	  if ( n == rcount-1 )
        		  isSelected = "selected"; %>
        	  <option value="<%=n+1%>" <%=isSelected%>><%=n+1%></option>
          <%}%>
      </select>
    </td>
  </tr>
  <tr >
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
    <th >&nbsp;</th>
  </tr>
</table>
<br />
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table01" id="detail">
  <tr class="tr">
    <th colspan="5">‧細‧項‧目‧設‧定‧</th>
  </tr>
  <tr align="center">
    <th width="5%">編號</th>
    <th width="59%">題　　　目</th>
    <th width="8%">複選</th>
    <th width="10%">提供民眾<br/>文字輸入</th>
    <th width="18%">解　答</th>
  </tr>
  <tr>
    <td colspan="5">
      <%
        if ( qlists != null ) {
        	for ( int n=0; n<rcount; n++ ) {
        		QuestionnaireData qlist = ( QuestionnaireData )qlists.get( n );
        	    String mchoicetype = qlist.getChoicetype();
        	    String mstyle3 = "style='display:none'";
        	    String mstyle4 = "style='display:none'";
        	    if ( mchoicetype.equals("1") ) {
        	    	mstyle3 = "style='display:block'";
        	    	mstyle4 = "style='display:none'";
        	    }else if ( mchoicetype.equals("2") ) {
        	    	mstyle3 = "style='display:none'";
        	    	mstyle4 = "style='display:block'";
        	    } %>
        		<span id="enterline<%=n+1%>"></span>
        		<table border="0" width="100%" id="table<%=n+1%>">
        		  <tr align="center" valign="top">
	        	    <td width="5%"><%=n+1%></td>
	        	    <td width="59%" align="left">
	        	      <input type="text" name="subject<%=n+1%>" size="60" value="<%=qlist.getMsubject()%>" /><br/>
	        	      <input type="radio" name="choice<%=n+1%>" value="1" onclick="chg3('<%=n+1%>')" <%=(qlist.getChoicetype().equals("1") ? "checked" : "")%> />選項為文字&nbsp;&nbsp;&nbsp;
	        	      <input type="radio" name="choice<%=n+1%>" value="2" onclick="chg3('<%=n+1%>')" <%=(qlist.getChoicetype().equals("2") ? "checked" : "")%> />選項為圖片
	        	      <table border="0">
	        	        <tr id="type3<%=n+1%>" <%=mstyle3%>>
	        	          <td>
	        	            1.<input type="text" name="msubject1<%=n+1%>" size="22" maxlength="100" value="<%=qlist.getServerfile1()%>" />&nbsp;&nbsp;
	        	            2.<input type="text" name="msubject2<%=n+1%>" size="22" maxlength="100" value="<%=qlist.getServerfile2()%>" /><br/>
	        	            3.<input type="text" name="msubject3<%=n+1%>" size="22" maxlength="100" value="<%=qlist.getServerfile3()%>" />&nbsp;&nbsp;
	        	            4.<input type="text" name="msubject4<%=n+1%>" size="22" maxlength="100" value="<%=qlist.getServerfile4()%>" /><br/>
	        	            5.<input type="text" name="msubject5<%=n+1%>" size="22" maxlength="100" value="<%=qlist.getServerfile5()%>" />&nbsp;&nbsp;
	        	            6.<input type="text" name="msubject6<%=n+1%>" size="22" maxlength="100" value="<%=qlist.getServerfile6()%>" /><br/>
	        	            7.<input type="text" name="msubject7<%=n+1%>" size="22" maxlength="100" value="<%=qlist.getServerfile7()%>" />&nbsp;&nbsp;
	        	            8.<input type="text" name="msubject8<%=n+1%>" size="22" maxlength="100" value="<%=qlist.getServerfile8()%>" /><br/>
	        	          </td>
	        	        </tr>
	        	        <tr id="type4<%=n+1%>" <%=mstyle4%>>
	        	          <td>
	        	            1.<input name="filename1<%=n+1%>" type="file" class="lInput01" />&nbsp;
	        	                                       圖片說明：<input type="text" name="expfile1<%=n+1%>" size="18" maxlength="100" value="<%=qlist.getExpfile1().equals("null") ? "" : qlist.getExpfile1()%>"/><br />
	        	               <%
	        	                 if ( qlist.getClientfile1() != null && !qlist.getClientfile1().equals("null") && !qlist.getClientfile1().equals("") ) { %>
	        	                	 <span class="T10">&nbsp;【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile1(),"UTF-8")%>&flag=questionpath"><%=qlist.getClientfile1()%></a>
	        	                	 <input type="checkbox" name="delete1<%=n+1%>" />&nbsp;刪除(若是更換圖片，此處不需勾選)
	        	                	 </span><br />
	        	                 <%}%>
	        	            2.<input name="filename2<%=n+1%>" type="file" class="lInput01" />&nbsp;
        	                                                  圖片說明：<input type="text" name="expfile2<%=n+1%>" size="18" maxlength="100" value="<%=qlist.getExpfile2().equals("null") ? "" : qlist.getExpfile2()%>"/><br />
        	                   <%
	        	                 if ( qlist.getClientfile2() != null && !qlist.getClientfile2().equals("null") && !qlist.getClientfile2().equals("") ) { %>
	        	                	 <span class="T10">【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile2(),"UTF-8")%>&flag=questionpath"><%=qlist.getClientfile2()%></a>
	        	                	 &nbsp;<input type="checkbox" name="delete2<%=n+1%>" />&nbsp;刪除(若是更換圖片，此處不需勾選)
	        	                	 </span><br />
	        	                 <%}%>                               
        	                3.<input name="filename3<%=n+1%>" type="file" class="lInput01" />&nbsp;
        	                                                  圖片說明：<input type="text" name="expfile3<%=n+1%>" size="18" maxlength="100" value="<%=qlist.getExpfile3().equals("null") ? "" : qlist.getExpfile3()%>"/><br />
        	                   <%
	        	                 if ( qlist.getClientfile3() != null && !qlist.getClientfile3().equals("null") && !qlist.getClientfile3().equals("") ) { %>
	        	                	 <span class="T10">【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile3(),"UTF-8")%>&flag=questionpath"><%=qlist.getClientfile3()%></a>
	        	                	 &nbsp;<input type="checkbox" name="delete3<%=n+1%>" />&nbsp;刪除(若是更換圖片，此處不需勾選)
	        	                	 </span><br />
	        	                 <%}%>
        	                4.<input name="filename4<%=n+1%>" type="file" class="lInput01" />&nbsp;
        	                                                  圖片說明：<input type="text" name="expfile4<%=n+1%>" size="18" maxlength="100" value="<%=qlist.getExpfile4().equals("null") ? "" : qlist.getExpfile4()%>"/><br />
        	                   <%
	        	                 if ( qlist.getClientfile4() != null && !qlist.getClientfile4().equals("null") && !qlist.getClientfile4().equals("") ) { %>
	        	                	 <span class="T10">【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile4(),"UTF-8")%>&flag=questionpath"><%=qlist.getClientfile4()%></a>
	        	                	 &nbsp;<input type="checkbox" name="delete4<%=n+1%>" />&nbsp;刪除(若是更換圖片，此處不需勾選)
	        	                	 </span><br />
	        	                 <%}%>
        	                5.<input name="filename5<%=n+1%>" type="file" class="lInput01" />&nbsp;
        	                                                  圖片說明：<input type="text" name="expfile5<%=n+1%>" size="18" maxlength="100" value="<%=qlist.getExpfile5().equals("null") ? "" : qlist.getExpfile5()%>"/><br />
        	                   <%
	        	                 if ( qlist.getClientfile5() != null && !qlist.getClientfile5().equals("null") && !qlist.getClientfile5().equals("") ) { %>
	        	                	 <span class="T10">【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile5(),"UTF-8")%>&flag=questionpath"><%=qlist.getClientfile5()%></a>
	        	                	 &nbsp;<input type="checkbox" name="delete5<%=n+1%>" />&nbsp;刪除(若是更換圖片，此處不需勾選)
	        	                	 </span><br />
	        	                 <%}%>
        	                6.<input name="filename6<%=n+1%>" type="file" class="lInput01" />&nbsp;
        	                                                  圖片說明：<input type="text" name="expfile6<%=n+1%>" size="18" maxlength="100" value="<%=qlist.getExpfile6().equals("null") ? "" : qlist.getExpfile6()%>"/><br />
        	                   <%
	        	                 if ( qlist.getClientfile6() != null && !qlist.getClientfile6().equals("null") && !qlist.getClientfile6().equals("") ) { %>
	        	                	 <span class="T10">【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile6(),"UTF-8")%>&flag=questionpath"><%=qlist.getClientfile6()%></a>
	        	                	 &nbsp;<input type="checkbox" name="delete6<%=n+1%>" />&nbsp;刪除(若是更換圖片，此處不需勾選)
	        	                	 </span><br />
	        	                 <%}%>
        	                7.<input name="filename7<%=n+1%>" type="file" class="lInput01" />&nbsp;
        	                                                  圖片說明：<input type="text" name="expfile7<%=n+1%>" size="18" maxlength="100" value="<%=qlist.getExpfile7().equals("null") ? "" : qlist.getExpfile7()%>"/><br />
        	                   <%
	        	                 if ( qlist.getClientfile7() != null && !qlist.getClientfile7().equals("null") && !qlist.getClientfile7().equals("") ) { %>
	        	                	 <span class="T10">【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile7(),"UTF-8")%>&flag=questionpath"><%=qlist.getClientfile7()%></a>
	        	                	 &nbsp;<input type="checkbox" name="delete7<%=n+1%>" />&nbsp;刪除(若是更換圖片，此處不需勾選)
	        	                	 </span><br />
	        	                 <%}%>
        	                8.<input name="filename8<%=n+1%>" type="file" class="lInput01" />&nbsp;
        	                                                  圖片說明：<input type="text" name="expfile8<%=n+1%>" size="18" maxlength="100" value="<%=qlist.getExpfile8().equals("null") ? "" : qlist.getExpfile8()%>"/><br />
        	                   <%
	        	                 if ( qlist.getClientfile8() != null && !qlist.getClientfile8().equals("null") && !qlist.getClientfile8().equals("") ) { %>
	        	                	 <span class="T10">&nbsp;【原圖片檔名】：<a href="../../downdoc?file=/<%=java.net.URLEncoder.encode(qlist.getServerfile8(),"UTF-8")%>&flag=questionpath"><%=qlist.getClientfile8()%></a>
	        	                	 <input type="checkbox" name="delete8<%=n+1%>" />&nbsp;刪除(若是更換圖片，此處不需勾選)
	        	                	 </span><br />
	        	                 <%}%>
        	               </td>
        	            </tr>
        	            <input type="hidden" name="mfilename1<%=n+1%>" />
        	            <input type="hidden" name="mfilename2<%=n+1%>" />
        	            <input type="hidden" name="mfilename3<%=n+1%>" />
        	            <input type="hidden" name="mfilename4<%=n+1%>" />
        	            <input type="hidden" name="mfilename5<%=n+1%>" />
        	            <input type="hidden" name="mfilename6<%=n+1%>" />
        	            <input type="hidden" name="mfilename7<%=n+1%>" />
        	            <input type="hidden" name="mfilename8<%=n+1%>" />
        	            <input type="hidden" name="ocfile1<%=n+1%>" value="<%=qlist.getClientfile1()%>" />
        	            <input type="hidden" name="ocfile2<%=n+1%>" value="<%=qlist.getClientfile2()%>" />
        	            <input type="hidden" name="ocfile3<%=n+1%>" value="<%=qlist.getClientfile3()%>" />
        	            <input type="hidden" name="ocfile4<%=n+1%>" value="<%=qlist.getClientfile4()%>" />
        	            <input type="hidden" name="ocfile5<%=n+1%>" value="<%=qlist.getClientfile5()%>" />
        	            <input type="hidden" name="ocfile6<%=n+1%>" value="<%=qlist.getClientfile6()%>" />
        	            <input type="hidden" name="ocfile7<%=n+1%>" value="<%=qlist.getClientfile7()%>" />
        	            <input type="hidden" name="ocfile8<%=n+1%>" value="<%=qlist.getClientfile8()%>" />
        	            <input type="hidden" name="osfile1<%=n+1%>" value="<%=qlist.getServerfile1()%>" />
        	            <input type="hidden" name="osfile2<%=n+1%>" value="<%=qlist.getServerfile2()%>" />
        	            <input type="hidden" name="osfile3<%=n+1%>" value="<%=qlist.getServerfile3()%>" />
        	            <input type="hidden" name="osfile4<%=n+1%>" value="<%=qlist.getServerfile4()%>" />
        	            <input type="hidden" name="osfile5<%=n+1%>" value="<%=qlist.getServerfile5()%>" />
        	            <input type="hidden" name="osfile6<%=n+1%>" value="<%=qlist.getServerfile6()%>" />
        	            <input type="hidden" name="osfile7<%=n+1%>" value="<%=qlist.getServerfile7()%>" />
        	            <input type="hidden" name="osfile8<%=n+1%>" value="<%=qlist.getServerfile8()%>" />
        	            <input type="hidden" name="oexpfile1<%=n+1%>" value="<%=qlist.getExpfile1()%>" />
        	            <input type="hidden" name="oexpfile2<%=n+1%>" value="<%=qlist.getExpfile2()%>" />
        	            <input type="hidden" name="oexpfile3<%=n+1%>" value="<%=qlist.getExpfile3()%>" />
        	            <input type="hidden" name="oexpfile4<%=n+1%>" value="<%=qlist.getExpfile4()%>" />
        	            <input type="hidden" name="oexpfile5<%=n+1%>" value="<%=qlist.getExpfile5()%>" />
        	            <input type="hidden" name="oexpfile6<%=n+1%>" value="<%=qlist.getExpfile6()%>" />
        	            <input type="hidden" name="oexpfile7<%=n+1%>" value="<%=qlist.getExpfile7()%>" />
        	            <input type="hidden" name="oexpfile8<%=n+1%>" value="<%=qlist.getExpfile8()%>" />
        	            <input type="hidden" name="oimagemagick1<%=n+1%>" value="<%=qlist.getImagemagick1()%>" />
        	            <input type="hidden" name="oimagemagick2<%=n+1%>" value="<%=qlist.getImagemagick2()%>" />
        	            <input type="hidden" name="oimagemagick3<%=n+1%>" value="<%=qlist.getImagemagick3()%>" />
        	            <input type="hidden" name="oimagemagick4<%=n+1%>" value="<%=qlist.getImagemagick4()%>" />
        	            <input type="hidden" name="oimagemagick5<%=n+1%>" value="<%=qlist.getImagemagick5()%>" />
        	            <input type="hidden" name="oimagemagick6<%=n+1%>" value="<%=qlist.getImagemagick6()%>" />
        	            <input type="hidden" name="oimagemagick7<%=n+1%>" value="<%=qlist.getImagemagick7()%>" />
        	            <input type="hidden" name="oimagemagick8<%=n+1%>" value="<%=qlist.getImagemagick8()%>" />
        	          </table>
        	        </td>
        	        <%
        	          String mchecked = "";
        	          if ( qlist.getRellection().equals("Y") )
        	        	  mchecked = "checked";
        	          String mchecked1 = "";
        	          if ( qlist.getInputtext().equals("Y") )
        	        	  mchecked1 = "checked";
        	        %>
        	        <td width="8%"><input type="checkbox" name="reelection<%=n+1%>" <%=mchecked%>/></td>
        	        <td width="10%"><input type="checkbox" name="inputtext<%=n+1%>" <%=mchecked1%>/></td>
        	        <td width="18%" align="left">
        	          <textarea name="answer<%=n+1%>" rows="3" cols="15"><%=qlist.getAnswer()%></textarea>
        	          <br/><font size="2"><b>※ 複選解答輸入請以逗號隔開；如1,2</b></font>
        	        </td>
        	      </tr>        	  
        	    </table>
        	<%}
        }
        for ( int k=rcount+1; k<=20; k++ ) { %>
        	<span id="enterline<%=k%>"></span>
        	<table border="0" width="100%" style="display:none" id="table<%=k%>">
        	  <tr align="center" valign="top">
        	    <td width="5%"><%=k%></td>
        	    <td width="59%" align="left">
        	      <input type="text" name="subject<%=k%>" size="60" /><br/>
        	      <input type="radio" name="choice<%=k%>" value="1" onclick="chg3('<%=k%>')" checked />選項為文字&nbsp;&nbsp;&nbsp;
        	      <input type="radio" name="choice<%=k%>" value="2" onclick="chg3('<%=k%>')" />選項為圖片
        	      <table border="0">
        	        <tr id="type3<%=k%>" style="display:block">
        	          <td>
        	            1.<input type="text" name="msubject1<%=k%>" size="22" maxlength="100" />&nbsp;&nbsp;
        	            2.<input type="text" name="msubject2<%=k%>" size="22" maxlength="100" /><br/>
        	            3.<input type="text" name="msubject3<%=k%>" size="22" maxlength="100" />&nbsp;&nbsp;
        	            4.<input type="text" name="msubject4<%=k%>" size="22" maxlength="100" /><br/>
        	            5.<input type="text" name="msubject5<%=k%>" size="22" maxlength="100" />&nbsp;&nbsp;
        	            6.<input type="text" name="msubject6<%=k%>" size="22" maxlength="100" /><br/>
        	            7.<input type="text" name="msubject7<%=k%>" size="22" maxlength="100" />&nbsp;&nbsp;
        	            8.<input type="text" name="msubject8<%=k%>" size="22" maxlength="100" /><br/>
        	          </td>
        	        </tr>
        	        <tr id="type4<%=k%>" style="display:none">
        	          <td>
        	            1.<input name="filename1<%=k%>" type="file" class="lInput01" />&nbsp;
      	                                                圖片說明：<input type="text" name="expfile1<%=k%>" size="18" maxlength="100"/>
      	                2.<input name="filename2<%=k%>" type="file" class="lInput01" />&nbsp;
      	                                                圖片說明：<input type="text" name="expfile2<%=k%>" size="18" maxlength="100"/>
      	                3.<input name="filename3<%=k%>" type="file" class="lInput01" />&nbsp;
      	                                                圖片說明：<input type="text" name="expfile3<%=k%>" size="18" maxlength="100"/>
      	                4.<input name="filename4<%=k%>" type="file" class="lInput01" />&nbsp;
      	                                                圖片說明：<input type="text" name="expfile4<%=k%>" size="18" maxlength="100"/>
      	                5.<input name="filename5<%=k%>" type="file" class="lInput01" />&nbsp;
      	                                                圖片說明：<input type="text" name="expfile5<%=k%>" size="18" maxlength="100"/>
      	                6.<input name="filename6<%=k%>" type="file" class="lInput01" />&nbsp;
      	                                                圖片說明：<input type="text" name="expfile6<%=k%>" size="18" maxlength="100"/>
      	                7.<input name="filename7<%=k%>" type="file" class="lInput01" />&nbsp;
      	                                                圖片說明：<input type="text" name="expfile7<%=k%>" size="18" maxlength="100"/>
      	                8.<input name="filename8<%=k%>" type="file" class="lInput01" />&nbsp;
      	                                                圖片說明：<input type="text" name="expfile8<%=k%>" size="18" maxlength="100"/>
      	              </td>
      	            </tr>
      	            <input type="hidden" name="mfilename1<%=k%>" />
      	            <input type="hidden" name="mfilename2<%=k%>" />
      	            <input type="hidden" name="mfilename3<%=k%>" />
      	            <input type="hidden" name="mfilename4<%=k%>" />
      	            <input type="hidden" name="mfilename5<%=k%>" />
      	            <input type="hidden" name="mfilename6<%=k%>" />
      	            <input type="hidden" name="mfilename7<%=k%>" />
      	            <input type="hidden" name="mfilename8<%=k%>" />
      	          </table>
      	        </td>
      	        <td width="8%"><input type="checkbox" name="reelection<%=k%>"/></td>
      	        <td width="10%"><input type="checkbox" name="inputtext<%=k%>"/></td>
      	        <td width="18%" align="left">
      	          <textarea name="answer<%=k%>" rows="3" cols="15"></textarea>
      	          <br/><font size="2"><b>※ 複選解答輸入請以逗號隔開；如1,2</b></font>
      	        </td>
      	      </tr>        	  
      	    </table>
      	<%}%>
    </td>
  </tr>
</table>        

<p><div align="left"><a class="md" href="#top">回頁首</a></div>

</form>
</body>
</html>

