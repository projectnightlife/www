<?php
//$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
$globalDir = dirname(dirname(dirname(__FILE__))).'\\';
require_once($globalDir.'pages\\includes\\global.php');

$timeparts = explode(" ",microtime());
$startTime = bcadd(($timeparts[0]*1000),bcmul($timeparts[1],1000));

if (isset($_GET['filter']))
{
    switch (strtolower($_GET['filter']))
	{
		case 'electronic' : $pageData['filter'] = 'electronic';
	                	    break;
							
		case 'rock' :      $pageData['filter'] = 'rock';
	                	    break;
							
		case 'urban' :      $pageData['filter'] = 'urban';
	                	    break;
							
		case 'lifestyle' :  $pageData['filter'] = 'lifestyle';
	                	    break;
							
		case 'all' :  		$pageData['filter'] = 'all';
							break;
							
		default: 		    $pageData['filter'] = 'other';
	                	    break;
	}
}
else
{
    $pageData['filter'] = 'all'; // incase no v argument is supplied to page, display all posts ('all' is not a genre so all posts will be returned)
}

isset($_GET['filter']) ? $pageData['filterOn'] = ucwords(strtolower($_GET['filter'])) : $pageData['filterOn'] = "All";

$blogService = API::GetService("blog");
try {
	$featuredPosts = $blogService->GetFeaturedPosts()->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetFeaturedPosts() - Unable to get featured posts");
	header("HTTP/1.0 500 Internal Server Error"); 
    exit(); 
}
try {
	$posts = $blogService->GetPosts($pageData['filterOn'], 8, 0)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetPosts() - Unable to get posts");
	header("HTTP/1.0 500 Internal Server Error"); 
    exit(); 
}
try {
	$blogs= $blogService->GetBlogs($pageData['filterOn'], 0, 0)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetBlogs() - Unable to get blogs");
	header("HTTP/1.0 500 Internal Server Error"); 
    exit(); 
}

foreach ($featuredPosts as $post)
{
    $post->title = substr($post->title, 0, 43);
	if (strlen($post->title) == 43)
	{
		$end = strrpos($post->title, " ");
		if ($end)
		{
			$post->title = substr($post->title, 0, $end);
			$post->title = $post->title."...";
		}
	}
	if (strlen($post->title) > 30) // else allow all characters (255 max held by db)
	{
	    $post->excerpt = substr($post->excerpt, 0, 175);
	    if (strlen($post->excerpt ) == 175)
	    {
		    $end = strrpos($post->excerpt , " ");
		    if ($end)
		    {
			    $post->excerpt  = substr($post->excerpt , 0, $end);
			    $post->excerpt  = $post->excerpt ."...";
		    }
	    }
	}
}

// get date string for each post
foreach ($posts as $key => $post) 
{
  $post->created = API::GetDateString((int)$post->created);
}

$resourceManager = new ResourceDependancyManager('blogs/blogs', 'css');
require_once($globalDir.'pages\\includes\\core_css.php');
if (!$ismobile) { // tidied the code up a lil here - just appended ! - marcus
	$resourceManager->addResource('blogs.css');
	$resourceManager->addResource('featureApps.css');
}
$pageData['cssFile'] = $resourceManager->build();

$resourceManager = new ResourceDependancyManager('blogs/blogs', 'js');
require_once($globalDir.'pages\\includes\\core_js.php');
$resourceManager->addResource('jquery.color.js');
$resourceManager->addResource('corners.js');
$resourceManager->addResource('blogs/blogs.js');
$pageData['jsFile'] = $resourceManager->build();

$smarty->assign('pageData', $pageData);
$smarty->assign('featuredPosts', $featuredPosts);
$smarty->assign('posts', $posts);
$smarty->assign('blogs', $blogs);

$smarty->loadFilter('output', 'trimwhitespace');
$smarty->display('templates/'.$mobilepfx.'blogs.tpl');

$timeparts = explode(" ",microtime());
$endTime = bcadd(($timeparts[0]*1000),bcmul($timeparts[1],1000));
$logService->LogResponseTime($appId, $_SERVER['REQUEST_URI'], $endTime - $startTime);
?>