<?php

// load Smarty library
require('Smarty.class.php');
require_once('backend/global_include.php');
API::Authenticate();

$smarty = new Smarty;

$smarty->template_dir = 'c:/inetpub/wwwroot/smarty/templates';
$smarty->config_dir = 'c:/inetpub/wwwroot/smarty/config';
$smarty->cache_dir = 'c:/smarty/cache';
$smarty->compile_dir = 'c:/smarty/templates_c';

$venue = API::getVenue(1);
$venueName = $venue->getName();

$smarty->assign('name',$venueName);
$smarty->assign('description','<p style="font-weight: bold;">Cocoon in the Park returns in 2010 for our second spectacular open-air festival, the only one of it\'s kind in the UK.</p>
<p>The festival site is set within the grounds of a 450 year old mansion house in the rolling Yorkshire countryside, an area of outstanding natural beauty surrounded by forests and lakes, playing host to an exclusive lineup over one stage featuring Ricardo Villalobos, Loco Dice, Adam Shelton and headed-up by the Cocoon ringmaster himself, Sven Väth. Expect a breathtaking Cocoon production including dancers, full lighting show, pyrotechnics, Live VJ along with many other extras to top last years event. A custom built PA supplied by Audio-Plus to supply us with their Funktion-One setup.</p>
<p>Join us and thousands of like-minded souls for what promises to be a truly unique and captivating experience.</p>');

$smarty->display('venue.tpl');
?>