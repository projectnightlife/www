	<div id="header">
		<div class="mainheader">
			<a href="/" class="site_logo"><span>Project Nightlife</span></a>
		</div>
		<a class="mainheader_pulldown" href="javascript:void(0);">&nbsp;</a>
		<div id="pulldown">
			<div class="pulldown_spacer">
				<ul>
					{if $session['loggedIn']}
						<li id="nav-logout"><a id="fblogout" ajaxify="1" href="index.htm">Logout</a></li>
					{else}
						<li id="nav-login"><a id="fblogin" ajaxify="1" href="#">Login</a></li>
					{/if}
				</ul>
			</div>
		</div>
	</div>