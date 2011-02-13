<div class="header">
  <ul class="mainnav left">
    <li id="nav-home"><a class="" href=""><div class="logo"></div><span>home</span></a></li>
    <li id="nav-blogs"><a href="pages/blogs/blogs.php">Blogs</a></li>
    <!--<li id="nav-faq"><a href="pages/general/site/faq.php">Faq</a></li>
    <li id="nav-photos"><a href="index.htm">Photos</a></li>
    <li id="nav-venues"><a href="index.htm">Venues</a></li>
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
        <li><a href="pages/blogs/editblog.php">Dashboard</a></li>
      {/if}
      <li id="nav-logout"><a id="fblogout" ajaxify="1" href="index.htm">Logout</a></li>
    {else}
      <li id="nav-register"><a id="fbregister" ajaxify="1" href="#">Register</a></li>
      <li id="nav-login"><a id="fblogin" ajaxify="1" href="#">Login</a></li>
    {/if}
  </ul>
</div>