<?php

class FacebookAuth
{

	const app_id = "131359770249054";
	const app_secret = "cf8f9c5d95bb8b37d5ab97f42a2fcb36";
	const cookie_id = "fbs_131359770249054";
	const fb_graph_id = "https://graph.facebook.com/me?access_token=";
	const guest_id = -1;
	
	
	public static function Authenticate()
	{
		//by default log in as a guest user
		$credentials = Credentials::$GuestUser;
		
		
	     //if there is a facebook session, try and retrieve the user info
		$facebook = new Facebook(array(
			'appId'  => self::app_id,
			'secret' => self::app_secret,
			'cookie' => true, // enable optional cookie support
		));
		

		if ($facebook->getSession()) 
		{
			try
			{
			  $user = $facebook->api('/me');
			  $credentials = new Credentials($user, $facebook->getAccessToken());
			} 
			catch (FacebookApiException $e)
			{
				//couldnt get user info
			}
		}
		
		return $credentials;

	}


}



?>