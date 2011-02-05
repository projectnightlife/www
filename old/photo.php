<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="CACHE-CONTROL" content="NO-CACHE">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--[if lte IE 7]><meta http-equiv="X-UA-Compatible" content="IE=7"><![endif]-->
<!--[if IE 8]><meta http-equiv="X-UA-Compatible" content="IE=8"><![endif]-->
<title>Project Nightlife | Photos
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
  </style>
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
  if ($existsEvent)
  { 
    $photoNum = "";
	  if ($photo < 10) { $photoNum = "00".$photo; }
	  else if ($photo < 100) { $photoNum = "0".$photo; }
	  else { $photoNum = "".$photo; }
      $imageSize = getimagesize('barcrawl/'.$photoNum.'.jpg');
    $ratio = (int)$imageSize[0] / $imageSize[1];
	$fromPage = (int)ceil($photo / $gallerySize);
	if ($ratio > 1)
	{ // then image is landscape
      ?>
    <div style="margin: 10px auto; width: 750px; height: 520px;">
    <div style="overflow: auto;">
    <div style="float: left; overflow: auto; padding-left: 5px; padding-bottom: 2px;"><a href="<?php echo "photos.php?page=".$fromPage; ?>">Back to photos</a></div>
    <div style="float: right; overflow: auto; padding-right: 5px; padding-bottom: 2px;"><a href="<?php echo "photo.php?photo=".$next; ?>">Next</a></div>
    <div style="float: right; overflow: auto; padding-right: 10px; padding-bottom: 2px;"><a href="<?php echo "photo.php?photo=".$previous; ?>">Previous</a></div>
    </div>
    <div style="background: #060606;">  
    <?php 
    if ((int)$imageSize[0] == 750)
    {
      echo '<div style="margin: 0 auto; width: 750px; height: 500px;">';
    }
    else
    {
      echo '<div style="margin: 0 auto; width: 667px; height: 500px;">';
    }
	echo '<a href="photo.php?photo='.$next.'" title="next"><img src="barcrawl/'.$photoNum.'.jpg"></a>';
	?>
    </div>
    </div>
    </div>
    <?php
	}// if
	else
	{ // image is portrait
	  ?>
    <div style="margin: 10px auto; width: 750px; height: 520px;">
    <div style="overflow: auto;">
    <div style="float: left; overflow: auto; padding-left: 5px; padding-bottom: 2px;"><a href="<?php echo "photos.php?page=".$fromPage; ?>">Back to photos</a></div>
    <div style="float: right; overflow: auto; padding-right: 5px; padding-bottom: 2px;"><a href="<?php echo "photo.php?photo=".$next; ?>">Next</a></div>
    <div style="float: right; overflow: auto; padding-right: 10px; padding-bottom: 2px;"><a href="<?php echo "photo.php?photo=".$previous; ?>">Previous</a></div>
    </div>
    <div style="background: #060606;">
    <?php 
    if ((int)$imageSize[0] == 333)
    {
      echo '<div style="margin: 0 auto; width: 333px; height: 500px;">';
    }
    else
    {
      echo '<div style="margin: 0 auto; width: 375px; height: 500px;">';
    }
	echo '<a href="photo.php?photo='.$next.'" title="next"><img src="barcrawl/'.$photoNum.'.jpg"></a>';
	?>
    </div>
    </div>
    </div>
    <?php
	} // else
  } // if
  else
  { //render error page ?>
    <div style="margin: 10px auto; width: 750px; height: 520px;">
	  <span style="color: #fff; font-size: 12px; font-weight: normal;">Invalid photo id!</span>
	  <span style="color: #fff; font-size: 12px; font-weight: normal;">The photo you requested does not exist</span>
	</div>
    <span class="back"><a href="javascript: history.go(-1)">Back</a></span> 
    <?php
  } // else
  mysql_close($con);?>
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