 <?php
	#Begin Session
	session_start();
	
	
	#Import needed files

	require_once "logic/login-logic.php";
	require_once "page/login-page.php";

	$error="";
	
	#var_dump($_POST);
	
	#If they are already logged in they should be at the home screen instead.
	if(isSet($_SESSION["username"])&& !empty($_SESSION["username"]))
	{
		header("location: portal.php"); // Redirecting To Other Page
		exit();
	}
 
 
	#If they submitted a login attempt, process it now
	if(isset($_POST['pass-submit']))
	{
		$error = attemptPassLogin();
	}
	else if(isset($_POST['kiosk-submit']))
	{
		$error = attemptKioskLogin();
	}

	
	#Since the user is not logged in nor completed a successful login requiest, render the form.
	
	printHeader();
	printStartBody();
	#printNavigation();
	printForm($error);
	printEndBody();
 
?>
