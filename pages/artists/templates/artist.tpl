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
          <h1 class="left">{$blog->name}</h1><h1 class="right">Artist</h1>
        </div>
        <hr />
        <div class="breadcrumbs"><a href="">Home</a> > <a href="pages/blogs/blogs.php">Blogs</a> > <a href="pages/artists/artist.php">{$blog->name}</a></div>
      </div>
      
      <div class="canvas">
        <div class="span960 btmspcr" style="position: relative;">
          <img src="images/conor.png" style="-moz-border-radius: 6px; -webkit-border-radius: 6px; border-radius: 6px;" />
          <div style="position: absolute; z-index: 100; top: 50px; right: 30px; width: 200px; background: url(http://www.projectnightlife.co.uk/images/core/transparency/75.png) repeat; border-radius: 5px; -moz-border-radius: 5px; -webkit-border-radius: 5px; padding: 10px;">
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">Age: 22</span></div>
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">City: London</span></div>
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">Listening to: The Swell Season</span></div>
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">Supports: Liverpool</span></div>
            <div><img src="images/core/icons/single_blue_chevron.png" /><span style="padding-left: 5px;">Random: James Corden stripped me of my shirt on the dancefloor at the Mayfair Hotel the other weekend!</span></div>
          </div>
        </div>
        
        <div class="span600">
          <div class="UIpanel">
            <div class="UIcontainer">
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
              <li><a href="#tabs-1" style="padding: 0 10px;">Updates</a></li>
              <li><a href="#tabs-2" style="padding: 0 10px;">Album</a></li>
              <li><a href="#tabs-3" style="padding: 0 10px;">Tour</a></li>
            </ul>
            <div id="tabs-1">tab 1</div>
            <div id="tabs-2">tab 2</div>
            <div id="tabs-3">tab 3</div>
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
          
          <div class="UIpanel topspcr">
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
<script type="text/javascript">
$(document).ready(function() {
    $("#tabs").tabs();
  });
</script>
{include file='../../includes/templates/js.tpl'}