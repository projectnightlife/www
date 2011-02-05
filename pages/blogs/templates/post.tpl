<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Project Nightlife | {$post->title} - {$blog->name}</title>
<meta property="og:title" content="{$post->title}"/>
<meta property="og:image" content="http://photos.projectnightlife.co.uk/{$post->thumbnail}_1.jpg"/>
<meta property="og:description" content="{$post->excerpt}"/>
<meta name="medium" content="blog" />
<link rel="shortcut icon" href="images/core/icons/favicon.ico" type="image/x-icon" />
<link rel="icon" type="image/png" href="images/core/icons/favicon.png" />
<link rel="apple-touch-icon" href="images/core/icons/favicon.png" />
<!-- Framework CSS -->
  <link rel="stylesheet" href="css/blueprint/screen.css" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="css/blueprint/print.css" type="text/css" media="print">
  <!--[if lte IE 7]><link rel="stylesheet" href="http://www.projectnightlife.co.uk/css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->
  <!--[if IE]><link rel="stylesheet" href="http://www.projectnightlife.co.uk/css/ie.css" type="text/css" media="screen, projection"><![endif]-->
  <link rel="stylesheet" href="css/core.css" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="css/blogs.css" type="text/css" media="screen, projection"> 
</head>

<body id="blogs">
  <input type="hidden" id="commentCount" value="{$post->numComments}" autocomplete="off" />
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
        <div class="heading">
          <h1 class="left">{$blog->name}</h1><h1 class="right">Blog Post</h1>
        </div>
        <hr />
        <div class="breadcrumbs"><a href="">Home</a> > <a href="pages/blogs/blogs.php">Blogs</a> > <a href="pages/blogs/blog.php?id={$blog->id}">{$blog->name}</a></div>
      </div>
      
      <div class="canvas">
      
        <div class="span630">
        
          <div class="UIpanel">
            {if $isContributor}
              <div style="overflow: auto;">
                <h1 class="postHeading left" style="width: 540px;">{$post->title}</h1>
                <a class="edit right" style="margin-top: 5px;" href="pages/blogs/editblog.php?v=edit&p={$post->id}">Edit Post</a>
              </div>
            {else}
              <h1 class="postHeading word-wrap">{$post->title}</h1>
            {/if}
            <div class="postMeta">
              <span class="posted">Posted {$pageData['postCreated']}</span>
              <span class="numComments"><a href="pages/blogs/post.php?id={$post->id}#comments" id="numComments">{$post->numComments}{$pageData['numCommentsLiteral']}</a></span>
            </div>
            <div class="post word-wrap">
              {$post->body}
            </div>
          </div>
          
          <div class="UIpanel topspcr" id="comments">
            <h1 class="postHeading">Comments</h1>
            {if $session['loggedIn']}
            <div class="comments">
              <form id="commentForm" action="backend/ajax.php" ajaxify="1" callback="addComment" spinner="commentBox" errorcallback="commentError" onformsubmit="commentSubmit">
                <input type="hidden" name="params" value='{ "service":"blog","method":"AddComment","postId":"{$post->id}" }' autocomplete="off" />
                <textarea id="commentBox" name="content" serializable="api.dummySerialization:api.serializeStringFormatting" validator="api.validation.nonEmpty" autocomplete="off" onkeydown="api.limitText(this,1500);" onkeyup="api.limitText(this,1500);" onchange="api.limitText(this,1500);"></textarea>
                <input id="submitComment" class="right" type="submit" value="Comment" />
              </form>
            </div>
            {else}
            <div class="comments">
              <div class="comment">In order to post comments, you must be logged in.</div>
            </div>
            {/if}
            <div class="comments" id="commentsContainer">
              {foreach from=$comments item=comment name=comments}
              <div class="comment" id="comment[{$comment->id}]">
                <span class="meta"><span class="user"><a href="http://www.facebook.com/profile.php?id={$comment->userId}" target="_blank">{$comment->firstname} {$comment->lastname}</a></span> says:</span>
                {if $session['userId'] == $comment->userId}
                <span class="remove"><a href="backend/ajax.php?service=blog&method=RemoveComment&id={$comment->id}" ajaxify="1" callback="removeComment" spinner="comment{$comment->id}Spinner" class="right">delete</a><div class="ajaxSpinner" id="comment{$comment->id}Spinner"></div></span>
                {/if}
                <span class="posted">{$comment->created}</span>
                <span class="body word-wrap">{$comment->body}</span>
              </div>
              {/foreach}
              {if $post->numComments > 10}
              <div class="viewAll" id="viewAllComments"><a style="float: left;" href="backend/ajax.php?service=blog&method=GetComments&id={$post->id}&num=0&start=0" callback="viewAllComments" spinner="viewAllCommentsSpinner" ajaxify="1">View all {$post->numComments} comments</a><div class="ajaxSpinner" id="viewAllCommentsSpinner"></div></div>
              {/if}
            </div>
          </div>
        </div> <!-- span630 -->
      
        <div class="span320 leftspcr">
        
          <div class="UIpanel">
            <div class="blogvitals">
              <div class="clear left">
                <a class="thumb" href="pages/blogs/blog.php?id={$blog->id}"><img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=80x80" /></a>
              </div>
              <div class="info thin">
                <h3>{$blog->name}</h3>
                <p style="margin-bottom: 10px;">By <a href="http://www.facebook.com/profile.php?id={$post->authorId}" target="_blank">{$post->firstname} {$post->lastname}</a></p>
                <div class="fblike">
                  <fb:like href="projectnightlife.co.uk/blog/{$blog->id}" layout="button_count" show_faces="false" width="55"></fb:like>
                </div>
              </div>
            </div>
          </div>
          
          <div class="UIpanel topspcr">
            <table class="socialPlugins">
              <tbody>
                <tr>
                  <th><a href="http://twitter.com/share" class="twitter-share-button" data-via="pnightlife" data-text="{$post->title}">Tweet</a></th>
                  <th><a name="fb_share" type="icon_link">Share this post</a></th>
                </tr>
              </tbody>
            </table>
          </div>
          
          <div class="advert">
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="300" height="250">
      <param name="movie" value="http://www.betolima.com/img/LOGOS/Smirnoff/090804_Smirnoff_THERE_MREC.swf">
      <param name="quality" value="high">
      <param name="wmode" value="transparent" />
      <embed src="http://www.betolima.com/img/LOGOS/Smirnoff/090804_Smirnoff_THERE_MREC.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="300" height="250" wmode="transparent"></embed>
    </object>
          </div>
          
          {if isset($relatedPosts)}
          <div class="UIpanel topspcr">
            <div class="UIheading">
              <h3>Similar Posts</h3>
            </div>
            <ul class="UIobjectlist slim">
              {foreach from=$relatedPosts item=post name=relatedPosts}
              <li {if $smarty.foreach.relatedPosts.last}class="last"{/if}>
                <div class="thumb"><a class="thumb" href="pages/blogs/post.php?id={$post->id}"><img src="pages/getphoto/GetPhoto.php?id={$post->thumbnail}&size=80x80" width="80" height="80" /></a></div>
                <div class="description">
                  <h4 style="margin-bottom: 5px;"><a href="blogpost.php?id={$post->id}">{$post->title}</a></h4>
                  <span style="color: #999; display: block;">{$post->blogName}</span>
                </div>
              </li>
              {/foreach}
            </ul>
          </div>
          {/if}
          
          {if isset($relatedBlogs)}
          <div class="UIpanel topspcr">
            <div class="UIheading">
              <h3>Similar Blogs</h3>
            </div>
            <ul class="UItileview" style="margin: 0 18px;">
            {foreach from=$relatedBlogs item=blog name=blogs}
              {if $smarty.foreach.blogs.index % 2 == 0}
                <div style="overflow: auto;">
              {/if}
              <li>
                <a class="thumb" href="pages/blogs/blog.php?id={$blog->id}"><img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=80x80" width="80" height="80" /></a><span class="tilename">{$blog->name}</span>
              </li>
              {if $smarty.foreach.blogs.index % 2!= 0}
                </div>
              {/if}
            {/foreach}
            </ul>
          </div>
          {/if}
        </div> <!-- span320 -->
          
      </div> <!-- canvas -->
    </div> <!-- container -->
    <div class="push"></div>
  </div> <!-- wrapper -->
  {include file='../../includes/templates/footer.tpl'}
  <div id="fb-root"></div>
</body>
</html>
{include file='../../includes/templates/js.tpl'}
<script type="text/javascript" src="js/ba-linkify.min.js"></script>
<script type="text/javascript" src="js/blogs/post.js"></script>
<script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
<script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script>