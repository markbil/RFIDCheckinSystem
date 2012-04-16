<?php


require_once ('../edge_signup/include/mysql_connection.php');

 
$arr = array();

$query = "SELECT edge_user_id, firstname, lastname, thisyear, distinct_checkindays FROM view_highscorelist_distinctusercheckinsperday_thisyear";


$rs = mysql_query ($query) or die("mysql error: " . mysql_error()); 


while($obj = mysql_fetch_assoc($rs)) {
		
	$arr[] = $obj;

}
 

echo json_encode($arr);

?>