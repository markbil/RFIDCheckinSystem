<h1>Feedback</h1>
<p>Please enter your comments, suggestions, issues about The Edge's RFID Checkin System</p>

<div id="infoMessage"><?php echo $message;?></div>

<?php echo form_open("edge_user/feedback");?>

      <p>Feedback Comments, Suggestions, Issues:<br />
      <?php echo form_textarea('feedback_comment');?>
      </p>
      
      <p><?php echo form_submit('submit', 'Send My Feedback');?></p>
      
<?php echo form_close();?>