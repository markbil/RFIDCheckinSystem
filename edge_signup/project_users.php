<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="include/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="include/jquery.autocomplete.js"></script>

<link rel="StyleSheet" href="style.css" type="text/css" />
<!-- <link rel="StyleSheet" href="styles.css" type="text/css" /> -->

<title>Edge Projects And Users</title>

<script type="text/javascript">
	function getUsers(projectID) {
			$.post("include/common.php", {queryString: "list_project_users" + '=' + projectID }, 
					function(data){
						if(data.length >0) {
							$('#user_listing').html(data);
						}
							
					}
				);
	}
	
	function addUsers() {
		var project_sel=document.getElementById("project_listing");
		projectID=project_sel.value;
		$.post("include/common.php", {queryString: "add_project_users" + '=' + projectID }, 
				function(data){
					if(data.length >0) {
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

//var_dump($_POST);

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
		var_dump($_POST);
		var_dump($_GET);
		var_dump($project_id);
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
			$project_users=getProjectUsers($project_id);
			$users=getUsersList();
			
			print '<table cellspacing="0" cellpadding="0" width="100%">';
			print '<thead>';
			print'<th style="width:30%">Project</th>';
			print '<th>Users</th>';
			print '<th></th>';
			print '</thead>';
			print '<tr>';
			print '<td valign="top">';
			print '<select id="project_listing" size="5" style="min-height:200px;">';
			$loop=0;
			$project_first_id=null;
			$selected = 'selected="selected" ';
			foreach ($projects as $id=>$attributes) {
				$loop++;
				if ($loop==1) $project_first_id=$id;
				
				print '<option value="' . $id . '" title="'. $attributes['description'] .'" ';
				if ($loop == 1) print  $selected;
				print 'id="project_' . $id . '" onclick="getUsers(this.value)" >';
				print $attributes['name'];
				print '</option>';
			}
			print '</select>';
			print '</td>';
			print '<td valign="top">';
			print '<div style="min-height:200px;overflow-y:scroll;" id="user_listing">';
			display_project_user_list($project_first_id);
			
			print '</div>';
			print '</td>';

			print '</tr>';
			print '<tr valign="top">';
			print '<td align="right" colspan="3">';
			print '<a href="project_profiles.php?mode=list" title="List Projects"><input type="button" name="view_project"	value="Show Project" /></a>&nbsp;';
			print '<a href="project_profiles.php?mode=create" title="Create A New Project"><input type="button" name="new_project"	value="Create Project" /></a>';
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
