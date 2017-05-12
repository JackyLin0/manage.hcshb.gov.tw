<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--
程式名稱：systex.jsp
說明：管理端登入畫面
開發者：chmei
開發日期：2017.03.01
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
body{
	background-image: url(images/bg0.jpg);
	background-repeat: repeat;
	background-position: left top;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.font12 {
	font-family: Geneva, Arial, Helvetica, "新細明體";
	font-size: 12px;
	color: #000000;
}
-->
</style>

<script>
  function login2(){
    if (window.event.keyCode==13) login1()
  }

  function login1(){
    if ( document.form1.loginap.value == '' ) {
    	alert("【帳號】欄位不可空白，請輸入！")
    	document.form1.loginap.focus();
    	return;
    }	
    if ( document.form1.passwd.value == '' ) {
    	  alert("【密碼】欄位不可空白，請輸入！")
    	  document.form1.passwd.focus();
    	  return;
    }	    
    
    document.form1.action="login1.jsp";
    document.form1.method="post";
    document.form1.submit();

  }
</script>

</head>

<%
  if( !session.isNew() )
	  session.invalidate();
%>

<body>
<form name="form1">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="a2">
  <tr>
    <td height="50">&nbsp;</td>
  </tr>
  <tr>
    <td>
      <table width="50%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="left" valign="top"><img src="images/index_01.jpg" alt="新竹縣衛生局服務網-網站後端管理系統" width="800" height="137" /></td>
        </tr>
        <tr>
          <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left" valign="top"><img src="images/index_02.jpg" alt="" width="500" height="69" /></td>
                <td align="left" valign="top"><img src="images/index_03.jpg" alt="請輸入使用者資訊" width="206" height="69" /></td>
                <td align="left" valign="top"><img src="images/index_04.jpg" alt="" width="94" height="69" /></td>
              </tr>
              <tr>
                <td align="left" valign="top"><img src="images/index_05.jpg" alt="" width="500" height="85" /></td>
                <td align="left" valign="middle" background="images/index_06.jpg">
                  <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="36%" align="left" valign="middle" class="font12">使用者名稱：</td>
                      <td width="64%" align="left" valign="top">
                        <input type="text" name="loginap" size="15" onkeyup="login2()"/>
                      </td>
                    </tr>
                    <tr>
                      <td align="left" valign="middle" class="font12">使用者密碼：</td>
                      <td align="left" valign="top">
                        <input type="password" name="passwd" size="15" onkeyup="login2()"/>
                      </td>
                    </tr>
                    <tr>
                      <td colspan="2" align="left" valign="top" class="font12"><img src="images/d.gif" alt="" width="5" height="10" /></td>
                    </tr>
                    <tr>
                      <td colspan="2" align="left" valign="top" class="font12"><div align="center">
                        <input type="button" value="送出" onclick="login1();return false"/>
                        <input type="button" value="重設" onclick="javascript:document.form1.reset()"/>
                      </div></td>
                    </tr>
                  </table>
                </td>
                <td align="left" valign="top"><img src="images/index_07.jpg" alt="" width="94" height="85" /></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td align="left" valign="top"><img src="images/index_08.jpg" alt="" width="800" height="160" /></td>
        </tr>
        <tr>
          <td align="left" valign="top">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>

</body>
</html>

                          
<script>
   document.form1.loginap.focus();
</script>

