{include file='../../includes/templates/page.tpl'}
<title>Manage Content | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
 	    <div class="heading">
          <h1 class="left">{$blog->name}</h1><h1 class="right">Manage Content</h1>
        </div>
        <hr />
      </div>
      
      <div class="canvas">
         
        <div class="span180">
          {include file='../../includes/templates/blogs/editblog_nav.tpl'}
        </div> <!-- span200 -->
          
        <div class="span600 leftspcr">
          <div class="UIpanel UIcontainer">
            <div class="UIheading">
              <h3>Manage your content</h3>
              <div class="UIcontrol">
                <ul class="filter" id="postFilter">
                  <li class="spinner">loading icon</li>
                  <li class="selected rnd8px"><a onClick="return false;" href="#">Posts</a></li>
                  <!--<li class="last"><a onclick="return transition();" href="#">Charts</a></li>-->
                </ul>
              </div>
            </div>
              
            <ul id="posts" class="UIobjectlist listw580 condensed">
            
              {foreach from=$posts item=post name=posts}
              
              <li id="post[{$post->id}]" {if $smarty.foreach.posts.first && $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 10}class="first last"{else}{if $smarty.foreach.posts.first}class="first"{elseif $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 10}class="last"{/if}{/if}>
                <div class="thumb"><a class="thumb" href="pages/blogs/post.php?id={$post->id}"><img src="pages/getphoto/GetPhoto.php?id={$post->thumbnail}&size=80x80" width="80" height="80" /></a></div>
                <div class="description">
                  <div class="heading">
                    <h4 class="left text-overflow"><a href="pages/blogs/post.php?id={$post->id}">{$post->title}</a></h4>
                    <span class="datetime right">{$post->created}</span>
                  </div>
                  <p class="word-wrap">{$post->excerpt}</p>
                  <ul class="inline-links"><li><i>Live</i></li><li><a href="pages/blogs/editblog.php?v=edit&p={$post->id}">Edit</a></li><li><a href="#" onClick="api.launchConfirmDialog(&quot;Do you wish to delete this post?&quot;, &quot;removePost&quot;, &quot;{$post->id}&quot;); return false;">Delete</a></li><li><div class="ajaxSpinner" id="postSpinner{$post->id}"></div></li></ul>
                </div>
              </li>
              {/foreach}
              {if $smarty.foreach.posts.total eq 10}
              <li class="last">
                <div style="width: 500px; margin: 0 auto; padding: 5px; text-align: center;">
                  <a href="backend/ajax.php?service=blog&method=GetPostsByBlog&id={$blog->id}&amount=10&start=10" ajaxify="1" callback="injectPosts" onClick="this.style.display = 'none'; document.getElementById('morePostsSpinner').style.display = 'inline-block';" spinner="morePostsSpinner" offset="10" pagesize="10">View more</a>
                  <div id="morePostsSpinner" class="ajaxSpinner" style="display: none; float: none; margin: 1px;"></div>
                </div> 
              </li>
              {/if}
               
            </ul>
              
          </div>
        </div> <!-- span600 -->
        
        <div class="span160 leftspcr">
          <div class="UIpanel UIcontainer" style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">
            <div class="UIheading">
              <h3>Tip</h3>
            </div>
           <p>Looking for an easy way to boost your blogs popularity? Rather than sharing a tune directly on Facebook, why not create a quick post containing the song and a brief paragraph containing your thoughts. Then simply share the post instead!</p>
          </div>
          <div class="UIpanel UIcontainer btmspcr" style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">
            <div class="UIheading">
              <h3>Tip</h3>
            </div>
            <p>For maximum exposure - once you've written a post, don't forget to share it on Facebook and Twitter using the social buttons on the post's page.</p>
          </div>
        </div> <!-- span160 -->
        
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