<?php echo validation_errors(); ?>

<div style="margin-left: auto; margin-right: auto; width: 30%">
	<h2><?php echo $title; ?></h2>
	<?php if (isset($message)) echo "<h3>$message</h3>"; ?>
	<?php if (isset($login_attempt)) echo "<h3>$login_attempt</h3>"; ?>
	<?php echo form_open('edge_user') ?>
	<table width="30%">
			<tr>
				<td align="right" width="50%">User Name</td>
				<td align="left" width="50%"><input type="text" name="username"
					value="" />
				</td>
			</tr>
			<tr>
				<td align="right" width="50%">Password</td>
				<td align="left" width="50%"><input type="password" name="password" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right" width="50%"><input type="submit"
					value="Log Me In" /> <br /> <br />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
<!-- 				<a href="signup">Sign Up For An Account</a> -->
				<?php echo anchor('edge_user/signup','Sign Up For An Account', array('title'=>'Create an Account'))?>
				</td>
			</tr>
		</table>
	</form>
</div>
