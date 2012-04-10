<?php

$client = new SoapClient("http://sl-queensland-web.ungerboeck.com/USI_BK_Service/USI_Service.asmx?WSDL");


$bookingParameters  = array(
		'OrgCode'   => "10",
		'EventID'   => "",
		'FromDate'   => "2011-01-01",
		'ToDate'   => "2012-12-01",
);

$authentication  = array(
		'PartnerKey'   => "A456woiuer89asdfAPX8",
		'PartnerHash'   => "",
);

$params   = array(
		'ServiceAuthentication'   => $authentication,
		'Parameters'   => $bookingParameters,
);



$result = $client->GetBookingInfo($params);

print_r($result);


// $soapclient = new SoapClient('http://sl-queensland-web.ungerboeck.com/USI_BK_Service/USI_Service.asmx?WSDL');
// echo '<pre>';
// 	var_dump($soapclient->__getFunctions());	
// echo '</pre>';
// echo '<pre>';
// 	var_dump($soapclient->__getTypes());
// echo '</pre>';

?>

