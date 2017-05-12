<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：top.jsp
說明：管理端登入畫面
開發者：chmei
開發日期：97.02.13
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
}
-->
</style>

<link href="css/css.css" rel="stylesheet" type="text/css" />

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
</head>


<%
  //自session取得登入者的資料
  String logincn = ( String )session.getAttribute( "logincn" );
  String uname = ( String )session.getAttribute( "uname" );
  String logindn = ( String )session.getAttribute( "logindn" );
  System.out.println("logindn="+logindn);
  if ( logindn.equals("null") || logindn == null ) { %>
	  <script>
	     alert("您已超過時間未使用本系統，為了維護個人資料請重新登錄！");
	     window.open("index.jsp","_parent");
	  </script>
  <%}
  
%>

<body onload="MM_preloadImages('images/out1.jpg')">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="59%" background="images/bg1.jpg"><img src="images/top.jpg" width="615" height="92" /></td>
    <td width="41%" valign="middle" background="images/bg1.jpg">
      <table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td class="a2"><div align="right">歡迎&nbsp;&nbsp;<%=uname%>&nbsp;&nbsp;<%=logincn%>&nbsp;&nbsp;登入</div></td>
        </tr>
        <tr>
          <td><div align="right">
            <a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image2','','images/out1.jpg',1)"></a>
            <table width="80%" border="0">
              <tr>
                <!-- <td width="33%" align="right" valign="middle">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="1%" align="left" valign="middle"><img src="images/icon1.jpg" alt="*" width="25" height="26" /></td>
                      <td align="center" valign="middle" background="images/icon_bg.jpg" ><a href="#" class="link-a3">操作手冊</a> </td>
                      <td width="1%" align="left" valign="middle"><img src="images/icon2.jpg" alt="" width="6" height="26" /></td>
                    </tr>
                  </table>
                </td> -->
                <td width="34%" align="right" valign="middle">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="1%" align="left" valign="middle"><img src="images/icon1.jpg" alt="*" width="25" height="26" /></td>
                      <td align="center" valign="middle" background="images/icon_bg.jpg"><a href="http://www.hcshb.gov.tw" class="link-a3" target="_blank">新竹縣衛生局</a></td>
                      <td width="1%" align="left" valign="middle"><img src="images/icon2.jpg" alt="" width="6" height="26" /></td>
                    </tr>
                  </table>
                </td>
                <td width="33%" align="right" valign="middle">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="1%" align="left" valign="middle"><img src="images/icon1.jpg" alt="*" width="25" height="26" /></td>
                      <td align="center" valign="middle" background="images/icon_bg.jpg" class="a3"><a href="login1.jsp" class="link-a3" target="_parent">系統選單頁</a></td>
                      <td width="1%" align="left" valign="middle"><img src="images/icon2.jpg" alt="" width="6" height="26" /></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </div></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
