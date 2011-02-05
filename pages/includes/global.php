<?php

$global = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";

// load Smarty library
require('Smarty.class.php');
require($global.'backend\\global_include.php');
require($global.'pages\\includes\\autolink.php');

// Authenticate with the Project Nightlife api
API::Authenticate();

$logService = API::GetService("log");
$appId = 1;

$smarty = new Smarty;

$smarty->template_dir = 'templates';
$smarty->config_dir = 'c:/inetpub/wwwroot/smarty/config';
$smarty->cache_dir = 'c:/smarty/cache';
$smarty->compile_dir = 'c:/smarty/templates_c';

//var_dump(API::GetUserCredentials());

$session = array();
$pageData = array();
$pageData['year'] = gmDate("Y");

$credentials = API::GetUserCredentials();
$user = $credentials->getUser();

$blogService = API::GetService("blog");
try {
	$blog = $blogService->GetUsersBlog($user['id']);
	$session['ownsBlog'] = true;
}
catch (Exception $e) {
	$session['ownsBlog'] = false;
}

// populate current session data
$session['user'] = $user;
$session['userId'] = $user['id'];
$session['loggedIn'] = API::IsUserLoggedIn();

$smarty->assign('pageData', $pageData);
$smarty->assign('session', $session);
//print '<div style="margin: 20px; background-color: #FDF07E; border: 1px solid #e7d118; color: #111; padding: 10px;"><p>We can now assign multiple authors to a blog. I\'ve created a new blog with Chris, Alan and myself assigned to it. Can we all give it a thorough testing to make sure the site still works fine. Let me know any errors you find. I\'ve given it a good testing myself and tested at each stage in the modifications but it required me to make changes to about 2/3 of the blog system\'s stored procs - so i may have overlooked something...</p><p>At present we can only allow a person to author 1 blog due to limitations with the front end, however the backend does support a user having multiple blog privilidges. That means that for the time being you don\'t have author privilidges on your old blogs.</p></div>';
?>