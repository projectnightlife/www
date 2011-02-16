	<div id="header">
		<div class="mainheader">
			<a href="/" class="site_logo"><span>Project Nightlife</span></a>
		</div>
		<a class="mainheader_pulldown">Controls</a>
		<div id="pulldown">
			<div class="pulldown_spacer">
				<ul>
					{if $session['loggedIn']}
					{if $session['notifications']|@count > 0}
						<li><a href="#" ajaxify="1" id="notifications">{if $session['notificationsPending'] eq 'true'}New {/if}Notifications</a></li>
					{/if}
					{if $session['ownsBlog']}
						<li><a href="pages/blogs/editblog.php">Dashboard</a></li>
					{/if}
						<li id="nav-logout"><a id="fblogout" ajaxify="1" href="#">Logout</a></li>
					{else}
						<li id="nav-login"><a id="fblogin" ajaxify="1" href="#">Login</a></li>
					{/if}
				</ul>
			</div>
		</div>
	</div>