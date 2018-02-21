 <?php
	#Begin Session
	session_start();
	
	
	#Import needed files
	require_once "logic/403-logic.php";
	require_once "page/403-page.php";

	#Render page
	
	printHeader();
	printStartBody();
	#printNavigation();
	printForm(getCustomErrorMessage());
	printEndBody();
 
?>
