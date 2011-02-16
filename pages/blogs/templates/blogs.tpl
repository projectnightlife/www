{include file='../../includes/templates/page.tpl'}
<title>Blogs | Project Nightlife</title>
<link rel="alternate" type="application/rss+xml" title="Project Nightlife | Blogs (RSS 2.0)" href="blogs/rss" />
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
        <div class="heading">
          <h1 class="left">Blogs</h1>
          <div class="right" style="margin: 10px 5px 0;">
            <ul class="filter"><li>Filter:</li><li{if $pageData['filter'] eq 'all'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php">All</a></li><li{if $pageData['filter'] eq 'electronic'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php?filter=electronic">Electronic</a></li><li{if $pageData['filter'] eq 'rock'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php?filter=rock">Rock</a></li><li{if $pageData['filter'] eq 'urban'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php?filter=urban">Urban</a></li><li{if $pageData['filter'] != 'other'} class="last{/if}{if $pageData['filter'] eq 'lifestyle'} selected rnd8px{/if}{if $pageData['filter'] != 'other'}"{/if}><a href="pages/blogs/blogs.php?filter=lifestyle">Lifestyle</a></li>{if $pageData['filter'] eq 'other'}<li class="last selected rnd8px"><a href="pages/blogs/blogs.php?filter={$pageData['filterOn']}">{$pageData['filterOn']}</a></li>{/if}</ul>
          </div>
        </div>
        <hr />
      </div>
        
      <div class="canvas">
        
		{if $ismobile == "false"}
        <div id="mainFeaturedApp">
          <div id="descriptionWindow">
            <div id="descriptionReel">
              <div>
                <h2><a class="none" href="pages/general/opportunities/bloggers.php">Fancy blogging for us?</a></h2>
                <p>We're on the look out for talented new bloggers. If you're a budding music or fashion writer, or simply know the deal when it comes to either of these - then we want to hear from you!</p>
                <p>Blog with us and enjoy the rewards.</p>
                <a class="readmore" href="pages/general/opportunities/bloggers.php">Read more</a>
              </div>
              {foreach from=$featuredPosts item=post name=featuredPosts}
              <div>
                <h2><a class="none" href="post/{$post->id}">{$post->title}</a></h2>
                <p>{$post->excerpt}</p>
                <a class="readmore" href="post/{$post->id}">Read more</a>
              </div>
              {/foreach}
            </div>
          </div>
          <div id="imageWindow">
            <div id="imageReel">
              <a href="pages/general/opportunities/bloggers.php"><img src="images/blog_feature.jpg" width="608" height="312" /></a>
              {foreach from=$featuredPosts item=post name=featuredPosts2}
              <a href="post/{$post->id}"><img src="photo/{$post->thumbnail}/608x312" width="608" height="312" /></a>
              {/foreach}
            </div>  
          </div>
          <div id="pagingWindow">
            <a href="#" rel="1">1</a>
            <!--<a href="#" rel="2">2</a>
            <a href="#" rel="3">3</a>
            <a href="#" rel="4">4</a>-->
          </div>
        </div>
		{/if}
        
        <div class="span650 topspcr15">
          <div class="UIpanel">
            <div class="UIheading">
              <h3>Blog posts</h3>
              <div class="UIcontrol">
                <ul class="filter" id="postFilter">
                {if $pageData['filter'] eq 'all'}
                  <li class="spinner" id="togglePostsSpinner">loading icon</li>
                  <li class="selected rnd8px"><a onClick="return togglePostsSwitch(true);" href="#">Most recent</a></li>
                  <li class="notSelected last"><a onClick="return togglePostsSwitch(false);" href="#">Trending</a></li>
                {else}
                  <li class="selected rnd8px last" style="color: #111;">Most recent</li>
                {/if}
                </ul>
              </div>
            </div>
            <ul id="posts" class="UIobjectlist listw630">
              {foreach from=$posts item=post name=posts}
              <li {if $smarty.foreach.posts.first && $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="first last"{else}{if $smarty.foreach.posts.first}class="first"{elseif $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="last"{/if}{/if}>
                <div class="thumb"><a class="thumb" href="pages/blogs/post.php?id={$post->id}"><img src="pages/getphoto/GetPhoto.php?id={$post->thumbnail}&size=80x80" width="80" height="80" /></a></div>
                <div class="description">
                  <div class="heading">
                    <h4 class="left text-overflow" style="margin-bottom: 0;"><a href="pages/blogs/post.php?id={$post->id}">{$post->title}</a></h4>
                    <span class="datetime right">{$post->created}</span>
                  </div>
                  <span class="datetime" style="margin-bottom: 8px; display: block;">{$post->blogName}</span>
                  <p class="word-wrap">{$post->excerpt}</p>
                </div>
              </li>
              {/foreach}
              {if $smarty.foreach.posts.total eq 8}
              <li class="last">
                <div style="width: 500px; margin: 0 auto; padding: 5px; text-align: center;">
                  <a href="backend/ajax.php?service=blog&method=GetPosts&genre={$pageData['filterOn']}&amount=8&start=8" ajaxify="1" callback="injectPosts" onClick="this.style.display = 'none'; document.getElementById('morePostsSpinner').style.display = 'inline-block';" spinner="morePostsSpinner" offset="8" pagesize="8">View more</a>
                  <div id="morePostsSpinner" class="ajaxSpinner" style="display: none; float: none; margin: 1px;"></div>
                </div> 
              </li>
              {/if}
            </ul>
          </div>
        </div> <!-- span650 -->
        
        <div class="span300 leftspcr topspcr15">
          <div class="UIpanel">
            <div class="UIheading">
              <h3>Blogs</h3>
            </div>
            <ul class="UItileview" style="margin: 0 8px;">
            {foreach from=$blogs item=blog name=blogs}
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
        </div> <!-- span300 -->
        
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