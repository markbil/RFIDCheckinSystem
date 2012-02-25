<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="jquery.autocomplete.js"></script>

<link rel="StyleSheet" href="style.css" type="text/css" />
<link rel="StyleSheet" href="styles.css" type="text/css" />

<title>Edge Projects And Users</title>

<script type="text/javascript">
	function getUsers(projectID) {
			$.post("include/common.php", {queryString: ""+projectID+""}, 
					function(data){
						if(data.length >0) {
							//$('#suggestions').show();
							$('#user_listing').html(data);
						}
					}
				);		
	}
	</script>

<?php
require_once ('include/common.php');

$mode='update';
$project_id=null;
$name = null;	//Project Name
$description=null;	// Project Description
$submit=false;

var_dump($_POST);

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

if(!empty($project_id)) $mode="update";
 
 if ($mode == 'update') {
 	if (!$submit) {
 		/* // Using the ID
 		if (!empty($project_id)) {
 			$result = mysql_query("SELECT * FROM projects WHERE ID = '".$project_id."'");
 			while($row = mysql_fetch_array($result))
 			{
 				$name = $row["Name"];
 				$description=$row['Description'];
 			}
 		}*/
 	} else {
 		/* // Update Database
 		$query = 'UPDATE projects SET Name="'. $name . '",' .
 		                                                	'Description="' . $description . '" WHERE ID=' . $project_id;
 		$result = mysql_query ($query);
 		if (!$result) {
 			die('Invalid query UPDATE projects: ' . mysql_error());
 		}
 			
		// Redirect to Listings
 		$mode = 'list';
 		$submit=false;*/
 	}
 } else if ($mode == 'create') {
 	if ($submit) {
 		/* // Add in New Project to database
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
 		$submit=false; */
 	}
 }

?>

</head>
<body>
	<div id="form" style="width: 500px; margin-left: auto; margin-right: auto;">
	
		<?php
		//var_dump($_POST);
		if($mode == 'create' || $mode == 'update') {
			print '<form name="signup" method="post" action="project_users.php?mode=' . $mode . '">';
			print '<input name="is_submit" type="hidden" value="true" />';
		}
		if($mode == 'update') {
			//print '<input name="project_id" type="hidden" value="'. $project_id .'" />';
		}
		print '<fieldset>';
			print '<legend>Project Listings</legend>';
//		if(empty($project_id)&& $mode == 'update') echo "<p>NO PROJECT SELECTED";

		if($mode=='update' || $mode=='create') {
			// Get list from database
			$projects=getProjectsList();
			$project_users=getProjectsUsers($project_id);
			$users=getUsersList();
			
			print '<table cellspacing="0" cellpadding="0" width="100%">';
			print '<thead>';
			print'<th style="width:30%">Project</th>';
			print '<th>Users</th>';
			print '<th></th>';
			print '</thead>';
			print '<tr>';
			print '<td>';
			print '<select name="project_listing" size="5">';
			foreach ($projects as $id=>$attributes) {
				print '<option value="' . $id . '" title="'. $attributes['description'] .'" ';
				if ($id==$project_id) print  'selected="selected" ';
				print 'id="project_id" onclick="getUsers(this.value)" >';
				print $attributes['name'];
				print '</option>';
			}
			print '</select>';
			print '</td>';
			print '<td>';
			//print '<select name="user_listing" size="5" style="width:100%">';
			print '<div style="max-height:105px;overflow-y:scroll;" id="user_listing">';
			foreach ($users as $id=>$attributes) {
				//print '<option value="' . $id . '" title="'. $attributes['firstname'] . ' ' . $attributes['lastname']  .'">';
				print '<input type="checkbox" name="user_' . $id . '" '.  ' value="' . $id . '" ';
				if (array_key_exists($id, $project_users)) print 'checked="checked" ';
				print '</>';
				print $attributes['username'];
				print '<br/>';
				//print '</option>';
			}
			print '</div>';
			//print '</select>';
			print '</td>';

			print '</tr>';
			print '<tr valign="top">';
			print '<td align="right" colspan="3">';
			print '<a href="project_profiles.php?mode=list" title="List Projects">Show Projects</a>&nbsp;';
			print '<a href="project_profiles.php?mode=create" title="Create A New Project">NEW Project</a>';
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
