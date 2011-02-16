<?php

include_once("backend/global_include.php");


API::Authenticate();

/*print("Authenticating<br/>");
$auth = API::CreateWS("http://localhost:82/AuthenticationService.asmx?WSDL");

print("Logging In, and checking cross call auth<br/>");
if($auth->Authenticate(array("user" => "Chiser99", "token" => "magic")) == "magictoken"){
	print("Successfully Auth'd<br/>");
	if($auth->IsAuthorised() == "true") print("Cross Call auth succesfull<br/>");
	else print("Cross call auth failed<br/>");
}
else print("Auth Failed<br/>");

print("Attempting cross call auth without prior auth (shoud fail)<br/>");
$auth2 = API::CreateWS("http://localhost:82/AuthenticationService.asmx?WSDL");
if($auth2->IsAuthorised() == "false") print("Failed (good!)");
else ("Success (bad!)<br/>");*/

print("<br/><br/><br/>Creating venue 4<br/>");
$venue = API::getVenue(4);
print("ID: ".$venue->getID()."<br/>");
print("Name: ".$venue->getName()."<br/>");
print("Location: ".$venue->getLocation()."<br/>");


?>
