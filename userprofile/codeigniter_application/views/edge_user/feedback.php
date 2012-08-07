<?php
	echo validation_errors('<div class="login-warning center"><span class="center">', '</span></div>');
	
	print '<div id="content" class="center">';
	
	if (!empty($form_action)) {
		print anchor('edge_user','Return To Your Profile', array('class'=>'logg-button','title'=>'Return To Your Profile', 'style'=>'float:right'));
		$form_attributes = array('class' => 'logg-form content-inner center');
		echo form_open($form_action, $form_attributes);
		
		print '<h1 style="margin-bottom:6pt;">Feedback</h1>';
		print '<p>Please enter your comments, suggestions, issues about The Edge&apos;s RFID Checkin System</p>';
		print '<br /><br />';
		
		print '<h3>Feedback Comments, Suggestions, Issues</h3>';
		 
		$feedback_attributes = array('name'=>'feedback_comment', 'id'=>'feedback_comment', 'class'=>'logg-textarea');
		echo form_textarea($feedback_attributes);
		print '<br /><br />';
		
		print '<p>';
		$attributes= array('value'=>'Send My Feedback','class'=>'logg-button','name'=>'submit', 'style'=>'float:right');
		echo form_submit($attributes);
		print '<br /><br />';
		
		print '</p>';
		 
		echo form_close();
	} else {
		print '<p>' . $message;
		print '<br /><br />';
		print '</p>';
		print anchor('edge_user','Return To Your Profile', array('class'=>'logg-button','title'=>'Return To Your Profile', 'style'=>'float:right'));
		print '<br /><br />';
	}
	print '</div>';

?>