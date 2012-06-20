<?php echo validation_errors(); ?>

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
