<?php
$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'pages\\includes\\global.php');

$blogService = API::GetService("blog");

try {
    $post = $blogService->GetPost($_GET['id'], true);
}
catch (Exception $e)
{
	header('Location: http://projectnightlife.co.uk/blogs');
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

// escape invalid characters
$post->body = (string) preg_replace("/ & /", "&amp;", $post->body);
$post->body = (string) preg_replace("/<(?!(pnobject|b>|u>|i>|\/b>|\/u>|\/i>))/", "&lt;", $post->body);

//perform the XSL transformation to change object types into actual html
//This is just a quick hack, should probably think of a slightly nicer way of doing it

$newBody = new DOMDocument(); 
$processor = new XSLTProcessor(); 
$transform = new DOMDocument(); 

$newBody->loadXML("<body>".$post->body."</body>"); 
$transform->load( 'embed_transform.xsl', LIBXML_NOCDATA); 
$transform->substituteEntities = true;
$processor ->importStylesheet( $transform ); 

$post->body = $processor->transformToXML( $newBody );

$exploded = explode (API::$SplitOn, $post->body);
foreach ($exploded as $key => $paragraph)
{
	$post->body = API::ToHTMLParagraph(count($exploded), $key, $post->body, $paragraph);
}

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

$resourceManager = new ResourceDependancyManager('blogs/post', 'css');
require_once($globalDir.'pages\\includes\\core_css.php');
if (!$ismobile) { // tidied code - marcus
	$resourceManager->addResource('blogs.css');
}
$pageData['cssFile'] = $resourceManager->build();

$resourceManager = new ResourceDependancyManager('blogs/post', 'js');
require_once($globalDir.'pages\\includes\\core_js.php');
$resourceManager->addResource('ba-linkify.min.js');
$resourceManager->addResource('jquery.textarea-expander.js');
$resourceManager->addResource('blogs/post.js');
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
$smarty->display('templates/'.$mobilepfx.'post.tpl');
?>