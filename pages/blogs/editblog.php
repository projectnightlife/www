<?php
$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'pages\\includes\\global.php');

if (!$session['ownsBlog'])
{
	//die("User doesn't own a blog"); // tempory
	header('Location: http://projectnightlife.co.uk/blogs');
	exit();
}

// determine which control panel page to render
if (isset($_GET['v']))
{
    $action = strtolower($_GET['v']);
}
else
{
    $action = 'home'; // incase no v argument is supplied to page, direct to overview
}

switch ($action)
{
	case 'home' :       try {
							$blogContributors = $blogService->GetBlogContributors($blog->id)->children();
						}
						catch (Exception $e)
						{
							$logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetBlogContributors() - Unable to get blog contributors for ".$blog->id);
							header("HTTP/1.0 500 Internal Server Error"); 
   							exit(); 
						}
						$smarty->assign('blogContributors', $blogContributors);
						$page = 'templates/overview.tpl';
	                    break;
					 
	case 'new' :        $page = 'templates/editpost.tpl';
	                    break;
					 
	case 'edit' :       $page = 'templates/editpost.tpl';
					    try {
					      try {
	                   	      $post = $blogService->GetPost($_GET['p'], false);
					      }
					      catch (Exception $e)
					      {
						      $logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetPost() - Unable to get post ".$_GET['p']);
							  header("HTTP/1.0 500 Internal Server Error"); 
        					  exit(); 
					      }
					      if ($post->id == null || (int)$blog->id != (int)$post->blogId) {
						      throw new Exception;
					      }
					    }
					    catch (Exception $e) {
						    header('Location: http://projectnightlife.co.uk/blog/edit?v=manage');
							exit();
					    }
					    try {
					 	    $keywords = $blogService->GetPostkeywords($post->id)->children();
					    }
					    catch (Exception $e)
					    {
						    $logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetPostKeywords() - Unable to get post keywords for post ".$post->id);
							header("HTTP/1.0 500 Internal Server Error"); 
        					exit(); 
					    }
					    $smarty->assign('keywords', $keywords);
					    $smarty->assign('post', $post);
	                    break;
					 
	case 'manage' :     $page = 'templates/manage.tpl';
					    try {
					 	    $posts = $blogService->GetPostsByBlog($blog->id, 10, 0)->children();
					    }
					    catch (Exception $e)
					    {
						    $logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetPostsByBlog() - Unable to get posts by blog ".$blog->id);
							header("HTTP/1.0 500 Internal Server Error"); 
       						exit(); 
					    }
					    // get created string for each post
					    foreach ($posts as $key => $post)
                        {
                          $post->created = API::GetDateString((int)$post->created);
                        }
					    $smarty->assign('posts', $posts);
	                    break;
					 
	case 'details' :    $page = 'templates/editblog.tpl';
					    try {
					 	    $blogGenres = $blogService->GetBlogGenres($blog->id)->children();
					    }
					    catch (Exception $e)
					    {
						    $logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetBlogGenres() - Unable to get blog genres for blog ".$blog->id);
							header("HTTP/1.0 500 Internal Server Error"); 
       						exit(); 
					    }
						
						$genreService = API::GetService("genre");

						try {
							$genres = $genreService->GetGenres()->children();
						}
						catch (Exception $e)
					    {
						    $logService->LogAppError($appId, 6, $_SERVER['HTTP_USER_AGENT'], "GetGenres() - Unable to get genres from Genre Service");
							header("HTTP/1.0 500 Internal Server Error"); 
       						exit(); 
					    }
						$smarty->assign('genres', $genres);
					    $smarty->assign('blogGenres', $blogGenres);
					    break;
						
	case 'insights' :   require_once('blogstats.php');
						$pageData['blogIdHash'] = md5($blog->id);
						$page = 'templates/insights.tpl';
	                    break;
					 
	case 'guidelines' : $page = 'templates/guidelines.tpl';
	                    break;
					 
	case 'guide' :  $page = 'templates/guide.tpl';
	                    break;
					 
	default :           $page = 'templates/overview.tpl';
	                    break;
}

$smarty->assign('pageData', $pageData);
$smarty->assign('uri', $_SERVER['REQUEST_URI']);
$smarty->assign('blog', $blog);
$smarty->display($page);
?>