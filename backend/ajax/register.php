<?php

$response = array("data" => '
<div style="overflow: auto;">
  <h2 style="float: left; color: #ABA0C0; font-size: 22px;">Register with Project Nightlife</h2>
  <img style="float: right;" src="http://projectnightlife.co.uk/images/core/facebook.png" />
  <img style="float: right; padding: 2px 12px 0 0;" src="http://projectnightlife.co.uk/images/core/header/logo.png" />
</div>
<p>Project Nightlife allows you to login with your Facebook details - saving you from creating yet another online account.</p>
<div style="margin: 20px 0 5px; color: #d9d9d9;">
  <div style="margin-bottom: 6px;">
    <span>Step 1.</span><span style="padding-left: 10px;">Click the register button below</span>
  </div>
  <div style="margin-bottom: 6px;">
    <span>Step 2.</span><span style="padding-left: 10px;">Facebook will ask you to allow Project Nightlife access to the data we require to setup your account</span>
  </div>
  <div>
    <span>Step 3.</span><span style="padding-left: 10px;">Get started with Project Nightlife</span>
  </div>
</div>
<div style="padding: 20px 0;"><a class="register" href="#" style="display: block; margin: 0 auto;" title="Click to register" onclick="return api.updateRegisterDialog();">Register</a></div>
<p style="margin-bottom: 5px;">Although you\'ll be using Facebook to login, Facebook never send us your login details - so your account is completely safe.</p>
<p style="font-size: 11px;">More information can be found at <a href="http://www.facebook.com/about/login/" target="_blank">http://www.facebook.com/about/login/</a></p>
');

print json_encode($response);

?>