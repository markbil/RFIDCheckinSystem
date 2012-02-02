<?php

require_once ('mysql_connection.php');

$query = 'insert into edge_users (swipe_id, username, password) values ("'.$_POST["swipe"].'","'.$_POST["name"].'","'.$_POST["password"].'")';
//echo $query;
$result = @mysql_query ($query);// or die(mysql_error());

if ($result ^= '1') 
	echo "There has been an error: " . mysql_error();
else 
	header("Location: login.php");

?>