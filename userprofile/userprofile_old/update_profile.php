<?php

require_once ('include/mysql_connection.php');

if(!isset($_POST["swipe"]) || !isset($_POST["password"]))
	header("Location: login.php?fail=true");

$swipe_id = $_POST["swipe"];
$username = ""; 
$interests = array();
$expertise = array();
$questions = array();


$result = mysql_query("SELECT COUNT(*) as login FROM edge_users WHERE swipe_id = '".$swipe_id . "' AND password = '".$_POST["password"]."'");
while($row = mysql_fetch_array($result))
  {
  if($row["login"] == 0) {
  	header("Location: login.php?fail=true");
  }
  }





$result = mysql_query("SELECT * FROM edge_users WHERE swipe_id = '".$swipe_id."'");
while($row = mysql_fetch_array($result))
  {
  $username = $row["username"];
  }

$result = mysql_query("SELECT * FROM edge_users WHERE swipe_id = '".$swipe_id."'");
while($row = mysql_fetch_array($result))
  {
  $firstname = $row["firstname"];
  }

$result = mysql_query("SELECT * FROM edge_users WHERE swipe_id = '".$swipe_id."'");
while($row = mysql_fetch_array($result))
  {
  $lastname = $row["lastname"];
  }
  
$result = mysql_query("SELECT * FROM edge_users WHERE swipe_id = '".$swipe_id."'");
	while($row = mysql_fetch_array($result))
	{
	$email = $row["email"];
	}

$result = mysql_query("SELECT * FROM interest_table WHERE swipe_id = '".$swipe_id."'");
while($row = mysql_fetch_array($result))
  {
  array_push($interests,$row["interest"]);
  }

$result = mysql_query("SELECT * FROM expertise_table WHERE swipe_id = '".$swipe_id."'");
while($row = mysql_fetch_array($result))
  {
  array_push($expertise,$row["expertise"]);
  }

$result = mysql_query("SELECT * FROM questions_table WHERE swipe_id = '".$swipe_id."'");
while($row = mysql_fetch_array($result))
  {
  array_push($questions,$row["question"]);
  }



/*require_once ('include/mysql_connection.php');

$result = mysql_query("SELECT * FROM edge_users WHERE swipe_id = ".$_POST['swipe']." AND password = '".$_POST["password"]."'");
$swipe_id = "NONE";

while($row = mysql_fetch_array($result))
  {
  $username = $row["username"];
  $swipe_id = $row["swipe_id"];  
  }

if(  $swipe_id == "NONE")
	die();*/

  
  
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="include/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="include/query.autocomplete.js"></script>

<LINK REL=StyleSheet HREF="style.css" TYPE="text/css" />
<LINK REL=StyleSheet HREF="styles.css" TYPE="text/css" />

<title>Edge Signup</title>

<SCRIPT language="javascript">

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

<div id="form" style="width:500px; margin-left:auto; margin-right:auto;">
<form name="signup" method="post" action="update_submit.php">
<fieldset>
<legend>Edge Profile</legend>
<table cellspacing="0" cellpadding="0" width="100%">
<tr>
<th colspan="2">
General Info
</th>
</tr>
<tr>
<td width="50%" align="right">
Swipe Card ID:
</td>
<td width="50%">
<input type="text" name="swipe" readonly="readonly" value="<?php echo $swipe_id;?>" />
</td>
</tr>

<tr>
<td width="50%" align="right">
Username:
</td>
<td>
<input type="text" name="username" value="<?php echo $username;?>"/>
</td>
</tr>
<tr>
<td width="50%" align="right">
First name:
</td>
<td>
<input type="text" name="firstname" value="<?php echo $firstname;?>"/>
</td>
</tr>
<tr>
<td width="50%" align="right">
Last name:
</td>
<td>
<input type="text" name="lastname" value="<?php echo $lastname;?>"/>
</td>
</tr>
<td width="50%" align="right">
Email:
</td>
<td>
<input type="text" name="email" value="<?php echo $email;?>"/>
</td>
</tr>
</table>
<hr />

<table id="interestsTbl" cellspacing="0" cellpadding="0" width="100%">
<tr>
<th>
What are your interests?
</th>
</tr>

<?php 
$i = 0;
foreach($interests as $interest) { 
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
<table id="expertiseTbl" cellspacing="0" cellpadding="0" width="100%">
<tr>
<th>
What are you good in (tools / software / techniques / creative practices)? 
</th>
</tr>
<?php 
$i = 0;
foreach($expertise as $expert) { 
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

<table id="questionsTbl" cellspacing="0" cellpadding="0" width="100%">
<tr>    
<th>
What's your question to the Edge community? What help/skills would you like to get from others? 
</th>
</tr>
<?php 
$i = 0;
foreach($questions as $question) { 
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


<!--
<table>
<tr>
<th colspan="2">
What are you good in (tools / software / techniques / creative practices)? 
</th>
</tr>
<tr>
<td colspan="2" align="center">
<input type="text" name="expertise" value="" />
</td>
</tr>
</table>
<table>
<tr>
<th colspan="2">
What help/skills would you like to get from others?
</th>
</tr>
<tr>
<td colspan="2" align="center">
<input type="text" name="help" value="" />
</td>
</tr>



<tr>
<td colspan="2" align="center">

</td>
</tr>

</table>-->
<center><a href="login.php"><input type="button" name="cancel" value="Cancel" /></a><input type="submit" value="Update" /></center>
</fieldset>
</form>
</div>
</body>
</html>