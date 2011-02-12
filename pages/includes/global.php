<?php

$global = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";

// load Smarty library
require('Smarty.class.php');
require($global.'backend\\global_include.php');
require($global.'pages\\includes\\autolink.php');

// Authenticate with the Project Nightlife api
API::Authenticate();

$logService = API::GetService("log");
$notificationService = API::GetService("notification");
$appId = 1;
$logService->LogAppHit($appId, $_SERVER['REQUEST_URI'], $_SERVER['HTTP_USER_AGENT'], $_SERVER['REMOTE_ADDR']);

$smarty = new Smarty;

$smarty->template_dir = 'templates';
$smarty->config_dir = 'c:/inetpub/wwwroot/smarty/config';
$smarty->cache_dir = 'c:/smarty/cache';
$smarty->compile_dir = 'c:/smarty/templates_c';

//var_dump(API::GetUserCredentials());

$session = array();
$pageData = array();
$pageData['year'] = gmDate("Y");

if (strcmp(substr($_SERVER['REQUEST_URI'], strlen($_SERVER['REQUEST_URI']) - 1), "/") == 0)
	$pageData['URIDetectTrailingSlash'] = "/";
else
	$pageData['URIDetectTrailingSlash'] = "";

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
if (API::isUserLoggedIn())
{
	$session['notificationsPending'] = $notificationService->GetUserHasPending();
	$notifications = $notificationService->GetUserNotifications(5, 0);
	$session['notifications'] = array();
	foreach ($notifications as $notification)
	{
		if (strcmp($notification->type, "Post") == 0)
		{
			$post = $blogService->GetPost($notification->information, false);
			$session['notifications'][] = new notification($post->thumbnail, $post->title, "http://www.projectnightlife.co.uk/post/".$post->id, $post->excerpt,  API::GetDynamicDateString((int)$notification->date));
		}
	}
}

$smarty->assign('pageData', $pageData);
$smarty->assign('session', $session);
//print '<div style="margin: 20px; background-color: #FDF07E; border: 1px solid #e7d118; color: #111; padding: 10px;"><p>We\'re currently reworking the genre system and as a result, its broken quite a lot of pages which rely on the old system.</p></div>';
?>