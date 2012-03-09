<?php

require_once ('edge_signup/include/mysql_connection.php');


$dateTime = new DateTime("now", new DateTimeZone('Australia/Brisbane'));

$mainlocation = 'The Edge';
$sublocation = $_GET["sublocation"];
$checkintime = $dateTime->format("Y-m-d H:i:s");
$im_type = 1; // 1 = RFID
$im_thirdpartyid = $_GET["thirdpartyid"]; // unique RFID number

$sql_get_im_id = "SELECT id FROM identification_media im WHERE im.thirdpartyid = ".$im_thirdpartyid." AND im.type = " . $im_type;

if($_GET["thirdpartyid"] != "") {
	$query = 'INSERT INTO check_in (MainLocation, SubLocation, Check_In_Time, identification_media_id) VALUES (\''.$mainlocation.'\', \''.$sublocation.'\', \''.$checkintime.'\',('.$sql_get_im_id.'))';
	
	echo $query;
	echo "</br>";
	echo "</br>";
	$result = @mysql_query ($query) or die(mysql_error());
	//echo $result;
	
	echo "MySQL INSERT successful!";
	
} else
{
	echo "RFID parameter not set! </br>
	
	Checkin call must have following format: .../checkin_submit_manual.php?rfid=xxx&sublocation=yyy";
	
	}


mysql_close($dbc);	
	

?>