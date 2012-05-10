
<div id="form"
	style="width: 500px; margin-left: auto; margin-right: auto;">
	<fieldset>
		<legend>
			Edge Profile -
			<?php echo $title; ?>
		</legend>
		<?php echo validation_errors(); ?>
		<?php echo $message; ?>
		<?php echo anchor('edge_user/logout', 'Log Out', array('style'=>'float:right','title'=>'Exit System')); ?>
		<?php echo form_open($form_action) ?>
		<input type="hidden" name="id"
			value="<?php echo $user_details['ID']; ?>" />
		<table cellspacing="0" cellpadding="0" width="100%">
			<tr>
				<th colspan="2">General Info</th>
			</tr>
			<tr>
				<td width="50%" align="right">Swipe Card ID:</td>
				<td width="50%"><input type="text" name="swipe" readonly="readonly"
					value="<?php if (empty($user_details['ThirdPartyID'])) echo "To Be Allocated";
												else echo $user_details['ThirdPartyID']; ?>" /></td>
			</tr>

			<tr>
				<td width="50%" align="right">Username:</td>
				<td><input type="text" name="username" readonly="readonly"
					value="<?php echo $user_details['username']; ?>" /></td>
			</tr>
			<tr>
				<td width="50%" align="right">First name:</td>
				<td><input type="text" name="firstname"
					value="<?php echo $user_details['firstname'];?>" /></td>
			</tr>
			<tr>
				<td width="50%" align="right">Last name:</td>
				<td><input type="text" name="lastname"
					value="<?php echo $user_details['lastname'];?>" /></td>
			</tr>
			<tr>
				<td width="50%" align="right">Email:</td>
				<td><input type="text" name="email"
					value="<?php echo $user_details['email'];?>" /></td>
			</tr>
			<tr>
				<td width="50%" align="right">Occupation:</td>
				<td><input type="text" name="occupation"
					value="<?php echo $user_details['occupation'];?>" /></td>
			</tr>
			<tr>
				<td width="50%" align="right">Do Not Disturb:</td>
				<td><input type="checkbox" name="dontdisturb"
				<?php echo ($user_details['dontdisturb'] == 1) ? 'checked="true"' : null; ?>
					value="<?php echo ($user_details['dontdisturb'] == 1) ? "do_not" : "do"; ?>" />
				</td>
			</tr>
			<tr></tr>
			<tr>
				<td align="right" colspan="2">
				 <input type="submit" value="Update" />
					<hr />
				</td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					<?php 
					echo anchor('project','View Projects', array('title'=>'View List Of Projects'));
					?> 
				</td>
			</tr>
		</table>
		<hr />
		<div id="interests">
			<span style="background-color: grey; cursor: default;">
				What are your interests?
			</span>
			<table id="interestsTbl" cellspacing="0" cellpadding="0" width="100%">
				<?php
	 				print '<tr>';
					print '<td align="left">';
					print '<input type="text" name="new_interest" value="" />';
					print '<select name="new_interest_level" title="Level Of Interest">';
					print '<option value="0">Level</option>';
					print '<option value="1">1</option>';
					print '<option value="2">2</option>';
					print '<option value="3">3</option>';
					print '<option value="4" >4</option>';
					print '<option value="5">5</option>';
					print '</select>';
		 			print '<input type="submit" value="Add" />';
					print '</td>';
					print '</tr>';
								
					if (isset($interests)) {
							print '<tr>';
							print '<td align="left">';
							print '<div style="overflow-y: scroll; max-height: 80px;">';
							print '<table>';
						foreach($interests as $interest) {
							print '<tr>';
							print '<td>';
							print '<input type="checkbox" name="interest_' . $interest['ID'] . '" value="' . $interest['ID'] . '" checked />'.$interest['interest'];
							print '</td>';
							print '<td>';
							print '<select name="interest_level_' . $interest['ID'] . '">';
							for($i=1;$i<6;$i++) {
									print '<option value="' . $i . '" ';
									if ($i==$interest['level']) print "selected ";
									print '>' . $i . '</option>';
							}
							print '</select>';
							print '</td>';
							print '</tr>';
						}
							print '</table>';
							print '</div>';
							print '</td>';
							print '</tr>';
						if (count($interests)) {
							print '<tr>';
							print '<td align="left">';
							print '<input type="submit" value="Update" />';
							print '</td>';
							print '</tr>';
						}
					}
				?>
			</table>
		</div>
		<hr />
		<div id="expertise">
			<span style="background-color: grey; cursor: default;">
				What are you good in (tools / software / techniques / creative practices)? >>
			</span>
			<table id="expertiseTbl" cellspacing="0" cellpadding="0" width="100%">
				<?php
	 				print '<tr>';
					print '<td align="left">';
					print '<input type="text" name="new_expertise" value="" />';
					print '<select name="new_expertise_level" title="Level Of Expertise">';
					print '<option value="0">Level</option>';
					print '<option value="1">1</option>';
					print '<option value="2">2</option>';
					print '<option value="3">3</option>';
					print '<option value="4" >4</option>';
					print '<option value="5">5</option>';
					print '</select>';
		 			print '<input type="submit" value="Add" />';
					print '</td>';
					print '</tr>';
								
					if (isset($expertises)) {
							print '<tr>';
							print '<td align="left">';
							print '<div style="overflow-y: scroll; max-height: 80px;">';
							print '<table>';
						foreach($expertises as $expertise) {
							print '<tr>';
							print '<td>';
							print '<input type="checkbox" name="expertise_' . $expertise['ID'] . '" value="' . $expertise['ID'] . '" checked />'.$expertise['expertise'];
							print '</td>';
							print '<td>';
							print '<select name="expertise_level_' . $expertise['ID'] . '">';
							for($i=1;$i<6;$i++) {
									print '<option value="' . $i . '" ';
									if ($i==$expertise['level']) print "selected ";
									print '>' . $i . '</option>';
							}
							print '</select>';
							print '</td>';
							print '</tr>';
						}
							print '</table>';
							print '</div>';
							print '</td>';
							print '</tr>';
						if (count($expertises)) {
							print '<tr>';
							print '<td align="left">';
							print '<input type="submit" value="Update" />';
							print '</td>';
							print '</tr>';
						}
					}
				?>

			</table>
		</div>

		<hr />

		<div id="question">
			<span style="background-color: grey; cursor: default;">
				What's your question to the Edge community? What help/skills would you like to get from others? >>
			</span>
			<table id="questionTbl" cellspacing="0" cellpadding="0" width="100%">
				<?php
				print '<tr>';
				print '<td align="left">';
				print '<input type="text" name="new_question" value="" />';
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

			</table>
		</div>
		
		<hr />
	</fieldset>
	</form>
</div>
