<?php
header('Cache-Control: max-age=1209600 public');
header("Expires: ".gmdate('r', strtotime('+2 weeks'))." GMT"); 
header('Content-type: image/jpeg');
$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'backend\\global_include.php');

API::Authenticate();

$id = (isset($_GET['id'])) ? $_GET['id'] : die();
$size = (isset($_GET['size'])) ? $_GET['size'] : '606x450'; // eventually change to photo gallery photo size as default

$imageSvc = API::GetService("image");
$data = $imageSvc->GetPhotoLocations($id);

$foundImage = false;

foreach ($data as $image)
{
  if ($image->size == $size)
  {
   // header('location: '.$image->location);
	print file_get_contents($image->location);
	$foundImage = true;
	break;
  }
}

if (!$foundImage)
{
	$imageSize;
	switch ($size)
	{
		case '50x50'   : $imageSize = 6;
						 break;
		case '80x80'   : $imageSize = 1;
						 break;
		case '160x120' : $imageSize = 1;
						 break;
		case '200x600' : $imageSize = 5;
						 break;
		case '608x312' : $imageSize = 5;
						 break;
		case '606x450' : $imageSize = 5;
						 break;
		default		   : $imageSize = 6;
						 break;
	}
	print file_get_contents('http://photos.projectnightlife.co.uk/1_'.$imageSize.'.jpg');
}

// still has a bit of extra overhead for the webservice call and redirect... Much better than dynamic resizing though!

// Just to make sure that Git doesn't overwrite this with a bodged copy...
?>