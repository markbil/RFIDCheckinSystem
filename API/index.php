<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style type="text/css">

	.function_name{
		font-weight:bold;

	}
	.function_description{
		font-style:italic;
	}
	.footer{
		padding-top:50px;
		padding-bottom:50px:
		font-size:10px;
		font-family:"Courier New", Courier, monospace;
	}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>The Edge - Checkin System API</title>


</head>
<body>

<?php
 	//$urlbase = "http://theedge.checkinsystem.net/API/";
	$urlbase = "http://". $_SERVER['SERVER_NAME'] . substr($_SERVER['PHP_SELF'],0,strlen($_SERVER['PHP_SELF'])-strlen("index.php")) ;
?>

<h1>The Edge - Checkin System API (beta)</h1>
<p>
This API provides access to selected data from the checkin-system database at The Edge. Each of the API-URLs listed below returns a JSON file
with specific datasets.
</p>
<br/>

<p>
<div class="function_name">view_list_distinctusercheckins_all.php</div>
<div class="function_description">Description: returns number of distinct users who have ever checked-in, incl. some profile details and areas of expertise and interests</div>
<a href="<?php echo $urlbase ?>view_list_distinctusercheckins_all.php"><?php echo $urlbase ?>view_list_distinctusercheckins_all.php</a>
</p>

<p>
<div class="function_name">view_list_distinctusercheckins_all_2.php</div>
<div class="function_description">Description: same as "view_list_distinctusercheckins_all.php" but includes user's level of expertise for each expertise keyword</div>
<a href="<?php echo $urlbase ?>view_list_distinctusercheckins_all_2.php"><?php echo $urlbase ?>view_list_distinctusercheckins_all_2.php</a>
</p>

<p>
	<div class="function_name">view_citienzj_list_distinctusercheckins.php</div>
	<div class="function_description">Description: List of Citizen J Users</div>
	<div class="function_description"><br/>&nbsp;Params: ?limit=</div>
	<div class="function_description">&nbsp;&nbsp;&nbsp;&nbsp;eg: ?limit=6</div>
	<div class="function_description">&nbsp;&nbsp;Define the limit of number of records/users</div>
	<div class="function_description"><br/>&nbsp;Params: ?location=</div>
	<div class="function_description">&nbsp;&nbsp;&nbsp;&nbsp;eg: ?location=41</div>
	<div class="function_description">&nbsp;&nbsp;Define the location ID of users</div><br/>
	<a href="<?php echo $urlbase ?>view_citienzj_list_distinctusercheckins.php"><?php echo $urlbase ?>view_citienzj_list_distinctusercheckins.php</a>&limit=N?location=LOCATION_ID
</p>

<p>
    <div class="function_name">view_number_distinctusercheckins_perhour.php</div>
    <div class="function_description">Description: returns hours of a day and the number of distinct users that have checked-in at at that hour cumulated over all dates since launch of the checkin system</div>
    <a href="<?php echo $urlbase ?>view_number_distinctusercheckins_perhour.php"><?php echo $urlbase ?>view_number_distinctusercheckins_perhour.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_perhour_15minslots.php</div>
<div class="function_description">Description: returns hours of a day in 15min sections, and number of checkins that distinct users have checked-in at each 15min slot during a particuar hour, cumulated over all dates since launch of the checkin system. E.g. at 8am, 6 people have checked in during the 1st quarter of the hour (i.e. 8:00-8:14am)</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_perhour_15minslots.php"><?php echo $urlbase ?>view_number_distinctusercheckins_perhour_15minslots.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_perdate.php</div>
<div class="function_description">Description: returns checkin_dates and the number of distinct users that have checked-in on that date</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_perdate.php"><?php echo $urlbase ?>view_number_distinctusercheckins_perdate.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_perdate_hour_quarter.php</div>
<div class="function_description">Description: returns checkin_dates and the number of distinct users that have checked-in per hour and quarter of an hour on each date</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_perdate_hour_quarter.php"><?php echo $urlbase ?>view_number_distinctusercheckins_perdate_hour_quarter.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_peryearmonth.php</div>
<div class="function_description">Description: returns individual months and the number of distinct users that have checked-in in that month</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_peryearmonth.php"><?php echo $urlbase ?>view_number_distinctusercheckins_peryearmonth.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_perweekday.php</div>
<div class="function_description">Description: returns days of a week and the number of distinct users that have checked-in at that weekday</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_perweekday.php"><?php echo $urlbase ?>view_number_distinctusercheckins_perweekday.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_thismonth_perday.php</div>
<div class="function_description">Description: returns days of the current month and the number of distinct users that have checked-in on each day of the current month</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_thismonth_perday.php"><?php echo $urlbase ?>view_number_distinctusercheckins_thismonth_perday.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_thisweek_perday.php</div>
<div class="function_description">Description: returns days of the current week and the number of distinct users that have checked-in at each day of the current week</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_thisweek_perday.php"><?php echo $urlbase ?>view_number_distinctusercheckins_thisweek_perday.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_today_perhour.php</div>
<div class="function_description">Description: returns hours of the current day and the number of distinct users that have checked-in each hour today</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_today_perhour.php"><?php echo $urlbase ?>view_number_distinctusercheckins_today_perhour.php</a>
</p>

<p>
<div class="function_name">view_number_distinctusercheckins_today_perhour_15minslots.php</div>
<div class="function_description">Description: returns hours of today in 15min sections, and number of checkins that distinct users have checked-in at each 15min slot during a particuar hour today. E.g. at 8am, 6 people have checked in during the 1st quarter of the hour (i.e. 8:00-8:14am)</div>
<a href="<?php echo $urlbase ?>view_number_distinctusercheckins_today_perhour_15minslots.php"><?php echo $urlbase ?>view_number_distinctusercheckins_today_perhour_15minslots.php</a>
</p>

<p>
<div class="function_name">HIGHSCORE LISTS</div>
<div class="function_description">list of users with total number of checkins on distinct days over a particular period of time, e.g. this week, this month, this year, all... (Enables statements such as: "Congratulations: You have checked-in on 10 different days this month")</div>


<a href="<?php echo $urlbase ?>view_highscorelist_distinctusercheckins_all.php"><?php echo $urlbase ?>view_highscorelist_distinctusercheckins_all.php</a><br/>
<a href="<?php echo $urlbase ?>view_highscorelist_distinctusercheckins_thisweek.php"><?php echo $urlbase ?>view_highscorelist_distinctusercheckins_thisweek.php</a><br/>
<a href="<?php echo $urlbase ?>view_highscorelist_distinctusercheckins_thismonth.php"><?php echo $urlbase ?>view_highscorelist_distinctusercheckins_thismonth.php</a><br/>
<a href="<?php echo $urlbase ?>view_highscorelist_distinctusercheckins_thisyear.php"><?php echo $urlbase ?>view_highscorelist_distinctusercheckins_thisyear.php</a><br/>
</p>



<p>
<div class="footer">API by Mark Bilandzic. For any comments, feedback and ideas for improvement, please send me an email: mark.bilandzic(at)qut.edu.au </div>
</p>

</body>
</html>