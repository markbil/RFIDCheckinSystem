<?php


require_once ('mysql_connection.php');
require_once ('timezone.php');
 
$arr = array();
//VIEW: "view_number_distinctusercheckins_perhour" = returns hours of a day and number of checkins that distinct users have checkin at at that our
$query = "SELECT dayofmonth_index, weekday_name, date, distinct_usercheckins FROM view_number_distinctusercheckins_thismonth_perday";

$tmz = mysql_query ("SET time_zone = " . $timezone) or die("mysql error: " . mysql_error());
$rs = mysql_query ($query) or die("mysql error: " . mysql_error()); 


while($obj = mysql_fetch_assoc($rs)) {
		
	$arr[] = $obj;

}
 

echo json_encode($arr);

?>