<div id="form" style="width: 900px; margin-left: auto; margin-right: auto;">

<?php
	print $link_back;
	print '<br/>';
	print '<fieldset>';
	print '<legend>Project Listings</legend>';	
	//echo form_open('project/add');
//if(empty($project_id)&& $mode == 'update') echo "<p>NO PROJECT SELECTED</p>";
	print '<table cellspacing="3px" cellpadding="0" width="100%">';
	print '<thead>';
	print'<th style="width:30%">Name</th>';
	print '<th>Description</th>';
	print '<th></th>';
	print '</thead>';	
	print '<tbody>'	;
	print '<tr>';
	print '<td colspan="3">';
	print '<div style="max-height:400px;overflow:auto;">';
	print '<table>';
	foreach ($project_list as $key=>$value) {
		print '<tr valign="top">';
		print '<td>';
		print $value['Name'];
		print '</td>';
		print '<td>';
		print $value['Description'];
		print '</td>';
		print '<td>';
		echo anchor('project/profile/' . $value['ID'], 'EDIT');
	//	print '<a href="project_profiles.php?id=' .$value['ID'] . '" title="Modify Project \'' . $value['Name'] . '\'"><input type="button" name="edit"	value="Edit" /></a>';
		print '</td>';
		print '</tr>';
	}
	print '</table>';
	print '</div>';
	print '</td>';
	print '</tr>';
	print '<tr valign="top">';
	print '<td align="right" colspan="4">';
	print '<hr/>';
	//print anchor('project/create', "Create A New Project")
	print '<a href="project/create" title="Create A New Project"><input type="button" name="new_project"	value="Create Project" /></a>';
	print '</td>';
	print '</tr>';
	print '</tbody>'	;
	
	print '</table>';
	print '<hr />';
	//print '</form>';

print '</fieldset>';
?>
	</div>
