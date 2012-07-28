<?php

// Exchange the code we're given for an access token
$app_id = "400073310043056";
$app_secret = "eee0ee4645517e0232ff9ea4a888cc62";
$my_url = "http://localhost/edge/ThirdPartyServices/facebook/auth.php";
$code = $_REQUEST["code"];
if (isset($code))
{
	$token_url="https://graph.facebook.com/oauth/access_token?client_id="
      . $app_id . "&redirect_uri=" . urlencode($my_url) 
      . "&client_secret=" . $app_secret 
      . "&code=" . $code . "&display=popup";
    $response = file_get_contents($token_url);
    $params = null;
    parse_str($response, $params);
    $access_token = $params['access_token'];


	// this would save the session state which we need here (put this in profile page)
	//SessionManager::setParameter('user', Request::getParameter('user'));

	// and this would retrieve the current user
	//SessionManager::getParameter('user')

	// Store it in the database for this user
	echo $access_token;

}

// Do nothing if no code was received (user denied or there was an error)
else
	echo "no code";

?>