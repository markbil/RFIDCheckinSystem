<?php


require_once ('mysql_connection.php');
require_once ('timezone.php');
 
$arr = array();
////VIEW: "view_list_distinctusercheckins_all" = all check-ins and user details, but only the most recent checkin per edge_user is returned
 
$query = "SELECT edge_user_id, firstname, lastname, occupation, statusmessage, MAX(checkin_timestamp) AS checkin_timestamp, months_since_checkin, days_since_checkin, hours_since_checkin, minutes_since_checkin, checkin_sublocation FROM `view_checkins` GROUP BY edge_user_id ORDER BY checkin_timestamp DESC";

//USE this statement to filter particular time-spans...
// //all check-ins and user details within the last x months/days/hours/minutes. only the most recent checkin per edge_user in the given timeperiod is returned
// SELECT edge_user_id, firstname, lastname, occupation, statusmessage, imt_name, im_id, MAX(checkin_timestamp) AS checkin_timestamp, months_since_checkin, days_since_checkin, hours_since_checkin, minutes_since_checkin, checkin_sublocation FROM `view_checkins` WHERE days_since_checkin < 1 GROUP BY edge_user_id ORDER BY checkin_timestamp DESC

// //OTHER POSSIBLE VARIABLES
// months_since_checkin < 7	//checkins in the last 6 months
// days_since_checkin < 1		//only today's checkins
// hours_since_checkin < 3		//checkins in the last 2 hours
// minutes_since_checkin < 11	//checkins in the last 10 minutes

$tmz = mysql_query ("SET time_zone = " . $timezone) or die("mysql error: " . mysql_error());
$rs = mysql_query ($query) or die("mysql error: " . mysql_error()); 


while($obj = mysql_fetch_assoc($rs)) {
		
	$edge_user_id = $obj['edge_user_id'];

	//get expertise list for each user
	$expertise_user_checkedin = "SELECT expertise, level FROM expertise_table et, edge_users_expertises eue WHERE eue.expertise_id = et.id AND eue.edge_users_id = " . $edge_user_id;
	$arr_expertise = array();
	$rs_expertise = mysql_query ($expertise_user_checkedin) or die("mysql error: " . mysql_error());
	while ($get_field = mysql_fetch_object($rs_expertise)){
		
			$arr_expertise[] = ($get_field);
		
	}

	//get interest list for each user
	$interests_user_checkedin = "SELECT interest FROM interest_table it, edge_users_interests eui WHERE it.id = eui.interest_id AND eui.edge_users_id = " . $edge_user_id;
	$arr_interest = array();
	$rs_interest = mysql_query ($interests_user_checkedin) or die("mysql error: " . mysql_error());
	while ($get_field = mysql_fetch_row($rs_interest)){
		foreach ($get_field as $int){
			$arr_interest[] = $int;
		}
	}
	
	
	$obj['expertise'] = $arr_expertise;
	$obj['interests'] = $arr_interest;
	$arr[] = $obj;

}
 

echo json_encode($arr);

?>