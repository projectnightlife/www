<?php

$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'pages\\includes\\global.php');

$smarty->assign('pageData', $pageData);
$smarty->display('templates/about.tpl');
?>