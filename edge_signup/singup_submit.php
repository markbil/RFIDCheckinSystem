<?php

require_once ('mysql_connection.php');

if (empty($_POST["swipe"]) || empty($_POST["name"]) || empty($_POST["password"])) {
	header("Location: signup.php?fail=true");
	return;
}

// Add in ID Media to database
$query = 'INSERT INTO identification_media (ID, ThirdPartyID, Type) values ("","'.
																								$_POST["swipe"].'",1)';
$result = mysql_query ($query);
if (!$result) {
	die('Invalid query INSERT INTO identification_media: ' . mysql_error());
}

// Get the ID of the identification_media table
$query = 'SELECT MAX(ID) FROM identification_media';
$result = mysql_query ($query);
if (!$result) {
	die('Invalid query: SELECT MAX(ID)' . mysql_error());
}
$idMediaID = mysql_fetch_row($result);
$idMediaID = $idMediaID[0];

// Insert Person's Details into 'edge_users'
$query = 'INSERT INTO edge_users (ID, username, password) values ("", "'.
	$_POST["name"].'","'.$_POST["password"].'")';
$result = mysql_query ($query);
if (!$result) {
	die('Invalid query:INSERT INTO edge_users ' . mysql_error());
}

// Get the ID of the 'edge_users' table
$query = 'SELECT MAX(ID) FROM edge_users';
$result = mysql_query ($query);
if (!$result) {
	die('Invalid query: SELECT MAX(ID)' . mysql_error());
}
$idEdgeUser = mysql_fetch_row($result);
$idEdgeUser = $idEdgeUser[0];

// Insert ID Media and Person's Details into 'people' table
$query = 'INSERT INTO people (ID, edge_users_id, Identification_id) values ("",'.
	$idEdgeUser . ',' .$idMediaID.')';
$result = mysql_query ($query);
if (!$result) {
	die('Invalid query: INSERT INTO people' . mysql_error());
}

// Let's check the details
/* $query = 'SELECT * FROM people';
$result = mysql_query ($query);
if (!$result) {
	die('Invalid query: SELECT * FROM' . mysql_error());
}

while ($row = mysql_fetch_assoc($result)) {
    echo "PersonID[" . $row['edge_users_ID'] . "]\n";
    echo "CheckinID[" . $row['Identification_idIdentification']. "]\n";
}
 */
header("Location: login.php");

?>