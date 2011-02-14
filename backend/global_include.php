<?php
//remeber this will be called in context of pages... so paths start from root

$globalDir = "c:\\inetpub\\wwwroot\\www.projectnightlife.co.uk\\";

include_once($globalDir."backend\\Credentials.php");
include_once($globalDir."backend\\FacebookAuth.php");
include_once($globalDir."backend\\WebService.php");
include_once($globalDir."backend\\api.php");
include_once($globalDir."backend\\facebook.php");
include_once($globalDir."backend\\notification.php");
include_once($globalDir."backend\\ResourceDependancyManager.php");


?>