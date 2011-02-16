<?php

$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'pages\\includes\\global.php');

$resourceManager = new ResourceDependancyManager('about', 'css');
require_once($globalDir.'pages\\includes\\core_css.php');
$pageData['cssFile'] = $resourceManager->build();

$resourceManager = new ResourceDependancyManager('about', 'js');
require_once($globalDir.'pages\\includes\\core_js.php');
$pageData['jsFile'] = $resourceManager->build();

$smarty->assign('pageData', $pageData);
$smarty->loadFilter('output', 'trimwhitespace');
$smarty->display('templates/'.$mobilepfx.'about.tpl');
?>