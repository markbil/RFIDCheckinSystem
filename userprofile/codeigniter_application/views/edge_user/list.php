<?php
	print '<div id="content" class="center">';
	print anchor('admin','Return To Admin', array('class'=>'logg-button','title'=>'Return To Admin', 'style'=>'float:right'));
	print anchor('edge_user/profile','Return To Your Profile', array('class'=>'logg-button','title'=>'Return To Your Profile', 'style'=>'float:right'));
	
	print '<br/>';
	print '<fieldset style="clear:both">';
	print '<legend>User Listings</legend>';	
	print '<table cellspacing="3px" cellpadding="0" width="100%">';
	print '<thead>';
	print'<th style="">Name</th>';
	print'<th style="">Username</th>';
	print '<th></th>';
	print '</thead>';	
	print '<tbody style="max-height:200px;overflow:auto;">';
	$count = 0;
	foreach ($users as $key=>$value) {
		$count++;
		if(($count % 2) == 0) {
		print '<tr class="even">';
		} else {
			print '<tr >';
		}
		print '<td valign="middle">';
		print $value->firstname . ' ' . $value->lastname;		
		print '</td>';
		print '<td valign="middle">';
		print $value->username;		
		print '</td>';
		print '<td valign="middle">';
		print anchor('edge_user/profile/'.$value->ID,'Edit', array('class'=>'logg-button','title'=>'Edit'));
		print '</td>';
		print '</tr>';
	}

	print '</tbody>'	;
	
	print '</table>';

	print '</fieldset>';
	
	print '</div>';
?>
