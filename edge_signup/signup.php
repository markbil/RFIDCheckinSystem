<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Edge Signup</title>
</head>
<body>

	<div style="width: 400px; margin-left: auto; margin-right: auto;">
		<fieldset>
			<legend>Edge Signup</legend>
			<table>
			<?php if(isset($_GET["fail"])) echo "Please Fill In All Fields</br>";?>
				<form name="signup" method="post" action="singup_submit.php">
					<tr>
						<td>Swipe Card:</td>
						<td><input type="text" name="swipe"
							value="&lt;?php /*if (isset($_GET['swipe_id'])) echo $_GET['swipe_id']; else echo &quot;&quot;;*/?&gt;" />
						</td>
					</tr>

					<tr>
						<td>Name?</td>
						<td><input type="text" name="name" /></td>
					</tr>

					<tr>
						<td>Password</td>
						<td><input type="password" name="password" /></td>
					</tr>

					<tr>
						<td colspan="2" align="center"><input type="submit"
							value="Sign Up" /></td>
					</tr>
				</form>
			</table>
		</fieldset>
	</div>
</body>
</html>