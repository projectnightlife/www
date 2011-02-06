<?php
// load Smarty library
require('Smarty.class.php');
require_once('backend/global_include.php');
API::Authenticate();

$smarty = new Smarty;

$smarty->template_dir = 'c:/inetpub/wwwroot/smarty/templates';
$smarty->config_dir = 'c:/inetpub/wwwroot/smarty/config';
$smarty->cache_dir = 'c:/smarty/cache';
$smarty->compile_dir = 'c:/smarty/templates_c';

$page = API::getBlogPost((int)$_GET['id']);
$post = $page->getPost();
$blog = $page->getBlog();
$comments = $page->getComments();

// determine post date literal
$post->created = API::GetDateString((int)$post->created);
// determine number of comments literal
$post->numComments = (int)$post->numComments == 1 ? '1 comment' : $post->numComments.' comments';

// determine post image string
if (isset($post->image))
{
  $post->image = '<img src="images/blogs/'.$blog->id.'/posts/'.$post->image.'" />';
}

// determine post content literal
$explodedContent = explode ('\n\n', $post->content);
foreach ($explodedContent as $key => $paragraph)
{
	if ($key == 0)
	{
	  $post->content = '<p><b>'.$paragraph.'</b></p>';
	}
	else
	{
	  $post->content = $post->content.'<p>'.$paragraph.'</p>';
	}
}

// determine comment literals
foreach ($comments as $key => $comment)
{
  // determine comment date literal
  $comment->created = API::GetDateString((int)$comment->created);
  // determine comment content literal
  $explodedContent = explode ('\n\n', $comment->content);
  foreach ($explodedContent as $key => $paragraph)
  {
	if ($key == 0)
	{
	  $comment->content = '<p>'.$paragraph.'</p>';
	}
	else
	{
	  $comment->content = $comment->content.'<p>'.$paragraph.'</p>';
	}
  }
}

$smarty->assign('post', $post);
$smarty->assign('comments', $comments);
$smarty->assign('blog', $blog);

$smarty->display('templates/blogpost.tpl');
?>