<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="alternate" type="application/rss+xml" title="Project Nightlife | Blogs (RSS 2.0)" href="blogs/rss" />
<title>Project Nightlife | Blogs</title>
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
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
        <div class="heading">
          <h1 class="left">Blogs</h1>
          <div class="right" style="margin: 10px 5px 0;">
            <ul class="filter"><li>Filter:</li><li{if $pageData['filter'] eq 'all'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php">All</a></li><li{if $pageData['filter'] eq 'electronic'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php?filter=electronic">Electronic</a></li><li{if $pageData['filter'] eq 'indie'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php?filter=indie">Indie</a></li><li{if $pageData['filter'] eq 'urban'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php?filter=urban">Urban</a></li><li{if $pageData['filter'] eq 'lifestyle'} class="selected rnd8px"{/if}><a href="pages/blogs/blogs.php?filter=lifestyle">Lifestyle</a></li><li class="last{if $pageData['filter'] eq 'other'} selected rnd8px{/if}"><a href="pages/blogs/blogs.php?filter=other">{if $pageData['filter'] eq 'other'}{$pageData['filterOn']}{else}Other{/if}</a></li></ul>
          </div>
        </div>
        <hr />
      </div>
        
      <div class="canvas">
        
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
              <a href="pages/general/opportunities/bloggers.php"><img src="images/blog_feature.jpg" /></a>
              {foreach from=$featuredPosts item=post name=featuredPosts2}
              <a href="post/{$post->id}"><img src="http://www.projectnightlife.co.uk/photo/{$post->thumbnail}/608x312" /></a>
              {/foreach}
            </div>  
          </div>
          <div id="pagingWindow">
            <a href="#" rel="1">1</a>
            <a href="#" rel="2">2</a>
            <a href="#" rel="3">3</a>
            <a href="#" rel="4">4</a>
          </div>
        </div>
        
        <div class="span650 topspcr15">
          <div class="UIpanel">
            <div class="UIheading">
              <h3>Blog posts</h3>
              <div class="UIcontrol">
                <ul class="filter" id="postFilter">
                {if $pageData['filter'] eq 'all'}
                  <li class="spinner" id="togglePostsSpinner">loading icon</li>
                  <li class="selected rnd8px"><a onclick="return togglePostsSwitch(true);" href="#">Most recent</a></li>
                  <li class="notSelected last"><a onclick="return togglePostsSwitch(false);" href="#">Trending</a></li>
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
                  <a href="backend/ajax.php?service=blog&method=GetPosts&genre={$pageData['filterOn']}&amount=8&start=8" ajaxify="1" callback="injectPosts" onclick="this.style.display = 'none'; document.getElementById('morePostsSpinner').style.display = 'inline-block';" spinner="morePostsSpinner" offset="8" pagesize="8">View more</a>
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
              {if $smarty.foreach.blogs.index <= 3}
              {if $smarty.foreach.blogs.index % 2 == 0}
                <div style="overflow: auto;">
              {/if}
              <li>
                <a class="thumb" href="pages/blogs/blog.php?id={$blog->id}"><img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=80x80" width="80" height="80" /></a><span class="tilename">{$blog->name}</span>
              </li>
              {if $smarty.foreach.blogs.index % 2!= 0}
                </div>
              {/if}
              {/if}
            {/foreach}
            </ul>
          </div>
          <div class="advert" style="margin: 10px auto;">
            <!--<div style="position: relative; margin: 0 auto; font-size: 36px; color: #000; text-align: center; width: 150px; top: 95px;">Advert</div>-->
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="300" height="250">
      <param name="movie" value="http://www.betolima.com/img/LOGOS/Smirnoff/090804_Smirnoff_THERE_MREC.swf">
      <param name="quality" value="high">
      <param name="wmode" value="transparent" />
      <embed src="http://www.betolima.com/img/LOGOS/Smirnoff/090804_Smirnoff_THERE_MREC.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="300" height="250" wmode="transparent"></embed>
    </object>
          </div>
          {if $blogs|@count > 4}
          <div class="UIpanel topspcr">
            <ul class="UItileview" style="margin: 0 8px;">
            {foreach from=$blogs item=blog name=blogs}
              {if $smarty.foreach.blogs.index > 3}
              {if $smarty.foreach.blogs.index % 2 == 0}
                <div style="overflow: auto;">
              {/if}
              <li>
                <a class="thumb" href="pages/blogs/blog.php?id={$blog->id}"><img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=80x80" width="80" height="80" /></a><span class="tilename">{$blog->name}</span>
              </li>
              {if $smarty.foreach.blogs.index % 2!= 0}
                </div>
              {/if}
              {/if}
            {/foreach}
            </ul>
          </div>
          {/if}
        </div> <!-- span300 -->
        
      </div> <!-- canvas -->
    </div> <!-- container -->
    <div class="push"></div>
  </div> <!-- wrapper -->
  {include file='../../includes/templates/footer.tpl'}
  <div id="fb-root"></div>
</body>
</html>
{include file='../../includes/templates/js.tpl'}
<script type="text/javascript" src="js/jquery.color.js"></script>
<script type="text/javascript" src="js/corners.js"></script>
<script type="text/javascript" src="js/blogs/blogs.js"></script>