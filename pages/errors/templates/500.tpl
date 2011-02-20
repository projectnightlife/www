<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="shortcut icon" href="{$pageData['hostname']}/images/core/icons/favicon.ico" type="image/x-icon" />
<link rel="icon" type="image/png" href="{$pageData['hostname']}/images/core/icons/favicon.png" />
<link rel="apple-touch-icon" href="{$pageData['hostname']}/images/core/icons/favicon.png" />
<meta http-equiv="Content-language" content="en" /> 
<meta name="robots" content="noodp,noydir" />
<meta name="description" content="Project Nightlife is your essential guide to nightlife and music. Catch the latest updates from your favorite artists or get the latest music news from our bloggers." /> 
<link rel="stylesheet" href="{$pageData['hostname']}/css/blueprint/screen.css" type="text/css" media="screen, projection">
<link rel="stylesheet" href="{$pageData['hostname']}/css/blueprint/print.css" type="text/css" media="print">
<!--[if lte IE 7]><link rel="stylesheet" href="{$pageData['hostname']}/css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->
<link rel="stylesheet" href="{$pageData['hostname']}/css/core.css" type="text/css" media="screen, projection">
<title>Page Unavailable | Project Nightlife</title>
</head>

<body>
  <div class="wrapper">
    <div class="header">
      <ul class="mainnav left">
        <li id="nav-home"><a class="" href="{$pageData['hostname']}/"><div class="logo"></div><span>home</span></a></li>
        <li id="nav-blogs"><a href="{$pageData['hostname']}/blogs">Blogs</a></li>
        <!--<li id="nav-photos"><a href="/">Photos</a></li>-->
        <!--<li id="nav-venues"><a href="index.htm">Venues</a></li>
        <li id="nav-events"><a href="index.htm">Events</a></li>
        <li id="nav-photos"><a href="index.htm">Photos</a></li>
        <li id="nav-music"><a href="index.htm">Music</a></li>
        <li id="nav-tickets"><a href="index.htm">Tickets</a></li>
        <li id="nav-lifestyle"><a href="">Lifestyle</a></li>-->
      </ul>
      <!--<div id="mainsearch" class="right"><input type="text" /></div>-->
      <ul class="mainnav right">
        {if $session['loggedIn']}
          {if $session['notifications']|@count > 0}
            <li><a href="#" ajaxify="1" id="notifications">{if $session['notificationsPending'] eq 'true'}New {/if}Notifications</a></li>
          {/if}
          {if $session['ownsBlog']}
            <li><a href="{$pageData['hostname']}/blog/edit">Dashboard</a></li>
          {/if}
          <li id="nav-logout"><a id="fblogout" ajaxify="1" href="">Logout</a></li>
        {else}
          <li id="nav-register"><a href="#" id="fbregister" ajaxify="1">Register</a></li>
          <li id="nav-login"><a id="fblogin" ajaxify="1" href="#">Login</a></li>
        {/if}
      </ul>
    </div>
    <div class="container">
    
      <div class="masthead">
        <div class="heading">
          <h1 class="left">Page Unavailable At This Time</h1>
        </div>
        <hr />
      </div>
      
      <div class="canvas">
          
        <div class="span500 center">
          <div class="UIpanel UIcontainer topspcr" style="border: 1px solid #222; background: #0f0f0f;">
            <div class="UIheading" style="margin-bottom: 0; padding-bottom: 5px; border-bottom: 1px solid #222;">
              <h3>We're sorry, but the page you were after is currently experiencing some problems</h3>
            </div>
            <p style="margin-top: 5px; margin-bottom: 1em;">You may wish to try and load the page again. If the problem persists, please try again later.</p>
            <ul style="list-style-type: square; font-size: 11px; padding-left: 2em; margin-bottom: 1em;">
              <li><a href="#" onclick="history.go(0); return false;">Retry current page</a></li>
              <li><a href="#" onclick="history.go(-1); return false;">Go back to the previous page</a></li>
              <li><a href="{$pageData['hostname']}">Return home</a></li>
            </ul>
          </div>
        </div> <!-- span500 -->
        
      </div> <!-- canvas -->
    </div> <!-- container -->
    <div class="push"></div>
  </div> <!-- wrapper -->
  <div class="footer">
    <div id="stamp">
      <div class="name"></div>
      <p>Project Nightlife is not responsible for the content of external websites</p>
      <p>Copyright &copy; {$pageData['year']}</p>
    </div>
    <div id="columns">
      <div id="company-column"class="column">
        <span>The Company</span>
        <ul>
          <li><a href="{$pageData['hostname']}/about">About us</a></li>
          <!--<li>Partners</li>
          <li>Work with us</li>-->
          <li><a href="#" onclick="return api.composeMessage('Contact Us', api.contactus(), '{$pageData['hostname']}/backend/communicate.php', 0);" title="Contact us">Contact us</a></li>
        </ul>
      </div>
      <div id="opportunities-column" class="column">
        <span>Opportunities</span>
        <ul>
          <li>Advertising</li>
          <!--<li>Industry</li>
          <li>Photographers</li>-->
          <li><a href="{$pageData['hostname']}/bloggers">Bloggers</a></li>
        </ul>
      </div>
      <!--<div id="feature-column" class="column">
        <span>Feature</span>
        <ul>
          <li>Venues</li>
          <li>Promoters</li>
          <li>Festivals</li>
          <li>Artists</li>
        </ul>
      </div>-->
    </div>
  </div>
  <div id="fb-root"></div>
</body>
</html>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<script type="text/javascript" src="{$pageData['hostname']}/js/jquery.js"></script>
<script type="text/javascript" src="{$pageData['hostname']}/js/api.js"></script>
<!--[if lte IE 6]><script>api.upgradeBrowser();</script><![endif]-->
<script type="text/javascript">
  api.session.populate({$session['userId']}, "{$session['user']['first_name']}", "{$session['user']['last_name']}", "{$session['user']['email']}");
  {foreach from=$session['notifications'] item=notification name=notifications}
  api.notifications.populate("{$notification->thumbnail}", "{$notification->title}", "{$notification->url}", "{$notification->excerpt}", "{$notification->time}");
  {/foreach}
</script>