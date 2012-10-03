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
            $form_attributes = array('class' => 'logg-form content-inner center');
            echo form_open('edge_user/change_password/', $form_attributes);
      ?>

            <h1>Change Password</h1>

            <h3>Old Password</h3>
            <?php
                  $old_password['class'] = 'logg-textbox';
                  echo form_input($old_password);
            ?>
            <br /><br />
            
            <h3>New Password <span class="subtitle">(at least <?php echo $min_password_length;?> characters long)</span></h3>
            <?php
                  $new_password['class'] = 'logg-textbox';
                  echo form_input($new_password);
            ?>
            <br /><br />
            
            <h3>Confirm New Password</h3>
            <?php
                  $new_password_confirm['class'] = 'logg-textbox';
                  echo form_input($new_password_confirm);
            ?>
            <br /><br />
            
            <?php echo form_input($user_id);?>
            <p>
            <?php
             echo form_submit('submit', 'Change');
             echo anchor('edge_user','Return To Profile', array('class'=>'logg-button','title'=>'Return To Profile'));
              
            ?>
            </p>
            
      <?php echo form_close();?>

</div>