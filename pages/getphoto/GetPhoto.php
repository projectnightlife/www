<?php
	/**
	 * GetPhoto 
	 * 
	 * Copyright (c) 2010-2011
	 *
	 * Last updated 8/02/2011
	 *
	 */
	
	// Output buffering so we don't screw up the headers
	ob_start();
	
	// Global include
	$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
	require_once($globalDir.'backend\\global_include.php');
	
	// API Auth
	API::Authenticate();
	
	// ID and sizes
	$id		= (isset($_GET['id'])) 		? htmlspecialchars($_GET['id']) 	: false;
	$size	= (isset($_GET['size'])) 	? htmlspecialchars($_GET['size']) 	: '606x450'; // eventually change to photo gallery photo size as default
	
	if ($id == false) { 
		die(); 
	}
	
	$imageSvc = API::GetService("image");
	$data = $imageSvc->GetPhotoLocations($id);
	
	foreach ($data as $image) {
		if ($image->size == $size) {
			// Set the caching headers
			header('Content-type: image/jpeg');
			header_remove("Cache-Control: no-cache");
			header("Cache-Control: public max-age=" . 60 * 60 * 24 * 7 * 2);
			header("Expires: ".gmdate('r', strtotime('+2 weeks'))." GMT"); 
			
			print file_get_contents($image->location);
			break;
		}
	}
	
	// Send the output buffer
	ob_end_flush();
	
	// still has a bit of extra overhead for the webservice call and redirect... Much better than dynamic resizing though!
	
?>