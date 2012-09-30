-- phpMyAdmin SQL Dump
-- version 3.4.10.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 24, 2012 at 12:01 PM
-- Server version: 5.5.25
-- PHP Version: 5.3.14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Structure for view `view_checkins`
--
DROP TABLE IF EXISTS `view_checkins`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_checkins` AS select `eu`.`ID` AS `edge_user_id`,`eu`.`firstname` AS `firstname`,`eu`.`lastname` AS `lastname`,`eu`.`occupation` AS `occupation`,`eu`.`statusmessage` AS `statusmessage`,`imt`.`Name` AS `imt_name`,`im`.`ThirdPartyID` AS `im_id`,`check_in`.`Check_In_Time` AS `checkin_timestamp`,(select timestampdiff(MONTH,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(MONTH, check_in.check_in_time, (SELECT NOW()))`) AS `months_since_checkin`,(select timestampdiff(DAY,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(DAY, check_in.check_in_time, (SELECT NOW()))`) AS `days_since_checkin`,(select timestampdiff(HOUR,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(HOUR, check_in.check_in_time, (SELECT NOW()))`) AS `hours_since_checkin`,(select timestampdiff(MINUTE,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(MINUTE, check_in.check_in_time, (SELECT NOW()))`) AS `minutes_since_checkin`,`locations`.`name` AS `checkin_sublocation` from (((((`identification_media` `im` join `identification_media_type` `imt` on((`im`.`Type` = `imt`.`ID`))) join `people` on((`people`.`identification_id` = `im`.`ID`))) join `edge_users` `eu` on((`eu`.`ID` = `people`.`edge_users_id`))) join `check_in` on((`check_in`.`identification_media_id` = `im`.`ID`))) left join `locations` on((`check_in`.`SubLocation` = `locations`.`id`))) order by `check_in`.`Check_In_Time` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_list_distinctusercheckins_all`
--
DROP TABLE IF EXISTS `view_list_distinctusercheckins_all`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_list_distinctusercheckins_all` AS select `view_checkins`.`edge_user_id` AS `edge_user_id`,`view_checkins`.`firstname` AS `firstname`,`view_checkins`.`lastname` AS `lastname`,`view_checkins`.`occupation` AS `occupation`,`view_checkins`.`statusmessage` AS `statusmessage`,max(`view_checkins`.`checkin_timestamp`) AS `checkin_timestamp`,`view_checkins`.`months_since_checkin` AS `months_since_checkin`,`view_checkins`.`days_since_checkin` AS `days_since_checkin`,`view_checkins`.`hours_since_checkin` AS `hours_since_checkin`,`view_checkins`.`minutes_since_checkin` AS `minutes_since_checkin`,`view_checkins`.`checkin_sublocation` AS `checkin_sublocation` from `view_checkins` group by `view_checkins`.`edge_user_id` order by max(`view_checkins`.`checkin_timestamp`) desc;

-- --------------------------------------------------------

--
-- Structure for view `view_list_distinctusercheckins_perdate`
--
DROP TABLE IF EXISTS `view_list_distinctusercheckins_perdate`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_list_distinctusercheckins_perdate` AS select `view_checkins`.`edge_user_id` AS `edge_user_id`,`view_checkins`.`firstname` AS `firstname`,`view_checkins`.`lastname` AS `lastname`,`view_checkins`.`occupation` AS `occupation`,`view_checkins`.`statusmessage` AS `statusmessage`,`view_checkins`.`imt_name` AS `imt_name`,`view_checkins`.`im_id` AS `im_id`,`view_checkins`.`checkin_timestamp` AS `checkin_timestamp`,`view_checkins`.`months_since_checkin` AS `months_since_checkin`,`view_checkins`.`days_since_checkin` AS `days_since_checkin`,`view_checkins`.`hours_since_checkin` AS `hours_since_checkin`,`view_checkins`.`minutes_since_checkin` AS `minutes_since_checkin`,`view_checkins`.`checkin_sublocation` AS `checkin_sublocation` from `view_checkins` group by `view_checkins`.`edge_user_id`,cast(`view_checkins`.`checkin_timestamp` as date) order by `view_checkins`.`checkin_timestamp` desc;

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_all`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_all`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_all` AS select count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins`;

-- --------------------------------------------------------

--
-- Structure for view `view_highscorelist_distinctusercheckinsperday_thismonth`
--
DROP TABLE IF EXISTS `view_highscorelist_distinctusercheckinsperday_thismonth`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_highscorelist_distinctusercheckinsperday_thismonth` AS select `view_list_distinctusercheckins_perdate`.`edge_user_id` AS `edge_user_id`,`view_list_distinctusercheckins_perdate`.`firstname` AS `firstname`,`view_list_distinctusercheckins_perdate`.`lastname` AS `lastname`,monthname(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `thismonth_name`,count(0) AS `distinct_checkindays` from `view_list_distinctusercheckins_perdate` where (extract(year_month from `view_list_distinctusercheckins_perdate`.`checkin_timestamp`) = extract(year_month from (select now() AS `NOW()`))) group by `view_list_distinctusercheckins_perdate`.`edge_user_id` order by count(0) desc;

-- --------------------------------------------------------

--
-- Structure for view `view_highscorelist_distinctusercheckinsperday_thisweek`
--
DROP TABLE IF EXISTS `view_highscorelist_distinctusercheckinsperday_thisweek`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_highscorelist_distinctusercheckinsperday_thisweek` AS select `view_list_distinctusercheckins_perdate`.`edge_user_id` AS `edge_user_id`,`view_list_distinctusercheckins_perdate`.`firstname` AS `firstname`,`view_list_distinctusercheckins_perdate`.`lastname` AS `lastname`,yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) AS `weekofyear`,count(0) AS `distinct_checkindays` from `view_list_distinctusercheckins_perdate` where (yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) = yearweek((select now() AS `NOW()`),7)) group by `view_list_distinctusercheckins_perdate`.`edge_user_id` order by count(0) desc;

-- --------------------------------------------------------

--
-- Structure for view `view_highscorelist_distinctusercheckinsperday_thisyear`
--
DROP TABLE IF EXISTS `view_highscorelist_distinctusercheckinsperday_thisyear`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_highscorelist_distinctusercheckinsperday_thisyear` AS select `view_list_distinctusercheckins_perdate`.`edge_user_id` AS `edge_user_id`,`view_list_distinctusercheckins_perdate`.`firstname` AS `firstname`,`view_list_distinctusercheckins_perdate`.`lastname` AS `lastname`,year(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `thisyear`,count(0) AS `distinct_checkindays` from `view_list_distinctusercheckins_perdate` where (year(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) = year((select now() AS `NOW()`))) group by `view_list_distinctusercheckins_perdate`.`edge_user_id` order by count(0) desc;

-- --------------------------------------------------------

--
-- Structure for view `view_highscorelist_distinctusercheckins_all`
--
DROP TABLE IF EXISTS `view_highscorelist_distinctusercheckins_all`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_highscorelist_distinctusercheckins_all` AS select `view_list_distinctusercheckins_perdate`.`edge_user_id` AS `edge_user_id`,`view_list_distinctusercheckins_perdate`.`firstname` AS `firstname`,`view_list_distinctusercheckins_perdate`.`lastname` AS `lastname`,count(0) AS `distinct_checkindays` from `view_list_distinctusercheckins_perdate` group by `view_list_distinctusercheckins_perdate`.`edge_user_id` order by count(0) desc;

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_perdate`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_perdate`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_perdate` AS select cast(`view_checkins`.`checkin_timestamp` as date) AS `checkin_date`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` group by cast(`view_checkins`.`checkin_timestamp` as date) order by cast(`view_checkins`.`checkin_timestamp` as date) desc;

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_perdate_hour_quarter`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_perdate_hour_quarter`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_perdate_hour_quarter` AS select cast(`view_checkins`.`checkin_timestamp` as date) AS `checkin_date`,hour(`view_checkins`.`checkin_timestamp`) AS `hour`,ceiling((minute(`view_checkins`.`checkin_timestamp`) / 14.99)) AS `quarterofhour`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` group by cast(`view_checkins`.`checkin_timestamp` as date),hour(`view_checkins`.`checkin_timestamp`),ceiling((minute(`view_checkins`.`checkin_timestamp`) / 14.99)) order by cast(`view_checkins`.`checkin_timestamp` as date) desc,hour(`view_checkins`.`checkin_timestamp`) desc,ceiling((minute(`view_checkins`.`checkin_timestamp`) / 14.99)) desc;

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_perhour`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_perhour`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_perhour` AS select hour(`view_checkins`.`checkin_timestamp`) AS `hour`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` group by hour(`view_checkins`.`checkin_timestamp`) order by hour(`view_checkins`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_perhour_15minslots`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_perhour_15minslots`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_perhour_15minslots` AS select hour(`view_checkins`.`checkin_timestamp`) AS `hour`,ceiling((minute(`view_checkins`.`checkin_timestamp`) / 14.99)) AS `quarterofhour`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` group by hour(`view_checkins`.`checkin_timestamp`),ceiling((minute(`view_checkins`.`checkin_timestamp`) / 14.99)) order by hour(`view_checkins`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_permonth`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_permonth`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_permonth` AS select month(`view_checkins`.`checkin_timestamp`) AS `month_index`,monthname(`view_checkins`.`checkin_timestamp`) AS `month_name`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` group by month(`view_checkins`.`checkin_timestamp`) order by month(`view_checkins`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_perweekday`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_perweekday`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_perweekday` AS select weekday(`view_checkins`.`checkin_timestamp`) AS `weekday_index`,dayname(`view_checkins`.`checkin_timestamp`) AS `weekday_name`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` group by weekday(`view_checkins`.`checkin_timestamp`) order by weekday(`view_checkins`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_thismonth_perday`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_thismonth_perday`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_thismonth_perday` AS select dayofmonth(`view_checkins`.`checkin_timestamp`) AS `dayofmonth_index`,dayname(`view_checkins`.`checkin_timestamp`) AS `weekday_name`,cast(`view_checkins`.`checkin_timestamp` as date) AS `date`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` where (extract(year_month from `view_checkins`.`checkin_timestamp`) = extract(year_month from (select now() AS `NOW()`))) group by dayofmonth(`view_checkins`.`checkin_timestamp`) order by dayofmonth(`view_checkins`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_thisweek_perday`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_thisweek_perday`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_thisweek_perday` AS select weekday(`view_checkins`.`checkin_timestamp`) AS `weekday_index`,dayname(`view_checkins`.`checkin_timestamp`) AS `weekday_name`,cast(`view_checkins`.`checkin_timestamp` as date) AS `date`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` where (yearweek(`view_checkins`.`checkin_timestamp`,7) = yearweek((select now() AS `NOW()`),7)) group by weekday(`view_checkins`.`checkin_timestamp`) order by weekday(`view_checkins`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_today_perhour`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_today_perhour`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_today_perhour` AS select hour(`view_checkins`.`checkin_timestamp`) AS `hour`,cast(`view_checkins`.`checkin_timestamp` as date) AS `date`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` where (cast(`view_checkins`.`checkin_timestamp` as date) = cast((select now() AS `NOW()`) as date)) group by hour(`view_checkins`.`checkin_timestamp`) order by hour(`view_checkins`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_distinctusercheckins_today_perhour_15minslots`
--
DROP TABLE IF EXISTS `view_number_distinctusercheckins_today_perhour_15minslots`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_today_perhour_15minslots` AS select hour(`view_checkins`.`checkin_timestamp`) AS `hour`,ceiling((minute(`view_checkins`.`checkin_timestamp`) / 14.99)) AS `quarterofhour`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins` from `view_checkins` where (cast(`view_checkins`.`checkin_timestamp` as date) = cast((select now() AS `NOW()`) as date)) group by hour(`view_checkins`.`checkin_timestamp`),ceiling((minute(`view_checkins`.`checkin_timestamp`) / 14.99)) order by hour(`view_checkins`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_totalusercheckins_peryearmonth`
--
DROP TABLE IF EXISTS `view_number_totalusercheckins_peryearmonth`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_totalusercheckins_peryearmonth` AS select extract(year_month from `view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `yearmonth_index`,monthname(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `month_name`,year(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `year`,count(`view_list_distinctusercheckins_perdate`.`edge_user_id`) AS `total_usercheckins` from `view_list_distinctusercheckins_perdate` group by extract(year_month from `view_list_distinctusercheckins_perdate`.`checkin_timestamp`) order by extract(year_month from `view_list_distinctusercheckins_perdate`.`checkin_timestamp`);

-- --------------------------------------------------------

--
-- Structure for view `view_number_totalusercheckins_peryearweek`
--
DROP TABLE IF EXISTS `view_number_totalusercheckins_peryearweek`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `view_number_totalusercheckins_peryearweek` AS select yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) AS `yearweek_index`,week(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) AS `weekofyear`,year(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `year`,count(`view_list_distinctusercheckins_perdate`.`edge_user_id`) AS `total_usercheckins` from `view_list_distinctusercheckins_perdate` group by yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) order by yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
