<?php

require_once("backend/global_include.php");

print("<h1>Exported API Functions</h1>");
print("<ul>");

foreach(API::$exportedFunctions as $function => $key)
{
	print("<li>");
	print($function);
	print(" => ");
	print($key);
	print("</li>");
}

print("</ul>");

?>