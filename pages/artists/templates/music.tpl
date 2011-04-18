{include file='../../includes/templates/page.tpl'}
<meta property="og:title" content="{$blog->name}"/>
<meta property="og:type" content="musician"/>
<meta property="og:url" content="http://www.projectnightlife.co.uk/conorowen"/>
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
        <div class="breadcrumbs"><a href="">Home</a> > <a href="pages/blogs/blogs.php">Artists</a> > <a href="pages/artists/artist.php">{$blog->name}</a> > <a href="">Music</a><div style="float: right"><a href="">Home</a> | <a href="">Photos</a> | <a href="music.php">Music</a></div></div>
      </div>
      
      <div class="canvas">
      
        <div class="span180">
          <div class="vnav">
  <a href="">Albums</a>
  <a href="">Tracks</a>
</div>
        </div> <!-- span200 -->
        
        <div class="span770 leftspcr">
          <div class="UIpanel UIcontainer">
            <div class="UIheading">
              <h3>Albums</h3>
            </div>
          </div>
        </div>
          
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
<script src="http://platform.twitter.com/widgets.js" type="text/javascript"></script>