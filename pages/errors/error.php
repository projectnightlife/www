<?php
//$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
$globalDir = dirname(dirname(dirname(__FILE__))).'\\';
require_once($globalDir.'pages\\includes\\global.php');

if (isset($_GET['code']))
{
	$code = $_GET['code'];
}
else
{
	$code = 404;
}

$smarty->display('templates/'.$code.'.tpl');
?>