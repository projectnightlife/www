{include file='../../includes/templates/page.tpl'}
<title>Notifications | Project Nightlife</title>
</head>

<body>
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
        
        <div class="span960">
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