<?php


require_once ('../userprofile/include/mysql_connection.php');

 
$arr = array();
//VIEW: "view_number_distinctusercheckins_perhour" = returns hours of a day and number of checkins that distinct users have checkin at at that our
$query = "SELECT hour, distinct_usercheckins FROM view_number_distinctusercheckins_perhour";


$rs = mysql_query ($query) or die("mysql error: " . mysql_error()); 


while($obj = mysql_fetch_assoc($rs)) {
		
	$arr[] = $obj;

}
 

echo json_encode($arr);

?>
