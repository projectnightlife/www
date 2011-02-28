<?php
//$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
$globalDir = dirname(dirname(dirname(__FILE__))).'\\';
require_once($globalDir.'pages\\includes\\global.php');

$blogService = API::GetService("blog");

try {
    $post = $blogService->GetPost($_GET['id'], true);
}
catch (Exception $e)
{
	header('Location: '.$pageData['hostname'].'/blogs');
	exit();
}

try {
	$blog = $blogService->GetBlog($post->blogId);
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetBlog() - Unable to get blog ".$post->blogId." for post ".$post->id);
	header("HTTP/1.0 500 Internal Server Error"); 
    exit(); 
}

try {
	$blogContributors = $blogService->GetBlogContributors($post->blogId)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetBlogContributors() - Unable to get blog contributors for ".$post->blogId);
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

if ($post->numComments > 10)
{
	try {
  		$comments = $blogService->GetComments($_GET['id'], 10, 0)->children();
	}
	catch (Exception $e)
	{
		$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetComments() - Unable to get comments for post ".$post->id);
		header("HTTP/1.0 500 Internal Server Error"); 
        exit(); 
	}
}
else 
{
	try {
  		$comments = $blogService->GetComments($_GET['id'], 0, 0)->children();
	}
	catch (Exception $e)
	{
		$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetComments() - Unable to get comments for post ".$post->id);
		header("HTTP/1.0 500 Internal Server Error"); 
        exit(); 
	}
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
try {
	$relatedPosts = $blogService->GetRelatedPosts($post->id, 4)->children();
}
catch (Exception $e)
{
	$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetRelatedPosts() - Unable to get related posts for post ".$post->id);
	header("HTTP/1.0 500 Internal Server Error"); 
    exit(); 
}

// determine post date literal
$pageData['postCreated'] = API::GetDynamicDateString((int)$post->created);

// determine number of comments literal
$pageData['numCommentsLiteral'] = (int)$post->numComments == 1 ? ' comment' : ' comments';

// determine comment literals
foreach ($comments as $key => $comment)
{
  // determine comment date literal
  $comment->created = API::GetDynamicDateString((int)$comment->created);
  // determine comment body literal
  $comment->body = replace_urls_callback($comment->body, "linkify");
  $exploded = explode (API::$SplitOn, $comment->body);
  foreach ($exploded as $key => $paragraph)
  {
	$comment->body = API::ToHTMLParagraph(count($exploded), $key, $comment->body, $paragraph);
  }
}

$resourceManager = new ResourceDependancyManager('chart', 'css');
require_once($globalDir.'pages\\includes\\core_css.php');
$resourceManager->addResource('comments.css');
$pageData['cssFile'] = $resourceManager->build();

$resourceManager = new ResourceDependancyManager('chart', 'js');
require_once($globalDir.'pages\\includes\\core_js.php');
$resourceManager->addResource('ba-linkify.min.js');
$resourceManager->addResource('comments.js');
$pageData['jsFile'] = $resourceManager->build();

$smarty->assign('post', $post);
$smarty->assign('comments', $comments);
$smarty->assign('blog', $blog);
$smarty->assign('isContributor', $isContributor);
if ($relatedPosts->count() != 0)
{
  $smarty->assign('relatedPosts', $relatedPosts);
}
if ($relatedBlogs->count() != 0)
{
  $smarty->assign('relatedBlogs', $relatedBlogs);
}
$smarty->assign('pageData', $pageData);
$smarty->loadFilter('output', 'trimwhitespace');
$smarty->display('templates/'.$mobilepfx.'chart.tpl');
?>