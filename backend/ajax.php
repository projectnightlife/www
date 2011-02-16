<?php

include('global_include.php');

//auth
API::Authenticate();

if (isset($_POST['xmlData']))
{
  $xml = new SimpleXMLElement(utf8_encode($_POST['xmlData']));
}

//get the post arguments

if((!isset($_GET['service']) && !isset($xml->service)) || (!isset($_GET['method']) && !isset($xml->method)))
{
	die("Required parameters missing"); //better handling?
}


if (isset($_GET['service']))
{
  $serviceName = (string) $_GET['service'];
  unset($_GET['service']);
}
else
{
  $serviceName = (string) $xml->service;
  unset($xml->service);
}
if (isset($_GET['method']))
{
  $methodName = (string) $_GET['method'];
  unset($_GET['method']);
}
else
{
  $methodName = (string) $xml->method;
  unset($xml->method);
}


//build the args
$args = array();

if (isset($xml))
{
  foreach($xml as $element)
  {
	$input = (string) preg_replace("/\[pnobject ([^\]]*)\]/", "<pnobject $1 />", strip_tags($element));
	
	$input = (string) str_replace("\\n\\n\\n\\n", "\\n\\n", $input); // works ok however is not a regex just a straight string substitution
	$input = (string) preg_replace("/^(\\n\\n).*/", "$1", $input); // doesn't work
	$input = (string) preg_replace("/.*(\\n\\n)$/", "$1", $input); // doesn't work
	/* example
	<a></a>
	blah blah blah
	<a></a>
	is represented by: <a></a>\n\nblah blah blah\n\n<a></a>
	
	should output
	<p>blah blah blah</p>
	is represented by: blah blah blah
	
	but at present it outputs
	<p></p>
	<p>blah blah blah</p>
	<p></p>
	is represented by: \n\nblah blah blah\n\n
	*/
	$input = (string) preg_replace("/\[u\]/", "<u>", $input);
	$input = (string) preg_replace("/\[\/u\]/", "</u>", $input);
	$input = (string) preg_replace("/\[i\]/", "<i>", $input);
	$input = (string) preg_replace("/\[\/i\]/", "</i>", $input);
	$input = (string) preg_replace("/\[b\]/", "<b>", $input);
	$input = (string) preg_replace("/\[\/b\]/", "</b>", $input);
	
	$args[] = $input;
  }
}
else
{
  foreach($_GET as $element)
  {
	$input = (string) preg_replace("/\[pnobject ([^\]]*)\]/", "<pnobject $1 />", strip_tags($element));
	
	$input = (string) str_replace("\\n\\n\\n\\n", "\\n\\n", $input); // works ok however is not a regex just a straight string substitution
	$input = (string) preg_replace("/^(\\n\\n).*/", "$1", $input); // doesn't work
	$input = (string) preg_replace("/.*(\\n\\n)$/", "$1", $input); // doesn't work
	/* example
	<a></a>
	blah blah blah
	<a></a>
	is represented by: <a></a>\n\nblah blah blah\n\n<a></a>
	
	should output
	<p>blah blah blah</p>
	is represented by: blah blah blah
	
	but at present it outputs
	<p></p>
	<p>blah blah blah</p>
	<p></p>
	is represented by: \n\nblah blah blah\n\n
	*/
	$input = (string) preg_replace("/\[u\]/", "<u>", $input);
	$input = (string) preg_replace("/\[\/u\]/", "</u>", $input);
	$input = (string) preg_replace("/\[i\]/", "<i>", $input);
	$input = (string) preg_replace("/\[\/i\]/", "</i>", $input);
	$input = (string) preg_replace("/\[b\]/", "<b>", $input);
	$input = (string) preg_replace("/\[\/b\]/", "</b>", $input);
	
	$args[] = $input;
  }
}

$args[] = $_SERVER['REMOTE_ADDR'];

try
{
  //create the webservice
  $service = API::GetService($serviceName);

  //throw new Exception(); // simulate web service call failing
  
  //call the method and return the result (need to handle exceptions here)
  $result = $service->__call($methodName, $args);
  
  // do we have a custom data processor?
  if (file_exists('ajax/'.strtolower($serviceName).'/'.strtolower($methodName).'.php'))
  {
    // data mapping to process returned xml
    include('ajax/'.$serviceName.'/'.$methodName.'.php');
    $response = DataProcessor($result);
  }
  else // use standard data processor
  {
	  //$response = array("data" => json_decode($result));
	  $response = array("data" => $result);
  }
}
catch (Exception $e) // web service call failed
{
	$response = array("error" => $e);
}

print json_encode($response);

?>