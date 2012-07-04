<?php echo validation_errors('<div class="login-warning center"><span class="center">', '</span></div>'); ?>

<div id="content" class="center">

      <?php
            $form_attributes = array('class' => 'logg-form content-inner center');
            echo form_open('edge_user/create', $form_attributes);
            
            print anchor('admin','Return To Admin', array('class'=>'logg-button','title'=>'Return To Admin', 'style'=>'float:right'));
            
      ?>

	<h1 style="margin-bottom:6pt;">Create User</h1>
	<p>Please enter the users information below.<br /><br />
	
	<!--<div id="infoMessage"><?php echo $message;?></div>-->
      <br />
	
      <h3>First Name:</h3>
      <?php
            $first_name['class'] = 'logg-textbox';
            echo form_input($first_name);
      ?>
      <br /><br />
      
      <h3>Last Name:</h3>
      <?php
            $last_name['class'] = 'logg-textbox';
            echo form_input($last_name);
      ?>
      <br /><br />
      
      <h3>Email:</h3>
      <?php
            $email['class'] = 'logg-textbox';
            echo form_input($email);
      ?>
      <br /><br />
      
      <h3>Password:</h3>
      <?php
            $password['class'] = 'logg-textbox';
            echo form_input($password);
      ?>
      <br /><br />
      
      <h3>Confirm Password:</h3>
      <?php
            $password_confirm['class'] = 'logg-textbox';
            echo form_input($password_confirm);
      ?>
      <br /><br />
      
      
      <h3><?php echo form_submit('submit', 'Create User');?><br /><br />

      
    <?php echo form_close();?>

</div>
