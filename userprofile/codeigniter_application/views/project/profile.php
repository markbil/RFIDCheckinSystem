<?php	
	if($is_admin) {
		print anchor('admin','Return To Admin', array('class'=>'logg-button','title'=>'Return To Admin', 'style'=>'float:right'));
	}
	print anchor('project','Return To Project List', array('class'=>'logg-button','title'=>'Return To List Of Projects', 'style'=>'float:right'));
	print '<br><br>';
	print form_open($form_action, array('id'=>'profile-form', 'class' => 'logg-form content-inner center'));
	
	echo $message;
	echo validation_errors();
	echo form_open($form_action);
	if($form_mode == 'create' || $form_mode == 'update') {
		print '<input name="is_update" type="hidden" value="true" />';
	}
	if($form_mode == 'update'|| $form_mode=='delete') {
		print '<input id="project_id" name="project_id" type="hidden" value="'. $project_details['ID'] .'" />';
	}
	print '<fieldset>';
	if ($form_mode == 'list') {
		print '<legend>Project Listings</legend>';
	} else {
		print '<legend>Project Profile</legend>';
	}
	//if(empty($project_id)&& $form_mode == 'update') echo "<p>NO PROJECT SELECTED</p>";

	if($form_mode=='update' || $form_mode=='create'|| $form_mode=='delete') {
		print '<table cellspacing="0" cellpadding="0" width="100%">';
		print '<thead>';
		if ($form_mode=='create')
			print'<th colspan="2">Create Project</th>';
		else if($form_mode=='update')
			print'<th colspan="2">Modify Project</th>';
		else if($form_mode=='delete')
			print'<th colspan="2">Delete Project</th>';
		
		print '</thead>';
		print '<tr>';
		print'<td align="left">Project Name:</td>';
		print '<td>';
		print '<input type="text" name="name"	value="' . $project_details['Name'] . '"';
		print '/></td>';
		print '</tr>';
		print '<tr>';
		print '	<td align="left" valign="top">Project Description:</td>';
		print '<td>';
		print '<textarea cols="30" rows="10" name="description"';
		print '>';
		print $project_details['Description'];
		print '</textarea>';
		print '</td>';
		print '</tr>';
		if ($form_mode!='create') {
			print '<tr>';
			print'<td valign="top" align="left">Collaborators:</td>';
			print '<td>';
		//	print anchor('submit','Add Collaborator', array('class'=>'logg-button','title'=>'Add Collaborator To Project'));
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
			print '</div>';
		}
		print '</table>';
	}
	print '<hr />';
	if ($form_mode == 'create' || $form_mode == 'update'|| $form_mode == 'delete') {
		//echo $link_back;
		$submit_value='Update';
		$submit_name = 'update';
		$submit_delete=null;
		if($form_mode=='create') {
			$submit_value = 'Create';
			$submit_name = 'create';
		} else {
			$submit_delete='<input type="submit" name="delete" value="Delete" onclick="javascript:return confirm(\'Are you sure you want to delete Project &quot;' . $project_details['Name'] . '&quot; ? \')" />';
		}
		print '<input type="submit" name="' .$submit_name . '" value="' . $submit_value . '" />';
		if (!empty($submit_delete)) {
			print $submit_delete;
		}

    		print form_close();
	}
	
	print '</fieldset>';
	print '</div>';
	?>

