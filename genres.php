<?php

$xml = $_GET['data'];

$newBody = new DOMDocument(); 
$processor = new XSLTProcessor(); 
$transform = new DOMDocument(); 

$newBody->loadXML("<response>".$xml."</response>"); 
$transform->load( 'genres_transform.xsl', LIBXML_NOCDATA); 
$transform->substituteEntities = true;
$processor ->importStylesheet( $transform ); 

$response = simplexml_load_string($processor->transformToXML( $newBody ));

print($response->asXML());

//print json_encode($response);

?>