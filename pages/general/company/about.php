<?php

$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'pages\\includes\\global.php');

$resourceManager = new ResourceDependancyManager('about', 'css');
$resourceManager->addResource('blueprint/screen.css');
$resourceManager->addResource('core.css');
$pageData['cssFile'] = $resourceManager->build();

$resourceManager = new ResourceDependancyManager('about', 'js');
$resourceManager->addResource('jquery.js');
$resourceManager->addResource('api.js');
$pageData['jsFile'] = $resourceManager->build();

$smarty->assign('pageData', $pageData);
$smarty->display('templates/about.tpl');
?>