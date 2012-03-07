<?php

require_once ('edge_signup/include/mysql_connection.php');


$dateTime = new DateTime("now", new DateTimeZone('Australia/Brisbane'));

$mainlocation = 'The Edge';
$sublocation = $_GET["sublocation"];
$checkintime = $dateTime->format("Y-m-d H:i:s");
$imt_id = 1; // 1 = RFID
$im_thirdpartyid = $_GET["rfid"]; // unique RFID number



if($_GET["rfid"] != "") {
	$query = 'INSERT INTO check_in (MainLocation, SubLocation, Check_In_Time, identification_media_type_id, identification_media_thirdpartyid) VALUES (\''.$mainlocation.'\', \''.$sublocation.'\', \''.$checkintime.'\','.$imt_id .','.$im_thirdpartyid.')';
	
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