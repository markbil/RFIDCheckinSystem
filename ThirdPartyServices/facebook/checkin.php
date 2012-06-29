<?php

require 'facebook.php';

function postCheckinToFacebook($appSecret,$userID,$token,$message,$firstAttempt)
{
	// Setup facebook
	$facebook = new Facebook(array(
	  'appId'  => '400073310043056',
	  'secret' => $appSecret,
	));
	$facebook->setAccessToken($token);

	// Construct and send the location based post
	try
	{
		$result = $facebook->api('/'.$userID.'/feed', 'POST', array(
		'access_token' => $facebook->getAccessToken(),
		'place' => '246419308104',	// The Edge's FBID
		'message' =>$message,
		'coordinates' => json_encode(array(
		   'latitude'  => '-27.47159234211',
		   'longitude' => '153.019149383',
		   'tags' => $userID)),
		 )
		);
	}
	catch (FacebookApiException $e)
	{
		echo $e->__toString();
		if ($firstAttempt == true)
		{
			// Having trouble figuring out how to differentiate between the various errors that
			// can be caught here (they don't use unique codes for some reason!?)
			// But it doesn't matter, we can pretty harmlessly just retry with an extended token
			$token = $facebook->getExtendedAccessToken();
			if (isset($token))
				postCheckinToFacebook($appSecret,$userID,$token,$message,false);
		}
		// Ignore errors if we've already tried this again
    }
}

?>