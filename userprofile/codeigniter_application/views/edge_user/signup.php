<?php echo validation_errors('<div class="login-warning"><span class="center">', '</span></div>'); ?>

<<<<<<< HEAD
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
=======
	<div style="width: 400px; margin-left: auto; margin-right: auto;">
		<fieldset>
			<legend>The Edge<br/>Signup for the Checkin System</legend>
			<table>
					<?php echo form_open('edge_user/signup') ?>
					<tr>
						<td>Choose a Username:</td>
						<td><input type="text" name="username" /></td>
					</tr>
					<tr>
						<td>Choose a Password:</td>
						<td><input type="password" name="password" /></td>
					</tr>
					<tr>
						<td>Re-enter your chosen a Password:</td>
						<td><input type="password" name="password_confirm" /></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
								<?php echo form_submit('submit', 'Register Me');?>
						</td>
					</tr>
    <?php echo form_close();?>
					</table>
		</fieldset>
	</div>
>>>>>>> dcc18e94266add54ae452271af3aa5be151a247c
