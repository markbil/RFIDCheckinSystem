<?php
print validation_errors('<div class="login-warning center"><span class="center">', '</span></div>');
if ($message) {
	print '<div class="logg-success center"><span class="center">';
	print $message;
	print '</span></div>';
}
?>
<div id="content" class="center">
	<?php
	print form_open($form_action, array('id'=>'profile-form', 'class' => 'logg-form content-inner center'));
	print '<input type="hidden" name="id" value="'. $user_details["ID"] . '" />';
	print anchor('edge_user/change_password','Change Password', array('class'=>'logg-button','title'=>'Change Your Password'));
	//print anchor('project','View Projects', array('class'=>'logg-button','title'=>'View List Of Projects'));
	if ($is_admin) {
		print anchor('a', 'A', array('style'=>'visibility:hidden;'));
		print anchor('admin', 'Admin', array('class'=>'logg-button','title'=>'Admin'));
	}
	print anchor('edge_user/logout', 'Logout', array('class'=>'logg-button right','title'=>'Logout'));
	?>

	<br /> <br /> <br />

	<h1>Profile Info</h1>

	<div class="collapse-head collapse-nohide collapse-floating"
		id="collapse-profile">
		<h3 class="inline-block">Profile Info</h3>
		<div class="collapsed-arrow right"
			id="collapse-profile-arrow-collapsed">&#9660;</div>
		<div class="expanded-arrow right" id="collapse-profile-arrow-expanded">&#9650;</div>
	</div>
	<div class="collapse-content" id="collapse-profile-content">
		<?php
		if ($is_admin) {
			$active_checked=empty($user_details['active']) ? null:'checked';
			print '<input type="checkbox" title="Active" name="active" value="' . $user_details["active"] . '" ' . $active_checked . ' />';
			print '<span>&nbsp;Is Active ?</span>';

			print '<span>&nbsp;&nbsp;</span>';
			$admin_checked=empty($user_details['is_admin']) ? null:'checked';
			print '<input type="checkbox" title="Administration Access" name="is_admin" value="' . $user_details['is_admin'] . '" ' . $admin_checked . ' />';
			print '<span>&nbsp;Allow Administration Access ?</span>';

			print '<h3>Swipe Card ID:</h3>';
			print '<input type="text" class="logg-textbox" id="user_profile_rfid" name="swipe" ';
			if (empty($user_details['ThirdPartyID'])) {
				print 'value="To Be Allocated" ';
			} else {
				print 'value="' . $user_details['ThirdPartyID'] . '" disabled="disabled" ';
			}
			print ' />';

			$identification_id=empty($user_details['identification_id']) ? null:$user_details['identification_id'];
			print '<input type="hidden" id="user_profile_rfid_ID" name="user_profile_rfid_ID" value="'.   $identification_id . '" />';
		}
		?>

		<h3>Username:</h3>
		<input type="text" class="logg-textbox logg-readonly" name="username"
			readonly="readonly" value="<?php print $user_details['username']; ?>" />

		<h3>First name:</h3>
		<input type="text" class="logg-textbox" name="firstname"
			value="<?php print $user_details['firstname'];?>" />

		<h3>Last name:</h3>
		<input type="text" class="logg-textbox" name="lastname"
			value="<?php print $user_details['lastname'];?>" />

		<h3>Email:</h3>
		<input type="text" class="logg-textbox" name="email"
			value="<?php print $user_details['email'];?>" />

		<!--  Group Listing For User -->
		<br />
		<?php
		if ($is_admin) {
			print '<div class="collapse-head" id="collapse-groups">';
			print '<div class="collapsed-arrow right" id="collapse-groups-arrow-collapsed">&#9660;</div>';
			print '<div class="expanded-arrow right" id="collapse-groups-arrow-expanded">&#9650;</div>';
			print '<h3 class="inline">User Groups</h3>';
			print '</div>';
			print '<div class="collapse-content" id="collapse-groups-content">';
			print '<h3>Groups that Edge User Belongs To</h3>';
			$users_groups=empty($user_details['groups'])?array():$user_details['groups'];

			print '<table class="user-group-list">';

			foreach($groups as $group_id=>$group_name) {
				print '<tr class="interest-space"></tr>';

				print '<tr>';
				print '<td class="interest-name logg-textbox  logg-readonly">' . $group_name . '</td>';
				print '<td>';
				print '<input type="checkbox" title="Select Group" name="group_' . $group_id . '" value="' . $group_id . '" ';
				print array_key_exists($group_id, $users_groups) ? 'checked ':null;
				print '/>';
				print '</td>';
				print '</tr>'; // group-item
			}
			print '</table>'; // group-list
			print '</div>';
		}
		?>

		<br /> <br />

		<div class="right">
			<input class="logg-button" type="submit" value="Add/Update" />
		</div>

	</div>
	<br /> <br /> <br /> <br /> <br />

	<h1>What are you up to at The Edge today?</h1>

	<div class="collapse-head no-collapse" id="collapse-donotdisturb"
		click-on-click="dontdisturb">
		<input id="dontdisturb" type="checkbox" class="logg-checkbox"
			name="dontdisturb"
			<?php print ($user_details['dontdisturb'] == 1) ? 'checked="true"' : null; ?>
			value="<?php print ($user_details['dontdisturb'] == 1) ? "do_not" : "do"; ?>" />
		<h3 class="inline">I'm busy, don't disturb me</h3>
	</div>
	<br /> <br />

	<div class="collapse-head" id="collapse-cometalk">
		<div class="collapsed-arrow right"
			id="collapse-cometalk-arrow-collapsed">&#9660;</div>
		<div class="expanded-arrow right"
			id="collapse-cometalk-arrow-expanded">&#9650;</div>
		<input type="checkbox" class="logg-checkbox" name="status-cometalk"
			checked />
		<h3 class="inline">Just hanging out today, come talk to me!</h3>
	</div>
	<div class="collapse-content" id="collapse-cometalk-content">
		<h3>My background / interests / hobbies</h3>
		<div id="interest_list">
			<?php
			print $profile['interests'];
			?>
		</div>
		<table style="width: 100%">
			<tr class="interest-space"></tr>
			<tr>
				<td style="width: 100%"><input type="text" id="new_interest"
					class="interest-name logg-textbox" name="new_interest" value="" />
				</td>
				<td><select id="new_interest_level" name="new_interest_level" style="display: inline"
					title="Level of interest">
						<option id="new_interest_level_opt1" value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				</select>
				</td>
				<td><input id="new_interest_checkbox" type="checkbox" style="visibility: hidden" /></td>
			</tr>
		</table>

	<div class="right">
		<input name="interest_update" id="interest_update" class="logg-button" type="submit" value="Add/Update" />
	</div>
	</div>
	<br /> <br />

	<div class="collapse-head" id="collapse-goodwith">
		<div class="collapsed-arrow right"
			id="collapse-goodwith-arrow-collapsed">&#9660;</div>
		<div class="expanded-arrow right"
			id="collapse-goodwith-arrow-expanded">&#9650;</div>
		<input type="checkbox" class="logg-checkbox" name="status-shareskills" />
		<h3 class="inline">I am happy to share my skills!</h3>
		<div id="skills_i_share"></div>
	</div>
	<div class="collapse-content" id="collapse-goodwith-content">
		<h3>Skills I can share with other Edge users</h3>

		<div id="skills_list">
			<?php
			if (isset($user_details['expertises'])) {
				print '<table class="interest-list">';

				foreach($user_details['expertises'] as $expertise) {
					print '<tr class="interest-space"></tr>';

					print '<tr>';
					print '<td class="interest-name logg-textbox  logg-readonly">' . $expertise['expertise'] . '</td>';
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

		</div>
		<table style="width: 100%">
			<tr class="interest-space"></tr>
			<tr>
				<td style="width: 100%"><input type="text"
					class="interest-name logg-textbox" name="new_expertise" value="" />
				</td>
				<td><select name="new_expertise_level" title="Level of expertise">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				</select>
				</td>
				<td><input type="checkbox" style="visibility: hidden" /></td>
			</tr>
		</table>

		<div class="right">
			<input class="logg-button" type="submit" value="Add/Update" />
		</div>

	</div>

	<br /> <br />

	<div class="collapse-head" id="collapse-question">
		<div class="collapsed-arrow right"
			id="collapse-question-arrow-collapsed">&#9660;</div>
		<div class="expanded-arrow right"
			id="collapse-question-arrow-expanded">&#9650;</div>
		<input type="checkbox" class="logg-checkbox" name="status-needhelp" />
		<h3 class="inline-block">I need your help &#46;&#46;&#46;</h3>
	</div>
	<div class="collapse-content" id="collapse-question-content">
		<h3>I need someone's help with &#46;&#46;&#46;</h3>
		<span class="subtitle">(My project ideas / questions)</span>
		<div id="questions_list">
			<?php
			if (isset($user_details['questions'])) {
				print '<table class="interest-list">';

				foreach($user_details['questions'] as $question) {
					print '<tr class="interest-space"></tr>';

					print '<tr>';
					print '<td class="interest-name logg-textbox  logg-readonly">' . $question['question'] . '</td>';
					print '<td><input type="checkbox" title="Keep question" name="question_' . $question['ID'] . '" value="' . $question['ID'] . '" checked /></td>';
					print '</tr>'; // interest-item
				}
				print '</table>'; // interest-list
			}
			?>
		</div>
		<table style="width: 100%">
			<tr class="interest-space"></tr>
			<tr>
				<td style="width: 100%"><input type="text"
					class="interest-name logg-textbox" name="new_question" value="" />
				</td>
				<td><input type="checkbox" style="visibility: hidden" /></td>
			</tr>
		</table>

		<div class="right">
			<input class="logg-button" type="submit" value="Add/Update" />
		</div>

	</div>

	<br /> <br />

	<div class="collapse-head no-collapse" id="collapse-donotdisturb">
		<input type="checkbox" class="logg-checkbox" name="status-new" />
		<h3 class="inline">I'm new here, and don't really know what The Edge
			is about yet &#46;&#46;&#46;</h3>
	</div>
	<br /> <br />

	<div class="collapse-head no-collapse" id="collapse-donotdisturb">
		<input type="checkbox" class="logg-checkbox" name="status-message" />
		<h3 class="inline">Other status message:</h3>
		<input type="text" style="margin-bottom: 0; margin-top: 3pt;"
			class="interest-name logg-textbox" name="status_message" value="" />

	</div>
	<br /> <br />

	<?php 
	//print anchor('project','View Projects', array('class'=>'logg-button','title'=>'View List Of Projects'));
	?>
	<div class="right">
		<input type="submit" class="logg-button logg-submit" value="Update" />
	</div>
	<div class="clearfix"></div>
</div>
