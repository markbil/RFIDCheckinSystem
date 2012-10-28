<?php

if (isset($profile['interests'])) {
	print '<table class="interest-list">';

	foreach($profile['interests'] as $key=>$interest) {
		print '<tr class="interest-space"></tr>';
			
		print'<tr>';
		print '<td class="interest-name logg-textbox logg-readonly">' . $interest['interest'] . '</td>';
		print '<td>';
		print '<select style="display:inline" title="Interest level" name="interest_level_' . $interest['ID'] . '">';
		for($i=1;$i<6;$i++) {
			print '<option value="' . $i . '" ';
			if ($i==$interest['level']) print "selected ";
			print '>' . $i . '</option>';
		}
		print '</select>';
		print '</td>';
		print  '<td><input type="checkbox" title="Keep interest" name="interest_' . $interest['ID'] . '" value="' . $interest['ID'] . '" checked /></td>';
		print '</tr>'; // interest-item
	}
	print '</table>'; // interest-list
}

?>