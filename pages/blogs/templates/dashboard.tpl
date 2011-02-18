{include file='../../includes/templates/page.tpl'}
<title>Dashboard | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body id="blogs{if $ismobile == "true"} mobile{/if}">
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="masthead">
 	    <div class="heading">
          <h1 class="left">{$blog->name}</h1><h1 class="right">Dashboard</h1>
        </div>
        <hr />
      </div>
      
      <div class="canvas">
         
        <div class="span180">
          {include file='../../includes/templates/blogs/editblog_nav.tpl'}
        </div> <!-- span200 --> 
        
        <div class="span600 leftspcr">
          <div class="UIpanel UIcontainer btmspcr">
            <div class="blogvitals left">
              <div class="clear left">
                <a class="thumb" href="pages/blogs/blog.php?id={$blog->id}"><img src="pages/getphoto/GetPhoto.php?id={$blog->thumbnail}&size=80x80" width="80" height="80" /></a>
              </div>
              <div class="info">
                <h3 style="line-height: 1em">{$blog->name}</h3>
                <p>{$blog->slogan}</p>
                <p>By 
                {foreach from=$blogContributors item=contributor name=contributors}{if $smarty.foreach.contributors.first}<a href="http://www.facebook.com/profile.php?id={$contributor->userId}" target="_blank">{$contributor->firstname} {$contributor->lastname}</a>{elseif $smarty.foreach.contributors.last} and <a href="http://www.facebook.com/profile.php?id={$contributor->userId}" target="_blank">{$contributor->firstname} {$contributor->lastname}</a>{else}, <a href="http://www.facebook.com/profile.php?id={$contributor->userId}" target="_blank">{$contributor->firstname} {$contributor->lastname}</a>{/if}{/foreach}
                </p>
              </div>
            </div>
          </div>
          <div class="UIpanel UIcontainer">
            <div class="UIheading">
              <h3>Dashboard</h3>
            </div>
            <ul class="UIobjectlist listw580">
              <li class="first">
                <div style="margin: 0 auto; width: 298px;">
                  <ul class="blogstats">
                    <li class="postCount">
                      <span class="value">{$blog->numPosts}</span>
                      <span>posts</span>
                    </li>
                    <li class="commentCount">
                      <span class="value">{$blog->numComments}</span>
                      <span>comments</span>
                    </li>
                    <li class="followerCount">
                      <span class="value">{$blog->numSubscribers}</span>
                      <span>subscribers</span>
                    </li>
                  </ul>
                </div>
              </li>
              <li class="last">
                <div style="text-align: center; padding: 20px 0;">No messages</div>
              </li>
            </ul> 
          </div>
        </div> <!-- span600 -->
        
        <div class="span160 leftspcr">
          <div class="UIpanel UIcontainer btmspcr" style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">
            <div class="UIheading">
              <h3>Tip</h3>
            </div>
            <p>For maximum exposure - once you've written a post, don't forget to share it on Facebook and Twitter using the social buttons on the post's page.</p>
          </div>
          <div class="UIpanel UIcontainer" style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">
            <div class="UIheading">
              <h3>Tip</h3>
            </div>
            <p>Looking for an easy way to boost your blogs popularity? Rather than sharing a tune directly on Facebook, why not create a quick post containing the song and a brief paragraph summarising your thoughts. Then simply share the post instead!</p>
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
<script type="text/javascript">
$(document).ready(function()
{
	if (window.location.href.lastIndexOf("#welcome") != -1)
	  api.launchDialog("Welcome to your blog dashboard", '<p>Before you get started, we recommend you take a moment to read the guide we\'ve prepared. It\'ll give you a brief introduction to our blogging system as well as how to get the most from your blog.</p><p>The guide is available at any time under the \'Guide\' option from the left menu.</p><p><a href="blog/edit?v=guide" style="background: url({$pageData["hostname"]}/images/core/icons/single_pink_chevron.png) no-repeat 0 2px; padding-left: 12px;">Read the guide</a></p>');
});
</script>