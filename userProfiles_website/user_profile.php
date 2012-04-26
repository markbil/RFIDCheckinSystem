<?php
require_once ('include/mysql_connection.php');

global $user_details;
$user_details = array(
	"id"=> null,
	'swipe_id' => null,
	"username"=> null,
	"firstname" => null,
	"lastname" => null,
	"email" => null,
	"interests" => array(),
	"expertise" => array(),
	"questions" => array()
);

$mode='list';
$submit=false;
$username=null;
$swipe_id = null;
$password=null;

function validateMediaID($swipe_id, $password) {
	// First Get Swipe ID and Password Match
	$query='SELECT * FROM people ' .
									'INNER JOIN identification_media ON people.Identification_id = identification_media.ID '.
									'INNER JOIN edge_users ON people.edge_users_id = edge_users.ID ' .
									'WHERE ThirdPartyID="'.	$swipe_id . '" AND password="' . $password .'"';
	$result = mysql_query($query);
	
	if ($num=mysql_numrows($result) != 1) {
		header("Location: login.php?fail=true");
	}
	setUserProfile($result);
	
}

function validateUserName($user_name, $password) {
// 	$query='SELECT ID,username,firstname,lastname,email FROM edge_users ' .
// 					'WHERE username="'.	$user_name. '" AND password="' . $password .'"';
	$query='SELECT ID,username,firstname,lastname,email,identification_media_id FROM view_edge_users_identification_media ' .
					'WHERE username="'.	$user_name. '" AND password="' . $password .'"';
	$result = mysql_query($query);
		
// 	error_log('QUERY[' . $query . ']'.PHP_EOL,3,'/var/log/php_errors.log');
// 	error_log('RESULT[' . var_export($result) . ']'.PHP_EOL,3,'/var/log/php_errors.log');
	
	if (mysql_num_rows($result) != 1) {
		header("Location: login.php?fail=true");
	}
	setUserProfile($result);
	
}

function validateUserId($user_id) {
// 	$query='SELECT ID AS edge_users_id,username,firstname,lastname,email FROM edge_users ' .
// 					'WHERE ID='.	$user_id;
	$query='SELECT * FROM people ' .
									'INNER JOIN identification_media ON people.identification_id = identification_media.ID '.
									'INNER JOIN edge_users ON people.edge_users_id = edge_users.ID ' .
									'WHERE edge_users.ID='.	$user_id;
	$result = mysql_query($query);
	
// 	error_log('validateUserId QUERY[' . $query . ']'.PHP_EOL,3,'/var/log/php_errors.log');
// 	error_log('validateUserId RESULT[' . var_export($result) . ']'.PHP_EOL,3,'/var/log/php_errors.log');
	
	if (mysql_num_rows($result) != 1) {
		header("Location: login.php?fail=true");
	}
	setUserProfile($result);
	
}

function setUserProfile($result) {
	//error_log('RESULT[' . var_export($result) . ']'.PHP_EOL,3,'/var/log/php_errors.log');
	
	global $user_details;
	while($row = mysql_fetch_array($result))
	{
		$user_details['id']=$row['ID'];
		$user_details['swipe_id']=$row['identification_media_id'];
		$user_details['username'] = $row["username"];
		$user_details['firstname'] = $row["firstname"];
		$user_details['lastname'] = $row["lastname"];
		$user_details['email'] = $row["email"];
		
	}
	$result = mysql_query("SELECT interest FROM interest_table WHERE edge_users_id = '".$user_details['id']."'");
	while($row = mysql_fetch_array($result))
	{
		array_push($user_details['interests'],$row["interest"]);
	}
	
	$result = mysql_query("SELECT expertise FROM expertise_table WHERE edge_users_id = '".$user_details['id']."'");
	while($row = mysql_fetch_array($result))
	{
		array_push($user_details['expertise'],$row["expertise"]);
	}
	
	$result = mysql_query("SELECT question FROM questions_table WHERE edge_users_id = '".$user_details['id']."'");
	while($row = mysql_fetch_array($result))
	{
		array_push($user_details['questions'],$row["question"]);
	}
	
}

if(isset($_GET["mode"])) {
	$mode=$_GET['mode'];
}

if (isset($_POST['is_submit'])) {
	$submit=($_POST['is_submit'] == 'true');
}

if(isset($_POST["user_id"])) {
	$user_details['id']=$_POST['user_id'];
}

if(isset($_POST['username']) && isset($_POST['password'])) {
	$username = trim($_POST["username"]);
	$password=trim($_POST["password"]);
}

if ($mode != "create") {
	if (empty($user_details['id'])) {
		if(empty($_POST["username"]) || empty($_POST["password"])) {
			//die();
			header("Location: login.php?fail=true");
		}
		validateUserName($username, $password);
	} else {
		validateUserId($user_details['id']);
		$mode="update";
	}
}

 if ($mode == 'update') {
 	if ($submit) {
 		// Update edge_users Table
		$query = 'UPDATE edge_users SET username = "'.$_POST['username'].'", '.
							'firstname = "' . $_POST['firstname'] .'", '.
							'lastname = "'. $_POST['lastname'] . '", ' .
							'email = "' .$_POST['email'] .'" '.
							'WHERE ID = '.$user_details['id'];
		
		$result = mysql_query ($query);
 		if (!$result) {
 			die('Invalid query UPDATE Projects: ' . mysql_error());
 		}
 		
 		// TODO - For each Interest update interest_table
 		// TODO - For each expertise update expertise_table
 		// TODO - For each question update question_table
 		 	
		validateUserId($user_details['id']);
 		
 		$submit=false;
 	}
 } else if ($mode == 'create') {
 	if ($submit) {
 		// Add in New User to database
 		/* $query = 'INSERT INTO Projects (ID, Name, Description) values ("","'.
 		$_POST["name"].'","' . $_POST['description'] . '")';
 		$result = mysql_query ($query);
 		if (!$result) {
 			die('Invalid query INSERT INTO Projects: ' . mysql_error());
 		}
 		
 		// Get the ID of the identification_media table
 		$query = 'SELECT MAX(ID) FROM Projects';
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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="include/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="include/jquery.autocomplete.js"></script>
<script type="text/javascript" src="include/user_profile.js" charset="utf-8"></script>

<link rel="StyleSheet" href="style.css" type="text/css" />
<link rel="StyleSheet" href="styles.css" type="text/css" />

<title>Edge Signup</title>
</head>
<body onload="startup()">
	<div id="form"
		style="width: 500px; margin-left: auto; margin-right: auto;">
		
		<?php
		if($mode == 'create' || $mode == 'update') {
			print '<form name="user_profile" method="post" action="user_profile.php?mode=' . $mode . '">';
			print '<input name="is_submit" type="hidden" value="true" />';
		}
		if($mode == 'update') {
			print '<input type="hidden" name="user_id" value="'. $user_details['id'] . '" />';
		}
		?>
		
			<fieldset>
				<legend>Edge Profile</legend>
				<table cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<th colspan="2">General Info</th>
					</tr>
					<tr>
						<td width="50%" align="right">Swipe Card ID:</td>
						<td width="50%"><input type="text" name="swipe"
							readonly="readonly" value="<?php echo $user_details['swipe_id'];?>" /></td>
					</tr>

					<tr>
						<td width="50%" align="right">Username:</td>
						<td><input type="text" name="username"
							value="<?php echo $user_details['username']; ?>" /></td>
					</tr>
					<tr>
						<td width="50%" align="right">First name:</td>
						<td><input type="text" name="firstname"
							value="<?php echo $user_details['firstname'];?>" /></td>
					</tr>
					<tr>
						<td width="50%" align="right">Last name:</td>
						<td><input type="text" name="lastname"
							value="<?php echo $user_details['lastname'];?>" /></td>
					</tr>
					<td width="50%" align="right">Email:</td>
					<td><input type="text" name="email"
						value="<?php echo $user_details['email'];?>" /></td>
					<tr></tr>
					<tr><td align="right" colspan="2">					
						<a  href="login.php"><input type="button" name="cancel"	value="Cancel" /></a>
						<input type="submit" value="Update" />
						<hr/>
					</td></tr>
					<tr><td align="left" colspan="2">					
						<a  href="project_profiles.php"><input type="button" name="projects"	value="View Projects" /></a>
<!-- 						<a  href="project_users.php"><input type="button" name="project_users"	value="Project Collaborators" /></a> -->
<!-- 						<input type="submit" value="Update" /> -->
					</td></tr>				
					</table>
				<hr />

				<div id="interests">
				<span style="background-color: grey; cursor:default;">What are your interests?  >></span>
				<table id="interestsTbl" cellspacing="0" cellpadding="0"
					width="100%">
					<tr>
						<th></th>
					</tr>
						<?php 
						$i = 0;
						foreach($user_details['interests'] as $interest) { 
						$i = $i + 1;
						?>
						<tr>
						<td align="center"><input type="text" id="int<?php echo $i; ?>" name="int<?php echo $i; ?>" value="<?php echo $interest; ?>" onkeyup="addRow('interestsTbl',this,'i')" /></td>
						</tr>
					    
					<?php 
					}
					$i = $i + 1;
					?>
					
					<tr>
						<td align="center">
						<input type="text" id="i<?php echo $i; ?>" name="int<?php echo $i; ?>" value="" onkeyup="addRow('interestsTbl',this,'int')" />
						</td>
						</tr>
					    
					</table>
					</div>
					
				<hr />
				<div id="expertise">
					<span style="background-color: grey;cursor:default;">What are you good in (tools / software / techniques /
							creative practices)?		>></span>
			<table id="expertiseTbl" cellspacing="0" cellpadding="0"
					width="100%">
					<tr>
						<th></th>
					</tr>
					
				<?php 
				$i = 0;
				foreach($user_details['expertise'] as $expert) { 
				$i = $i + 1;
				?>
					<tr>
					<td align="center">
					<input type="text" id="exp<?php echo $i; ?>" name="exp<?php echo $i; ?>" value="<?php echo $expert; ?>" onkeyup="addRow('expertiseTbl',this,'exp')" />
					</td>
					</tr>
				    
				<?php 
				}
				$i = $i + 1;
				?>
				
				<tr>
					<td align="center">
					<input type="text" id="exp<?php echo $i; ?>" name="exp<?php echo $i; ?>" value="" onkeyup="addRow('expertiseTbl',this,'exp')" />
					</td>
					</tr>    
				</table>
				</div>
				
				<hr />

				<div id="questions">
						<span style="background-color: grey;cursor:default;">What's your question to the Edge community? What
							help/skills would you like to get from others?	   >></span>
										<table id="questionsTbl" cellspacing="0" cellpadding="0"
					width="100%">
					<tr>
						<th></th>
					</tr>
					
					<?php 
					$i = 0;
					foreach($user_details['questions'] as $question) { 
					$i = $i + 1;
					?>
						<tr>
						<td align="center">
						<input type="text" id="que<?php echo $i; ?>" name="que<?php echo $i; ?>" value="<?php echo $question; ?>" onkeyup="addRow('questionsTbl',this,'que')" />
						</td>
						</tr>
					    
					<?php 
					}
					$i = $i + 1;
					?>
					
					<tr>
						<td align="center">
						<input type="text" id="que<?php echo $i; ?>" name="que<?php echo $i; ?>" value="" onkeyup="addRow('questionsTbl',this,'que')" />
						</td>
						</tr>
					</table>
					</div>
					
				<hr />
				<center>
					<a href="login.php"><input type="button" name="cancel"	value="Cancel" /></a>
						<input type="submit" value="Update" />
				</center>
			</fieldset>
		</form>
	</div>
</body>
</html>