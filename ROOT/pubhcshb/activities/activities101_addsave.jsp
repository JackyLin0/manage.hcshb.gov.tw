<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：activities101_addsave.jsp
說明：活動訊息維護(可發布至縣府入口網的活動訊息)
開發者：chmei
開發日期：97.02.17
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數
  String table = ( String )request.getParameter( "t" );
  String table1 = ( String )request.getParameter( "t1" );
  String table2 = ( String )request.getParameter( "t2" );
  String title = ( String )request.getParameter( "title" );
  String pagesize = ( String )request.getParameter( "pagesize" );
  String intpage = ( String )request.getParameter( "intpage" );
  String murl = ( String )request.getParameter( "murl" );
  String language = ( String )request.getParameter( "language" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值    
  String stdate = ( String )request.getParameter( "stdate" );
  String startusing = ( String )request.getParameter( "startusing" );
  String endate = ( String )request.getParameter( "endate" );
  if ( startusing.equals("1") ) {
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	  Calendar specialDate = Calendar.getInstance();
	  specialDate.setTime(sdf.parse(stdate));
	  specialDate.add(Calendar.YEAR, 1);
	  endate = sdf.format(specialDate.getTime());
  }
	
  String subject = ( String )request.getParameter( "subject" );
  String secsubject = ( String )request.getParameter( "secsubject" );    
  String punit = ( String )request.getParameter( "punit" );  
  String[] ary_punit = SvString.split(punit,"||");  
  String sponsorunit = ( String )request.getParameter( "sponsorunit" );
  String assistunit = ( String )request.getParameter( "assistunit" );
  String content = ( String )request.getParameter( "content" );
  String actsdate = ( String )request.getParameter( "actsdate" );
  String actshour = ( String )request.getParameter( "actshour" );
  String actsminute = ( String )request.getParameter( "actsminute" );
  String actstime = actshour + actsminute;  
  String actedate = ( String )request.getParameter( "actedate" );
  String actehour = ( String )request.getParameter( "actehour" );
  String acteminute = ( String )request.getParameter( "acteminute" );
  String actetime = actehour + acteminute;
  String actplace = ( String )request.getParameter( "actplace" );
  String liaisonper = ( String )request.getParameter( "liaisonper" );
  String liaisontel = ( String )request.getParameter( "liaisontel" );
  String liaisonfax = ( String )request.getParameter( "liaisonfax" );
  String liaisonemail = ( String )request.getParameter( "liaisonemail" );
  String relateurl = ( String )request.getParameter( "relateurl" );
  String relatename = ( String )request.getParameter( "relatename" );
  String mfsort = ( String )request.getParameter( "fsort" );
  int fsort = 2;
  if ( !mfsort.equals("") && mfsort != null && !mfsort.equals("null") )
	  fsort = Integer.parseInt(mfsort);
  String modflag = ( String )request.getParameter( "modflag" );
  String noteflag = ( String )request.getParameter( "noteflag" );
    
  String aptable = ( String )request.getParameter( "aptable" );
  String[] ary_aptable = SvString.split(aptable,"||");
  String aplistdn = ( String )request.getParameter( "webdn" );
  
  //多站台資料
  String webrcount = ( String )request.getParameter( "webrcount" );
  int mcount = 0;
  if ( !webrcount.equals("") )
	  mcount = Integer.parseInt(webrcount);
  
  String website = "";
  String classdata = "";
  for ( int i=0; i<mcount; i++ ) {
	  String mweb = ( String )request.getParameter( "websitedn"+i );
	  String mclass = ( String )request.getParameter( "webclass"+i );
	  if (  (mweb != null) && !mweb.equals("null") && !mweb.equals("") ) {
		  if ( website.equals("") ) {
			  website = mweb;
			  classdata = mclass;
		  }else{
			  website = website + "&" + mweb;
			  classdata = classdata + "&" +mclass;
		  }
	  }	  
  }
  //線上報名
  String onlinesign = ( String )request.getParameter( "onlinesign" );
  String islimitnum = ( String )request.getParameter( "islimitnum" );
  String limitnum = ( String )request.getParameter( "limitnum" );
  if ( limitnum == null || limitnum.equals("null") ||limitnum.equals("") )
	  limitnum = "0";
  String signsdate = ( String )request.getParameter( "qptdate" );
  String signedate = ( String )request.getParameter( "qdldate" );
  String signplace = ( String )request.getParameter( "signplace" );

  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  ActivitiesData obj = new ActivitiesData();  
  
  boolean rtn = true ;
  String errMsg="0";     

  obj.setPosterdate(stdate);
  obj.setStartusing(startusing);
  obj.setClosedate(endate);
  obj.setSecsubject(secsubject);  
  obj.setSponsorunit(sponsorunit);
  obj.setAssistunit(assistunit);
  obj.setContent(content);
  obj.setActsdate(actsdate);
  obj.setActstime(actstime);
  obj.setActedate(actedate);
  obj.setActetime(actetime);
  obj.setActplace(actplace);
  obj.setLiaisonper(liaisonper);
  obj.setLiaisontel(liaisontel);
  obj.setLiaisonfax(liaisonfax);
  obj.setLiaisonemail(liaisonemail);
  obj.setOnlinesign(onlinesign);
  obj.setIslimitnum(islimitnum);
  obj.setLimitnum(Integer.parseInt(limitnum));
  obj.setSignsdate(signsdate);
  obj.setSignedate(signedate);
  obj.setSignplace(signplace);
  obj.setRelateurl(relateurl);
  obj.setRelatename(relatename);
  obj.setFsort(fsort);
  obj.setAptable(aptable);
  obj.setExamtable(table1);
  obj.setAplistdn(aplistdn);
  obj.setWebsitedata(website);
  obj.setWebclassdata(classdata);
  obj.setModflag(modflag);
  obj.setNoteflag(noteflag); 
  
  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(ary_punit[0]);      //發布單位DN
  obj.setPubunitname(ary_punit[1]);    //發布單位名稱
  obj.setSubject(subject);             //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(ary_aptable[1]);    //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("A");                  //狀態

  //取系統路徑
  String sysRoot = (String) application.getRealPath("");
  
  //執行動作(新增資料)  
  rtn = obj.create(sysRoot);    
    
  String showAlert = null;  
  String program = "activities101_add.jsp";
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "新增失敗！" + errMsg;
  }else{	  
	  if ( onlinesign.equals("Y") ) {
		  showAlert="新增成功！此活動有提供線上報名，請繼續執行【報名表欄位編輯】！";
		  program = "activities102_add.jsp?activityserno="+obj.getSerno();
		  murl = "pubhcshb/activities/activities102.jsp?language=ch";
	  }else{
		  showAlert="新增成功！";
	  }
  }
%>

  <form name="mform" action="<%=program%>" method="post">
     <input type="hidden" name="t" value="<%=table%>"/>
     <input type="hidden" name="t1" value="<%=table1%>"/>
     <input type="hidden" name="t2" value="<%=table2%>"/>
     <input type="hidden" name="title" value="<%=title%>"/>
     <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
     <input type="hidden" name="intpage" value="<%=intpage%>"/>
     <input type="hidden" name="murl" value="<%=murl%>"/>
     <input type="hidden" name="language" value="<%=language%>"/>
     <input type="hidden" name="webdn" value="<%=aplistdn%>"/>
     <input type="hidden" name="flag"/>
  </form>
  
  <script>
     alert("<%=showAlert%>");
     document.mform.submit();
  </script>

