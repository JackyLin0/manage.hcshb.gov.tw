<%@page import="tw.com.sysview.filter.qfilterSql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：login.jsp
說明：管理端登入畫面
開發者：chmei
開發日期：97.02.11
修改者：
修改日期：
版本：ver1.0
-->

<html lang="zh-TW">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新竹縣衛生局服務網後端管理系統</title>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(images/bodybg.jpg);
	background-repeat: repeat-x;
	background-position: left top;
}
.content_bg {
	background-image: url(images/main02_08.jpg);
	background-repeat: no-repeat;
	background-position: left top;
	height: 193px;
}
-->
</style>

<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>

<link href="css/css.css" rel="stylesheet" type="text/css" />

<script>
  function menu1() {
     document.mform.action="indextry.jsp";
     document.mform.method="post";
     document.mform.submit();
  }
  
  function menu2(menudn) {
     document.mform.murl.value=menudn;
     document.mform.flag.value="go";
     document.mform.action="indextry.jsp";
     document.mform.method="post";
     document.mform.submit();
  }

</script>  

</head>   
    
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="sysview.zhiren.ldap.SvLdap" %>
<%@ page import="sysview.zhiren.ldap.netscape.SvNetscapeLdap" %>
<%@ page import="sysview.zhiren.function.*" %>

<%
  String loginap = ( String )request.getParameter( "loginap" );
  String passwd = ( String )request.getParameter("passwd");
  
  if ( loginap == null || loginap.equals("null") ) {
	  loginap = ( String )session.getAttribute("loginap");
	  passwd = ( String )session.getAttribute("passwd");
  } else {
	  qfilterSql qcontentlink = new qfilterSql();
  	  boolean rtn = qcontentlink.filterSql(loginap);
  	  if ( rtn )
  		loginap = qcontentlink.getMcontent();
     
  }
  
  //取系統路徑
  String sysRoot = (String) application.getRealPath("");
  
  String Ldap_PATH = sysRoot + "/WEB-INF/ldap.properties";
  Properties ldap = new Properties();
  ldap.load(new FileInputStream(Ldap_PATH) );
  String ds_server = ldap.getProperty("ds_server");
  String port = ldap.getProperty("ds_port");
  String ds_user = ldap.getProperty("ds_user");
  String ds_pwd = ldap.getProperty("ds_pwd");
  String ds_root = ldap.getProperty("ds_root");
  
  int ds_port=Integer.parseInt(port);
  
  String userdn = "";
  String usercn = "";
  String unit_title = "";
  SvNetscapeLdap prelogin = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
  boolean qdata = prelogin.query( ds_root, "dn,cn", "uid=" + loginap, SvLdap.QUERYSUBTREE );
  if ( !qdata ) {
	  if ( loginap == null || loginap.equals("null") ) { %>
		  <script>
		     alert("您已超過時間未使用本系統，為了維護個人資料請重新登錄！");
		     window.open("index.jsp","_parent");
		  </script>
	  <%}else{%>
		  <script>
		     window.location="error.html";
		  </script>
	  <%}
  }else{
	  while ( prelogin.next() )  {
		  userdn = prelogin.getString( "dn" );
          usercn = prelogin.getString( "cn" );
          SvNetscapeLdap login1 = new SvNetscapeLdap( ds_server, ds_port, userdn, passwd, SvLdap.ENCODEUNICODE );
          boolean qlogin = login1.query( userdn, "uid,carlicense", SvLdap.QUERYBASE );
          if ( !qlogin ) 
          { %>
        	  <script>
                window.location="error.html";
              </script>
          <%}else{
        	  while ( login1.next() ) {
        		  //尋找login者的單位名稱
        		  String mdn = SvString.right(userdn,",");
        		  String[] ary_mdn = SvString.split(mdn,",");
        		  SvNetscapeLdap qou = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
        		  boolean qunit = qou.query( mdn, "chinesetitle", "objectclass=department", SvLdap.QUERYBASE );
        		  if ( qunit ) {
        			  while ( qou.next() ) {
        				  String mdn1 = mdn;
        				  String unitname = "";
        				  if ( ary_mdn.length > 4 ) {
        					  for ( int i=0; i<ary_mdn.length-4; i++ ) {
        						  mdn1 = SvString.right(mdn1,",");
        					  }
        					  SvNetscapeLdap qou1 = new SvNetscapeLdap( ds_server, ds_port, ds_user, ds_pwd, SvLdap.ENCODEUNICODE );
        					  boolean qunit1 = qou1.query( mdn1, "chinesetitle", "objectclass=department", SvLdap.QUERYBASE );
        					  if ( qunit1 ) {
        						  while ( qou1.next() ) {
        							  unitname = qou1.getString( "chinesetitle" );
        						  }
        					  }
        				  }
        				  if ( !unitname.equals("") )
        					  unit_title = unitname + "&nbsp;" + qou.getString( "chinesetitle" );
        				  else
        					  unit_title = qou.getString( "chinesetitle" );
        	          }
        			  session.setAttribute("passwd",passwd);
                      session.setAttribute("loginap",loginap); 
        		  }
        	  }
          }
      }
  }
%>


<body onload="MM_preloadImages('images/main02_02over.jpg')">
<form name="mform">
  <input type="hidden" name="uid" value="<%=loginap%>"/>
  <input type="hidden" name="murl"/>
  <input type="hidden" name="flag"/>
</form>

<table width="50%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left" valign="top">
      <table width="10%" border="0" align="center" cellpadding="0" cellspacing="0" class="a2">
        <tr>
          <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left" valign="top"><img src="images/main02_01.jpg" alt="" width="609" height="47" /></td>
                <td align="left" valign="top"><a href="http://gip.hsinchu.gov.tw" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image25','','images/main02_02over.jpg',1)"><img src="images/main02_02.jpg" alt="系統登出" name="Image25" width="191" height="47" border="0" id="Image25" /></a></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td align="left" valign="top"><img src="images/main02_03.jpg" alt="新竹縣衛生服務網全球資訊網圖" width="800" height="109" /></td>
        </tr>
        <!-- <tr>
          <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="14%" align="left" valign="top" background="images/main02_05.jpg"><img src="images/main02_04.jpg" alt="及時訊息" width="112" height="28" /></td>
                <td width="82%" align="left" valign="middle" background="images/main02_05.jpg" class="font13">請輸入訊息內容</td>
                <td width="4%" align="right" valign="top" background="images/main02_05.jpg"><img src="images/main02_06.jpg" alt="" width="35" height="28" /></td>
              </tr>
            </table>
          </td>
        </tr> -->
      </table>
    </td>
  </tr>
  <tr>
    <td align="left" valign="top"><img src="images/main02_07.jpg" alt="" width="800" height="16" /></td>
  </tr>
  <tr>
    <td align="left" valign="top" background="images/main02_09.jpg">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="left" valign="top" class="content_bg">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="3%" align="left" valign="top">&nbsp;</td>
                <td colspan="2" align="left" valign="middle" class="content_font13">親愛的使用者們，請選點下方的圖示，即可進入該專區服務系統；當您使用完請點選右上方的「系統登出」，即能登出畫面。</td>
              </tr>
              <tr>
                <td colspan="3" align="left" valign="top"><img src="images/d.gif" alt="" width="5" height="10" /></td>
              </tr>
              <tr>
                <td align="left" valign="top">&nbsp;</td>
                <td width="94%" align="left" valign="top">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left" valign="top">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center" valign="top"><a href="javascript:menu1();"><img src="images/001.jpg" alt="衛生局全球資訊網" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=nosmoking,ou=ap_root,o=hcshb,c=tw');"><img src="images/002.jpg" alt="菸害防制網" width="160" height="125" border="0"/></a></td>                            
                            <td align="center" valign="top"><a href="javascript:menu2('ou=training,ou=ap_root,o=hcshb,c=tw');"><img src="images/004.jpg" alt="教育訓練數位學習專區" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=epaper,ou=ap_root,o=hcshb,c=tw');"><img src="images/003.jpg" alt="健康電子報" width="160" height="125" border="0"/></a></td>
                          </tr>                          
                          <tr>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">衛生局全球資訊網</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">菸害防制網</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">教育訓練數位學習專區</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">健康電子報</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">&nbsp;</td>
                          </tr>
                          <tr>
                            <td colspan="4" align="left" valign="top" background="images/dot.gif">&nbsp;</td>
                          </tr>
                          <tr>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=virus,ou=ap_root,o=hcshb,c=tw');"><img src="images/005.jpg" alt="71型腸病毒防治網" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=fluguard,ou=ap_root,o=hcshb,c=tw');"><img src="images/006.jpg" alt="流感防疫專區" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="nosmokinggame/index.jsp?uid=<%=loginap%>"><img src="images/index_01.gif" alt="菸害遊戲網" width="160" height="125" border="0"/></a></td>                            
                            <td align="center" valign="top">&nbsp;</td>
                          </tr>
                          <tr>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">71型腸病毒防治網</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">流感防疫專區</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">菸害遊戲網</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top" colspan="3">&nbsp;</td>
                          </tr>
                          <tr>
                            <td colspan="4" align="left" valign="top" background="images/dot.gif">&nbsp;</td>
                          </tr>
                          <tr>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=chupei,ou=ap_root,o=hcshb,c=tw');"><img src="images/chupei.jpg" alt="竹北市衛生所" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=jhudong,ou=ap_root,o=hcshb,c=tw');"><img src="images/jhudong.jpg" alt="竹東鎮衛生所" width="160" height="125" border="0"/></a></td>                            
                            <td align="center" valign="top"><a href="javascript:menu2('ou=kuanshi,ou=ap_root,o=hcshb,c=tw');"><img src="images/kuanshi.jpg" alt="關西鎮衛生所" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=sinpu,ou=ap_root,o=hcshb,c=tw');"><img src="images/sinpu.jpg" alt="新埔鎮衛生所" width="160" height="125" border="0"/></a></td>
                          </tr>                          
                          <tr>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">竹北市衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">竹東鎮衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">關西鎮衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">新埔鎮衛生所</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">&nbsp;</td>
                          </tr>
                          <tr>
                            <td colspan="4" align="left" valign="top" background="images/dot.gif">&nbsp;</td>
                          </tr>
                          <tr>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=hukou,ou=ap_root,o=hcshb,c=tw');"><img src="images/hukou.jpg" alt="湖口鄉衛生所" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=sinfong,ou=ap_root,o=hcshb,c=tw');"><img src="images/sinfong.jpg" alt="新豐鄉衛生所" width="160" height="125" border="0"/></a></td>                            
                            <td align="center" valign="top"><a href="javascript:menu2('ou=cyonglin,ou=ap_root,o=hcshb,c=tw');"><img src="images/cyonglin.jpg" alt="芎林鄉衛生所" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=baoshan,ou=ap_root,o=hcshb,c=tw');"><img src="images/baoshan.jpg" alt="寶山鄉衛生所" width="160" height="125" border="0"/></a></td>
                          </tr>                          
                          <tr>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">湖口鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">新豐鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">芎林鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">寶山鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">&nbsp;</td>
                          </tr>
                          <tr>
                            <td colspan="4" align="left" valign="top" background="images/dot.gif">&nbsp;</td>
                          </tr>
                          <tr>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=beipu,ou=ap_root,o=hcshb,c=tw');"><img src="images/beipu.jpg" alt="北埔鄉衛生所" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=emei,ou=ap_root,o=hcshb,c=tw');"><img src="images/emei.jpg" alt="峨眉鄉衛生所" width="160" height="125" border="0"/></a></td>                            
                            <td align="center" valign="top"><a href="javascript:menu2('ou=jianshih,ou=ap_root,o=hcshb,c=tw');"><img src="images/jianshih.jpg" alt="尖石鄉衛生所" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=wufong,ou=ap_root,o=hcshb,c=tw');"><img src="images/wufong.jpg" alt="五峰鄉衛生所" width="160" height="125" border="0"/></a></td>
                          </tr>                          
                          <tr>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">北埔鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">峨眉鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">尖石鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">五峰鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">&nbsp;</td>
                          </tr>
                          <tr>
                            <td colspan="4" align="left" valign="top" background="images/dot.gif">&nbsp;</td>
                          </tr><tr>
                            <td align="center" valign="top"><a href="javascript:menu2('ou=hengshan,ou=ap_root,o=hcshb,c=tw');"><img src="images/hengshan.jpg" alt="橫山鄉衛生所" width="160" height="125" border="0"/></a></td>
                            <td align="center" valign="top">&nbsp;</td>
                            <td align="center" valign="top">&nbsp;</td>
                            <td align="center" valign="top">&nbsp;</td>
                          </tr>                          
                          <tr>
                            <td align="left" valign="top">
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td width="18%" align="right" valign="top"><img src="images/sss.gif" alt="*" width="13" height="15" /></td>
                                  <td width="82%" align="left" valign="top" class="main_font13">橫山鄉衛生所</td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="5">&nbsp;</td>
                          </tr>
                          <tr>
                            <td colspan="4" align="left" valign="top" background="images/dot.gif">&nbsp;</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td align="center" valign="top">&nbsp;</td>
                    </tr>
                  </table>
                </td>
                <td width="3%" align="left" valign="top">&nbsp;</td>
              </tr>
              <tr>
                <td align="left" valign="top">&nbsp;</td>
                <td align="left" valign="top">&nbsp;</td>
                <td align="left" valign="top">&nbsp;</td>
              </tr>
              <tr>
                <td align="left" valign="top">&nbsp;</td>
                <td align="left" valign="top">&nbsp;</td>
                <td align="left" valign="top">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td align="left" valign="top" background="images/main02_11.jpg">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="left" valign="top"><img src="images/main02_10.jpg" alt="" width="800" height="21" /></td>
        </tr>
        <tr>
          <td align="left" valign="top" background="images/main02_11.jpg">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center" valign="top" class="down_font13">新竹縣政府便民服務資訊維護系統 @2008  最佳瀏覽模式：1024*768  IE5.5以上版本  <br />
                Copyright © 2008 Hsin-Chu County Government. All Rights Reserved.</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td align="left" valign="top"><img src="images/main02_12.jpg" alt="" width="800" height="31" /></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
