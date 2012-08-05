
<?php
 
$urlbase = "http://localhost/RFIDCheckinSystem/";
//$urlbase = "http://theedge.checkinsystem.net/";
//$urlbase = "http://meetmee.javaprovider.net/php/RFIDCheckinSystem/API/"
//$urlbase = "http://meetmee.javaprovider.net/php/TheEdge_VisitorProfiles/API/";
?>
<html>
	<head>
		<meta http -equiv="Content-Type" content="text/html; charset=utf-8" />

		<!-- Screen -->
		<link rel="StyleSheet" href="<?php echo $urlbase ?>userprofile/include/css/clear.css" type="text/css" />
		<link rel="StyleSheet" href="<?php echo $urlbase ?>userprofile/include/css/screen.css" type="text/css" />

		<!-- Mobile -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=yes" />

		<!--<link rel="stylesheet" type="text/css" media="only screen and (max-width: 570px), only screen and (max-device-width: 570px)" href="<?php echo $urlbase ?>userprofile/include/css/antiscreen.css" />
		<link rel="stylesheet" type="text/css" media="handheld, only screen and (max-width: 570px), only screen and (max-device-width: 570px)" href="<?php echo $urlbase ?>userprofile/include/css/clear.css" />-->
		<link rel="stylesheet" type="text/css" media="handheld, only screen and (max-width: 570px), only screen and (max-device-width: 570px)" href="<?php echo $urlbase ?>userprofile/include/css/handheld.css" />
		<!--[if IEMobile]>
			<link rel="stylesheet" type="text/css" media="screen" href="<?php echo $urlbase ?>userprofile/include/css/handheld.css" />
		<![endif]-->
		
	<!--  Jquery UI Style -->
	<link rel="StyleSheet" href="<?php echo $urlbase ?>userprofile/include/css/ui-lightness/jquery-ui-1.8.21.custom.css" type="text/css" />
		
		
		<title>The Edge RFID Checkin</title>

		<script type="text/javascript" src="<?php echo $urlbase ?>userprofile/include/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="<?php echo $urlbase ?>userprofile/include/js/jquery-ui-1.8.21.custom.min.js"></script>
		<script type="text/javascript" src="<?php echo $urlbase ?>userprofile/include/js/rfid_edge_common.js"></script>
	</head>
		<body>
			<a id="logo" class="center" href="http://edgeqld.org.au"><h1>The Edge Checkin System</h1></a>

			<div id="content" class="center">
				<div class="content-inner center">

					<h1>Checkin System Landing Page</h1>
					<p>This is The Edge's Checkin System homepage</p>
					<br/>

					<p><a href="<?php echo $urlbase ?>userprofile/index.php">Login Page</a></p><br />
					<p><a href="<?php echo $urlbase ?>API/index.php">Backend API</a></p>

				</div>
			</div>

		<div id="footer" class="center">
			<strong>&copy; The Edge 2012</strong>
		</div>
	</body>
</html>
