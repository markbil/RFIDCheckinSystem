<?php echo validation_errors('<div class="login-warning"><span class="center">', '</span></div>'); ?>
<?php 
	if ($message) {
		echo '<div class="logg-success">';
		echo $message;
		echo '</div>';
	}
?>


<div id="content">
	<?php echo form_open($form_action, array('id'=>'profile-form', 'class' => 'logg-form content-inner center')) ?>
		<input type="hidden" name="id" value="<?php echo $user_details['ID']; ?>" />
		<?php echo anchor('edge_user/logout', 'Logout', array('class'=>'logg-button right','title'=>'Logout')); ?>

		<h1>Profile Info</h1>

		<h3>Swipe Card ID:</h3>
		<input type="text" class="logg-textbox" name="swipe" readonly="readonly"
			value="<?php if (empty($user_details['ThirdPartyID'])) echo "To Be Allocated";
			else echo $user_details['ThirdPartyID']; ?>" />

		<h3>Username:</h3>
		<input type="text" class="logg-textbox" name="username" readonly="readonly"
			value="<?php echo $user_details['username']; ?>" />

		<h3>First name:</h3>
		<input type="text" class="logg-textbox" name="firstname"
			value="<?php echo $user_details['firstname'];?>" />

		<h3>Last name:</h3>
		<input type="text" class="logg-textbox" name="lastname"
			value="<?php echo $user_details['lastname'];?>" />

		<h3>Email:</h3>
		<input type="text" class="logg-textbox" name="email"
			value="<?php echo $user_details['email'];?>" />

		<h3>Occupation:</h3>
		<input type="text" class="logg-textbox" name="occupation"
			value="<?php echo $user_details['occupation'];?>" />

		<h3 class="inline-block">Do Not Disturb:</h3>
		<input type="checkbox" class="logg-checkbox" name="dontdisturb"
		<?php echo ($user_details['dontdisturb'] == 1) ? 'checked="true"' : null; ?>
			value="<?php echo ($user_details['dontdisturb'] == 1) ? "do_not" : "do"; ?>" />
		<br />

		<div class="right">
			<input type="submit" class="logg-button logg-submit" value="Update" />
		</div>
		<div class="clearfix"></div>

		<br /><br /><br /><br />


		<h3>What are your interests?</h3>
		<div class="interest-space"></div>

		<?php
			if (isset($interests)) {
				print '<table class="interest-list"';

				foreach($interests as $interest) {
					print '<tr class="interest-space"></tr>';

					print '<tr>';
					print '<td class="interest-name logg-textbox">' . $interest['interest'] . '</td>';
					print '<td><select title="Interest level" name="interest_level_' . $interest['ID'] . '">';
					for($i=1;$i<6;$i++) {
							print '<option value="' . $i . '" ';
							if ($i==$interest['level']) print "selected ";
							print '>' . $i . '</option>';
					}
					print '</select></td>';
					print '<td><input type="checkbox" title="Keep interest" name="interest_' . $interest['ID'] . '" value="' . $interest['ID'] . '" checked /></td>';
					print '</tr>'; // interest-item
				}
				print '</table>'; // interest-list
			}

		?>

		<table style="width: 100%">
			<tr class="interest-space"></tr>
			<tr>
				<td style="width: 100%">
					<input type="text" style="background:#e3f2c9" class="interest-name logg-textbox" name="new_interest" value="" />
				</td>
				<td>
					<select name="new_interest_level" title="Level of interest">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</td>
				<td><input type="checkbox" style="visibility:hidden"/></td>
			</tr>
		</table>

		<div class="right">
			<input class="logg-button" type="submit" value="Add/Update" />
		</div>
		<br /><br /><br /><br /><br />


		<h3>What are you good with?</h3> <span class="subtitle">(tools / software / techniques / creative practices)</span>
		<div class="interest-space"></div>

		<?php
			if (isset($expertises)) {
				print '<table class="interest-list"';

				foreach($expertises as $expertise) {
					print '<tr class="interest-space"></tr>';

					print '<tr>';
					print '<td class="interest-name logg-textbox">' . $expertise['expertise'] . '</td>';
					print '<td><select title="Expertise level" name="expertise_level_' . $expertise['ID'] . '">';
					for($i=1;$i<6;$i++) {
							print '<option value="' . $i . '" ';
							if ($i==$expertise['level']) print "selected ";
							print '>' . $i . '</option>';
					}
					print '</select></td>';
					print '<td><input type="checkbox" title="Keep expertise" name="expertise_' . $expertise['ID'] . '" value="' . $expertise['ID'] . '" checked /></td>';
					print '</tr>'; // interest-item
				}
				print '</table>'; // interest-list
			}

		?>

		<table style="width: 100%">
			<tr class="interest-space"></tr>
			<tr>
				<td style="width: 100%">
					<input type="text" style="background:#e3f2c9" class="interest-name logg-textbox" name="new_expertise" value="" />
				</td>
				<td>
					<select name="new_expertise_level" title="Level of expertise">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</td>
				<td><input type="checkbox" style="visibility:hidden"/></td>
			</tr>
		</table>

		<div class="right">
			<input class="logg-button" type="submit" value="Add/Update" />
		</div>
		<br /><br /><br /><br /><br />


		What's your question to the Edge community? What help/skills would you like to get from others?
						<?php
						print '<tr>';
						print '<td align="left">';
						print '<input type="text" class="logg-textbox" name="new_question" value="" />';
						print '<input type="submit" value="Add" />';
						print '</td>';
						print '</tr>';

						if (isset($questions)) {
							print '<tr>';
							print '<td align="left">';
							print '<div style="overflow-y: scroll; max-height: 80px;">';
							print '<table>';
							foreach($questions as $question) {
								print '<tr>';
								print '<td>';
								print '<input type="checkbox" name="question_' . $question['ID'] . '" value="' . $question['ID'] . '" checked />'.$question['question'];
								print '</td>';
								print '</tr>';
							}
							print '</table>';
							print '</div>';
							print '</td>';
							print '</tr>';
							if (count($questions)) {
								print '<tr>';
								print '<td align="left">';
								print '<input type="submit" value="Update" />';
								print '</td>';
								print '</tr>';
							}
						}
						?>


		<?php 
			echo anchor('project','View Projects', array('title'=>'View List Of Projects'));
		?> 
</div>