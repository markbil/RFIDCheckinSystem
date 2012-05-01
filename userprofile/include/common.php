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
	
	$query .= ' ORDER BY name';
	
	$result = mysql_query ($query);
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}	
	
	while ($row = mysql_fetch_assoc($result)) {
		$project_detail[$row['ID']] = array('name'=>$row['name'], 'description'=>$row['description']);
	}
	
	return $project_detail;
}

function getProjectName($project_id) {
	if (!empty($project_id)) {
		$query = 'SELECT ID,name, description FROM projects WHERE ID=' . $project_id;
	} else return null;
	
	$result = mysql_query ($query);
	if (!$result) {
		die('Invalid query: ' . mysql_error());
	}
	
	
	$row = mysql_fetch_assoc($result);	
	$project_detail[$row['ID']] = array('name'=>$row['name'], 'description'=>$row['description']);
	
	return $row['name'];
}

function getProjectUsers($project_id) {
	/*
	 * $user_listing format
	 * id => {
	 * 				name,
	 * 				description
	 * 			}
	 */
	if (empty($project_id)) return array();
	
	$user_listing=array();
	
	$query = 'SELECT edge_users.ID AS ID, username, firstname, lastname ' .
							'FROM edge_users '.
							'INNER JOIN projects_edge_users ON edge_users.ID = edge_users_id '.
							'WHERE project_id=' . $project_id;
	
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

function addProjectUsers($project_id,$user_id_list) {
	$count=0;
	// 	For each ID enter into Associated Project ID
	
	foreach($user_id_list as $user_id) {
		$user_list = getUsersList($user_id);
		if(!empty($user_list)) {
		$query = 'INSERT INTO projects_edge_users (project_id, edge_users_id) VALUES(' . $project_id . ', ' . $user_id . ')';
			
			$result = mysql_query ($query);
			if (!$result) {
				die('Invalid query: ' . mysql_error());
			}
			$count++;
		}
	}

	display_project_user_list($project_id);
	//return $count;
}

function removeProjectUsers($project_id,$user_id_list) {
	$count=0;
	// 	For each ID enter into Associated Project ID
	
	foreach($user_id_list as $user_id) {
		$user_list = getUsersList($user_id);
		if(!empty($user_list)) {
		$query = 'DELETE FROM projects_edge_users WHERE project_id=' . $project_id . ' AND edge_users_id='. $user_id;
			
			$result = mysql_query ($query);
			if (!$result) {
				die('Invalid query: ' . mysql_error(). '\n[' . $query . ']');
			}
			$count++;
		}
	}

	display_project_user_list($project_id);
	//return $count;
}

function getUsersList($user_id=null,$project_id=null) {
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
	
	$project_user_list=getProjectUsers($project_id);
	$query = 'SELECT ID,username, firstname,lastname,email FROM edge_users';
	if (!empty($user_id)) {
		$query = 'SELECT ID,username, firstname,lastname,email FROM edge_users WHERE ID=' . $user_id;
	}
	
	$loop = -1;
	foreach ($project_user_list as $id=>$details) {
		$loop++;
		if (empty($user_id) && $loop==0) $query .= ' WHERE edge_users.ID !=' . $id;
		else
		$query .=  ' AND edge_users.ID !=' . $id;
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

function display_project_user_list($project_id) {
	$user_list =getProjectUsers($project_id);
	
	if (empty($user_list)) {
		print '<span >';
		print getProjectName($project_id) . '<br/>';
		print 'No Users Assigned!';
		print '<br/>';
		print '<input type="button" name="add_user" value="Add User" onclick="selectUsers(' . $project_id . ')"/>';
		print '</span>';
	
		return;
	}
	foreach ($user_list as $id=>$attributes) {
		print '<input type="checkbox" value="' . $id . '" ';
		print  'checked="checked" ';
		print 'id="user_' . $id . '" />';
		print $attributes['firstname'] . ' ' . $attributes['lastname'];
		print '<br/>';
	}
	print '<input type="button" name="update_users" value="Update User List" onclick="removeUsers(' . $project_id .')"/>';
	print '<input type="button" name="add_user" value="Add User" onclick="selectUsers(' . $project_id .')"/>';
}

function display_project_user_selection($project_id) {
	$user_list =getUsersList(null,$project_id);
			
	foreach ($user_list as $id=>$attributes) {
		print '<input type="checkbox" value="' . $id . '" ';
		print 'id="user_' . $id . '" />';
		print $attributes['firstname'] . ' ' . $attributes['lastname'];
		print '<br/>';
	}
	print '<input type="button" name="add_user" value="Save" onclick="saveUsers('.$project_id . ')" />';
	print '<input type="button" name="cancel" value="Cancel" onclick="getUsers('.$project_id . ')" />';
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
			if (strpos($queryString,'list_project_users')===0) {
				$command = explode('=', $queryString);
				display_project_user_list($command[1]);
				return;
			} else if (strpos($queryString,'select_project_users')===0) {
				$command = explode('=', $queryString);
				display_project_user_selection($command[1]);
				return;
			} else if (strpos($queryString,'add_project_users')===0) {
				$command = explode('=', $queryString);
				$user_ids=explode(',',$command[2]);
				array_pop($user_ids);
				addProjectUsers($command[1], $user_ids);
				return;
			} else if (strpos($queryString,'remove_project_users')===0) {
				$command = explode('=', $queryString);
				$user_ids=explode(',',$command[2]);
				array_pop($user_ids);
				removeProjectUsers($command[1], $user_ids);
				return;
			}
				
		} // There is a queryString.
	} else {
		echo 'There should be no direct access to this script!';
	}
}