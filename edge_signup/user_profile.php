<?php
require_once ('include/include/mysql_connection.php');

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
$swipe_id = null;
$password=null;

function validateUser($swipe_id, $password) {
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

function validateUserId($user_id) {
	$query='SELECT ID AS edge_users_id,username,firstname,lastname,email FROM edge_users ' .
					'WHERE ID='.	$user_id;
	$query='SELECT * FROM people ' .
									'INNER JOIN identification_media ON people.Identification_id = identification_media.ID '.
									'INNER JOIN edge_users ON people.edge_users_id = edge_users.ID ' .
									'WHERE edge_users.ID='.	$user_id;
	$result = mysql_query($query);
		
	if (mysql_numrows($result) != 1) {
		header("Location: login.php?fail=true");
	}
	setUserProfile($result);
	
}

function setUserProfile($result) {
	global $user_details;
	while($row = mysql_fetch_array($result))
	{
		$user_details['id']=$row['edge_users_id'];
		$user_details['swipe_id']=$row['ThirdPartyID'];
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

if(isset($_POST['swipe']) && isset($_POST['password'])) {
	$swipe_id = trim($_POST["swipe"]);
	$password=trim($_POST["password"]);
}

if ($mode != "create") {
	if (empty($user_details['id'])) {
		if(empty($_POST["swipe"]) || empty($_POST["password"])) {
			//die();
			header("Location: login.php?fail=true");
		}
		validateUser($swipe_id, $password);
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

<script type="text/javascript" src="jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="jquery.autocomplete.js"></script>

<link rel="StyleSheet" href="style.css" type="text/css" />
<link rel="StyleSheet" href="styles.css" type="text/css" />

<title>Edge Signup</title>

<script language="javascript" type="">

var interests = new Array();
var interestRows = new Array();
var profileInfo = new Object();

profileInfo.swipeID = "Mark";
profileInfo.username = "Mark";
profileInfo.interests = interests;

function addRow(tableName,sender,idType) {
	var table = document.getElementById(tableName);
	
 	//if this is the last option add a new one
	var last = document.getElementById(idType+(table.rows.length - 1));
	
	//if this is empty delete it
	if (sender.value == "" && sender.id != last.id) {
		
		var thisID = parseInt(sender.id.slice(1,sender.id.length),10);					
		var i = thisID + 1;
		table.deleteRow(thisID);
		
		while(document.getElementById(idType + i) != null) {
			var interestBox = document.getElementById(idType + i);
			interestBox.id = idType + (i - 1);
			interestBox.name = idType + (i - 1);
			i = i + 1;
		}
				
		return;
	}
	
	if(sender.id != last.id)		
		return;
	
	var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
	row.id = "row" + idType + thisID;
	row.align = "center";
 			
			
    var cell1 = row.insertCell(0);
    var element1 = document.createElement("input");
    element1.type = "text";			
	element1.name = idType+(table.rows.length - 1);	
	element1.id = idType+(table.rows.length - 1);
	
	element1.onkeyup = function() { addRow(tableName,element1,idType); };
		
    cell1.appendChild(element1);	
	setupAutoComplete(element1.id);
	
}

	
function setupAutoComplete(name) {	
	var URL = "";
	if(name.slice(0,3) == "int")
		URL = "autoInterests.php";
	if(name.slice(0,3) == "exp")
		URL = "autoExpertise.php";
	

	var options, a;
	
	jQuery(function(){	
	
		var onAutocompleteSelect = function(value, data) {
            $('#selection').html('<img src="\/global\/flags\/small\/' + data + '.png" alt="" \/> ' + value);            
        };
		
  		var options = {
            serviceUrl: URL,
            width: 200,
            delimiter: /(,|;)\s*/,
            onSelect: onAutocompleteSelect,
            deferRequestBy: 0, //miliseconds            
            noCache: false //set to true, to disable caching
        };

  		a = $('#'+name).autocomplete(options);
	});
}

function startup() {
	<?php
	for($i = 0; $i <= sizeof($interests); $i++)
		echo "setupAutoComplete('int".($i + 1)."'); ";
		
	for($i = 0; $i <= sizeof($expertise); $i++)
		echo "setupAutoComplete('exp".($i + 1)."'); ";
		
	?>
}

</script>

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
				</table>
				<hr />

				<table id="interestsTbl" cellspacing="0" cellpadding="0"
					width="100%">
					<tr>
						<th>What are your interests?</th>
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

				<hr />
				<table id="expertiseTbl" cellspacing="0" cellpadding="0"
					width="100%">
					<tr>
						<th>What are you good in (tools / software / techniques /
							creative practices)?</th>
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

				<hr />

				<table id="questionsTbl" cellspacing="0" cellpadding="0"
					width="100%">
					<tr>
						<th>What's your question to the Edge community? What
							help/skills would you like to get from others?</th>
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