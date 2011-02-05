<?php
// load Smarty library
require('Smarty.class.php');
require('../../backend/global_include.php');

// Authenticate with the Project Nightlife api
API::Authenticate();

$smarty = new Smarty;

$smarty->template_dir = 'templates';
$smarty->config_dir = 'c:/inetpub/wwwroot/smarty/config';
$smarty->cache_dir = 'c:/smarty/cache';
$smarty->compile_dir = 'c:/smarty/templates_c';
?>