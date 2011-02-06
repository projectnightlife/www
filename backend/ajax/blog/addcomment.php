<?php

function DataProcessor($xml)
{
  $credentials = API::GetUserCredentials();
  $user = $credentials->getUser();
  
  $local = array("id" => (string)$xml->id, "body" => str_replace('"', '\"', $xml->body), "firstname" => (string)$xml->firstname, "lastname" => (string)$xml->lastname, "userId" => (string)$xml->userId);
  
  return array("data" => array("local" => $local));
}
?>