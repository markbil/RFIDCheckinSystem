<?php

require_once ('mysql_connection.php');


echo print_r($_POST)."</br>";

$swipe_id = $_POST["swipe"];
$username = $_POST["username"];
$firstname = $_POST["firstname"];
$lastname = $_POST["lastname"];
$email = $_POST["email"];

//$update_sql = "UPDATE edge_users SET username = '".$username."' WHERE swipe_id = '".$swipe_id."'";
$update_sql = "UPDATE edge_users SET username = '".$username."', firstname = '".$firstname."', lastname = '".$lastname."', email = '".$email."' WHERE swipe_id = '".$swipe_id."'";




$interest_del_sql = "DELETE FROM interest_table WHERE swipe_id = '".$swipe_id."'";
$expertise_del_sql = "DELETE FROM expertise_table WHERE swipe_id = '".$swipe_id."'";
$questions_del_sql = "DELETE FROM questions_table WHERE swipe_id = '".$swipe_id."'";

$interest_sql = "INSERT INTO interest_table VALUES ";
$expertise_sql = "INSERT INTO expertise_table VALUES ";
$questions_sql = "INSERT INTO questions_table VALUES ";


$nrintr = 0; //number of entered interest keywords
$nrexp = 0; //number of entered expertise keywords
$nrquest = 0; //number of entered questions
foreach ($_POST as $name => $value) {	
	echo $name . " = " . $value ;
	if(substr($name, 0, 3) === "int" && $value != ""){
		$nrintr = $nrintr + 1;
		$interest_sql = $interest_sql . "('".$swipe_id."','".$value."'),";
	}
	else if (substr($name, 0, 3) === "exp" && $value != ""){
		//echo "LOL";
		$nrexp = $nrexp + 1;
		$expertise_sql = $expertise_sql . "('".$swipe_id."','".$value."'),";		
	}
	else if (substr($name, 0, 3) === "que" && $value != ""){
		$nrquest = $nrquest + 1;
		$questions_sql = $questions_sql . "('".$swipe_id."','".$value."'),";
	}
	echo "</br>";
}

$interest_sql = substr($interest_sql,0,strlen($interest_sql)-1);
$expertise_sql = substr($expertise_sql,0,strlen($expertise_sql)-1);
$questions_sql = substr($questions_sql,0,strlen($questions_sql)-1);

if ($nrexp == 0){
	$expertise_sql = "";
}
if ($nrintr == 0){
	$interest_sql = "";
}
if ($nrquest == 0){
	$questions_sql = "";
}

echo $interest_del_sql;
echo "</br>";
echo $expertise_del_sql;
echo "</br>";
echo $questions_del_sql;
echo "</br>";
echo $interest_sql;
echo "</br>";
echo $expertise_sql;
echo "</br>";
echo $questions_sql;


$sql = $update_sql . "; " . $interest_del_sql . "; " .$expertise_del_sql."; ". $questions_del_sql.";".$interest_sql."; ".$expertise_sql.";".$questions_sql.";";
echo "</br>";
echo "</br>";
echo $sql;

echo "</br>";
echo "</br>";


/*/echo $query;
$result = @mysql_query ($sql) or die(mysql_error());

if ($result ^= '1') 
	echo "There has been an error: " . mysql_error();
else 
	echo "Signed Up";*/
	
	$queries = preg_split("/;+(?=([^'|^\\\']*['|\\\'][^'|^\\\']*['|\\\'])*[^'|^\\\']*[^'|^\\\']$)/", $sql); 
foreach ($queries as $query){ 
   if (strlen(trim($query)) > 0) mysql_query($query) or die(mysql_error()); 
} 

echo "Profile Updated";

?>