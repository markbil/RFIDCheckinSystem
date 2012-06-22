<?php echo validation_errors('<div class="login-warning center"><span class="center">', '</span></div>'); ?>

<div id="content" class="center">

      <?php
            $form_attributes = array('class' => 'logg-form content-inner center');
            echo form_open('edge_user/feedback', $form_attributes);
      ?>

      	<h1 style="margin-bottom:6pt;">Feedback</h1>
      	<p>Please enter your comments, suggestions, issues about The Edge's RFID Checkin System</p>

            <br /><br />

            <h3>Feedback Comments, Suggestions, Issues</h3>
            <?php
                  $feedback_attributes = array('name'=>'feedback_comment', 'id'=>'feedback_comment', 'class'=>'logg-textarea');
                  echo form_textarea($feedback_attributes);
            ?>
            <br /><br />
            
            <p><?php echo form_submit('submit', 'Send My Feedback');?></p>
	      
	<?php echo form_close();?>

</div>