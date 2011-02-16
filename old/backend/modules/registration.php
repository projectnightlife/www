<?php

class Registration extends Module
{
		
	//static stuff
	public static function Init()
	{
		//yadda
		self::ExportFunction("register", "Create");
	}
	
	public static function Create($firstName, $lastName, $mobile, $email, $password, $gender, $birthDay, $birthMonth, $birthYear, $ip)
	{
		API::writeLog("registering account associated with ".$email."</br>");
		$registration = new Registration($firstName, $lastName, $mobile, $email, $password, $gender, $birthDay, $birthMonth, $birthYear, $ip);
		return $registration;
	}

	//not sure I like this, having the module 'plumbing' and the object in the same class
	//but its the only way I can think to be able to use private constructors...

	
	private $email;
	
	protected function __construct($firstName, $lastName, $mobile, $email, $password, $gender, $birthDay, $birthMonth, $birthYear, $ip)
	{
		API::writeLog("Creating user account via web service<br/>");
		$venueService = API::CreateWS("http://projectnightlife.co.uk/api/RegistrationService.asmx?WSDL");

		$xml = $venueService->Register($firstName, $lastName, $mobile, $email, $password, $gender, $birthDay, $birthMonth, $birthYear, $ip);
		$this->data["statuscode"] = $xml->statusCode;
		$this->data["message"] = $xml->message;
	}
	
}

?>