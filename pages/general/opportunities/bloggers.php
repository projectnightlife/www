<?php

$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'pages\\includes\\global.php');

$genreService = API::GetService("genre");

try {
	$genres = $genreService->GetGenres()->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetGenres() - Unable to get genres from Genre Service");
	header("HTTP/1.0 500 Internal Server Error"); 
  	exit(); 	
}

$smarty->assign('genres', $genres);
$smarty->display('templates/bloggers.tpl');
?>