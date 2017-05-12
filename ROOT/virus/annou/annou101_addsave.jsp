<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：annou101_addsave.jsp
說明：通報資料
開發者：hank
開發日期：98.07.29
修改者：
修改日期：
版本：ver1.0
-->

<%@ page import="sysview.zhiren.function.*" %>
<%@ page import="tw.com.sysview.dba.*" %>


<%
  //參數  
  String table = request.getParameter( "t" );
  String loginuid = request.getParameter( "loginuid" );
  String pagesize = request.getParameter( "pagesize" );
  String intpage = request.getParameter( "intpage" );
  String language = request.getParameter( "language" );
  
  String punit = ( String )request.getParameter( "mqpunit" );  
  String[] ary_punit = SvString.split(punit,"||");

  //form值
  String schName = request.getParameter("mschName");
  String stdate = request.getParameter( "stdate" );  
  String className = request.getParameter( "className" );
  String stuNum = request.getParameter( "stuNum" );
  String sickNum = request.getParameter( "sickNum" );  
  
  String[] stuName = request.getParameterValues("stuName");
  String[] famPhone = request.getParameterValues("famPhone");
  String[] docName = request.getParameterValues("docName");
  String[] remark = request.getParameterValues("remark");
  String[] record = request.getParameterValues("record");
  //取得修改者IP
  String hostIP = request.getRemoteHost();
  
  AnnouData obj = new AnnouData();
  
  boolean rtn = true ;
  String errMsg="0";     
 
  obj.setSchName(schName);
  obj.setAnnouDate(stdate);
  obj.setClassName(className);
  obj.setStuNum(stuNum);
  obj.setSickNum(sickNum);
  obj.setPostname(loginuid);

  //網站維運統計共用參數(WebSiteLog)
  obj.setPubunitdn(ary_punit[0]);      //發布單位DN
  obj.setPubunitname(ary_punit[1]);    //發布單位名稱
  obj.setSubject(className);             //標題
  obj.setPostname(loginuid);            //最後更新者姓名
  obj.setUnitname("通報資料");              //單元名稱
  obj.setTablename(table);             //table名稱
  obj.setWebip(hostIP);                //登入者IP
  obj.setLanguage(language);           //語系
  obj.setStatus("A");

  //執行動作(新增資料)  
  rtn = obj.create();  
  
  if(rtn){
	  AnnouItemData obj1 = new AnnouItemData();
	  for(int i = 0 ; i < stuName.length ; i++){
		  obj1.setMserno(obj.getSerno());
		  obj1.setStuName(stuName[i]);
		  obj1.setFamPhone(famPhone[i]);
		  obj1.setDocName(docName[i]);
		  obj1.setRemark(remark[i]);
		  obj1.setRecord(record[i]);
		  obj1.setDocdate(request.getParameter("docdate"+i));
		  
		  rtn = obj1.create();
	  }
  }  
  
  String showAlert = null; 
  if ( rtn == false ) {
	  errMsg = obj.getErrorMsg();
	  showAlert = "新增失敗！" + errMsg;
  }else{
	  showAlert="新增成功！";
  }

 %>

<form name="mform" action="annou101_add.jsp" method="post">
  <input type="hidden" name="t" value="<%=table%>"/>
  <input type="hidden" name="loginuid" value="<%=loginuid%>"/>
  <input type="hidden" name="pagesize" value="<%=pagesize%>"/>
  <input type="hidden" name="intpage" value="<%=intpage%>"/>
  <input type="hidden" name="language" value="<%=language%>"/>
</form>
 
<script>
   alert("<%=showAlert%>");
   document.mform.submit();
</script>  
  
