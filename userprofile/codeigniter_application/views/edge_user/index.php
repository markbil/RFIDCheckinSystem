<?php echo validation_errors('<div class="login-warning"><span class="center">', '</span></div>'); ?>
<!--<?php if (isset($message)) echo '<div class="login-warning"><span class="center">' . $message . '</span></div>'; ?>
<?php if (isset($login_attempt)) echo '<div class="login-warning"><span class="center">' . $login_attempt . '</span></div>'; ?>-->

<div id="content" class="center">

	<?php
		$form_attributes = array('id' => 'edge_user/login', 'class' => 'logg-form content-inner center');
		echo form_open('edge_user', $form_attributes);
	?>


       	<label for="identity" class="h3">Email/Username</label>
      	<?php
      		$identity['class'] = 'logg-textbox';
      		echo form_input($identity);
      	?>
	
		<h3>Password</h3>
	    <?php
      		$password['class'] = 'logg-textbox';
	      	echo form_input($password);
	    ?>
		
		<div class="login-submit-wrapper right">
			<input class="logg-button logg-submit" type="submit" value="Login" />
		</div>

	    <div>
		    <?php echo form_checkbox('remember', '1', FALSE, 'id="remember"');?>
		    <label for="remember">Remember Me</label>
		</div>
		
		<div class="clearfix"></div>

    <?php echo form_close();?>

    <div class="content-inner center" style="margin-top: 1.4em;">
    	<?php echo anchor('edge_user/forgot_password','Forgot your password?', array('title'=>'Forgot your password?', 'style'=>'text-decoration: none;'))?>
    </div>

</div>