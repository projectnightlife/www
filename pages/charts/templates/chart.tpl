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
          <h1 class="left">{$blog->name}</h1><h1 class="right">Chart</h1>
        </div>
        <hr />
        <div class="breadcrumbs"><a href="">Home</a> > <a href="pages/blogs/blogs.php">Blogs</a> > <a href="pages/blogs/blog.php?id={$blog->id}">{$blog->name}</a></div>
      </div>
      
      <div class="canvas">
      
        <div id="leftColumn" class="span200">
          <div class="UIpanel UIcontainer">
            <div class="blogvitals">
              <div class="clear left">
                <a class="thumb" href="pages/blogs/blog.php?id={$blog->id}"><img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=80x80" width="80" height="80" /></a>
              </div>
              <div class="info thin" style="width: 83px !important; margin-bottom: 8px;">
                <h3>{$blog->name}</h3>
                <div class="fblike" style="width: 83px;">
                  <iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.projectnightlife.co.uk%2Fblog%2F{$blog->id}&amp;layout=button_count&amp;show_faces=false&amp;width=100&amp;action=like&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:100px; height:21px;" allowTransparency="true"></iframe>
                </div>
              </div>
            </div>
          </div>
        </div> <!-- span200 -->
      
        <div class="span600 leftspcr">
        
          <div class="UIpanel UIcontainer">
            {if $isContributor}
              <div style="overflow: auto;">
                <h1 class="postHeading left">{$post->title}</h1>
                <a class="edit right" style="margin-top: 5px;" href="pages/blogs/editblog.php?v=edit&p={$post->id}">Edit Chart</a>
              </div>
            {else}
              <h1 class="postHeading word-wrap">{$post->title}</h1>
            {/if}
            <div class="postMeta">
              <span class="posted">Posted {$pageData['postCreated']}</span>
              <span class="numComments"><a href="pages/blogs/post.php?id={$post->id}{$pageData['URIDetectTrailingSlash']}#comments" id="numComments">{$post->numComments}{$pageData['numCommentsLiteral']}</a></span>
            </div>
          </div>
          <div class="topspcr">
            <div style="background: #0f0f0f; margin-bottom: 7px; overflow: auto; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">
              <div style="position: absolute; background: url(/images/core/icons/blue_ribbon.png) no-repeat; padding-top: 3px; width: 22px; height: 37px; margin: -2px 17px 0 15px; color: #fff; font-size: 16px; line-height: 20px; text-align: center;">1</div>
              <img src="photo/{$post->thumbnail}/50x50" style="float: left; padding: 7px 0 7px 54px;" />
              <div style="float: left; padding: 7px; width: 374px;">
                <div>DT8 Project</div>
                <div style="color: #777;">Destination</div>
              </div>
              <div style="display: block; float: left; padding: 20px 10px;">
                <a class="listen" href="#" onClick="return false;">Listen</a>
              </div>
            </div>
            <div style="background: #0c0c0c; margin-bottom: 7px; overflow: auto;">
              <div style="position: absolute; background: url(/images/core/icons/blue_ribbon.png) no-repeat; padding-top: 3px; width: 22px; height: 37px; margin: -2px 17px 0 15px; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif; color: #fff; font-size: 16px; line-height: 20px; text-align: center;">2</div>
              <img src="photo/{$post->thumbnail}/50x50" style="float: left; padding: 7px 0 7px 54px;" />
              <div style="float: left; padding: 7px; width: 374px;">
                <div>Atlantis vs. Avatar</div>
                <div style="color: #777;">Fiji (Lange Remix)</div>
              </div>
              <div style="display: block; float: left; padding: 20px 10px;">
                <a class="listen" href="#" onClick="return false;">Listen</a>
              </div>
            </div>
            <div style="background: #0f0f0f; margin-bottom: 7px; overflow: auto;">
              <div style="position: absolute; background: url(/images/core/icons/blue_ribbon.png) no-repeat; padding-top: 3px; width: 22px; height: 37px; margin: -2px 17px 0 15px; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif; color: #fff; font-size: 16px; line-height: 20px; text-align: center;">3</div>
              <img src="photo/{$post->thumbnail}/50x50" style="float: left; padding: 7px 0 7px 54px;" />
              <div style="float: left; padding: 7px; width: 374px;">
                <div>Terradia feat. Demona</div>
                <div style="color: #777;">Drowning In Dreams</div>
              </div>
              <div style="display: block; float: left; padding: 20px 10px;">
                <a class="listen" href="#" onClick="return false;">Listen</a>
              </div>
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
      
        <div class="span140 leftspcr">
          {if isset($relatedBlogs)}
          <div class="UIpanel UIcontainer">
            <div class="UIheading">
              <h3>Similar</h3>
            </div>
            <ul class="UItileview single">
            {foreach from=$relatedBlogs item=relatedBlog name=blogs}
              <li>
                <a class="thumb" href="pages/blogs/blog.php?id={$relatedBlog->id}"><img src="pages/getphoto/GetPhoto.php?id={$relatedBlog->thumbnail}&size=80x80" width="80" height="80" /></a><span class="tilename">{$relatedBlog->name}</span>
              </li>
            {/foreach}
            </ul>
          </div>
          {/if}
        </div> <!-- span140 -->
          
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
<script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
<script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script>