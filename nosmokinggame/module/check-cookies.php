<?
	session_start() ;
	
	require("../configure.php") ;
	
	if( $_COOKIE["cookies_url"] == "" )
	{
		header("Location: $cookies_alert_url") ;
	}
	else
	{
		$_SESSION["session_cookies_checked"] = true ;
		
		header("Location: " . $_COOKIE["cookies_url"] ) ;
	}
?>