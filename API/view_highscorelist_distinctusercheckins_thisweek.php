<?php


require_once ('mysql_connection.php');
require_once ('timezone.php');
 
$arr = array();

$query = "SELECT edge_user_id, firstname, lastname, weekofyear, distinct_checkindays FROM view_highscorelist_distinctusercheckinsperday_thisweek";

$tmz = mysql_query ("SET time_zone = " . $timezone) or die("mysql error: " . mysql_error());
$rs = mysql_query ($query) or die("mysql error: " . mysql_error()); 


while($obj = mysql_fetch_assoc($rs)) {
		
	$arr[] = $obj;

}
 

echo json_encode($arr);

?>