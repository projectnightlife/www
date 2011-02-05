<?php
$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";
require_once($globalDir.'backend\\global_include.php');

API::Authenticate();

$id = (isset($_GET['id'])) ? $_GET['id'] : die();
$size = (isset($_GET['size'])) ? $_GET['size'] : '606x450'; // eventually change to photo gallery photo size as default

$imageSvc = API::GetService("image");
$data = $imageSvc->GetPhotoLocations($id);

foreach ($data as $image)
{
  if ($image->size == $size)
  {
   // header('location: '.$image->location);
	header('Content-type: image/jpeg');
	print file_get_contents($image->location);
	break;
  }
}

// still has a bit of extra overhead for the webservice call and redirect... Much better than dynamic resizing though!

?>