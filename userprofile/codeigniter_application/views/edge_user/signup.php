<?php echo validation_errors('<div class="login-warning"><span class="center">', '</span></div>'); ?>

<div id="content" class="center">
	<?php
		$form_attributes = array('id' => 'signup_form', 'class' => 'logg-form content-inner center');
		echo form_open('edge_user/signup', $form_attributes)
	?>
		<h3>Username:</h3>
		<input type="text" name="username" class="logg-textbox" /><br />
		
		<h3>Password:</h3>
		<input type="password" name="password" class="logg-textbox" /><br />

		<h3>Re-enter Password:</h3>
		<input type="password" name="password_confirm" class="logg-textbox" /><br />
		
		<div class="login-submit-wrapper right">
			<input class="logg-button logg-submit" type="submit" value="Sign Up" />
		</div>
		<div class="clearfix"></div>
	</form>
</div>