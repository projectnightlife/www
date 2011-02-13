<?php
$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'pages\\includes\\global.php');

if (!API::isUserLoggedIn())
{
	header('Location: http://www.projectnightlife.co.uk');
	exit();
}

$notificationService = API::GetService("notification");

try {
  $rawNotifications = $notificationService->GetUserNotifications(0, 0);
}
catch(Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetUserNotifications() - Unable to get notifications for ".$user['id']);
	header("HTTP/1.0 500 Internal Server Error"); 
    exit(); 
}

$notifications = array();

foreach ($rawNotifications as $notification)
{
	if (strcmp($notification->type, "Post") == 0)
	{
		$post = $blogService->GetPost($notification->information, false);
		$notifications[] = new notification($post->thumbnail, $post->title, "http://www.projectnightlife.co.uk/post/".$post->id, $post->excerpt,  API::GetDynamicDateString((int)$notification->date));
	}
}

$resourceManager = new ResourceDependancyManager('notifications', 'css');
$resourceManager->addResource('blueprint/screen.css');
$resourceManager->addResource('core.css');
$pageData['cssFile'] = $resourceManager->build();

$resourceManager = new ResourceDependancyManager('notifications', 'js');
$resourceManager->addResource('jquery.js');
$resourceManager->addResource('api.js');
$pageData['jsFile'] = $resourceManager->build();

$smarty->assign('pageData', $pageData);
$smarty->assign('notifications', $notifications);
$smarty->display('templates/notifications.tpl');
?>