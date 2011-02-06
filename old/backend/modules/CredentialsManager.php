<?php

class CredentialsManager extends Module
{
	
	public static function Init()
	{
		
		self::ExportFunction("Authenticate", "Authenticate");
		self::ExportFunction("IsUserLoggedIn", "getAuthenticated");
		self::ExportFunction("GetUserCredentials", "GetCredentials");
				
	}

	private static $authenticated = false;
	private static $storedCredentials;
	
	const app_id = "131359770249054";
	const app_secret = "cf8f9c5d95bb8b37d5ab97f42a2fcb36";
	const cookie_id = "fbs_131359770249054";
	const fb_graph_id = "https://graph.facebook.com/me?access_token=";
	const guest_id = -1;
		
	public static function getAuthenticated()
	{
		return self::$authenticated;
	}
	
	
	public static function Authenticate()
	{
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
			  self::$authenticated = true;
			  self::$storedCredentials = new CredentialsManager($user, $facebook->getAccessToken());
			} 
			catch (FacebookApiException $e)
			{
				self::$authenticated = false;
				self::$storedCredentials = new CredentialsManager(0, 0);
			}
		}
		else
		{
				self::$authenticated = false;
				self::$storedCredentials = new CredentialsManager(0, 0);
		}
	
		//check to see if the FB cookie exists
		/*if(isset($_COOKIE[self::cookie_id]))
		{
			try
			{
				//we've got a logged in user
				$cookie = self::get_facebook_cookie();			
				$user = json_decode(file_get_contents(self::fb_graph_id . $cookie['access_token']));
				if($user == null)
					throw new Exception();
				self::$authenticated = true;
				self::$storedCredentials = new CredentialsManager($user,  $cookie['access_token']); 
			}
			catch(Exception $e)
			{
				//setcookie(self::cookie_id);
				print("Not Logged In");
				self::$authenticated = false;
				self::$storedCredentials = new CredentialsManager(0, 0);
			}
		}
		else
		{
			//not logged in, so set the credentials to be the guest
			print("Not Logged In");
			self::$authenticated = false;
			self::$storedCredentials = new CredentialsManager(0, 0);
		}*/
	}
	
	public static function GetCredentials()
	{
		return self::$storedCredentials;
	}
	


	
	private function __construct($user, $access_token)
	{
		$this->data['user']= $user;
		$this->data['access_token'] = $access_token;
	}
	
	public function IsAuthenticated()
	{
		return !($this->data['user'] == '');
	}
	
}

?>