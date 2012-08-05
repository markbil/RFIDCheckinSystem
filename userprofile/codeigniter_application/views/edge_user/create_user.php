<?php
	print validation_errors('<div class="login-warning center"><span class="center">', '</span></div>');
	if ($message) {
		print '<div class="logg-success"><span class="center">';
		print $message;
		print '</span></div>';
	}
	
	print '<div id="content" class="center">';
	print '<div class="content-inner center">';

    $form_attributes = array('class' => 'logg-form content-inner center');
	print form_open('edge_user/create', $form_attributes);

	print anchor('admin','Return To Admin', array('class'=>'logg-button','title'=>'Return To Admin', 'style'=>'float:left'));

	print '<br /><br />';
	print '<br /><br />';

	print '<h1 style="margin-bottom:6pt;">Add New User to Checkin System</h1>';
	print '<p>Please enter the users information below.<br /><br /></p>';
		
     print '<h3>First Name:</h3>';
	$first_name['class'] = 'logg-textbox';
	print form_input($first_name);
	print '<br /><br />';
                  
    print '<h3>Last Name:</h3>';
	$last_name['class'] = 'logg-textbox';
	print form_input($last_name);
	print '<br /><br />';
	      
	print '<h3>Email:</h3>';
	$email['class'] = 'logg-textbox';
	print form_input($email);
	print '<br /><br />';
	      
	print '<h3>Password:</h3>';
	$password['class'] = 'logg-textbox';
	print form_input($password);
	print '<br /><br />';
                  
    print '<h3>Confirm Password:</h3>';
	$password_confirm['class'] = 'logg-textbox';
	print form_input($password_confirm);
	print '<br /><br />';	      
      
	$submit_attributes = array(
			'name' => 'create_user_submit',
			'id' => 'create_user_submit',
			'class' => 'logg-button',
			'style' => 'float:right;',
	);
	
	print form_submit($submit_attributes, 'Create User');
	print '<br /><br />';     
      
    print form_close();

	print '</div>';
?>