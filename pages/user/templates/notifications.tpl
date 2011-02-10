<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta property="og:title" content="{$blog->name}"/>
<meta property="og:type" content="blog"/>
<meta property="og:url" content="http://www.projectnightlife.co.uk/blog/{$blog->id}"/>
<meta property="og:image" content="http://photos.projectnightlife.co.uk/uploads/{$blog->thumbnail}.jpg"/>
<meta property="og:site_name" content="Project Nightlife"/>
<meta property="fb:app_id" content="131359770249054"/>
<meta property="og:description" content="{$blog->description}"/>
<title>Project Nightlife | Notifications</title>
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
          <h1 class="left">{$session['user']['first_name']} {$session['user']['last_name']}</h1><h1 class="right">Subscription Updates</h1>
        </div>
        <hr />
        <div class="breadcrumbs"><a href="">Home</a> > <a href="pages/user/notifications.php">Subscription Updates</a></div>
      </div>
      
      <div class="canvas">
        
        <div class="span790">
          <div class="UIpanel">
            <div class="UIheading">
              <h3>Latest updates from your subscriptions</h3>
            </div>
            <div class="notifications" style="padding: 0 10px;">
              
              {foreach from=$notifications item=notification name=notifications}
              <div class="notification{if $smarty.foreach.notifications.last} last{/if}">
                <a href="{$notification->url}"><img src="photo/{$notification->thumbnail}/50x50" /></a>
                <div class="details">
                  <h3><a href="{$notification->url}">{$notification->title}</a></h3>
                  <p>{$notification->excerpt}</p>
                  <div class="datetime">{$notification->time}</div>
                </div>
              </div>
              {/foreach}
              
            </div>
          </div>
        </div> <!-- span790 -->
          
      </div> <!-- canvas -->
    </div> <!-- container -->
    <div class="push"></div>
  </div> <!-- wrapper -->
  {include file='../../includes/templates/footer.tpl'}
  <div id="fb-root"></div>
</body>
</html>
{include file='../../includes/templates/js.tpl'}
<script type="text/javascript" src="js/corners.js"></script>
<script type="text/javascript" src="js/blogs/blog.js"></script>