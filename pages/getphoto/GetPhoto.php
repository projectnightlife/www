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
	
	// Set the caching headers
	header('Cache-Control: max-age=604800 must-revalidate');
	header("Expires: ".gmdate('r', strtotime('+1 week'))." GMT"); 
	
	// Global include
	$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
	require_once($globalDir.'backend\\global_include.php');
	
	// API Auth
	API::Authenticate();
	
	// ID and sizes
	$id		= (isset($_GET['id'])) ? $_GET['id'] : false;
	$size	= (isset($_GET['size'])) ? $_GET['size'] : '606x450'; // eventually change to photo gallery photo size as default
	
	if ($id == false) { 
		die(); 
	}
	
	$imageSvc = API::GetService("image");
	$data = $imageSvc->GetPhotoLocations($id);
	
	echo "<pre>"; print_r($data); echo "</pre>"; 
	
	foreach ($data as $image) {
		if ($image->size == $size) {
			// header('location: '.$image->location);
			header('Content-type: image/jpeg');
			print file_get_contents($image->location);
			break;
		}
	}
	
	ob_end_flush();
	
	// still has a bit of extra overhead for the webservice call and redirect... Much better than dynamic resizing though!
	
?>