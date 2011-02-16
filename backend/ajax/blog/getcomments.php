<?php

function DataProcessor($xml)
{
  $credentials = API::GetUserCredentials();
  $user = $credentials->getUser();

  $global = array("userId" => $user['id']);
  $local = array();
  foreach($xml->children() as $result)
  {
	  $local[] = array("id" => (string)$result->id, "body" => str_replace('"', '\"', $result->body), "created" => API::GetDynamicDateString((int)$result->created), "firstname" => (string)$result->firstname, "lastname" => (string)$result->lastname, "userId" => (string)$result->userId);
  }
  
  return array("data" => array("global" => $global, "local" => $local));
}
?>