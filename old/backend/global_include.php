<?php
//remeber this will be called in context of pages... so paths start from root


include_once("backend/module.php");
include_once("backend/api.php");
include_once("backend/facebook.php");



foreach(new DirectoryIterator("backend/modules") as $file)
{

	//crude but we'll improve it later
	if(!$file->isDot())
	{
		$filename = $file->GetFilename();
		include_once("backend/modules/".$file->GetFilename());

		
		$classname_bits = explode(".", $file->GetFilename());
		$classname = $classname_bits[0];
		 
		//$classname::Init(); 						//Valid in PHP 5.3, but eclipse doesnt like it
		call_user_func($classname."::Init", ""); 	//equivilent call instead

	}
}

?>