
<?php
	print '<div id="content" class="center">';
	print '<div class="content-inner center">';
	
	print anchor('edge_user/profile','Return To Your Profile', array('class'=>'logg-button','title'=>'Return To Your Profile', 'style'=>'float:left;display:block;'));
?>
<br /><br />
<br />
<?php
	print '<br/>';
	print '<fieldset style="clear:both">';
	print '<h1>RFID Checkin Administration</h1>';	
	print '</fieldset>';
	/*
	print '<div>';
	print anchor('admin/create_project','Create Project', array('class'=>'logg-button','title'=>'Create A New Project'));
	print '</div>';
	print '<br>';
	print '<div>';
	print anchor('admin/list_projects','List Projects', array('class'=>'logg-button','title'=>'List Projects'));
	print '</div>';
	print '<br>';
	*/
	print '<div>';
	print anchor('admin/create_user','Create User', array('class'=>'logg-button','title'=>'Create A New User'));
	print '</div>';
	print '<br>';
	print '<div>';
	print anchor('admin/list_users','List Users', array('class'=>'logg-button','title'=>'List Users'));
	print '</div>';
	print '<br>';
	print '<div>';
	print anchor('admin/manage_user_rfids','Allocate RFID Card To User', array('class'=>'logg-button','title'=>'Allocate RFID To User'));
	print '</div>';
	print '<br>';
	print '<div>';
	print anchor('admin/list_rfids','Manage RFID Cards', array('class'=>'logg-button','title'=>'Manage RFID Cards'));
	print '</div>';
	print '<br>';
	print '</div>';	
	print '</div>';	
?>