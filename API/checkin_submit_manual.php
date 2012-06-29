<?php

require_once ('mysql_connection.php');
include '../ThirdPartyServices/twitter/tweet.php';
include '../ThirdPartyServices/facebook/checkin.php';

$dateTime = new DateTime("now", new DateTimeZone('Australia/Brisbane'));

$mainlocation = 99; // 99 = The Edge;
$sublocation = $_GET["sublocation"];
$checkintime = $dateTime->format("Y-m-d H:i:s");
$im_type = $_GET["im_type"]; // 1 = RFID
$im_thirdpartyid = $_GET["thirdpartyid"]; // unique RFID number

$sql_get_im_id = "SELECT id FROM identification_media im WHERE im.thirdpartyid = '".$im_thirdpartyid."' AND im.type = " . $im_type;

	if(($_GET["thirdpartyid"] != "") && ($_GET["im_type"] != "")) {
		$query = 'INSERT INTO check_in (MainLocation, SubLocation, Check_In_Time, identification_media_id) VALUES (\''.$mainlocation.'\', \''.$sublocation.'\', \''.$checkintime.'\',('.$sql_get_im_id.'))';
		
		echo $query;
		echo "</br>";
		echo "</br>";
		//*** mysql error text between the three stars will be displayed to the user in the processing sketch *** 
		$result = @mysql_query ($query) or die("***FAIL***  +++RFID card is not assigend to a user yet. Please visit a staff member at the counter...+++  " . mysql_error());
		//echo $result;
		$insertid = mysql_insert_id();
		
		echo "***SUCCESS***" . "     mysql insert-id: " . $insertid;
		echo "</br>";
		echo "</br>";
		
			//get the firstname, lastname, time, etc of the user who just checked in...
			$query2 = "SELECT eu.id AS edge_user_id, eu.firstname, eu.lastname, imt.name AS imt_name, im.ThirdPartyID AS im_id, check_in.check_in_time AS checkin_timestamp, check_in.sublocation AS checkin_sublocation FROM ((((identification_media im JOIN identification_media_type imt ON im.type = imt.id) JOIN people ON people.identification_id = im.id) JOIN edge_users eu ON eu.id = people.edge_users_id) JOIN check_in ON check_in.identification_media_id = im.id) WHERE check_in.checkinid=" . $insertid;
		
			echo $query2;
			echo "</br>";
			echo "</br>";
			//*** mysql error text between the three stars will be displayed to the user in the processing sketch ***
			$result2 = @mysql_query ($query2) or die("***Checkin could not be found***  " . mysql_error());
			
			$firstName = "";
			while($row = mysql_fetch_array($result2))
			{
				//data to be read by the processing script wrappen in +++ and +++
				echo "+++" . $row['firstname'] . "+++";
				echo "<br />";
				$firstName = $row['firstname'];
			}
				
			//echo "***Check-in successful!***";
			
			// // Do facebook checkin if applicable
			// if ((user enabled fb checkins) && (main location) && (lastCheckin > 2 hours))
			// {
				// $userFBID = 591180375;	// *** REPLACE THIS WITH ACTUAL FROM DATABASE **
				// $access_token = 'AAAFr3VOHe7ABAB9nU6ZBW08IBOWIMC3uzZCBrLUZCYZBpTQfqjNU4zX3eg000ik9C6tNy1KDtqT7OPG30ZClCyZAKtZCimu9w6lmfoQoeZCxngZDZD';
				// $message = "I'm checked in at The Edge!";
				// $appSecret = 'eee0ee4645517e0232ff9ea4a888cc62';
				// postCheckinToFacebook($appSecret,$userFBID,$access_token,$message,true);
			// }
			
			// // Do Twitter post about checkin if applicable
			// if ((user enabled twitter checkins) && (main location) && (lastCheckin > 2 hours))
			// {
				
			// }
			
			// Do coffee machine tweeting if applicable
			if (($sublocation == 16) && (!firstName.equals("")))
			{
				// Mention the visitor by first name or twitter handle if they've provided it
				$twitterHandle = "";	// *** REPLACE THIS WITH ACTUAL FROM DATABASE **
				$nameToUse = $firstName;
				if (!$twitterHandle.equals(""))
					$nameToUse = "@" . $twitterHandle;
					
				// Randomly generate a tweet with a mention to The Edge at the end
				$random = rand(1,5);
				$tweet = "";
				switch ($random)
				{
					case 1: $tweet = $nameToUse . "... prepare for death by coffee! @SLQedge";
						break;
					case 2: $tweet = "Enjoy your coffee " . $nameToUse . "! @SLQedge";
						break;
					case 3: $tweet = "Can't tweet, busy making awesome coffee for " . $nameToUse . " @SLQedge";
						break;
					case 4: $tweet = "Sweet delicious coffee coming " . $nameToUse . "'s way! @SLQedge";
						break;
					case 5: $tweet = "Brewing... brewing... brewing... @SLQedge";
						break;
				}
				
				// Sent the tweet from the coffee machine account
				tweetFromCoffeeMachine($tweet);
			}
		
	} else{
		echo "one or more ID parameters not set! </br>
		Checkin call must have following format: .../checkin_submit_manual.php?im_type=x&thirdpartyid=xxxxx&sublocation=yyy";
	}


mysql_close($dbc);	
	

?>