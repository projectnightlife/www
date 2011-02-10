<script src="http://connect.facebook.net/en_US/all.js"></script>
<!--<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>-->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/api.js"></script>
<!--[if lte IE 6]><script>api.upgradeBrowser();</script><![endif]-->
<script type="text/javascript">
  api.session.populate({$session['userId']}, "{$session['user']['first_name']}", "{$session['user']['last_name']}", "{$session['user']['email']}");
  {foreach from=$session['notifications'] item=notification name=notifications}
  api.notifications.populate("{$notification->thumbnail}", "{$notification->title}", "{$notification->url}", "{$notification->excerpt}", "{$notification->time}");
  {/foreach}
</script>