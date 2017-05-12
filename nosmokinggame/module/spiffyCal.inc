<LINK href="/test-php/module/spiffyCal/spiffyCal_v2_1.css" type="text/css" rel="stylesheet">
<script src="/test-php/module/spiffyCal/spiffyCal_v2_1.js"></script>

<DIV class="text" id="spiffycalendar" style="z-index:100"></DIV>

<script language="JavaScript">

	var Calendar_Count = 0 ;

	function Calendar( VarName , TextBoxName , FormName )
	{
		Calendar_Count ++ ;
		
		return new ctlSpiffyCalendarBox(VarName , FormName , TextBoxName ,"btnDate" + Calendar_Count , "" , scBTNMODE_CUSTOMBLUE ) ;
	}

</script>