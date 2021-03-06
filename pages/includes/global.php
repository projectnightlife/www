<?php

// $globalDir; already set in calling php page

// load Smarty library
require('Smarty.class.php');
require($globalDir.'backend\\global_include.php');
require($globalDir.'pages\\includes\\autolink.php');

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
$pageData['hostname'] = 'http://'.$_SERVER['HTTP_HOST'];

if (strcmp(substr($_SERVER['REQUEST_URI'], strlen($_SERVER['REQUEST_URI']) - 1), "/") == 0)
	$pageData['URIDetectTrailingSlash'] = "/";
else
	$pageData['URIDetectTrailingSlash'] = "";

$credentials = API::GetUserCredentials();
$user = $credentials->getUser();
//var_dump($credentials);

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
	try {
		$session['notificationsPending'] = $notificationService->GetUserHasPending();
		$notifications = $notificationService->GetUserNotifications(5, 0);
		$session['notifications'] = array();
		foreach ($notifications as $notification)
		{
			if (strcmp($notification->type, "Post") == 0)
			{
				$post = $blogService->GetPost($notification->information, false);
				$session['notifications'][] = new notification($post->thumbnail, 'New post by '.$blogService->getBlog($post->blogId)->name, "http://www.projectnightlife.co.uk/post/".$post->id, $post->title,  API::GetDynamicDateString((int)$notification->date));
			}
			else if (strcmp($notification->type, "Comment") == 0)
			{
				$post = $blogService->GetPost($notification->information, false);
				$session['notifications'][] = new notification($post->thumbnail, "New comments", "http://www.projectnightlife.co.uk/post/".$post->id."#comments", "On the post ".$post->title,  API::GetDynamicDateString((int)$notification->date));
			}
		}
	}
	catch (Exception $e)
	{
		$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "Unable to successfully get notifications for user ".$user['id']);
	}
}

$smarty->assign('pageData', $pageData);
$smarty->assign('session', $session);
//print '<div style="margin: 20px; background-color: #FDF07E; border: 1px solid #e7d118; color: #111; padding: 10px;"><p>We\'re currently reworking the genre system and as a result, its broken quite a lot of pages which rely on the old system.</p></div>';

// Greenhill - 12/02/2011 - Load mobiledetect
if ($mobiledetect->isMobile()) {
	$smarty->assign("ismobile", "true");
} else {
	$smarty->assign("ismobile", "false");
}
?>