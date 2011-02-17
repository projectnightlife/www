{include file='../../includes/templates/page.tpl'}
<meta property="og:title" content="{$blog->name}"/>
<meta property="og:type" content="blog"/>
<meta property="og:url" content="http://www.projectnightlife.co.uk/blog/{$blog->id}"/>
<meta property="og:image" content="http://www.projectnightlife.co.uk/photo/{$blog->thumbnail}/80x80"/>
<meta property="og:site_name" content="Project Nightlife"/>
<meta property="fb:app_id" content="131359770249054"/>
<meta property="og:description" content="{$blog->slogan}"/>
<title>{$blog->name} | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
        <div class="heading">
          <h1 class="left">{$blog->title}</h1><h1 class="right">Artist</h1>
        </div>
        <hr />
        <div class="breadcrumbs"><a href="">Home</a> > <a href="pages/blogs/blogs.php">Artists</a> > <a href="pages/blogs/blog.php?id={$blog->id}">Conor Owen</a></div>
      </div>
      
      <div class="canvas">
        <div class="span960 btmspcr" style="position: relative;">
          <img src="images/conor.png" style="border-radius: 10px; -moz-border-radius: 10px; -webkit-border-radius: 10px;" />
          <div style="position: absolute; z-index: 100; top: 50px; right: 30px; width: 200px; background: url(http://www.projectnightlife.co.uk/images/core/transparency/75.png) repeat; border-radius: 5px; -moz-border-radius: 5px; -webkit-border-radius: 5px; padding: 10px;">
            <div><img src="images/core/icons/blue_chevron.png" /><span style="padding-left: 5px;">Age: 22</span></div>
            <div><img src="images/core/icons/blue_chevron.png" /><span style="padding-left: 5px;">City: London</span></div>
          </div>
        </div>
        <!--<div id="leftColumn" class="span200">
          <img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=200x600" style="display: block; margin: 0 auto;" />
          <div class="profileInteractions topspcr">
            {if $blog->subscribed == "false" && $session['userId'] != 0 && !$isContributor}
            <a href="backend/ajax.php?service=blog&method=Subscribe&blogId={$blog->id}" class="profileButton subscription" rel="subscribe" ajaxify="1" callback="subscription">Subscribe to this blog</a>
            {else if $blog->subscribed == "true" && $session['userId'] != 0 && !$isContributor}
            <a href="backend/ajax.php?service=blog&method=Unsubscribe&blogId={$blog->id}" class="profileButton subscription" rel="unsubscribe" ajaxify="1" callback="subscription">Unsubscribe from this blog</a>
            {/if}
          </div>
          <div class="UIpanel topspcr">
            <div class="UIheading">
              <h3>Info</h3>
            </div>
            {$blog->description}
          </div>
          {if isset($subscribers)}
          <div class="UIpanel topspcr">
            <div class="UIheading">
              <h3>Subscribers</h3>
            </div>
            <div id="subscriptions">
              {foreach from=$subscribers item=subscriber name=subscribers}
              <a id="subscription[{$subscriber->id}]" href="http://www.facebook.com/profile.php?id={$subscriber->id}" class="fbSquareProfilePic" title="{$subscriber->firstname} {$subscriber->lastname}" target="_blank"><img src="https://graph.facebook.com/{$subscriber->id}/picture" alt="{$subscriber->firstname} {$subscriber->lastname}" width="50" height="50" /></a>
              {/foreach}
            </div>
          </div>
          {/if}
        </div>-->
        
        <div class="span600">
          <div class="UIpanel">
            
              <div style="width: 520px; float: left;">
                <h3 style="line-height: 1em; padding-bottom: 5px; color: #ABA0C0;">{$blog->title}</h3>
                {if isset($blog->slogan)}
                <span>{$blog->slogan}</span>
                {/if}
                <div class="stylesIconList">
                {foreach from=$genres item=genre name=genres}
                  <a href="pages/blogs/blogs.php?filter={$genre->name}" title="{$genre->name} homepage"><img src="images/genres/{$genre->id}.png" alt="{$genre->name}" style="margin-right: 3px;" height="19" /></a>
                {/foreach}
                </div>
              </div>
              <div class="right fblike fblikecount">
                <iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.projectnightlife.co.uk%2Fblog%2F{$blog->id}&amp;layout=box_count&amp;show_faces=false&amp;width=55&amp;action=like&amp;colorscheme=dark&amp;height=65" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:55px; height:65px;" allowTransparency="true"></iframe>
              </div>
            </div>
          
          <div class="UIpanel">
            <div class="UIheading">
              <h3>Latest updates</h3>
              <div class="UIcontrol">
                <ul class="filter" id="postFilter">
                  <li class="selected rnd8px last" style="color: #222;">Most recent</li>
                </ul>
              </div>
            </div>
            <ul id="posts" class="UIobjectlist listw580">
              
              {foreach from=$posts item=post name=posts}
              <li {if $smarty.foreach.posts.first && $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="first last"{else}{if $smarty.foreach.posts.first}class="first"{elseif $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="last"{/if}{/if}>
                <div class="thumb"><a class="thumb" href="pages/blogs/post.php?id={$post->id}"><img src="pages/getphoto/GetPhoto.php?id={$post->thumbnail}&size=80x80" width="80" height="80" /></a></div>
                <div class="description">
                  <div class="heading">
                    <h4 class="left text-overflow"><a href="pages/blogs/post.php?id={$post->id}">{$post->title}</a></h4>
                    <span class="datetime right">{$post->created}</span>
                  </div>
                  <p class="word-wrap">{$post->excerpt}</p>
                </div>
              </li>
              {/foreach}
              {if $smarty.foreach.posts.total eq 8}
              <li class="last">
                <div style="width: 500px; margin: 0 auto; padding: 5px; text-align: center;">
                  <a href="backend/ajax.php?service=blog&method=GetPostsByBlog&id={$blog->id}&amount=8&start=8" ajaxify="1" callback="injectPosts" onClick="this.style.display = 'none'; document.getElementById('morePostsSpinner').style.display = 'inline-block';" spinner="morePostsSpinner" offset="8" pagesize="8">View more</a>
                  <div id="morePostsSpinner" class="ajaxSpinner" style="display: none; float: none; margin: 1px;"></div>
                </div> 
              </li>
              {/if}
            
            </ul>
          </div>
          
        </div> <!-- span630 -->
        
        
        <div class="span350 leftspcr">
          {if isset($subscribers)}
          <div class="UIpanel">
            <div class="UIheading">
              <h3>Conor's Subscribers</h3>
            </div>
            <div id="subscriptions">
              {foreach from=$subscribers item=subscriber name=subscribers}
              <a id="subscription[{$subscriber->id}]" href="http://www.facebook.com/profile.php?id={$subscriber->id}" class="fbSquareProfilePic" title="{$subscriber->firstname} {$subscriber->lastname}" target="_blank"><img src="https://graph.facebook.com/{$subscriber->id}/picture" alt="{$subscriber->firstname} {$subscriber->lastname}" width="50" height="50" /></a>
              {/foreach}
            </div>
          </div>
          {/if}
          
          <div class="UIpanel topspcr">
            <div class="UIheading">
              <h3>Bio</h3>
            </div>
            {$blog->description}
          </div>
        
        </div> <!-- span350 -->
          
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