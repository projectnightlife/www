{include file='../../includes/templates/page.tpl'}
<title>About Us | Project Nightlife</title>
<link rel="stylesheet" href="{$pageData['cssFile']}" type="text/css" media="screen, projection">
</head>

<body>
  <div class="wrapper">
    {include file='../../includes/templates/header.tpl'}
    <div class="container">
      
      <div class="canvas">
      
      <div class="span960">
        <div class="UIpanel" style="height: 357px;">
          <img style="display: block; margin: 105px auto 50px;" src="images/core/logo.png" />   
        </div>
      </div>
      
      </form>
          
        <div class="span310 topspcr15">
          <div class="UIpanel UIcontainer" style="height: 250px; border-color: #111; font-family: Tahoma, Geneva, sans-serif;">
            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 24px; color: #ABA0C0; margin-bottom: 16px; line-height: 26px;">Who We Are</h3>
		    <p>At Project Nightlife we pride ourselves on our enthusiasm for what we do.</p><p class="last-child">Driven by our passion for nightlife and music in particular, we strive to bring you the latest, freshest and most up to date information available.</p>
          </div>
        </div>
        <div class="span310 leftspcr15 topspcr15">
          <div class="UIpanel UIcontainer" style="height: 250px; border-color: #111; font-family: Tahoma, Geneva, sans-serif;">
            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 24px; color: #ABA0C0; margin-bottom: 16px; line-height: 26px;">What We Do</h3>
            <p>Before launching our full website which will provide the latest on music, fashion, drinks and the funkiest venues,  Project Nightlife aims to become the ultimate music resource.</p><p class="last-child">We've recruited a team of excitingly talented bloggers whose passion and creativity will transpire to a wealth of information available to all our users at the click of a button. Our site is friendly and simple to use, making yours and our love for music easier than ever before!</p>
          </div>
        </div>
        <div class="span310 leftspcr15 topspcr15">
          <div class="UIpanel UIcontainer" style="height: 250px; border-color: #111; font-family: Tahoma, Geneva, sans-serif;">
            <h3 style="font-family: 'Lucida Sans Unicode', 'Lucida Grande', sans-serif; font-size: 24px; color: #ABA0C0; margin-bottom: 16px; line-height: 26px;">Our Vision</h3>
            <p>At Project Nightlife we aim for the best. Our vision is to be the ultimate resource for those with a real interest in going out and experiencing the best UK nightlife has to offer.</p><p>This is an extremely exciting project to be part of and we are always on the hunt for people as passionate as we are.</p><p class="last-child">If you think you fit the mould, then don't hesitate, we would love to <a href="#" onClick="return api.composeMessage('Contact Us', api.contactus(), '{$pageData['hostname']}/backend/communicate.php', 0);" title="Contact us">hear from you!</a></p>
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
{include file='../../includes/templates/js.tpl'}