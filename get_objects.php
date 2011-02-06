<?php

$xml = $_POST['xmlData'];

// escape invalid characters
$xml= (string) preg_replace("/&/", "&amp;", $xml);
$xml = (string) preg_replace("/<(?!(pnobject|b>|u>|i>|\/b>|\/u>|\/i>))/", "&lt;", $xml);


$newBody = new DOMDocument(); 
$processor = new XSLTProcessor(); 
$transform = new DOMDocument(); 

$newBody->loadXML("<response>".$xml."</response>"); 
$transform->load( 'get_objects_transform.xsl', LIBXML_NOCDATA); 
$transform->substituteEntities = true;
$processor ->importStylesheet( $transform ); 

$response = simplexml_load_string($processor->transformToXML( $newBody ));

//print($response->asXML());

print json_encode($response);

?>