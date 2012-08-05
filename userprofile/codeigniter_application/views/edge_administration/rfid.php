<?php
	print validation_errors('<div class="login-warning center"><span class="center">', '</span></div>');
	if ($message) {
		echo '<div class="logg-success"><span class="center">';
		echo $message;
		echo '</span></div>';
	}
	
	print '<div id="content" class="center">';
	print '<div class="content-inner center">';
	print '<br>';
	print anchor('admin','Return To Admin', array('class'=>'logg-button','title'=>'Return To Admin', 'style'=>'float:right'));
	print anchor('edge_user/profile','Return To Your Profile', array('class'=>'logg-button','title'=>'Return To Your Profile', 'style'=>'float:right'));
	
	print '<br/>';
	print '<fieldset style="clear:both">';
	print '<legend>RFID Listings</legend>';
	print '<div class="collapse-head" id="collapse-goodwith">';
	print '<div class="collapsed-arrow right" id="collapse-goodwith-arrow-collapsed">&#9660;</div>';
	print '<div class="expanded-arrow right" id="collapse-goodwith-arrow-expanded">&#9650;</div>';
	print '<h3 class="inline">Add New RFID Card</h3>';
	print '</div>';
	print '<div class="collapse-content" id="collapse-goodwith-content">';
	print '<h3>Enter RFID Card Unique ID</h3>';
	print form_open($form_action, array('id'=>'rfid-form', 'class' => 'logg-form content-inner center'));
	print '<input type="text" class="logg-text" size="50" name="new_rfid" />';
	print '<div class="right">';
	print form_submit('add_rfid', 'Add RFID');
	print '</div>';
	print form_close();
	print '</div>';
	
	print '<br/>';
	
	print '<div id="tableContainer" class="tableContainer">';
	print '<table class="scrollTable" cellspacing="0" cellpadding="0" border="0" width="100%">';
	//print '<table cellspacing="3px" cellpadding="0" width="100%">';
	//print '<thead>';
	print '<thead class="fixedHeader">';
	print '<tr>';
	print'<th style="">Name</th>';
	print'<th style="">Username</th>';
	print '<th></th>';
	print '</tr>';
	print '</thead>';	
	print '<tbody class="scrollContent">';
	//print '<tbody style="max-height:200px;">';
	$count=0;
	foreach ($rfids as $value) {
		$count++;
		if (($count % 2)==0) {
			print '<tr class="even">';
		} else {
		print '<tr >';			
		}
		print '<td valign="middle">';
		print $value->ThirdPartyID;		
		print '</td>';
		print '<td valign="middle">';
		print $value->firstname . ' ' . $value->lastname;		
		print '</td>';
		print '<td valign="middle">';
		print $value->username;		
		print '</td>';
		print '<td valign="middle">';
		print anchor('admin/list_rfids','Delete', array('class'=>'logg-button','title'=>'Delete RFID Card From System'));
		print '</td>';
		print '</tr>';
	}

	print '</tbody>'	;
	
	print '</table>';
	print '</div>';

	print '</fieldset>';
	
	print '</div>';
	print '</div>';
?>
