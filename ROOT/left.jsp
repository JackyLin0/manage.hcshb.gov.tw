<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!--
程式名稱：left.jsp
說明：管理端登入畫面
開發者：chmei
開發日期：2017.03.03
修改者：
修改日期：
版本：ver1.0
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>新竹縣衛生局服務網後端管理系統</title>

<link href="css/scrollbar.css" rel="stylesheet" type="text/css" />
<link href="css/text1.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="css/ext-menu-tree.css" />
<script type="text/javascript" src="js/ext-base.js"></script>
<script type="text/javascript" src="js/ext-all.js"></script>
	  
<script type="text/javascript" src="js/jquery-1.4.2.js"></script>
<script type="text/javascript" src="js/jquery.blockUI.js"></script>

<script type="text/javascript" src="js/leftmenu-zh-TW.js" charset="UTF-8"></script>

<style type="text/css">
<!--
.x-tree-node-expanded .x-tree-node-icon{
	background-image:url(images/tree/folderOpen.gif);
}

.x-tree-node-leaf .x-tree-node-icon{
	background-image:url(images/tree/icon.gif);
}

.x-tree-node-collapsed .x-tree-node-icon{
	background-image:url(images/tree/folderClosed.gif);
}

.x-tree-node-expanded .x-tree-node-icon-ch{
	background-image:url(images/tree/ch.jpg);
}

.x-tree-node-expanded .x-tree-node-icon-en{
	background-image:url(images/tree/en_img01.jpg);
}

-->
</style>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(images/leftbt_bg.jpg);
	background-repeat: repeat-y;
}
-->
</style>

<script type="text/javascript">
  var mLeftbarWidth = "32";
  var mLeftbarOpenWidth = "199";
  function fCloseFrame()  {
	  top.frames.document.getElementById("menuFram").cols = mLeftbarWidth + ",*";
  }

  function fOpenFrame()  {
	  top.frames.document.getElementById("menuFram").cols = mLeftbarOpenWidth + ",*";
  }

  //下列2function僅供IE6使用
  function blockLeft() {
	  $.blockUI({message:'',
		  css:{
			  width: '0px',
			  height: '0px'
	      }	  
	  });
  }
  
  function unblockLeft() {
	  $.unblockUI();
  }
 
</script>

</head>

<body>

<table width="10%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="100%" colspan="2" align="left">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="images/left2.jpg" alt="" width="199" height="34"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="left" valign="top" >
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="left" valign="top" class="left_bg">
            <table width="100%" border="0">
              <tr>
                <td><img src="images/d.gif" alt="" width="16" height="5"></td>
              </tr>
              <tr>
                <td><a href="javascript:fOpenFrame()"><img src="images/left_over1.gif" alt="*" width="14" height="15" border="0"></a></td>
              </tr>
              <tr>
                <td><a href="javascript:fCloseFrame()"><img src="images/left_bu2.gif" alt="*" width="14" height="15" border="0"></a></td>
              </tr>
            </table>
          </td>
          <td align="left" valign="top">
            <div id="leftmenu" style="overflow:auto; autoHeight:true; width:200px; border:1px solid #c3daf9;"></div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

</script>

</body>
</html>