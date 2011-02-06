<?php 

class WebService
{
	const NO_TOKEN = -1;
	const WS_API_ID = "PNIGHT";
	const WS_SECRET_KEY = "SECRET";

	private static $currentToken = self::NO_TOKEN;

	private $client;
		
	
	public function __construct($url)
	{
		
		$this->client = new SoapClient($url, array("features" => SOAP_SINGLE_ELEMENT_ARRAYS));
		
		//have we authenticated with the webservices server?
		if(self::$currentToken == self::NO_TOKEN)
		{
			
			//this is a bit weird, but guards against a server auth failure
			try
			{
				try
				{
					//Try and auth as the current user
					self::DoAuth();
				}
				catch(Exception $e)
				{
					//That failed, so log them out, and try and auth as a guest
					API::ClearCredentials();
					self::DoAuth();
				}
				
			}
			catch(Exception $e)
			{
				//We still couldn't auth, even as a guest... maybe the webservices are down?
				API::Fail($e, "Web Service Authentication Failed", __FILE__, __LINE__);
			}

		}
	}
	
	private function DoAuth()
	{
		$credentials = API::GetUserCredentials();
		$user = $credentials->getUser();
		$userid = $user['id'];
		$token = $credentials->getToken();
		
		$auth = new SoapClient("http://www.projectnightlife.co.uk/api/AuthenticationService.asmx?WSDL");
			
		self::$currentToken = $auth->Authenticate(self::WS_API_ID, self::WS_SECRET_KEY,$userid, $token);			
	}
	
	public function __call($name, $args)
	{
		try
		{
			array_unshift($args, self::$currentToken);
		    $result =  $this->client->__soapCall($name, $args);
		    $xmlResult =  simplexml_load_string($result);
			return $xmlResult;
		}
		catch(Exception $e)
		{
		    //API::Error($e, "Webservice call to function ".$name." failed with fault code ".$e->faultcode, __FILE__, __LINE__);
			throw $e;
		}
	}
}
?>