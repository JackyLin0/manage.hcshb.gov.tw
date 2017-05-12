<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="zh-TW">
<head>
<title>系統權限設定</title>

<link href="../style.css" rel="stylesheet" type="text/css">

<script>
	<!---自設變數--->
	var MaxLevel = 50		<!---最大階層數--->
	var FirstURL = "toptree.jsp?Level=1"		                <!---Top Level URL--->
	var CloseImg1 = "<img src=../../image/+2.gif border=0>"	    <!---┼號圖檔--->
	var CloseImg2 = "<img src=../../image/+1.gif border=0>"	    <!---結尾┼號圖檔--->
	var OpenImg1 = "<img src=../../image/-2.gif border=0>"	    <!---─號圖檔--->
	var OpenImg2 = "<img src=../../image/-1.gif border=0>"	    <!---結尾─號圖檔--->
	var LineImg1 = "<img src=../../image/11.gif border=0>"	    <!---連接線圖檔--->
	var LineImg2 = "<br>"		                                <!---連接線圖檔--->
	var secTimeout = 60000		                                <!---資料讀取Timeout時間(毫秒)--->

	var ShowWaiting = "<body bgcolor=D6D3CE topmargin=0 leftmargin=0>"		<!---等待訊息--->
	var strFirstLine = "<tr><td colspan=50><img src='../../image/org.gif'>&nbsp;<font fontface='細明體' size=2>新竹縣政府</font></td></tr>"
	var objOpenWin = top
	<!---系統變數--->
	var ReadTimeout = false
 	var strTree = new Array()
	var strTreeTrack = ""
	var strLineImgs
	var DataWin1
	var mIntervalID
	var mTimeoutID
	var strFirstHTML = "<form name='main' method='post'><table cellPadding=0 cellSpacing=0>"

	<!---讀取資料--->
	ReadData("","",0,FirstURL)

function ReadData(strLineImg,strTrack,NowPoint,RunURL) {
	if (DataWin1) if (!DataWin1.closed) return		<!---避免重複點選之錯誤--->
	if (strTrack != "") {
		<!---切換為已開啟狀態--->
		strTree[NowPoint] = strTree[NowPoint].replace(/javascript:parent.ReadData/i,"javascript:parent.CloseTree")
		strTree[NowPoint] = strTree[NowPoint].replace(/javascript:parent.OpenTree/i,"javascript:parent.CloseTree")
		strTree[NowPoint] = strTree[NowPoint].replace(/<!CloseImg1>/i,"<!OpenImg1>")
		strTree[NowPoint] = strTree[NowPoint].replace(/<!CloseImg2>/i,"<!OpenImg2>")
	}
	strLineImgs = strLineImg
	<!---設定目前Tree路徑，如"1,2,4"為第1層的第1行之下的第2行之下的第4行--->
	strTreeTrack = strTrack
	<!---顯示等待訊息--->
	if (ShowWaiting != "") {
		DataWin1 = objOpenWin.open("about:blank","TreeDataWin1","left=" + ((screen.width/2) - 100) + ",top=" + ((screen.height/2) - 25) + ",width=200,height=100")
		DataWin1.document.write(ShowWaiting)
	}
	<!---讀取資料，設定Timer抓取資料並設定Timeout時間--->
	DataWin1 = objOpenWin.open(RunURL,"TreeDataWin1")
	mIntervalID = setInterval("GetTree()",20)
	mTimeoutID = setTimeout("ReadTimeout=true",secTimeout)

}

function GetTree() {
	if (ReadTimeout) {
		ReadTimeout = false
		clearInterval(mIntervalID)
		DataWin1.close()
		alert("作業愈時!!")
		return
	}
	<!---判斷網頁資料是否已全部傳回--->
	try {
		if (!DataWin1.TreeData) return
		if (DataWin1.TreeData.innerHTML.indexOf("<!EndTreeData>") != -1) {
			clearInterval(mTimeoutID)
			clearInterval(mIntervalID)
			ParseData()
			ShowTree()
		}
	} catch(e) {}
}

function ParseData() {
	<!---資料解析並產生HTML語法存入陣列中--->
	var strLine
	var strAllHTML
	var strLineImg
	var strCloseImg
	var numCount
	var numInsPoint
	var strNowTrack
	var arySubTree = new Array()
	var strHTML = ""
	var strCurHTML = DataWin1.TreeData.innerHTML
	var NowLevel = strTreeTrack.split(",").length	<!---目前階層數--->
	if (!strTreeTrack) NowLevel = 0
	strCurHTML = strCurHTML.replace(/xmp/i,"!")
	arySubTree = strCurHTML.split("<!End>")	<!---分解每行資料存入陣列--->
	numCount = arySubTree.length - 1
	for (i = 0; i < numCount; i++) {	<!---捨棄最後一行<!EndTreeData>--->
		<!---判斷Tree結尾圖片--->
		if (i == numCount - 1) {
			strCloseImg = "<!CloseImg1>"
			strLineImg = strLineImgs + 1
		} else {
			strCloseImg = "<!CloseImg2>"
			strLineImg = strLineImgs + 0
		}
		<!---設定目前路徑--->
		if (strTreeTrack != "") {strNowTrack = strTreeTrack + ","} else {strNowTrack = strTreeTrack}
		strNowTrack = strNowTrack + i
		var strLine = arySubTree[i].split("<!,>")	<!---分解單行資料--->
		<!---產生單行HTML語法--->
		strHTML = strHTML + strNowTrack + "<!,><tr>"
		if (strLineImgs != "") {
			for (k = 1; k <= strLineImgs.length; k++) {
				if (strLineImgs.substr(k - 1,1) == "1") {
					strHTML = strHTML + "<td width='1%' align=center>" + LineImg2 + "</td>"
				} else {
					strHTML = strHTML + "<td width='1%' align=center>" + LineImg1 + "</td>"
				}
			}
		}
		strHTML = strHTML + "<td width='1%' align=center><a href=javascript:parent.ReadData('" + strLineImg + "','" + strNowTrack + "',<!i>,'" + strLine[1] + "')>"
											+ strCloseImg
											+ "</a></td><td width='99%' noWrap colspan=" + (MaxLevel - NowLevel) + ">"
											+ strLine[0] + "</td></tr><!;>";
	}
	<!---判斷本行路徑，將資料插入陣列中 noWrap--->
	strAllHTML = "<!;>" + strTree.join("<!;>")
	numInsPoint = strAllHTML.indexOf(">" + strTreeTrack + "<!,>",0)
	if (numInsPoint == -1) {
		numInsPoint = strAllHTML.length
	} else {
		numInsPoint = strAllHTML.indexOf("<!;>",numInsPoint + 1) + 4
	}
	strAllHTML = strAllHTML.substr(0,numInsPoint) + strHTML + strAllHTML.substr(numInsPoint)
	strAllHTML = strAllHTML.substr(4)
	strTree = strAllHTML.split("<!;>")
	DataWin1.close()
}


function ShowTree() {
	var strTmp
	var strLine = new Array()
	var strHTML = ""
	var strCloseTree = ""
	var j = 0
	var i = 0
	strHTML = strHTML + strFirstHTML + strFirstLine
	for (i = 0; i < strTree.length - 1 ; i++) {
		strLine = strTree[i].split("<!,>")
		<!---若上一層為未開啟則不顯示--->
		if (strLine[0].substr(0,strCloseTree.length) != strCloseTree || strCloseTree == "") {
			if (strLine[1].indexOf("javascript:parent.OpenTree") >= 0) strCloseTree = strLine[0]
			strHTML = strHTML + strLine[1].replace(/<!i>/i,i)
		}
	}
	strHTML = strHTML + "</table></form>"
	strHTML = strHTML.replace(/<!Openimg1>/gi,OpenImg1)
	strHTML = strHTML.replace(/<!Closeimg1>/gi,CloseImg1)
	strHTML = strHTML.replace(/<!Openimg2>/gi,OpenImg2)
	strHTML = strHTML.replace(/<!Closeimg2>/gi,CloseImg2)
	window.TreeView1.document.open()
	window.TreeView1.document.write(strHTML)
	window.TreeView1.document.close()
}

function OpenTree(strLineImg,strTrack,NowPoint,RunURL) {
	<!---切換為已開啟狀態--->
	strTree[NowPoint] = strTree[NowPoint].replace(/javascript:parent.ReadData/i,"javascript:parent.CloseTree")
	strTree[NowPoint] = strTree[NowPoint].replace(/javascript:parent.OpenTree/i,"javascript:parent.CloseTree")
	strTree[NowPoint] = strTree[NowPoint].replace(/<!CloseImg1>/i,"<!OpenImg1>")
	strTree[NowPoint] = strTree[NowPoint].replace(/<!CloseImg2>/i,"<!OpenImg2>")
	strTreeTrack = strTrack
	ShowTree()
}

function CloseTree(strLineImg,strTrack,NowPoint,RunURL) {
	<!---切換為未開啟狀態--->
	strTree[NowPoint] = strTree[NowPoint].replace(/javascript:parent.CloseTree/i,"javascript:parent.OpenTree")
	strTree[NowPoint] = strTree[NowPoint].replace(/<!OpenImg1>/i,"<!CloseImg1>")
	strTree[NowPoint] = strTree[NowPoint].replace(/<!OpenImg2>/i,"<!CloseImg2>")
	strTreeTrack = strTrack
	ShowTree()
}

function MM_preloadimage() {
  var d=document; if(d.image){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadimage.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

</script>

<frameset rows="100%" frameborder="NO" border="0" framespacing="0">
  <frame name="TreeView1" src="" marginwidth="5" marginheight="5">

</frameset>
<noframes><body bgcolor="#FFFFFF" text="#000000" topmargin=0 leftmargin=0>
</body></noframes>
