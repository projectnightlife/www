<?php

class Blog extends Module
{
		
	//static stuff
	public static function Init()
	{
		self::ExportFunction("GetBlog", "GetBlog");
		self::ExportFunction("GetBlogPost", "GetPost");
		self::ExportFunction("GetBlogPostsComments", "GetPostsComments");
		self::ExportFunction("GetBlogPostsMostRecentComments", "GetPostsMostRecentComments");
		self::ExportFunction("GetRelatedBlogs", "GetRelatedBlogs");
		self::ExportFunction("GetRelatedBlogPosts", "GetRelatedPosts");
	}
	
	public static function BlogPostPage($postId)
	{
		API::writeLog("Created blog post ".$postId."</br>");
		$blogPost = new Blog();
		
		$xml = $blogPost->webService->GetPostWebpage($postId);
		
		$comments = array();
		
		foreach ($xml->result->comments->PublicBlogComment as $key => $comment)
		{
		  $comments[] = $comment;
		}
		
		$blogPost->data["post"] = $xml->result->post;
		$blogPost->data["comments"] = $comments;
		$blogPost->data["blog"] = $xml->result->blog;
		
		return $blogPost;
	}

	//not sure I like this, having the module 'plumbing' and the object in the same class
	//but its the only way I can think to be able to use private constructors...
	
	protected function __construct()
	{
		API::writeLog("Getting blog post from Web Service<br/>");
		$this->webService = API::CreateWS("http://projectnightlife.co.uk/api/BlogService.asmx?WSDL");
	}
	
	public static function GetBlog($blogId)
	{
		$blog = new Blog();
		$response = $blog->webService->GetBlog($blogId);
		return $response->result;
	}
	
	public static function GetPost($postId)
	{
		$blog = new Blog();
		$response = $blog->webService->GetPost($postId);
		return $response->result;
	}
	
	public static function GetPostsComments($postId)
	{
		$blog = new Blog();
		$response = $blog->webService->GetComments($postId, 0);
		return $response->result->blog_GetCommentsResult;
	}
	
	public static function GetPostsMostRecentComments($postId, $amount)
	{
		$blog = new Blog();
		$response = $blog->webService->GetComments($postId, $amount);
		return $response->result->blog_GetCommentsResult;
	}
	
	public static function GetRelatedBlogs($blogId, $amount)
	{
		$blog = new Blog();
		$response = $blog->webService->GetRelatedBlogs($blogId, $amount);
		return $response->result->PublicBlog;
	}
	
	public static function GetRelatedPosts($postId, $amount)
	{
		$blog = new Blog();
		$response = $blog->webService->GetRelatedBlogPosts($postId, $amount);
		return $response->result->PublicBlogPost;
	}

}

?>