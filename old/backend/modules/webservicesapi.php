<?php 

//include_once("backend/nusoap/nusoap.php");

class WebServicesApi extends Module
{
	const NO_TOKEN = -1;
	const WS_API_ID = "PNIGHT";
	const WS_SECRET_KEY = "SECRET";
	private static $currentToken = self::NO_TOKEN;
	private $client;
		
	//Initialisation
	public static function Init()
	{
		self::ExportFunction("CreateWS", "CreateWS");
	}
	
	//creation
	public static function CreateWS($url)
	{
		return new WebServicesApi($url);
	}
	
	protected function __construct($url)
	{
		
		$this->client = new SoapClient($url, array("features" => SOAP_SINGLE_ELEMENT_ARRAYS));
		
		//have we authenticated with the webservices server?
		if(self::$currentToken == self::NO_TOKEN)
		{
			$userid = "";
			$token = "";
			if(API::IsUserLoggedIn())
			{
				$credentials = API::GetUserCredentials();
				$user = $credentials->getUser();
				$userid = $user['id'];
				$token = $credentials->getAccess_token();
			}
			
			$auth = new SoapClient("http://projectnightlife.co.uk/api/AuthenticationService.asmx?WSDL");
			try
			{
				self::$currentToken = $auth->Authenticate(self::WS_API_ID, self::WS_SECRET_KEY,$userid, $token);
			}
			catch(Exception $e)
			{
				var_dump($e);
				die();
			}
		}
	}
	
	public function __call($name, $args)
	{
		try
		{
			array_unshift($args, self::$currentToken);
		    $xmlResult =  $this->client->__soapCall($name, $args);
		    return simplexml_load_string($xmlResult);
		}
		catch(Exception $e)
		{
		  	var_dump($e);
			API::writeLog($e->faultcode);
		}
	}
}
?>