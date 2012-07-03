<?php echo validation_errors('<div class="login-warning center"><span class="center">', '</span></div>'); ?>

<div id="content" class="center">

      <?php
            $form_attributes = array('class' => 'logg-form content-inner center');
            echo form_open('edge_user/create_user', $form_attributes);
      ?>

	<h1 style="margin-bottom:6pt;">Create User</h1>
	<p>Please enter the users information below.<br /><br />
	
	<!--<div id="infoMessage"><?php echo $message;?></div>-->
      <br />
	
      <h3>First Name:</h3>
      <?php
            $first_name['class'] = 'logg-textbox';
            echo form_input($first_name);
      ?>
      <br /><br />
      
      <h3>Last Name:</h3>
      <?php
            $last_name['class'] = 'logg-textbox';
            echo form_input($last_name);
      ?>
      <br /><br />
      
      <h3>Company Name:</h3>
      <?php
            $company['class'] = 'logg-textbox';
            echo form_input($company);
      ?>
      <br /><br />
      
      <h3>Email:</h3>
      <?php
            $email['class'] = 'logg-textbox';
            echo form_input($email);
      ?>
      <br /><br />
      
      <h3>Phone:</h3>
      <table><tr>
            <td>
                  <?php
                        $phone1['class'] = 'logg-textbox';
                        echo form_input($phone1);
                  ?>
            </td>
            <td>
                  <?php
                        $phone2['class'] = 'logg-textbox';
                        echo form_input($phone2);
                  ?>
            </td>
            <td>
                  <?php
                        $phone3['class'] = 'logg-textbox';
                        echo form_input($phone3);
                  ?>
            </td>
      </tr></table>
      <br /><br />
      
      <h3>Password:</h3>
      <?php
            $password['class'] = 'logg-textbox';
            echo form_input($password);
      ?>
      <br /><br />
      
      <h3>Confirm Password:</h3>
      <?php
            $password_confirm['class'] = 'logg-textbox';
            echo form_input($password_confirm);
      ?>
      <br /><br />
      
      
      <h3><?php echo form_submit('submit', 'Create User');?><br /><br />

      
    <?php echo form_close();?>

</div>
