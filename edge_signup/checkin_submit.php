<?php

require_once ('mysql_connection.php');
$dateTime = new DateTime("now", new DateTimeZone('Australia/Brisbane'));

//$query = 'insert into edge_users values ('.$_POST["swipe"].',"'.$_POST["name"].'","'.$_POST["interests"].'")';
$query = 'UPDATE edge_users SET interests = "'.$_POST["interests"].'" WHERE swipe_id = '.$_POST["swipe"];
//echo $query;
$result = @mysql_query ($query) or die(mysql_error());

$characteristics = array();
if($_POST["interests"] != "") 
	array_push($characteristics,array("name" => $_POST["interests"],"category" => "Interests"));
if($_POST["name"] != "") 
	array_push($characteristics,array("name" => $_POST["name"],"category" => "Name"));
if($_POST["share"] != "") 
	array_push($characteristics,array("name" => $_POST["share"],"category" => "Share"));
if($_POST["doing"] != "") 
	array_push($characteristics,array("name" => $_POST["doing"],"category" => "Doing"));
if($_POST["anything"] != "") 
	array_push($characteristics,array("name" => $_POST["anything"],"category" => "Anything"));


	
	
$checkIn = array(
		'location' => "The Edge",		
		'characteristics' => $characteristics,
		'checkInID' => 0,
		'checkInTime' => $dateTime->format("Y-m-d H:i:s"),
		'person' => array(
			'personID'=> 0 ,
			'thirdPartyIdentifications' => array(array(
				'thirdParty' => 'Swipe Card',
				'thirdPartyID' => $_POST["swipe"]))),
		'method' => 'Swipe Card'
	);
	
$jsonPostString = "checkIns=".urlencode(json_encode(array($checkIn)));
//echo $jsonPostString;


	//set POST variables
	$url = "http://meetmee.javaprovider.net/CheckIn/InsertCheckIns";

	//open connection
	$ch = curl_init();

	//set the url, number of POST vars, POST data
	curl_setopt($ch,CURLOPT_URL,$url);
	curl_setopt($ch,CURLOPT_POST,count(array($checkIn)));
	curl_setopt($ch,CURLOPT_POSTFIELDS,$jsonPostString);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,true);
	//execute post
	$result = curl_exec($ch);


	//close connection
	curl_close($ch);
	
	echo $result;
	
	

?>