<?php

$client = new SoapClient("http://sl-queensland-web.ungerboeck.com/USI_BK_Service/USI_Service.asmx?WSDL");


$bookingParameters  = array(
		'OrgCode'   => "10",
		'EventID'   => "",
		'FromDate'   => "2010-03-27 15:40:01",
		'ToDate'   => "2012-04-10 15:40:01",
);

$authentication  = array(
		'PartnerKey'   => "xxxx",
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

