<?php

class Credentials
{
	//default guest user
	public static $GuestUser;
		
	private $user;
    private $token;	

	public function __construct($user, $token)
	{
		$this->user = $user;
		$this->token = $token;
	}
	
	public function getUser()
	{
		return $this->user;
	}
	
	public function getToken()
	{
		return $this->token;
	}
	
} 

//Construct the Guest user
Credentials::$GuestUser = new Credentials(array("id" => 0), 0);
//var_dump(Credentials::$GuestUser);

?>