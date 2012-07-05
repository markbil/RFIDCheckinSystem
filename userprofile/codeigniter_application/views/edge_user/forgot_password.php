<div id="content" class="center"><div class="content-inner logg-form center">

	<h1 style="margin-bottom:4pt;">Forgot Password</h1>
	<p>Please enter your email address so we can send you an email to reset your password.</p>

	<div id="infoMessage"><?php echo $message;?></div>

	<?php echo form_open("auth/forgot_password");?>

	      <h3 style="margin-top:16pt; margin-bottom:6pt;">Email Address:</h3>
	      <?php
	            $email['class'] = 'logg-textbox';
	            echo form_input($email);
	      ?>
	      
	      <p><?php
	            $submit_attributes = array( 'class' => 'logg-button logg-submit' );
	            echo form_submit('submit', 'Submit', $submit_attributes);
		 		echo anchor('edge_user','Cancel', array('class'=>'logg-button','title'=>'Cancel'));
	            ?></p>
	      
	<?php echo form_close();?>

</div></div>