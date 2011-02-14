<!--[if lte IE 6]><script>api.upgradeBrowser();</script><![endif]-->
<script type="text/javascript">
  api.session.populate({$session['userId']}, "{$session['user']['first_name']}", "{$session['user']['last_name']}", "{$session['user']['email']}");
  {foreach from=$session['notifications'] item=notification name=notifications}
  api.notifications.populate("{$notification->thumbnail}", "{$notification->title}", "{$notification->url}", "{$notification->excerpt}", "{$notification->time}");
  {/foreach}
</script>