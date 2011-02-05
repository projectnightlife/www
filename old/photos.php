<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--[if lte IE 7]><meta http-equiv="X-UA-Compatible" content="IE=7"><![endif]-->
<!--[if IE 8]><meta http-equiv="X-UA-Compatible" content="IE=8"><![endif]-->
<title>Project Nightlife | Halloween Bar Crawl
<?php
$con = mysql_connect("localhost","web","42bdmwc");
        if (!$con)
        {
          die('Could not connect: ' . mysql_error());
        }
        mysql_select_db("barcrawl", $con);

  $sql = "select * from `gallery`";
  $result = mysql_query($sql);
  $existsEvent = true;
    $row = mysql_fetch_array($result, MYSQL_NUM);
	  $gallerySize = $row[1];
	  $noOfPhotos = $row[2];
	  $noOfPages = (int)ceil($noOfPhotos / $gallerySize);
	  $pageArray['noOfPhotos'] = $noOfPhotos;
	  $pageArray['noOfPages'] = $noOfPages;
if (!isset($_GET['photo']) || $_GET['photo'] <= 0 || $_GET['photo'] > $noOfPhotos)
{
  $existsEvent = false;
}
else
{
  $photo = (int)$_GET['photo'];
  if ($photo == 1)
  {
	$previous = $noOfPhotos;
	$next = $photo + 1;
  }
  else if ($photo == $noOfPhotos)
  {
	$next = 1;
    $previous = $photo - 1;
  }
  else
  {
    $next = $photo + 1;
    $previous = $photo - 1;
  }
}
if (!isset($_GET['page']) || $_GET['page'] <= 0)
{
  $currentPage = 1;
}
else
{
  $currentPage = (int)$_GET['page'];
}
?>
</title>
<!-- Framework CSS -->
  <link rel="stylesheet" href="css/blueprint/screen.css" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="css/blueprint/print.css" type="text/css" media="print">
  <!--[if lte IE 7]><link rel="stylesheet" href="css/blueprint/ie.css" type="text/css" media="screen, projection"><![endif]-->
  <link rel="stylesheet" href="css/core.css" type="text/css" media="screen, projection">
  <link rel="stylesheet" href="css/index.css" type="text/css" media="screen, projection">

  <style>
    h1 a { color: #777; text-decoration: none }
	h1 a:hover { color: #aaa; text-decoration: none }
	h1 a:selected { color: #777; text-decoration: none }
	h1 a:focus { color: #777; text-decoration: none }
    a { color:#fff; text-decoration: none; }
	a:hover { color: #aaa; }
	a.selected { color: #aaa; }
	a:focus { outline: none; }
    a img.photo { border: #222 solid 1px; }
	a:hover img.photo { border: #666 solid 1px; }
	a.selected img.photo { border: #666 solid 1px; }
	a:focus img.photo { border: #666 solid 1px; }
  </style>
  <!--[if lte IE 6]><script>upgradeBrowser();</script><![endif]-->
</head>

<body id="index">
  <div class="wrapper">
  <div class="header">
  <ul class="mainnav left">
    <li id="nav-home"><a href="index.php"><img src="images/core/header/logo.png" height="33" width="101" alt="home" /><span>home</span></a></li>
    <li id="nav-venues"><a href="photos.php">View Bar Crawl Photos</a></li>
  </ul>
  <div id="mainsearch" class="right"><input type="text" /></div>
  <ul class="mainnav right">
    <li id="nav-register"><a  ajaxify="1" href="index.php">Register</a></li>
    <li id="nav-login"><a id="fblogin" ajaxify="1" href="index.php">Login</a></li>
  </ul>
  </div>
  
  <div class="container">
      
      <div style="margin: 15px 0 0; overflow: auto;">
        <div style="overflow: auto;"><h1 style="margin-bottom: 8px; line-height: 1.0; font-size: 2em; color: #777 !important; float: left;">Halloween Bar Crawl Photos</h1>
        <h1 style="margin-bottom: 8px; line-height: 1.0; font-size: 2em; color: #777 !important; float: right;"><fb:name uid="loggedinuser" useyou="false" linked="true"></fb:name></h1>
        <hr style="margin-bottom: 0px; background: #777;" />
      </div>
        
      <div class="canvas" style="margin-top: 15px !important;">
      
        <?php
  if ($currentPage > $pageArray['noOfPages'])
  {
    $currentPage = $pageArray['noOfPages'];
  } // if
  $firstPhotoNo = (int)($currentPage * $gallerySize) - ($gallerySize - 1);
  ?>



      <?php
  $leftToInsert = (int)($pageArray['noOfPhotos'] - (($currentPage - 1) * $gallerySize));
  echo '<div style="width: 900px; margin: 10px auto 0; overflow: auto;">';
  if ($currentPage == 1) {
    echo '<a href="photos.php?page='.($currentPage + 1).'"><div style="float: right; padding-right: 15px;">Next</div></a>';
  }
  else if ($currentPage == $pageArray['noOfPages']) {
	echo '<a href="photos.php?page='.($currentPage - 1).'"><div style="float: right; padding-right: 15px;">Previous</div></a>';
  }
  else {
	echo '<a href="photos.php?page='.($currentPage + 1).'"><div style="float: right; padding-right: 15px;">Next</div></a>';
	echo '<a href="photos.php?page='.($currentPage - 1).'"><div style="float: right; padding-right: 5px;">Previous</div></a>';
  }
  echo '</div>';
  echo '<div style="overflow: auto; margin: 0 auto; width: 890px;">';
  echo "<div>";
  for ($i = 0; $i < 4; $i++)
  {
    if ($leftToInsert > 0)
	{
	  $photoNum = "";
	  if (($firstPhotoNo + $i) < 10)
	  { $photoNum = "00".($firstPhotoNo + $i);}
	  else if (($firstPhotoNo + $i) < 100) 
	  { $photoNum = "0".($firstPhotoNo + $i); }
	  else 
	  { $photoNum = "".($firstPhotoNo + $i); }
	  $imageSize = getimagesize('barcrawl/thumbs/'.$photoNum.'.jpg');
      $ratio = (int)$imageSize[0] / $imageSize[1];
	  if ($ratio > 1)
	  { // then image is landscape
	    if ((int)$imageSize[0] == 200)
		{
          echo '<a href="photo.php?photo='.($firstPhotoNo + $i).'" title="View Photo"><img style="padding: 5px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
		else
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + $i).'" title="View Photo"><img style="padding: 5px 16px 5px 17px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
	  }
	  else
	  {
		if ((int)$imageSize[0] == 89)
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + $i).'" title="View Photo"><img style="padding: 5px 60px 5px 61px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
		else
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + $i).'" title="View Photo"><img style="padding: 5px 55px 5px 55px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
	  }
      $leftToInsert--;
	} // if
  } // for
  echo "</div>";
  echo "<div>";
  for ($i = 0; $i < 4; $i++)
  {
    if ($leftToInsert > 0)
	{
	  $photoNum = "";
	  if (($firstPhotoNo + 4 + $i) < 10) { $photoNum = "00".($firstPhotoNo + 4 + $i); }
	  else if (($firstPhotoNo + 4 + $i) < 100) { $photoNum = "0".($firstPhotoNo + 4 + $i); }
	  else { $photoNum = "".($firstPhotoNo + 4 + $i); }
       $imageSize = getimagesize('barcrawl/thumbs/'.$photoNum.'.jpg');
      $ratio = (int)$imageSize[0] / $imageSize[1];
	  if ($ratio > 1)
	  { // then image is landscape
        if ((int)$imageSize[0] == 200)
		{
          echo '<a href="photo.php?photo='.($firstPhotoNo + 4 + $i).'" title="View Photo"><img style="padding: 5px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
		else
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + 4 + $i).'" title="View Photo"><img style="padding: 5px 16px 5px 17px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
	  }
	  else
	  {
		if ((int)$imageSize[0] == 89)
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + 4 + $i).'" title="View Photo"><img style="padding: 5px 60px 5px 61px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
		else
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + 4 + $i).'" title="View Photo"><img style="padding: 5px 55px 5px 55px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
	  }
      $leftToInsert--;
	} // if
  } // for
  echo "</div>";
  echo "<div>";
  for ($i = 0; $i < 4; $i++)
  {
    if ($leftToInsert > 0)
	{
	  $photoNum = "";
	  if (($firstPhotoNo + 8 + $i) < 10) { $photoNum = "00".($firstPhotoNo + 8 + $i); }
	  else if (($firstPhotoNo + 8 + $i) < 100) { $photoNum = "0".($firstPhotoNo + 8 + $i); }
	  else { $photoNum = "".($firstPhotoNo + 8 + $i); }
       $imageSize = getimagesize('barcrawl/thumbs/'.$photoNum.'.jpg');
      $ratio = (int)$imageSize[0] / $imageSize[1];
	  if ($ratio > 1)
	  { // then image is landscape
        if ((int)$imageSize[0] == 200)
		{
          echo '<a href="photo.php?photo='.($firstPhotoNo + 8 + $i).'" title="View Photo"><img style="padding: 5px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
		else
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + 8 + $i).'" title="View Photo"><img style="padding: 5px 16px 5px 17px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
	  }
	  else
	  {
		if ((int)$imageSize[0] == 89)
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + 8 + $i).'" title="View Photo"><img style="padding: 5px 60px 5px 61px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
		else
		{
		  echo '<a href="photo.php?photo='.($firstPhotoNo + 8 + $i).'" title="View Photo"><img style="padding: 5px 55px 5px 55px; margin: 5px; float: left; overflow: auto;" class="photo" src="barcrawl/thumbs/'.$photoNum.'.jpg"></a>';
		}
	  }
      $leftToInsert--;
	} // if
  } // for
  echo "</div>";
  echo "</div>";
  ?>
  
  <div style="color: #aaa; width: 900px; margin: 10px auto; text-align: center;"> 
      <?php 
  echo 'Page:&nbsp;&nbsp;&nbsp;';
  for ($i = 1; $i <= $pageArray['noOfPages']; $i++)
  {
    if ($i == $currentPage)
	{
	  echo '<u>'.$i.'</u>&nbsp;&nbsp;&nbsp;';
	} // if
	else
	{
      echo '<a href="photos.php?page='.$i.'" title="page '.$i.'">'.$i.'</a>&nbsp;&nbsp;&nbsp;';
	} // else
  } // for
  ?>
    </div>
        
        
        </div>
      </div>
    </div>
    <div class="push"></div>
  </div>

  <div class="footer">
    <div id="stamp">
      <img src="images/core/footerlogo.png" width="180" height="35" alt="Project Nightlife" />
      <p>Project Nightlife is not responsible for the content of external websites</p>
      <p>Copyright &copy; 2010</p>
    </div>
    <div id="columns">
      <div id="company-column"class="column">
        <span>The Company</span>
        <ul>
          <li>About us</li>
          <li>Partners</li>
          <li>Work with us</li>
          <li>Contact us</li>
        </ul>
      </div>
      <div id="opportunities-column" class="column">
        <span>Opportunities</span>
        <ul>
          <li>Advertising</li>
          <li>Industry</li>
          <li>Photographers</li>
          <li>Bloggers</li>
        </ul>
      </div>
      <div id="feature-column" class="column">
        <span>Feature</span>
        <ul>
          <li>Venues</li>
          <li>Promoters</li>
          <li>Festivals</li>
          <li>Artists</li>
        </ul>
      </div>
    </div>
  </div>
<div id="fb-root"></div>
</body>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE">
</head>
</html>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/cycle.js"></script>
<script type="text/javascript" src="js/corners.js"></script>
<script type="text/javascript" src="js/api.js"></script>
<!--[if lte IE 6]><script>api.upgradeBrowser();</script><![endif]-->