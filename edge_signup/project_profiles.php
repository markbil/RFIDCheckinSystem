<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="jquery.autocomplete.js"></script>

<link rel="StyleSheet" href="style.css" type="text/css" />
<link rel="StyleSheet" href="styles.css" type="text/css" />

<title>Edge projects</title>

<?php
require_once ('include/common.php');

$mode='list';
$project_id=null;
$name = null;	//Project Name
$description=null;	// Project Description
$submit=false;


 if(isset($_GET["mode"])) {
 	$mode=$_GET['mode'];
 }
 
if (isset($_POST['is_submit'])) {
	$submit=true;
}

if (isset($_GET['id'])) {
	$project_id=$_GET['id'];
}
if (isset($_POST['project_id'])) {
	$project_id=$_POST['project_id'];
}

if (isset($_POST['name'])) {
	$name=$_POST['name'];
}

if (isset($_POST['description'])) {
	$description=$_POST['description'];
}

if(!empty($project_id)) $mode="update";
 
 if ($mode == 'update') {
 	if (!$submit) {
 		// Using the ID
 		if (!empty($project_id)) {
 			$result = mysql_query("SELECT * FROM projects WHERE ID = '".$project_id."'");
 			while($row = mysql_fetch_array($result))
 			{
 				$name = $row["Name"];
 				$description=$row['Description'];
 			}
 		}
 	} else {
 		// Update Database
 		$query = 'UPDATE projects SET Name="'. $name . '",' .
 		                                                	'Description="' . $description . '" WHERE ID=' . $project_id;
 		$result = mysql_query ($query);
 		if (!$result) {
 			die('Invalid query UPDATE projects: ' . mysql_error());
 		}
 			
		// Redirect to Listings
 		$mode = 'list';
 		$submit=false;
 	}
 } else if ($mode == 'create') {
 	if ($submit) {
 		// Add in New Project to database
 		$query = 'INSERT INTO projects (ID, Name, Description) values ("","'.
 		$_POST["name"].'","' . $_POST['description'] . '")';
 		$result = mysql_query ($query);
 		if (!$result) {
 			die('Invalid query INSERT INTO projects: ' . mysql_error());
 		}
 		
 		// Get the ID of the identification_media table
 		$query = 'SELECT MAX(ID) FROM projects';
 		$result = mysql_query ($query);
 		if (!$result) {
 			die('Invalid query: SELECT MAX(ID)' . mysql_error());
 		}
 		$project_id = mysql_fetch_row($result);
 		$project_id = $project_id[0];
 		$mode = 'list';
 		$submit=false;
 	}
 }

?>
</head>
<body>
	<div id="form" style="width: 500px; margin-left: auto; margin-right: auto;">
	
		<?php
		if($mode == 'create' || $mode == 'update') {
			print '<form name="signup" method="post" action="project_profiles.php?mode=' . $mode . '">';
			print '<input name="is_submit" type="hidden" value="true" />';
		}
		if($mode == 'update') {
			print '<input name="project_id" type="hidden" value="'. $project_id .'" />';
		}
		print '<fieldset>';
		if ($mode == 'list') {
			print '<legend>Project Listings</legend>';
		} else {
			print '<legend>Project Profile</legend>';
		}
		if(empty($project_id)&& $mode == 'update') echo "<p>NO PROJECT SELECTED";

		if($mode=='update' || $mode=='create') {
			print '<table cellspacing="0" cellpadding="0" width="100%">';
			print '<thead>';
			print'<th colspan="2">General Info</th>';
			print '</thead>';
			print '<tr>';
			print'<td align="left">Project Name:</td>';
			print '<td>';
			print '<input type="text" name="name"	value="' . $name . '"';
			if(empty($project_id)&& $mode == 'update') echo "disabled=\"disabled\"";
			print '/></td>';
			print '</tr>';
			print '<tr>';
			print '	<td align="left" valign="top">Project Description:</td>';
			print '<td>';
			print '<textarea cols="30" rows="10" name="description"';
			if(empty($project_id) && $mode == 'update') echo "disabled=\"disabled\"";
			print '>';
			print $description;
			print '</textarea>';
			print '</td>';
			print '</tr>';
			print '</table>';
		} else if ($mode=='list') {
			// Get list from database
			$projects=getProjectsList();

			print '<table cellspacing="3px" cellpadding="0" width="100%">';
			print '<thead>';
			print'<th style="width:30%">Name</th>';
			print '<th>Description</th>';
			print '<th></th>';
			print '<th></th>';
			print '</thead>';
			
			foreach ($projects as $id=>$attributes) {
				print '<tr valign="top">';
				print '<td>';
				print $attributes['name'];
				print '</td>';
				print '<td>';
				print $attributes['description'];
				print '</td>';
				print '<td>';
				print '<a href="project_profiles.php?id=' .$id . '" title="Modify Project \'' . $attributes['name'] . '\'">EDIT</a>';
				print '</td>';
				print '<td>';
				print '<a href="project_users.php?id=' .$id . '" title="Add User To Project \'' . $attributes['name'] . '\'">ADD USER</a>';
				print '</td>';
				print '</tr>';
			}
			print '<tr valign="top">';
			print '<td align="right" colspan="3">';
			print '<a href="project_profiles.php?mode=create" title="Create A New Project">NEW</a>';
			print '</td>';
			print '</table>';
		}

		print '<hr />';
		if ($mode == 'create' || $mode == 'update') {
			print '<input type="submit" value="';
			if($mode=='create') echo  'Create'; else echo 'Update';
			print '" />';
			print '<a href="project_profiles.php"><input type="button" name="cancel" value="Cancel" />';
			print '</a>';
				print '</form>';
		}
			print '</fieldset>';
		?>
	</div>
</body>
</html>
