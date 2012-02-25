<?php 

require_once ('include/include/mysql_connection.php');

if(isset($_GET["query"])) {
	$q = $_GET["query"];
}

$sql = "SELECT expertise, COUNT(*)
		FROM expertise_table
		WHERE expertise Like '%".$q."%'
		GROUP BY expertise
		ORDER BY expertise" ;
		
		
$result = mysql_query($sql);

$matches = array();

while($row = mysql_fetch_array($result)) {
	//echo $row["interest"]."</br>";
  	array_push($matches,$row["expertise"]);
}
$options = (object) array('query' => $q, 'suggestions' => $matches ,'data' => $matches);

echo json_encode($options);

?>