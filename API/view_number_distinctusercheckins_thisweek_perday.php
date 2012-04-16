<?php


require_once ('../edge_signup/include/mysql_connection.php');

 
$arr = array();

$query = "SELECT weekday_index, weekday_name, date, distinct_usercheckins FROM view_number_distinctusercheckins_thisweek_perday";


$rs = mysql_query ($query) or die("mysql error: " . mysql_error()); 


while($obj = mysql_fetch_assoc($rs)) {
		
	$arr[] = $obj;

}
 

echo json_encode($arr);

?>