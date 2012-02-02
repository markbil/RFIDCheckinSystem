<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Edge Signup</title>
</head>
<body>

<div style="width:400px; margin-left:auto; margin-right:auto; border-color:#000; border-style:outset; border-width:1px">
<center>Login</center>
<?php if(isset($_GET["fail"])) echo "Incorrect Login Details</br>";?>
<table width="100%">


<form name="signup" method="post" action="update_profile.php">

<tr >
<td align="right" width="50%">
Swipe Card
</td>
<td align="left" width="50%">
<input type="text" name="swipe" value="" />
</td>
</tr>

<tr>
<td align="right" width="50%">
Password
</td>
<td align="left" width="50%">
<input type="password" name="password" />
</td>
</tr>



<tr>
<td colspan="2" align="center">
<input type="submit" value="Login" />
</td>
</tr>
</form>
</table>
</div>
</body>
</html>