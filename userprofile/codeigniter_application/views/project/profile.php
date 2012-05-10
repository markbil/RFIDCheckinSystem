
<div id="form"
	style="width: 500px; margin-left: auto; margin-right: auto;">
	<?php	
	echo $message;
	echo validation_errors();
	echo form_open($form_action);
	if($form_mode == 'create' || $form_mode == 'update') {

		print '<input name="is_update" type="hidden" value="true" />';
	}
	if($form_mode == 'update') {
		print '<input id="project_id" name="project_id" type="hidden" value="'. $project_details['ID'] .'" />';
	}
	print '<fieldset>';
	if ($form_mode == 'list') {
		print '<legend>Project Listings</legend>';
	} else {
		print '<legend>Project Profile</legend>';
	}
	//if(empty($project_id)&& $form_mode == 'update') echo "<p>NO PROJECT SELECTED</p>";

	if($form_mode=='update' || $form_mode=='create') {
		print '<table cellspacing="0" cellpadding="0" width="100%">';
		print '<thead>';
		if ($form_mode=='create')
			print'<th colspan="2">Create Project</th>';
		else
			print'<th colspan="2">Modify Project</th>';

		print '</thead>';
		print '<tr>';
		print'<td align="left">Project Name:</td>';
		print '<td>';
		print '<input type="text" name="name"	value="' . $project_details['Name'] . '"';
		//if(empty($project_id)&& $form_mode == 'update') echo "disabled=\"disabled\"";
		print '/></td>';
		print '</tr>';
		print '<tr>';
		print '	<td align="left" valign="top">Project Description:</td>';
		print '<td>';
		print '<textarea cols="30" rows="10" name="description"';
		//if(empty($project_id) && $form_mode == 'update') echo "disabled=\"disabled\"";
		print '>';
		print $project_details['Description'];
		print '</textarea>';
		print '</td>';
		print '</tr>';
		if ($form_mode!='create') {
			print '<tr>';
			print'<td valign="top" align="left">Collaborators:</td>';
			print '<td>';
			print  '<input type="submit" value="Add Collaborator" name="add_collaborator_btn"/>';
			print '<div style="min-height:200px;overflow-y:scroll;" id="user_listing">';
			$collaborators=$this->project_model->get_collaborators($project_details['ID']);
			if (count($collaborators)) {
				print '<table>';
				foreach($collaborators as $user_id=>$username) {
					print '<tr>';
					print '<td>';
					print '<input type="checkbox" name="user_' . $user_id . '" checked />'.$username;
					print '</td>';
					print '</tr>';
				}
			print '</td>';
			print '</tr>';
			print '</table>';
			} else {
				print '<span>No Collaborators on this project!</span>';
			}
			
			//display_project_user_list($project_id);
			print '</div>';
		}
		print '</table>';
	}
	print '<hr />';
	if ($form_mode == 'create' || $form_mode == 'update') {
		echo $link_back;
		//anchor('project', 'Return To List');
		print '<input type="submit" value="';
		if($form_mode=='create') echo  'Create'; else echo 'Update';
		print '" />';
		//print '<a href="project_profiles.php"><input type="button" name="cancel" value="Cancel" />';
		//print '</a>';
		print '</form>';
	}
	print '</fieldset>';
	?>
</div>
