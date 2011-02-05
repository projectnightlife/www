<?php

include('global_include.php');

//auth
API::Authenticate();

if (isset($_POST['xmlData']))
{
  $xml = new SimpleXMLElement(utf8_encode($_POST['xmlData']));
}
else
{
  $response = array("error" => $e);
}

try {
  $headers = 'From: '.$xml->email;
  unset($xml->email);
  $subject = "Project Nightlife Enquiry - ".$xml->subject;
  unset($xml->subject);
  $message = "Name: ".$xml->name."\n";
  unset($xml->name);
  $message = $message."UserId: ".$xml->userId."\n\n";
  unset($xml->userId);
  foreach($xml as $field)
  {
	$message = $message.str_replace("\\n", "\n", $field)."\n\n";
  }
  mail("marcus@projectnightlife.co.uk", $subject, $message, $headers);
}
catch (Exception $e)
{
  $response = array("error" => $e);
}

$response = array("data" => "true");

print json_encode($response);

?>