<?php

class User extends Module
{
		
	//static stuff
	public static function Init()
	{
		//yadda
		self::ExportFunction("LookUpUser", "LookUp");
		self::ExportFunction("Register", "Create");
	}
	
	public static function LookUp($email, $ip)
	{
		API::writeLog("looking up account associated with ".$email." for ".$ip."</br>");
		$user = new User();
		$xml = $user->webService->LookUpUser($email);
		
		$user->data["userid"] = $xml->id;
		if ((int)$user->data["userid"] != 0) // not found
		{
		  $user->data["firstname"] = $xml->firstname;
		  $user->data["lastname"] = $xml->lastname;
		}
		return $user;
	}
	
	public static function Create($firstName, $lastName, $mobile, $email, $password, $gender, $birthDay, $birthMonth, $birthYear, $ip)
	{
		API::writeLog("registering account associated with ".$email."</br>");
		$user = new User();
		$xml = $user->webService->Register($firstName, $lastName, $mobile, $email, $password, $gender, $birthDay, $birthMonth, $birthYear, $ip);
		
		$user->data["userid"] = $xml->id;
		if ((int)$user->data["userid"] != 0) // not found
		{
		  $user->data["firstname"] = $xml->firstname;
		  $user->data["lastname"] = $xml->lastname;
		}
		return $user;
	}

	//not sure I like this, having the module 'plumbing' and the object in the same class
	//but its the only way I can think to be able to use private constructors...

	
	protected function __construct()
	{
		API::writeLog("Creating a user module<br/>");
		$this->webService = API::CreateWS("http://projectnightlife.co.uk/api/RegistrationService.asmx?WSDL");
	}
	
}

?>