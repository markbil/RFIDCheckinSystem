<?php
	print '<div id="content" class="center">';
	print '<div class="content-inner center">';

	print anchor('admin/create_user','Create New User', array('class'=>'logg-button','title'=>'Return To Admin', 'style'=>'float:left'));
	print anchor('admin','Return To Admin', array('class'=>'logg-button','title'=>'Return To Admin', 'style'=>'float:right'));
	print '<br /><br />';
	print '<br />';
	print '<br/>';
	print '<fieldset style="clear:both">';
	print '<legend>User Listings</legend>';	
	print '<div id="tableContainer" class="tableContainer">';
	print '<table class="scrollTable" cellspacing="0" cellpadding="0" border="0" width="100%">';
	print '<thead class="fixedHeader">';
	print '<tr>';
	print'<th style="">Name</th>';
	print'<th style="">Username</th>';
	print '<th></th>';
	print '</tr>';
	print '</thead>';	
	print '<tbody class="scrollContent">';
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
	print '</div>';

	print '</fieldset>';
	
	print '</div>';
	print '</div>';
?>
