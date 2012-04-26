<?php 

require_once ('include/mysql_connection.php');

if(isset($_GET["query"])) {
	$q = $_GET["query"];
}

$sql = "SELECT interest, COUNT(*)
		FROM interest_table
		WHERE interest Like '%".$q."%'
		GROUP BY interest
		ORDER BY interest" ;
		
		
$result = mysql_query($sql);

$matches = array();

while($row = mysql_fetch_array($result)) {
	//echo $row["interest"]."</br>";
  	array_push($matches,$row["interest"]);
}
$options = (object) array('query' => $q, 'suggestions' => $matches ,'data' => $matches);

echo json_encode($options);

?>