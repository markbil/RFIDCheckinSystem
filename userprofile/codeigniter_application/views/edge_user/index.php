<?php echo validation_errors('<div class="login-warning"><span class="center">', '</span></div>'); ?>
	<?php if (isset($message)) echo '<div class="login-warning"><span class="center">' . $message . '</span></div>'; ?>
	<?php if (isset($login_attempt)) echo '<div class="login-warning"><span class="center">' . $login_attempt . '</span></div>'; ?>

<div id="content" class="center">
	<!--<h2><?php echo $title; ?></h2>-->

	<?php
		$form_attributes = array('id' => 'login_form', 'class' => 'logg-form content-inner center');
		echo form_open('edge_user', $form_attributes);
	?>


	<h3>Username</h3>
	<input class="logg-textbox" type="text" name="username" value="" />

	<h3>Password</h3>
	<input class="logg-textbox" type="password" name="password" />

	<div class="login-submit-wrapper right">
		<input class="logg-button logg-submit" type="submit" value="Login" />
	</div>

	<?php echo anchor('edge_user/signup','Sign Up', array('title'=>'Register', 'class'=>'login-register'))?>

	<div class="clearfix"></div>

	</form>
</div>