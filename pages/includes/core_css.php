<?php
if ($ismobile == false) {
	// Greenhill - 14/02/2011 - No need to load these CSS files for the mobile site
	$resourceManager->addResource('blueprint/screen.css');
	$resourceManager->addResource('core.css');
} else { 
	$resourceManager->addResource("handheld.css");
}
?>