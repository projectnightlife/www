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
          <li><a href="pages/general/company/about.php">About us</a></li>
          <li><a href="#" onclick="return api.composeMessage('Contact Us', api.contactus(), '{$pageData['hostname']}/backend/communicate.php', 0);" title="Contact us">Contact us</a></li>
        </ul>
      </div>
      <div id="opportunities-column" class="column">
        <span>Opportunities</span>
        <ul>
          <li>Advertising</li>
          <li><a href="pages/general/opportunities/bloggers.php">Bloggers</a></li>
        </ul>
      </div>
    </div>
  </div>
   <!--{if $session['loggedIn']}
  <div style="position: fixed; bottom: 0px; height: 30px; background: #111; width: 100%; border-top: 1px solid #222; overflow: auto; opacity:0.8;filter:alpha(opacity=80);">
    <div style="padding: 5px;">
      <div style="float: left; color: #bbb;">Just a little idea i'm toying with for the future ;-)</div>
      {if $session['notifications']|@count > 0}
        {if $session['notificationsPending'] eq 'true'}
          <a href="#" ajaxify="1" id="notifications" style="background: #6b5294; float: right;">New Notifications</a>
        {else}
          <a href="#" ajaxify="1" id="notifications" style="float: right;">Notifications</a>
        {/if}
      {/if}
      {if $session['ownsBlog']}
        <a href="pages/blogs/editblog.php" style="padding-right: 10px; float: right;">Dashboard</a>
      {/if}
    </div>
  </div>
  {/if}-->