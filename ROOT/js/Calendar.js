function nonAssignFunc(yy, mm, dd) { alert(yy+ '/'+ mm+ '/'+ dd); }

function Calendar(year, month) {
	var day = new Date();
	this.thisYear = day.getYear();
	if (this.thisYear < 1000) this.thisYear += 1900;
	this.thisMonth = day.getMonth() + 1;
	this.thisDay = day.getDate();

	this.specDays = new Array();
	this.specSpec = new Array('bgColor="#ffcccc"', 'bgColor="#ccffcc"', 'bgColor="#ccccff"');
	this.weekday = new Array('日', '一', '二', '三', '四', '五', '六');
	this.year = (year)? year : this.thisYear;
	this.month = (month)? month : this.thisMonth;
	this.clickFunName = "nonAssignFunc";

	this.assignClickFuncName = function(fname) { this.clickFunName = fname; }
	this.createTable = calCrtTbl;
	this.addSpecDay = calAddSpecDay;
	this.toNextMonth = function() { if (this.month < 12) this.month++; else {this.month = 1; this.year++;} }
	this.toPrevMonth = function() { if (this.month > 1) this.month--; else {this.month = 12; this.year--;} }
	this.toNextYear = function() { this.year++; }
	this.toPrevYear = function() { this.year--; }
}

function calCrtTbl(tblWid) {
	var sday, eday, txt, i, j;
	var tdBg = new Array(32);
	for (i=1; i<=31; i++) tdBg[i] = 'bgColor="#f0f0f0"';
	if (!tblWid) tblWid = 180;

	// Style 設定
	var ctHeight = "24px;";
	var cssTitle = "font-size:16px;color:#000000;background-color:#dddddd;vertical-align:middle;line-height:24px;";
	var cssHead = "font-size:14px;color:#ffffff;background-color:#999999;vertical-align:middle;line-height:22px;";
	var cssNone = "background-color:#f0f0f0;line-height:"+ ctHeight;
	var cssOrg = "font-size:14px;text-decoration:None;text-align:center;vertical-align:middle;letter-spacing:-1px;line-height:"+ ctHeight;

	var yy = this.year;
	var mm = this.month;
	sday = new Date(yy, mm-1, 1);

	// 特殊日背景色
	if ((this.thisYear == yy)&&(this.thisMonth == mm)) {
		tdBg[this.thisDay] = 'bgColor="#FFFF80"';
	}
	var tmp = this.specDays[yy+ "/"+ mm];
	for (i in tmp) tdBg[i] = this.specSpec[tmp[i]];

	sday = 1 - sday.getDay();
	eday = 31;
	if (mm == 2) {
		if (((yy % 4 == 0) && (yy % 100 != 0)) || (yy % 400 == 0)) eday = 29;
		else eday = 28;
	} else if ((mm == 4)||(mm == 6)||(mm == 9)||(mm == 11)) eday = 30;

	txt = '<table border="0" width="'+ tblWid+ '" bgcolor="#ccccff" cellspacing="0" cellpadding="2"><tr><td>\n' +
		'<table border="0" width="100%" bgcolor="#aaaadd" cellspacing="0" cellpadding="1"><tr><td>\n' +
		'<table border="0" width="100%" cellPadding="1" cellSpacing="0">\n' +
		'<tr><td colSpan="7" style="'+ cssTitle+ '" align="center"><font face="細明體">' +
		yy + '年 '+ mm+ '月</font></td></tr>\n<tr>';

	var extAttr = new Array(' color="#cc0000"', '', '', '', '', '', ' color="#000099"');
	for (i=0; i<7; i++)
		txt += '<td width="14%" style="'+ cssHead+ '" align="center"><font face="細明體"' +
			extAttr[i]+ '>'+ this.weekday[i]+ '</font></td>';

	var para = this.year+ ','+ this.month+ ',';
	for (i=0; i<6; i++) {
		txt += '</tr>\n<tr bgcolor="#ffffff" align="center">';

		for (j=0; j<7; j++) {
			if ((sday < 1) || (sday > eday))
				txt += '<td width="14%" style="'+ cssNone+ '">&nbsp;</td>\n';
			else {
				if (j == 0) txt += '<td width="15%" '+ tdBg[sday]+ '><a style="'+ cssOrg+ '" href="javascript:' +
					this.clickFunName+ '('+ para+ sday+ ');"><font face="Arial" color="#cc0000">'+ sday+ '</font></a></td>\n';
				else if (j == 6) txt += '<td width="15%" '+ tdBg[sday]+ '><a style="'+ cssOrg+ '" href="javascript:' +
					this.clickFunName+ '('+ para+ sday+ ');"><font face="Arial" color="#000099">'+ sday+ '</font></a></td>\n';
				else txt += '<td width="14%" '+ tdBg[sday]+ '><a style="'+ cssOrg+ '" href="javascript:' +
					this.clickFunName+ '('+ para+ sday+ ');"><font face="Arial" color="#666666">'+ sday+ '</font></a></td>\n';
			}
			sday++;
		}
	}

	return( txt + '</tr>\n</table></td></tr></table>\n</td></tr></table>' );
}

function calAddSpecDay(day, idx, ext) {
	// 建立特殊日子的顯示 calAddSpecDay('2002/5/3,*/4/1,2002/8/2', 2)
	var i=0, j=0;
	if (!idx) {
		idx = this.specSpec.length;
		this.specSpec[idx] = ext;
	}

	while ((j = day.indexOf(',', i)) > 0) {
		if (/^([\d\*]+)\/(\d+)\/(\d+)/.test(day.substring(i, j))) {
			var tmp = parseInt(RegExp.$1)+ '/'+ parseInt(RegExp.$2);
			if (!this.specDays[tmp]) this.specDays[tmp] = new Array();
			this.specDays[tmp][parseInt(RegExp.$3)] = idx;
		}
		i = j + 1;
	}

	if (/^([\d\*]+)\/(\d+)\/(\d+)/.test(day.substring(i))) {
		var tmp = parseInt(RegExp.$1)+ '/'+ parseInt(RegExp.$2);
		if (!this.specDays[tmp]) this.specDays[tmp] = new Array();
		this.specDays[tmp][parseInt(RegExp.$3)] = idx;
	}
}

function show_calendar(item,item2, year, month) {
	//item 註明 form_name.field_name
	var ctlSym = new Array('前一年', '前一月', '後一月', '後一年');
	var win = window;

	win.document.write("<body topmargin=0 leftmargin=0>")
	win.document.write("<!-- 起始行 -->");
	win.document.write((navigator.appName == 'Netscape')? '<layer id="calLyr"> </layer>' : '<span id="calLyr"> </span>');

	for (var i in ctlSym) ctlSym[i] = '<font color="#0000ff" size="-1">'+ ctlSym[i]+ '</font>';
	win.ctrlBar = '<a style="text-decoration:none;" href="javascript:Cal.toPrevYear(); redrawCal();" title="前一年">'+ ctlSym[0]+ '</a> &nbsp; ' +
		'<a style="text-decoration:none;" href="javascript:Cal.toPrevMonth(); redrawCal();" title="前一月">'+ ctlSym[1]+ '</a> &nbsp; ' +
		'<a style="text-decoration:none;" href="javascript:Cal.toNextMonth(); redrawCal();" title="後一月">'+ ctlSym[2]+ '</a> &nbsp; ' +
		'<a style="text-decoration:none;" href="javascript:Cal.toNextYear(); redrawCal();" title="後一年">'+ ctlSym[3]+ '</a>';

	win.Cal = new Calendar(year, month);

	win.calClick = function(year, month, day) {
		
		var i = item.indexOf('.');
		
		var itm = opener.document.forms[item.substring(0, i)].elements[item.substring(i+1)];
		var itm2 = opener.document.forms[item2.substring(0, i)].elements[item2.substring(i+1)];
		str_1=year+ ((month < 10)?'0':'')+ month+ ((day < 10)?'0':'')+ day
		//alert(str_1);
        itm.value = str_1;
		//year=year-1911;
		str_2=year+'年'+ ((month < 10)?'0':'')+ month+'月'+ ((day < 10)?'0':'')+ day+'日';
		//alert(str_2);
		itm2.value = str_2;
		
		if (itm.onchange) itm.onchange();
		win.close();
	}
	win.Cal.assignClickFuncName("calClick");

	win.redrawCal = function() {
		var tmp = '<center>'+ win.Cal.createTable(200)+ win.ctrlBar+ '</center>';
		win.document.getElementById("calLyr").innerHTML = tmp;
	}

	win.document.close();
	win.redrawCal();
}

