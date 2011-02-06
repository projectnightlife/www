<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>

<?php 
$text = 'Unsurprisingly that February\'s Most Popular is Tek One! With a huge following, these boys tunes are in demand and with a release coming out on HENCH later this month we hope many represses will follow!\n\nRighty hibidy hoo! We finally got some Tek One on the Squitty Bubbler Blog, and with a rancid free tune for all you straw sucking meat mongers out there!\n\nWe first heard about Tek One on the mighty Hush House Blog, since then we’ve been picking up on all that these two boys are up to! With their unique live sets, they sure have a lot of beef in their trolley!\n\nComa is one sick ass mo fo. We gave one of his tracks a listen the other day and had to be taken to the emergency room with extreme popped earitis. We fucking love the sound coming from this guy! Coma has been in the business for some time now and has mastered and seeks inspiration from many a genre of music, spanning from House to Reggae, Jazz to Drum and Bass, Hip Hop, Breakbeats and beyond this chap has it all. Underneath you will find the two stunners we have for you today, two absolute sickening tracks, play em loud, play em proud!Enjoy!\n\n www.projectnightlife.co.uk.';
$text = preg_replace("(([A-Za-z]{3,9})://)?([-;:&=\+\$,\w]+@{1})?(([-A-Za-z0-9]+\.)+[A-Za-z]{2,3})(:\d+)?((/[-\+~%/\.\w]+)?/?([&?][-\+=&;%@\.\w]+)?(#[\w]+)?)?", "'<a href=\"http://$3\" target=\"_blank\">$3</a>$4'", $text);
echo $text;
?>
</body>
</html>
