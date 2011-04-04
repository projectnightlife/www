{include file='../../includes/templates/page.tpl'}
<meta property="og:title" content="{$blog->name}"/>
<meta property="og:type" content="musician"/>
<meta property="og:url" content="http://www.projectnightlife.co.uk/conorowen"/>
<meta property="og:image" content="http://www.projectnightlife.co.uk/photo/{$blog->thumbnail}/80x80"/>
<meta property="og:site_name" content="Project Nightlife"/>
<meta property="fb:app_id" content="131359770249054"/>
<meta property="og:description" content="{$blog->slogan}"/>
<title>{$blog->name}'s Events | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
        <div class="heading">
          <h1 class="left">{$blog->name}</h1><h1 class="right">Events</h1>
        </div>
        <hr />
        <div class="breadcrumbs"><a href="">Home</a> > <a href="pages/blogs/blogs.php">Blogs</a> > <a href="pages/artists/artist.php">{$blog->name}</a></div>
      </div>
    </div>
    
    <div style="width: 100%; background-image: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#141414), to(#0c0c0c)); margin-top: 10px; margin-bottom: 5px; overflow: hidden;">
    <img style="display: block; float: left; margin: 35px 27px 35px 54px; -webkit-transition: 0.15s linear; -webkit-box-shadow: 0 0 2px 2px #101010;" src="pages/brands/templates/1.jpg" width="135" height="200" />
    <img style="display: block; float: left; margin: 35px 27px; -webkit-transition: 0.15s linear; -webkit-box-shadow: 0 0 2px 2px #101010;" src="pages/brands/templates/1.jpg" width="135" height="200" />
    <img style="display: block; float: left; margin: 35px 27px; -webkit-transition: 0.15s linear; -webkit-box-shadow: 0 0 2px 2px #101010; -webkit-transform: scale(1.175);" src="pages/brands/templates/1.jpg" width="135" height="200" />
    <img style="display: block; float: left; margin: 35px 27px; -webkit-transition: 0.15s linear; -webkit-box-shadow: 0 0 2px 2px #101010;" src="pages/brands/templates/1.jpg" width="135" height="200" />
    <img style="display: block; float: left; margin: 35px 54px 35px 27px; -webkit-transition: 0.15s linear; -webkit-box-shadow: 0 0 2px 2px #101010;" src="pages/brands/templates/1.jpg" width="135" height="200" />
    </div>
    
    <div class="container">
      
      <div class="canvas">
      
        <div class="span960 btmspcr" style="position: relative;">
          <div id="imageWindow" style="width: 960px; height: 431px;">
            <div id="imageReel" style="width: 2880px; left: -960px;">
              <img src="images/conor2.jpg" />
              <img src="images/conor.png" />
              <img src="images/conor3.jpg" />
            </div>
          </div>
          <img id="hero_mask" src="images/core/hero_mask.png" style="position: absolute; z-index: 10; top: 0; left: 0;" />
          <div id="heroNext" style="position: absolute; display: none; z-index: 100; bottom: 20px; right: 20px; width: 21px; height: 21px;">
            <a href="" class="nextIcon">Next</a>
          </div>
          <div id="heroPrev" style="position: absolute; display: none; z-index: 100; bottom: 20px; left: 20px; width: 21px; height: 21px;">
            <a href="" class="previousIcon">Previous</a>
          </div>
          <div id="overlay" style="position: absolute; z-index: 100; top: 50px; right: 30px; width: 200px; background: url(http://www.projectnightlife.co.uk/images/core/transparency/75.png) repeat; border-radius: 5px; -moz-border-radius: 5px; -webkit-border-radius: 5px; padding: 10px; font-family: 'Lucida Sans Unicode','Lucida Grande',sans-serif;">
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">Age: 22</span></div>
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">City: London</span></div>
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">Listening to: The Swell Season</span></div>
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">Supports: Liverpool</span></div>
            <!--<div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">Random: James Corden stripped me of my shirt on the dancefloor at the Mayfair Hotel the other weekend!</span></div>-->
          </div>
        </div>
        
        <div class="span600">
          <div class="UIpanel">
            <div class="UIcontainer" style="font-family: 'Lucida Sans Unicode','Lucida Grande',sans-serif;">
              <div style="width: 520px; float: left;">
                <h3 style="line-height: 1em; padding-bottom: 5px; color: #ABA0C0;">{$blog->name}</h3>
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
          </div>
          
          <div class="UIpanel topspcr" id="tabs">
            <ul class="UItabs">
              <div class="UIcaret"></div>
              <li><a href="#tabs-1">Updates</a></li>
              <li><a href="#tabs-2">Album</a></li>
              <li><a href="#tabs-3">Tour</a></li>
            </ul>
            <div class="UIcontainer" id="tabs-1">
              <div class="UIheading">
                <h3>Latest updates</h3>
                <div class="UIcontrol">
                  <ul class="filter" id="postFilter">
                    <li class="selected rnd8px last" style="color: #222;">Most recent</li>
                  </ul>
                </div>
              </div>
              <ul id="posts" class="UIobjectlist listw580">
                {if $posts|@count == 0}
                  <div style="text-align: center; font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 16px; padding: 20px 0; color: #ABA0C0;">No updates yet</div>
                {/if}
                {foreach from=$posts item=post name=posts}
                <li {if $smarty.foreach.posts.first && $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="first last"{else}{if $smarty.foreach.posts.first}class="first"{elseif $smarty.foreach.posts.last && $smarty.foreach.posts.total lt 8}class="last"{/if}{/if}>
                  <div class="thumb"><a class="thumb" href="pages/blogs/post.php?id={$post->id}" onClick="window.location = this.href;"><img src="pages/getphoto/GetPhoto.php?id={$post->thumbnail}&size=80x80" width="80" height="80" /></a></div>
                  <div class="description">
                    <div class="heading">
                      <h4 class="left text-overflow"><a href="pages/blogs/post.php?id={$post->id}" onClick="window.location = this.href;">{$post->title}</a></h4>
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
            </div> <!-- UIcontainer -->
            <div class="UIcontainer" id="tabs-2" style="font-family: 'Lucida Sans Unicode','Lucida Grande',sans-serif;">
              <div class="UIheading">
                <h3>The Observationalist</h3>
              </div>
              <p>Singer/songwriter Conor Owen invites you to see and hear the world from his point of view. Step into a world of passion,love and raw emotion in his moving and inspiring sensational debut album – The Observationalist.</p>
              <p>Here are four tracks taken from Conor's debut album</p>
              <p><object height="225" width="100%"> <param name="movie" value="http://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Fplaylists%2F511919&amp;show_comments=true&amp;auto_play=false&amp;show_playcount=true&amp;show_artwork=true&amp;color=601c85"></param> <param name="allowscriptaccess" value="always"></param> <embed allowscriptaccess="always" height="225" src="http://player.soundcloud.com/player.swf?url=http%3A%2F%2Fapi.soundcloud.com%2Fplaylists%2F511919&amp;show_comments=true&amp;auto_play=false&amp;show_playcount=true&amp;show_artwork=true&amp;color=601c85" type="application/x-shockwave-flash" width="100%"></embed> </object>   <span><a href="http://soundcloud.com/conor-owen/sets/the-observationalist">The Observationalist</a> by <a href="http://soundcloud.com/conor-owen">Conor Owen</a></span></p>
            </div> <!-- UIcontainer -->
            <div class="UIcontainer" id="tabs-3" style="font-family: 'Lucida Sans Unicode','Lucida Grande',sans-serif;">
              <div class="UIheading">
                <h3>Park Up and Play Tour March 2011</h3>
              </div>
<p>This tour is about taking music to the people of the U.K. From March 21st – 31st, Conor Owen will be embarking on a nationwide tour in his yellow van "Penelope" as they go on a one man/van mission to enlighten the ears of boys, girls, women and men around the country.</p>
<p>This is a unique experience. This is a chance for live music lovers be part of a form of touring and entertainment that has never been done before. The location of the show could be anywhere, cobbled side streets, car parks, uni campus', city centres or abandoned warehouses.</p>
<p>Conor will play at 17:30 everyday at a secret location in the city. Only to be announced at 14:00 on the day of the show via facebook, myspace and twitter. As well as the afternoon performance, Conor will also play an unplugged private set at fans house the same evening.</p>
<p>The Dates</p>
<p>
21/03 – Brighton<br />
22/03 – London<br />
23/03 – Oxford<br />
24/03 – Cambridge<br />
25/03 – Norwich<br />
26/03 – Peterborough<br />
27/03 – Nottingham<br />
28/03 – Sheffield<br />
29/03 – Leeds<br />
30/03 – Manchester<br />
31/03 – Liverpool</p>
            </div> <!-- UIcontainer -->
          </div>
          
        </div> <!-- span630 -->
        
        
        <div class="span350 leftspcr">
          <div class="UIpanel">
            <div class="UIcontainer">
              <div class="UIheading">
                <h3>Conor's Subscribers</h3>
                <div class="UIcontrol">
                  {if $blog->subscribed == "false" && $session['userId'] != 0 && !$isContributor}
                  <a class="plus subscription" href="backend/ajax.php?service=blog&method=Subscribe&blogId={$blog->id}" rel="subscribe" ajaxify="1" callback="subscription" title="Subscribe">Subscribe</a>
                  {else if $blog->subscribed == "true" && $session['userId'] != 0 && !$isContributor}
                  <a class="minus subscription" href="backend/ajax.php?service=blog&method=Unsubscribe&blogId={$blog->id}" rel="unsubscribe" ajaxify="1" callback="subscription" title="Unsubscribe">Unsubscribe</a>
                  {/if}
                </div>
              </div>
              <div id="subscriptions">
                {foreach from=$subscribers item=subscriber name=subscribers}
                <a id="subscription[{$subscriber->id}]" href="http://www.facebook.com/profile.php?id={$subscriber->id}" class="fbSquareProfilePic" title="{$subscriber->firstname} {$subscriber->lastname}" target="_blank"><img src="https://graph.facebook.com/{$subscriber->id}/picture" alt="{$subscriber->firstname} {$subscriber->lastname}" width="50" height="50" /></a>
                {/foreach}
              </div>
            </div>
          </div>
          
          <div class="UIpanel topspcr" style="font-family: 'Lucida Sans Unicode','Lucida Grande',sans-serif;">
            <div class="UIcontainer">
              <div class="UIheading">
                <h3>Bio</h3>
              </div>
              {$blog->description}
            </div>
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
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
{include file='../../includes/templates/js.tpl'}