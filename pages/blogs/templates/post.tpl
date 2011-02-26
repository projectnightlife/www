{include file='../../includes/templates/page.tpl'}
<title>{$post->title} - {$blog->name} | Project Nightlife</title>
<meta property="og:title" content="{$post->title}"/>
<meta property="og:image" content="http://www.projectnightlife.co.uk/photo/{$post->thumbnail}/80x80"/>
<meta property="og:description" content="{$post->excerpt}"/>
<meta name="medium" content="blog" />
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
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
        
          <div class="UIpanel UIcontainer">
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
              <span class="numComments"><a href="pages/blogs/post.php?id={$post->id}{$pageData['URIDetectTrailingSlash']}#comments" id="numComments">{$post->numComments}{$pageData['numCommentsLiteral']}</a></span>
            </div>
            <div class="post word-wrap">
              {$post->body}
            </div>
          </div>
          
          <div class="UIpanel UIcontainer topspcr" id="comments">
            <h1 class="postHeading">Comments</h1>
            {if $session['loggedIn']}
            <div class="comments">
              <form id="commentForm" action="backend/ajax.php" ajaxify="1" callback="addComment" spinner="commentBox" errorcallback="commentError" onformsubmit="commentSubmit">
                <input type="hidden" name="params" value='{ "service":"blog","method":"AddComment","postId":"{$post->id}" }' autocomplete="off" />
                <textarea id="commentBox" class="expand70-250" name="content" serializable="api.dummySerialization:api.serializeStringFormatting" validator="api.validation.nonEmpty" autocomplete="off" onKeyDown="api.limitText(this,1500);" onKeyUp="api.limitText(this,1500);" onChange="api.limitText(this,1500);"></textarea>
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
                <a href="http://www.facebook.com/profile.php?id={$comment->userId}" class="fbSquareProfilePic photo" target="_blank"><img src="https://graph.facebook.com/{$comment->userId}/picture" width="50" height="50" /></a>
                <div class="body">
                  <a class="meta user" href="http://www.facebook.com/profile.php?id={$comment->userId}" target="_blank">{$comment->firstname} {$comment->lastname}</a>
                  {if $session['userId'] == $comment->userId}
                  <span class="remove"><a href="backend/ajax.php?service=blog&method=RemoveComment&id={$comment->id}" ajaxify="1" callback="removeComment" spinner="comment{$comment->id}Spinner" class="right">delete</a><div class="ajaxSpinner" id="comment{$comment->id}Spinner"></div></span>
                {/if}
                  <span class="posted">{$comment->created}</span>
                  <span class="content word-wrap">{$comment->body}</span>
                </div>
              </div>
              {/foreach}
              {if $post->numComments > 10}
              <div class="viewAll" id="viewAllComments"><a style="float: left;" href="backend/ajax.php?service=blog&method=GetComments&id={$post->id}&num=0&start=0" callback="viewAllComments" spinner="viewAllCommentsSpinner" ajaxify="1">View all {$post->numComments} comments</a><div class="ajaxSpinner" id="viewAllCommentsSpinner"></div></div>
              {/if}
            </div>
          </div>
        </div> <!-- span630 -->
      
        <div class="span320 leftspcr">
        
          <div class="UIpanel UIcontainer">
            <div class="blogvitals">
              <div class="clear left">
                <a class="thumb" href="pages/blogs/blog.php?id={$blog->id}"><img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=80x80" width="80" height="80" /></a>
              </div>
              <div class="info thin">
                <h3>{$blog->name}</h3>
                <p style="margin-bottom: 10px;">By <a href="http://www.facebook.com/profile.php?id={$post->authorId}" target="_blank">{$post->firstname} {$post->lastname}</a></p>
                <div class="fblike">
                  <iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.projectnightlife.co.uk%2Fblog%2F{$blog->id}&amp;layout=button_count&amp;show_faces=false&amp;width=100&amp;action=like&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100px; height:21px;" allowTransparency="true"></iframe>
                </div>
              </div>
            </div>
          </div>
          
          <div class="UIpanel UIcontainer topspcr">
            <table class="socialPlugins">
              <tbody>
                <tr>
                  <th><a href="http://twitter.com/share" class="twitter-share-button" data-via="pnightlife" data-text="{$post->title}">Tweet</a></th>
                  <th><iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.projectnightlife.co.uk%2Fpost%2F{$post->id}&amp;layout=button_count&amp;show_faces=false&amp;width=180&amp;action=recommend&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:180px; height:21px; display: block; padding-top: 10px;" allowTransparency="true"></iframe></th>
                </tr>
              </tbody>
            </table>
          </div>
          
          {if isset($relatedPosts)}
          <div class="UIpanel UIcontainer topspcr">
            <div class="UIheading">
              <h3>Similar Posts</h3>
            </div>
            <ul class="UIobjectlist slim">
              {foreach from=$relatedPosts item=post name=relatedPosts}
              <li {if $smarty.foreach.relatedPosts.last}class="last"{/if}>
                <div class="thumb"><a class="thumb" href="pages/blogs/post.php?id={$post->id}"><img src="pages/getphoto/GetPhoto.php?id={$post->thumbnail}&size=80x80" width="80" height="80" /></a></div>
                <div class="description">
                  <h4 style="margin-bottom: 5px;"><a href="pages/blogs/post.php?id={$post->id}">{$post->title}</a></h4>
                  <span style="color: #999; display: block;">{$post->blogName}</span>
                </div>
              </li>
              {/foreach}
            </ul>
          </div>
          {/if}
          
          {if isset($relatedBlogs)}
          <div class="UIpanel UIcontainer topspcr">
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
{include file='../../includes/templates/critical_js.tpl'}
<script type="text/javascript" src="{$pageData['jsFile']}"></script>
{include file='../../includes/templates/js.tpl'}
<script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script>