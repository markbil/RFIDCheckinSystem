-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 18, 2012 at 12:22 PM
-- Server version: 5.5.25a-log
-- PHP Version: 5.3.16

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `checkin_db_v9`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_users`
--

CREATE TABLE IF NOT EXISTS `app_users` (
  `FB_ID` varchar(100) NOT NULL,
  `accesToken` varchar(200) NOT NULL,
  `LastCheckin` datetime DEFAULT NULL,
  PRIMARY KEY (`FB_ID`),
  UNIQUE KEY `acces token_UNIQUE` (`accesToken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `backgrounds`
--

CREATE TABLE IF NOT EXISTS `backgrounds` (
  `ID` int(5) NOT NULL,
  `background` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User background experiences';

-- --------------------------------------------------------

--
-- Table structure for table `characteristic`
--

CREATE TABLE IF NOT EXISTS `characteristic` (
  `CheckInID` int(11) NOT NULL,
  `Characteristic` varchar(250) NOT NULL,
  `Category` varchar(45) NOT NULL,
  PRIMARY KEY (`CheckInID`,`Characteristic`),
  KEY `fk_CheckIn` (`CheckInID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `check_in`
--

CREATE TABLE IF NOT EXISTS `check_in` (
  `CheckInID` int(11) NOT NULL AUTO_INCREMENT,
  `MainLocation` int(5) NOT NULL,
  `SubLocation` int(5) NOT NULL,
  `Check_In_Time` datetime NOT NULL,
  `Check_Out_Time` datetime DEFAULT NULL,
  `identification_media_id` int(10) NOT NULL,
  KEY `fk_CheckIn` (`CheckInID`),
  KEY `fk_Tag` (`CheckInID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=372 ;

-- --------------------------------------------------------

--
-- Table structure for table `check_in_raw`
--

CREATE TABLE IF NOT EXISTS `check_in_raw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checkintime` datetime NOT NULL,
  `thirdpartyid` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=80 ;

-- --------------------------------------------------------

--
-- Table structure for table `edge_users`
--

CREATE TABLE IF NOT EXISTS `edge_users` (
  `ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `occupation` varchar(100) NOT NULL,
  `statusmessage` varchar(140) NOT NULL,
  `dontdisturb` int(4) DEFAULT '1',
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=77 ;

-- --------------------------------------------------------

--
-- Table structure for table `edge_users_backgrounds`
--

CREATE TABLE IF NOT EXISTS `edge_users_backgrounds` (
  `ID` int(5) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(5) NOT NULL,
  `background_id` int(5) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `edge_users_expertises`
--

CREATE TABLE IF NOT EXISTS `edge_users_expertises` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `expertise_id` int(11) NOT NULL,
  `level` int(2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=65 ;

-- --------------------------------------------------------

--
-- Table structure for table `edge_users_interests`
--

CREATE TABLE IF NOT EXISTS `edge_users_interests` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `interest_id` int(11) NOT NULL,
  `level` int(2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `edge_users_questions`
--

CREATE TABLE IF NOT EXISTS `edge_users_questions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `question` varchar(300) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

-- --------------------------------------------------------

--
-- Table structure for table `edge_users_social_network_service`
--

CREATE TABLE IF NOT EXISTS `edge_users_social_network_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `edge_user_id` int(11) NOT NULL COMMENT 'ID for the Edge User',
  `service` int(11) NOT NULL,
  `service_property` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE IF NOT EXISTS `equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table `equipment_identification_media`
--

CREATE TABLE IF NOT EXISTS `equipment_identification_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_id` int(11) NOT NULL,
  `identification _media_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `equipment_location`
--

CREATE TABLE IF NOT EXISTS `equipment_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipment_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `expertise_table`
--

CREATE TABLE IF NOT EXISTS `expertise_table` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `expertise` varchar(300) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=62 ;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE IF NOT EXISTS `feedback` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Feedback` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `gatecounter`
--

CREATE TABLE IF NOT EXISTS `gatecounter` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `population` int(10) NOT NULL,
  `in` int(5) NOT NULL,
  `out` int(5) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `identification_media`
--

CREATE TABLE IF NOT EXISTS `identification_media` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ThirdPartyID` varchar(45) NOT NULL,
  `Type` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=76 ;

-- --------------------------------------------------------

--
-- Table structure for table `identification_media_type`
--

CREATE TABLE IF NOT EXISTS `identification_media_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `interest_table`
--

CREATE TABLE IF NOT EXISTS `interest_table` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `interest` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=85 ;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(5) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE IF NOT EXISTS `people` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `identification_id` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(40) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

-- --------------------------------------------------------

--
-- Table structure for table `projects_edge_users`
--

CREATE TABLE IF NOT EXISTS `projects_edge_users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=59 ;

-- --------------------------------------------------------

--
-- Table structure for table `social_network_service`
--

CREATE TABLE IF NOT EXISTS `social_network_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='List of Social Networking Services that Edge Users can use' AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table `social_network_service_property`
--

CREATE TABLE IF NOT EXISTS `social_network_service_property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `system_social_network_service`
--

CREATE TABLE IF NOT EXISTS `system_social_network_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service` int(11) NOT NULL,
  `service_property` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE IF NOT EXISTS `users_groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=44 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_checkins`
--
CREATE TABLE IF NOT EXISTS `view_checkins` (
`edge_user_id` mediumint(8) unsigned
,`firstname` varchar(50)
,`lastname` varchar(50)
,`occupation` varchar(100)
,`statusmessage` varchar(140)
,`imt_name` varchar(45)
,`im_id` varchar(45)
,`checkin_timestamp` datetime
,`months_since_checkin` bigint(21)
,`days_since_checkin` bigint(21)
,`hours_since_checkin` bigint(21)
,`minutes_since_checkin` bigint(21)
,`checkin_sublocation_id` int(5)
,`checkin_sublocation` varchar(50)
);
-- --------------------------------------------------------

--
-- Table structure for table `view_highscorelist_distinctusercheckinsperday_thismonth`
--

CREATE TABLE IF NOT EXISTS `view_highscorelist_distinctusercheckinsperday_thismonth` (
  `edge_user_id` mediumint(8) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `thismonth_name` varchar(9) DEFAULT NULL,
  `distinct_checkindays` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_highscorelist_distinctusercheckinsperday_thisweek`
--

CREATE TABLE IF NOT EXISTS `view_highscorelist_distinctusercheckinsperday_thisweek` (
  `edge_user_id` mediumint(8) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `weekofyear` int(6) DEFAULT NULL,
  `distinct_checkindays` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_highscorelist_distinctusercheckinsperday_thisyear`
--

CREATE TABLE IF NOT EXISTS `view_highscorelist_distinctusercheckinsperday_thisyear` (
  `edge_user_id` mediumint(8) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `thisyear` int(4) DEFAULT NULL,
  `distinct_checkindays` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_highscorelist_distinctusercheckins_all`
--

CREATE TABLE IF NOT EXISTS `view_highscorelist_distinctusercheckins_all` (
  `edge_user_id` mediumint(8) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `distinct_checkindays` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_list_distinctusercheckins_all`
--

CREATE TABLE IF NOT EXISTS `view_list_distinctusercheckins_all` (
  `edge_user_id` mediumint(8) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `statusmessage` varchar(140) DEFAULT NULL,
  `checkin_timestamp` datetime DEFAULT NULL,
  `months_since_checkin` bigint(21) DEFAULT NULL,
  `days_since_checkin` bigint(21) DEFAULT NULL,
  `hours_since_checkin` bigint(21) DEFAULT NULL,
  `minutes_since_checkin` bigint(21) DEFAULT NULL,
  `checkin_sublocation` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_list_distinctusercheckins_perdate`
--

CREATE TABLE IF NOT EXISTS `view_list_distinctusercheckins_perdate` (
  `edge_user_id` mediumint(8) unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `statusmessage` varchar(140) DEFAULT NULL,
  `imt_name` varchar(45) DEFAULT NULL,
  `im_id` varchar(45) DEFAULT NULL,
  `checkin_timestamp` datetime DEFAULT NULL,
  `months_since_checkin` bigint(21) DEFAULT NULL,
  `days_since_checkin` bigint(21) DEFAULT NULL,
  `hours_since_checkin` bigint(21) DEFAULT NULL,
  `minutes_since_checkin` bigint(21) DEFAULT NULL,
  `checkin_sublocation` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_all`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_all` (
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_perdate`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_perdate` (
  `checkin_date` date DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_perdate_hour_quarter`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_perdate_hour_quarter` (
  `checkin_date` date DEFAULT NULL,
  `hour` int(2) DEFAULT NULL,
  `quarterofhour` int(6) DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_perhour`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_perhour` (
  `hour` int(2) DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_perhour_15minslots`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_perhour_15minslots` (
  `hour` int(2) DEFAULT NULL,
  `quarterofhour` int(6) DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_permonth`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_permonth` (
  `month_index` int(2) DEFAULT NULL,
  `month_name` varchar(9) DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_perweekday`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_perweekday` (
  `weekday_index` int(1) DEFAULT NULL,
  `weekday_name` varchar(9) DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_thismonth_perday`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_thismonth_perday` (
  `dayofmonth_index` int(2) DEFAULT NULL,
  `weekday_name` varchar(9) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_thisweek_perday`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_thisweek_perday` (
  `weekday_index` int(1) DEFAULT NULL,
  `weekday_name` varchar(9) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_today_perhour`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_today_perhour` (
  `hour` int(2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_distinctusercheckins_today_perhour_15minslots`
--

CREATE TABLE IF NOT EXISTS `view_number_distinctusercheckins_today_perhour_15minslots` (
  `hour` int(2) DEFAULT NULL,
  `quarterofhour` int(6) DEFAULT NULL,
  `distinct_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_totalusercheckins_peryearmonth`
--

CREATE TABLE IF NOT EXISTS `view_number_totalusercheckins_peryearmonth` (
  `yearmonth_index` int(6) DEFAULT NULL,
  `month_name` varchar(9) DEFAULT NULL,
  `year` int(4) DEFAULT NULL,
  `total_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `view_number_totalusercheckins_peryearweek`
--

CREATE TABLE IF NOT EXISTS `view_number_totalusercheckins_peryearweek` (
  `yearweek_index` int(6) DEFAULT NULL,
  `weekofyear` int(2) DEFAULT NULL,
  `year` int(4) DEFAULT NULL,
  `total_usercheckins` bigint(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure for view `view_checkins`
--
DROP TABLE IF EXISTS `view_checkins`;

CREATE ALGORITHM=UNDEFINED DEFINER=`meetmee`@`localhost` SQL SECURITY INVOKER VIEW `view_checkins` AS select `eu`.`ID` AS `edge_user_id`,`eu`.`firstname` AS `firstname`,`eu`.`lastname` AS `lastname`,`eu`.`occupation` AS `occupation`,`eu`.`statusmessage` AS `statusmessage`,`imt`.`Name` AS `imt_name`,`im`.`ThirdPartyID` AS `im_id`,`check_in`.`Check_In_Time` AS `checkin_timestamp`,(select timestampdiff(MONTH,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(MONTH, check_in.check_in_time, (SELECT NOW()))`) AS `months_since_checkin`,(select timestampdiff(DAY,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(DAY, check_in.check_in_time, (SELECT NOW()))`) AS `days_since_checkin`,(select timestampdiff(HOUR,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(HOUR, check_in.check_in_time, (SELECT NOW()))`) AS `hours_since_checkin`,(select timestampdiff(MINUTE,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(MINUTE, check_in.check_in_time, (SELECT NOW()))`) AS `minutes_since_checkin`,`locations`.`id` AS `checkin_sublocation_id`,`locations`.`name` AS `checkin_sublocation` from (((((`identification_media` `im` join `identification_media_type` `imt` on((`im`.`Type` = `imt`.`ID`))) join `people` on((`people`.`identification_id` = `im`.`ID`))) join `edge_users` `eu` on((`eu`.`ID` = `people`.`edge_users_id`))) join `check_in` on((`check_in`.`identification_media_id` = `im`.`ID`))) left join `locations` on((`check_in`.`SubLocation` = `locations`.`id`))) order by `check_in`.`Check_In_Time` desc;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
