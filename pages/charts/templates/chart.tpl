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
          <h1 class="left">{$post->title}</h1><h1 class="right">Chart</h1>
        </div>
        <hr />
        <div class="breadcrumbs"><a href="">Home</a> > <a href="pages/blogs/blogs.php">Blogs</a> > <a href="pages/blogs/blog.php?id={$blog->id}">{$blog->name}</a></div>
      </div>
      
      <div class="canvas">
      
        <div id="leftColumn" class="span200">
          <div class="UIpanel UIcontainer">
            <div class="blogvitals">
              <div class="clear left">
                <a class="thumb" href="pages/blogs/blog.php?id={$blog->id}"><img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=50x50" width="50" height="50" /></a>
              </div>
              <div class="info thin" style="width: 113px !important; font-family: 'Lucida Sans Unicode','Lucida Grande',sans-serif;">
                <h3 style="margin-bottom: 5px;">{$blog->name}</h3>
                <p style="font-size: 11px;">{$pageData['postCreated']}</p>
              </div>
            </div>
          </div>
          
          <div class="UIpanel UIcontainer topspcr">
            <a href="http://twitter.com/share" class="twitter-share-button" data-via="pnightlife" data-text="{$post->title}">Tweet</a>
            <iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fexample.com%2Fpage%2Fto%2Flike&amp;layout=button_count&amp;show_faces=false&amp;width=180&amp;action=recommend&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:180px; height:21px; display: block; padding-top: 10px;" allowTransparency="true"></iframe>
          </div>
          
          <div class="UIpanel UIcontainer topspcr">
            <div class="UIheading">
              <h3>Chart Description</h3>
            </div>
            <div>A selection of February's hottest beats.</div>
          </div>
          
        </div> <!-- span200 -->
      
        <div class="span600 leftspcr">
        
          <div>
            <div style="background: #111; margin-bottom: 7px; overflow: auto; border-radius: 4px; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">
              <div style="position: absolute; background: url(/images/core/icons/blue_ribbon.png) no-repeat; padding-top: 3px; width: 22px; height: 37px; margin: 7px 17px 0 15px; color: #fff; font-size: 16px; line-height: 20px; text-align: center;">1</div>
              <img src="photo/216/50x50" style="float: left; margin: 7px 0 7px 54px; padding: 1px; border: 1px solid #222;" />
              <div style="float: left; padding: 7px; width: 374px;">
                <div>DT8 Project</div>
                <div style="color: #777;">Destination</div>
              </div>
              <div style="display: block; float: left; padding: 20px 10px;">
                <a class="listen" href="#" onClick="return false;">Listen</a>
              </div>
            </div>
            <div style="background: #0d0d0d; margin-bottom: 7px; overflow: auto; border-radius: 4px;">
              <div style="position: absolute; background: url(/images/core/icons/blue_ribbon.png) no-repeat; padding-top: 3px; width: 22px; height: 37px; margin: 7px 17px 0 15px; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif; color: #fff; font-size: 16px; line-height: 20px; text-align: center;">2</div>
              <img src="photo/166/50x50" style="float: left; margin: 7px 0 7px 54px; padding: 1px; border: 1px solid #222;" />
              <div style="float: left; padding: 7px; width: 374px;">
                <div>Atlantis vs. Avatar</div>
                <div style="color: #777;">Fiji (Lange Remix)</div>
              </div>
              <div style="display: block; float: left; padding: 20px 10px;">
                <a class="listen" href="#" onClick="return false;">Listen</a>
              </div>
            </div>
            <div style="background: #111; margin-bottom: 7px; overflow: auto; border-radius: 4px;">
              <div style="position: absolute; background: url(/images/core/icons/blue_ribbon.png) no-repeat; padding-top: 3px; width: 22px; height: 37px; margin: 7px 17px 0 15px; font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif; color: #fff; font-size: 16px; line-height: 20px; text-align: center;">3</div>
              <img src="photo/{$post->thumbnail}/50x50" style="float: left; margin: 7px 0 7px 54px; padding: 1px; border: 1px solid #222;" />
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