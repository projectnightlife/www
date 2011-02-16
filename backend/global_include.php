<?php
//remeber this will be called in context of pages... so paths start from root

$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";

require_once($globalDir."backend\\Credentials.php");
require_once($globalDir."backend\\FacebookAuth.php");
require_once($globalDir."backend\\WebService.php");
require_once($globalDir."backend\\api.php");
require_once($globalDir."backend\\facebook.php");
require_once($globalDir."backend\\notification.php");
require_once($globalDir."backend\\ResourceDependancyManager.php");
require_once($globalDir."backend\\Mobile_Detect.php");

?>