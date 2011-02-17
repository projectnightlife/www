<?php
$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'pages\\includes\\global.php');

$blogService = API::GetService("blog");
try {
  $blog = $blogService->GetBlog(19);
}
catch(Exception $e)
{
	header('Location: http://projectnightlife.co.uk/blogs');
	exit();
}

try {
	$blogContributors = $blogService->GetBlogContributors($blog->id)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetBlogContributors() - Unable to get blog contributors for ".$blog->id);
	header("HTTP/1.0 500 Internal Server Error"); 
    exit(); 
}

$isContributor = false;
foreach ($blogContributors as $contributor)
{
	if ($contributor->userId == $user['id'])
	{
	  $isContributor = true;
	  break;
	}
}

// convert backend blog description to HTML paragraphs
$exploded = explode (API::$SplitOn, $blog->description);
foreach ($exploded as $key => $paragraph)
{
	$blog->description = API::ToHTMLParagraph(count($exploded), $key, $blog->description, $paragraph);
}

// get blog's subscribers
try {
	$subscribers = $blogService->GetBlogSubscribers($blog->id)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetSubscribers() - Unable to get subscribers for blog ".$blog->id);
	header("HTTP/1.0 500 Internal Server Error"); 
    exit();
}

// get blog's genres
try {
	$genres = $blogService->GetBlogGenres($blog->id)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetBlogGenres() - Unable to get blog genres for blog ".$blog->id);
	header("HTTP/1.0 500 Internal Server Error"); 
    exit();
}
try {
	$posts = $blogService->GetPostsByBlog($blog->id, 8, 0)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetPostsByBlog() - Unable to get posts by blog ".$blog->id);
	header("HTTP/1.0 500 Internal Server Error"); 
    exit();
}
try {
	$relatedBlogs = $blogService->GetRelatedBlogs($blog->id, 6)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetRelatedBlogs() - Unable to get related blogs for blog ".$blog->id);
	header("HTTP/1.0 500 Internal Server Error"); 
    exit();
}

// get created string for each post
foreach ($posts as $key => $post)
{
  $post->created = API::GetDateString((int)$post->created);
}

$resourceManager = new ResourceDependancyManager('blogs/blog', 'css');
require_once($globalDir.'pages\\includes\\core_css.php');
if ($ismobile == false) {
	$resourceManager->addResource('blogs.css');
}
$pageData['cssFile'] = $resourceManager->build();

$resourceManager = new ResourceDependancyManager('blogs/blog', 'js');
require_once($globalDir.'pages\\includes\\core_js.php');
$resourceManager->addResource('corners.js');
$resourceManager->addResource('blogs/blog.js');
$pageData['jsFile'] = $resourceManager->build();

$smarty->assign('blog', $blog);
$smarty->assign('isContributor', $isContributor);
$smarty->assign('blogContributors', $blogContributors);
$smarty->assign('genres', $genres);
$smarty->assign('posts', $posts);
if ($relatedBlogs->count() != 0)
{
  $smarty->assign('relatedBlogs', $relatedBlogs);
}
if ($subscribers->count() != 0)
{
  $smarty->assign('subscribers', $subscribers);
}
$smarty->assign('pageData', $pageData);
$smarty->loadFilter('output', 'trimwhitespace');
$smarty->display('templates/'.$mobilepfx.'artist.tpl');
?>