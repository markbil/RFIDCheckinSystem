<?php
require_once ('mysql_connection.php');

function getProjectsList($project_id=null) {
	/*
	 * $project_detail format
	 * id => {
	 * 				name,
	 * 				description
	 * 			}
	 */
	$project_detail=array();
	
	$query = 'SELECT ID,name, description FROM projects';
	if (!empty($project_id)) {
		$query = 'SELECT ID,name, description FROM projects WHERE ID=' . $project_id;
	}
	
	$result = mysql_query ($query);
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}
	
	
	while ($row = mysql_fetch_assoc($result)) {
		$project_detail[$row['ID']] = array('name'=>$row['name'], 'description'=>$row['description']);
	}
	
	return $project_detail;
}

function getProjectsUsers($project_id) {
	/*
	 * $user_listing format
	 * id => {
	 * 				name,
	 * 				description
	 * 			}
	 */
	$user_listing=array();
	
	//$query = 'SELECT ID,name, description FROM projects WHERE ID=' . $project_id;
	$query = 'SELECT edge_users.ID AS ID, username, firstname, lastname ' .
							'FROM edge_users '.
							'INNER JOIN projects_edge_users ON edge_users.ID = edge_users_id '.
							'WHERE project_id=' . $project_id;
	if (empty($project_id)) return array();
	
	$result = mysql_query ($query);
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}
	
	while ($row = mysql_fetch_assoc($result)) {
		$user_listing[$row['ID']] = array('name'=>$row['username'], 
																		'firstname'=>$row['firstname'],
																		'lastname'=>$row['lastname'],
		);
	}
	
	return $user_listing;
}

function getUsersList($user_id=null) {
	/*
	 * $user_detail format
	* id => {
	* 				username,
	* 				firstname,
	* 				lastname,
	* 				email
	* 			}
	*/
	$user_detail =array();

	$query = 'SELECT ID,username, firstname,lastname,email FROM edge_users';
	if (!empty($user_id)) {
		$query = 'SELECT ID,username, firstname,lastname,email FROM edge_users WHERE ID=' . $user_id;
	}
	$result = mysql_query ($query);
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}

	while ($row = mysql_fetch_assoc($result)) {
		$user_detail[$row['ID']] = array('username'=>$row['username'],
																	'firstname'=>$row['firstname'],
																	'lastname'=>$row['lastname'],
																	'email'=>$row['email'],
		);
	}

	return $user_detail;
}

/*
 * Handle AJAX POSTS
 */
	

if(!$dbc) {
	// Show error if we cannot connect.
	echo 'ERROR: Could not connect to the database.';
} else {
	// Is there a posted query string?
	if(isset($_POST['queryString'])) {
		$queryString = mysql_real_escape_string($_POST['queryString']);
			
		// Is the string length greater than 0?
		if(strlen($queryString) >0) {
			$query = 'SELECT edge_users_id FROM projects_edge_users WHERE project_id ='.$queryString;
			$result = mysql_query ($query);
			if ($result) {
				while ($row = mysql_fetch_assoc($result)) {
					echo '<li onClick="fill(\''.$row['edge_users_id'].'\');">'.$row['edge_users_id'] .'</li>';
				}
			} else {
				echo 'ERROR: There was a problem with the query.';
			}
		} else {
			// Dont do anything.
		} // There is a queryString.
	} else {
		echo 'There should be no direct access to this script!';
	}
}