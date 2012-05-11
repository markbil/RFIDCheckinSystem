<?php


require_once ('mysql_connection.php');
require_once ('timezone.php');
 
$arr = array();

$query = "SELECT DATE(checkin_timestamp) AS checkin_date, HOUR(checkin_timestamp) AS hour, (CEILING(MINUTE(checkin_timestamp) / 14.99)) AS quarterofhour, COUNT(DISTINCT edge_user_id) AS distinct_usercheckins FROM view_checkins GROUP BY checkin_date, hour, quarterofhour ORDER BY checkin_date DESC, hour DESC, quarterofhour DESC";

$tmz = mysql_query ("SET time_zone = " . $timezone) or die("mysql error: " . mysql_error());
$rs = mysql_query ($query) or die("mysql error: " . mysql_error()); 


while($obj = mysql_fetch_assoc($rs)) {
		
	$arr[] = $obj;

}
 

echo json_encode($arr);

?>
