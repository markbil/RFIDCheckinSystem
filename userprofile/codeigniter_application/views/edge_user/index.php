<?php echo validation_errors('<div class="login-warning"><span class="center">', '</span></div>'); ?>
	<?php if (isset($message)) echo '<div class="login-warning"><span class="center">' . $message . '</span></div>'; ?>
	<?php if (isset($login_attempt)) echo '<div class="login-warning"><span class="center">' . $login_attempt . '</span></div>'; ?>

<div id="content" class="center">
	<!--<h2><?php echo $title; ?></h2>-->

	<?php
		$form_attributes = array('id' => 'edge_user/login', 'class' => 'logg-form content-inner center');
		echo form_open('edge_user', $form_attributes);
	?>


<!-- 	<input class="logg-textbox" type="text" name="username" value="" /> -->
       	<label for="identity">Email/Username:</label>
      	<?php echo form_input($identity);?>
	
	<h3>Password</h3>
<!-- 	<input class="logg-textbox" type="password" name="password" /> -->
      	<?php echo form_input($password);?>
	
	<div class="login-submit-wrapper right">
		<input class="logg-button logg-submit" type="submit" value="Login" />
	</div>
<<<<<<< HEAD

	<?php echo anchor('edge_user/signup','Sign Up', array('title'=>'Register', 'class'=>'login-register'))?>

=======
      <div>
	      <label for="remember">Remember Me Please:</label>
	      <?php echo form_checkbox('remember', '1', FALSE, 'id="remember"');?>
	  </div>
	
>>>>>>> dcc18e94266add54ae452271af3aa5be151a247c
	<div class="clearfix"></div>

    <?php echo form_close();?>

    <div>
    <?php echo anchor('edge_user/forgot_password','Forgot your password?', array('title'=>'Forgot your password?', 'class'=>'logg-button login-register'))?>
    </div>
	</div>
