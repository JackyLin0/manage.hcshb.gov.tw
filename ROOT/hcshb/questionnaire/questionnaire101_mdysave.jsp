<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：questionnaire101_addsave.jsp
說明：問卷調查資料維護
開發者：chmei
開發日期：97.12.10
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="java.io.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="sysview.zhiren.servlet.mime.SvMultipartRequest" %>
<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>
<%@ page import="tw.com.sysview.upload.*" %>

<%
  //取系統路徑
  String sysRoot1 = (String) application.getRealPath("");
  //判斷OS版本
  String Upload_PATH = "";
  if ( sysRoot1.indexOf("/") == -1 )
	  Upload_PATH = sysRoot1+"\\WEB-INF\\uploadpath.properties";
  else
	  Upload_PATH = sysRoot1+"/WEB-INF/uploadpath.properties";

  Properties upload = new Properties();
  upload.load(new FileInputStream(Upload_PATH) );
  String filepath = upload.getProperty("questionpath");
  String imageresize = upload.getProperty("imageresize");

  //目錄不存在時，建立目錄
  File f = new File(filepath);  
  if (!f.exists()) 
     f.mkdirs();

  //接受上一頁Form內的所有欄位值
  SvMultipartRequest req = new SvMultipartRequest(request);  

  int size = 52428800;
  if ( !req.process(filepath,size) )
  { 
	 System.out.println(req.getErrorMsg());
     session.setAttribute("AlertMessage", "檔案無法上傳！");
     response.sendRedirect("questionnaire101.jsp");
     return;
  }

  QuestionnaireData obj = new QuestionnaireData();  
  
  boolean rtn = true ;
  String errMsg="0"; 
  
  //參數  
  String table = ( String )req.getParameter( "t", "" );
  String title = ( String )req.getParameter( "title", "" );
  String logindn = ( String )req.getParameter( "logindn", "" );
  String pagesize = ( String )req.getParameter( "pagesize", "" );
  
  String intpage = ( String )req.getParameter( "intpage", "" );
  String murl = ( String )req.getParameter( "murl", "" );
  String language = ( String )req.getParameter( "language", "" );
  
  String logincn = ( String )session.getAttribute( "logincn" );

  //form值
  String serno = ( String )req.getParameter( "serno", "" );
  String stdate = ( String )req.getParameter( "stdate", "" );
  String startusing = ( String )req.getParameter( "startusing", "" );
  String endate = ( String )req.getParameter( "endate", "" );
  if ( startusing.equals("1") )
	  endate = "";
  String subject = ( String )req.getParameter( "subject", "" );
  String punit = ( String )req.getParameter( "punit", "" );
  String pubunitname = ( String )req.getParameter( "pubunitname", "" );  
  
  String content = ( String )req.getParameter( "mcontent", "" );
  
  //問卷類型
  String questiontype = ( String )req.getParameter( "questiontype", "" );
  //獎品數量
  String prizenumber = ( String )req.getParameter( "prizenumber", "" );
  if ( prizenumber.equals("") )
	  prizenumber = "0";
  //基本資料
  String isbasic = ( String )req.getParameter( "isbasic", "" );
  String basicfield = "";
  if ( isbasic.equals("Y") ) {
	  String[] ary_basic = req.getParameters( "field", "" );
	  for ( int i=0; i<ary_basic.length; i++ ) {
		  if ( basicfield.equals("") )
			  basicfield = ary_basic[i];
		  else
			  basicfield = basicfield + "||" + ary_basic[i];
	  }
  }

  //問卷題數
  int fieldnum = Integer.parseInt(( String )req.getParameter( "fieldnum", "" ));
  String questdata = "";
  String textdata = "";  
  for ( int q=1; q<=fieldnum; q++ ) {
	  String qsubject = ( String )req.getParameter( "subject"+q, "");
	  if ( qsubject != null && !qsubject.equals("null") && !qsubject.equals("") ) {
		  //題目、複選、文字輸入、解答
		  String mreelection = ( String )req.getParameter( "reelection"+q, "" );
		  if ( mreelection.equals("") )
			  mreelection = "N";
		  else
			  mreelection = "Y";
		  String minputtext = ( String )req.getParameter( "inputtext"+q, "" );
		  if ( minputtext.equals("") )
			  minputtext = "N";
		  else
			  minputtext = "Y";
		  String manswer = ( String )req.getParameter( "answer"+q, "" );
		  if ( questdata.equals("") ) {
			  questdata = q + "||" + qsubject + "||" + minputtext + "||" + mreelection + "||" + manswer;
		  }else{
			  questdata = questdata + "&" + q + "||" + qsubject + "||" + minputtext + "||" + mreelection + "||" + manswer;
		  }
		  
		  String mchoice = ( String )req.getParameter( "choice"+q, "" );
		  String choicedata = "";
		  //選項為文字  
		  if ( mchoice.equals("1") ) {
			  for ( int c1=1; c1<=8; c1++ ) {
				  String msubject = ( String )req.getParameter( "msubject"+c1+q, "" );
				  if ( choicedata.equals("") ) {
					  if ( msubject != null && !msubject.equals("null") && !msubject.equals("") )
						  choicedata = q + "||" + msubject;
					  else
						  choicedata = q + "||" + "a";
				  }else{
					  if ( msubject != null && !msubject.equals("null") && !msubject.equals("") )
						  choicedata = choicedata + "||" + msubject;
					  else
						  choicedata = choicedata + "||" + "a";
				  }
			  }
			  if ( textdata.equals("") )
				  textdata = choicedata;
			  else
				  textdata = textdata + "&" + choicedata;
		  }
	  }
  }
  
  //取系統日期
  SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
  String ndate = fmt.format(Calendar.getInstance().getTime());
      
  File[] reqfile = req.getFiles();  
  //取得上傳檔案的個數 
  int num = reqfile.length;
  
  //宣告陣列
  String filename[] = new String[num];  
  String originfile[] = new String[num];
  
  String filedata = "";
  for (int i=0; i<num; i++) {
	  String mflag = "N";
	  filename[i] = reqfile[i].getName();
	  originfile[i] = req.getOriginFile(filename[i]);
	  if ( i == 0 ) {		  
		  //獎品圖片
		  if ( !req.getParameter( "mfilename", "" ).equals("") ) {			  
			  mflag = "Y";
			  String subfile = SvString.right(filename[i],'.');
			  String filename2 = ndate + i + "." + subfile;
			  File oldfile = new File(filepath + "/" + filename[i]);
			  File newfile = new File(filepath + "/" + filename2);
			  String rename = filename[i];

			  if ( oldfile.renameTo(newfile) )
				  rename = filename2;
			  
			  //自動縮圖 start
			  String autoresize = "N";
			  String smallimagename = SvString.left(rename,".") + i + "_small" + "." + subfile;
			  String bigimg = filepath + "/" + rename;
			  String smallimg = filepath + "/" + SvString.left(rename,".") + i + "_small" + "." + subfile;
			  
			  ImageMagick checkimage = new ImageMagick();
			  boolean smallimage = checkimage.check(imageresize,bigimg);
			  
			  if ( smallimage ) {
				  ImageMagick image = new ImageMagick();		  
				  image.converImage(imageresize,bigimg,smallimg);
				  autoresize = "Y";
			  }
			  //自動縮圖 end
			  
			  if ( oldfile.renameTo(newfile) )
				  rename = filename2;
			  obj.setServerfile(rename);
			  obj.setClientfile(originfile[i]);
			  String mfileexp = ( String )req.getParameter( "mexpfile", "" );
			  obj.setExpfile(mfileexp);
			  if ( autoresize.equals("Y") )
				  obj.setImagemagick(smallimagename);		  
			  else
				  obj.setImagemagick(rename);
		  }
	  }
	  if ( mflag.equals("N") ) {
		  for ( int n=1; n<=fieldnum; n++ ) {
			  String msubject = ( String )req.getParameter( "subject"+n, "");
			  String mchoice = ( String )req.getParameter( "choice"+n, "" );
			  //選項為圖片
			  if ( msubject != null && !msubject.equals("null") && !msubject.equals("") ) {
				  if ( mchoice.equals("2") ) {				  
					  String choicedata = "";
					  for ( int c=1; c<=8; c++ ) {
						  if ( !req.getParameter( "mfilename"+c+n, "" ).equals("") ) {
							  String subfile = SvString.right(reqfile[i].getName(),'.');
							  String filename2 = ndate + i + "." + subfile;
							  File oldfile = new File(filepath + "/" + reqfile[i].getName());
							  File newfile = new File(filepath + "/" + filename2);
							  String rename = reqfile[i].getName();

							  if ( oldfile.renameTo(newfile) )
								  rename = filename2;
							  
							  //自動縮圖 start
							  String autoresize = "N";
							  String smallimagename = SvString.left(rename,".") + i + "_small" + "." + subfile;
							  String bigimg = filepath + "/" + rename;
							  String smallimg = filepath + "/" + SvString.left(rename,".") + i + "_small" + "." + subfile;
							  
							  ImageMagick checkimage = new ImageMagick();
							  boolean smallimage = checkimage.check(imageresize,bigimg);
							  
							  if ( smallimage ) {
								  ImageMagick image = new ImageMagick();		  
								  image.converImage(imageresize,bigimg,smallimg);
								  autoresize = "Y";
							  }
							  //自動縮圖 end
							  
							  if ( oldfile.renameTo(newfile) )
								  rename = filename2;
							 
							  String mexpfile = ( String )req.getParameter( "expfile"+c+n, "" );
							  String imagemagick = rename;
							  if ( autoresize.equals("Y") )
								  imagemagick = smallimagename;
							  if ( choicedata.equals("") ) {
								  choicedata = req.getOriginFile(reqfile[i].getName()) + "," + rename + "," + mexpfile + "," + imagemagick;
							  }else{
								  choicedata = choicedata + "||" + req.getOriginFile(reqfile[i].getName()) + "," + rename + "," + mexpfile + "," + imagemagick;
							  }	
							  i = i + 1;
						  }else {
							  if ( choicedata.equals("") )
								  choicedata = "a";
							  else
								  choicedata = choicedata + "||" + "a";
						  }
					  }
					  if ( filedata.equals("") ) {
						  filedata = n + "||" + choicedata;
					  }else{
						  filedata = filedata + "&" + n + "||" + choicedata;
					  }
				  }
			  }
		  }
	  }
  }
  
  //獎品圖片是否有更新
  String ocfilename = ( String )req.getParameter( "ocfile", "" );
  String osfilename = ( String )req.getParameter( "osfile", "" );
  String oexpfile = ( String )req.getParameter( "oexpfile", "" );
  String oimagemagick = ( String )req.getParameter( "oimagemagick", "" );
  if ( req.getParameter( "mfilename", "" ).equals("") ) {
	  String mdel = ( String )req.getParameter( "delete", "" );
	  if ( !mdel.equals("") ) {
		  //刪除原檔案
		  if ( !osfilename.equals("") ) {
			  File df = new File(filepath,osfilename);
			  if (df.exists())
				  df.delete();
		  }
		  if ( !oimagemagick.equals("") ) {
			  File df = new File(filepath,oimagemagick);
			  if (df.exists())
				  df.delete();
		  }
		  obj.setServerfile("");
		  obj.setClientfile("");
		  obj.setExpfile("");
		  obj.setImagemagick("");
	  }else{
		  obj.setServerfile(osfilename);
		  obj.setClientfile(ocfilename);
		  obj.setExpfile(oexpfile);
		  obj.setImagemagick(oimagemagick);
	  }
  }else{
	  //刪除原檔案
	  if ( !osfilename.equals("") ) {
		  File df = new File(filepath,osfilename);
		  if (df.exists())
			  df.delete();
	  }
	  if ( !oimagemagick.equals("") ) {
		  File df = new File(filepath,oimagemagick);
		  if (df.exists())
			  df.delete();
	  }
  }
  //選項圖片是否有更新
  String ofiledata = "";
  for ( int i=0; i<fieldnum; i++ ) {
	  String mchoice = ( String )req.getParameter( "choice"+i, "" );
	  String choicedata = "";
	  if ( mchoice.equals("2") ) {
		  for ( int j=1; j<=8; j++ ) {
			  String ocfilename1 = ( String )req.getParameter( "ocfile"+j+i, "" );
			  String osfilename1 = ( String )req.getParameter( "osfile"+j+i, "" );
			  String oexpfile1 = ( String )req.getParameter( "oexpfile"+j+i, "" );
			  String oimagemagick1 = ( String )req.getParameter( "oimagemagick"+j+i, "" );
			  if ( req.getParameter( "mfilename"+j+i, "" ).equals("") ) {
				  String mdel = ( String )req.getParameter( "delete"+j+i, "" );
				  if ( !mdel.equals("") ) {
					  //刪除原檔案
					  if ( !osfilename1.equals("") ) {
						  File df = new File(filepath,osfilename1);
						  if (df.exists())
							  df.delete();
					  }
					  if ( !oimagemagick1.equals("") ) {
						  File df = new File(filepath,oimagemagick1);
						  if (df.exists())
							  df.delete();
					  }
					  if ( choicedata.equals("") )
						  choicedata = "a";
					  else
						  choicedata = choicedata + "||" + "a";
				  }else{
					  if ( !ocfilename1.equals("") ) {
						  if ( choicedata.equals("") )
							  choicedata = ocfilename1 + "," + osfilename1 + "," + oexpfile1 + "," + oimagemagick1;
						  else
							  choicedata = choicedata + "||" + ocfilename1 + "," + osfilename1 + "," + oexpfile1 + "," + oimagemagick1;
					  }else{
						  if ( choicedata.equals("") )
							  choicedata = "a";
						  else
							  choicedata = choicedata + "||" + "a";
					  }
				  }
			  }else{
				  //刪除原檔案
				  if ( !osfilename1.equals("") ) {
					  File df = new File(filepath,osfilename1);
					  if (df.exists())
						  df.delete();
				  }
				  if ( !oimagemagick1.equals("") ) {
					  File df = new File(filepath,oimagemagick1);
					  if (df.exists())
						  df.delete();
				  }
				  if ( choicedata.equals("") )
					  choicedata = "a";
				  else
					  choicedata = choicedata + "||" + "a";
			  }
		  }
		  if ( !choicedata.equals("") ) {
			  if ( ofiledata.equals("") ) {
				  ofiledata = i + "||" + choicedata;
			  }else{
				  ofiledata = ofiledata + "&" + i + "||" + choicedata;
			  }
		  }
	  }
  }

  //取得修改者IP
  String hostIP = request.getRemoteHost();

  obj.setSerno(serno);
  obj.setPosterdate(stdate);
  obj.setContent(content);
  obj.setStartusing(startusing);
  obj.setClosedate(endate);
  obj.setQuestiontype(questiontype);
  obj.setIsbasic(isbasic);
  obj.setBasicfield(basicfield);
  obj.setPrizenumber(Integer.parseInt(prizenumber));
  obj.setQuestdata(questdata);
  obj.setTextdata(textdata);
  obj.setFiledata(filedata);
  obj.setOfiledata(ofiledata);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(punit);             //發布單位DN
  obj.setPubunitname(pubunitname);     //發布單位名稱
  obj.setSubject(subject);             //標題
  obj.setPostname(logincn);            //最後更新者姓名
  obj.setUnitname(title);              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("A");                  //狀態

  //執行動作(新增資料)  
  rtn = obj.store();
    
  String showAlert = null; 
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "修改失敗！" + errMsg;
  }else{
	  showAlert="修改成功！";
  }

 %>

<form name="mform" action="questionnaire101.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="title" value="<%=title%>"/>
  <input type="hidden" name="logindn" value="<%=logindn%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="murl" value="<%=murl%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  

  
