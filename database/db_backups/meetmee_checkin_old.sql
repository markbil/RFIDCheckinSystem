-- phpMyAdmin SQL Dump
-- version 3.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 06, 2012 at 07:25 PM
-- Server version: 5.0.51
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `meetmee_checkin`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_users`
--

CREATE TABLE IF NOT EXISTS `app_users` (
  `FB_ID` varchar(100) NOT NULL,
  `accesToken` varchar(200) NOT NULL,
  `LastCheckin` datetime default NULL,
  PRIMARY KEY  (`FB_ID`),
  UNIQUE KEY `acces token_UNIQUE` (`accesToken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `app_users`
--

INSERT INTO `app_users` (`FB_ID`, `accesToken`, `LastCheckin`) VALUES
('1236128', 'AAACOahlvPXUBAGGZAHJkJj65u0DZBLepcTBef73iO2GX6zM2WXIm3fw3GOCM4j3XcQiRoyr0KnZCqn2XPp7h5UOEQubOhoZD', NULL),
('531587817', 'AAACOahlvPXUBAH1ina47HSv4i3KEmA2FDTobRNcTLh4ZCpG6blqtSJvBb3Qo8xiP41lLOjEixEreKZCssu36ybv8PCQcgZD', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `characteristic`
--

CREATE TABLE IF NOT EXISTS `characteristic` (
  `CheckInID` int(11) NOT NULL,
  `Characteristic` varchar(250) NOT NULL,
  `Category` varchar(45) NOT NULL,
  PRIMARY KEY  (`CheckInID`,`Characteristic`),
  KEY `fk_CheckIn` (`CheckInID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `characteristic`
--

INSERT INTO `characteristic` (`CheckInID`, `Characteristic`, `Category`) VALUES
(55, 'Age', '20'),
(54, 'Age', '20'),
(54, 'Occupation', 'Student'),
(54, 'TV Show', 'How I Met Your Mother'),
(52, 'testing', 'Visit Reason'),
(53, 'Meeting new people', 'Visit Reason'),
(51, 'Peter is fat', 'Help'),
(48, 'Who knows some good Flash keyboard plugins?', 'Help'),
(49, 'Test ', 'Help'),
(50, 'CALVIN IS A BOGANNN!!!!', 'Help'),
(47, 'test checkin', 'Visit Reason'),
(48, 'Would a virtual keyboard be better as a method to answer questions?', 'Help'),
(46, 'Meetmee API', 'Visit Reason'),
(45, 'mark b and mark j', 'Visit Reason'),
(32, '2 Player TEAMS EVENT this SUNDAY at Swan Districts - Steel Blue Oval %5 per person Buy In Rego 12pm Start 1pm C U There! reply stop to opt out', 'Help'),
(33, 'JAVA, PHP, C#, JavaScript, C++', 'Visit Reason'),
(44, 'mark b and mark j meeting', 'Visit Reason'),
(43, 'Urban Informatics, interaction design, arduino', 'Visit Reason'),
(42, 'I am here', 'Visit Reason'),
(39, 'APL Free Poker Tournament Every Wednesday  Fuse Bar Hotel Northbridge Cnr Lake & Brisbane St 6PM Rego B There! reply stop to opt out', 'Help'),
(41, 'test test mark', 'Visit Reason'),
(55, 'Occupation', 'Student'),
(55, 'TV Show', 'How I Met Your Mother'),
(56, 'Age', '20'),
(56, 'Occupation', 'Student'),
(56, 'TV Show', 'How I Met Your Mother'),
(57, 'Age', '20'),
(57, 'Occupation', 'Student'),
(57, 'TV Show', 'How I Met Your Mother'),
(58, '20', 'Age'),
(58, 'Software Engineer', 'Occupation'),
(59, 'How I Met Your Mother', 'TV Show'),
(59, 'Friends', 'TV Show'),
(59, 'Blink 182', 'Band'),
(60, 'Test', 'Help'),
(61, '20', 'Age'),
(61, 'Software Engineer', 'Occupation'),
(62, 'How I Met Your Mother', 'TV Show'),
(62, 'Friends', 'TV Show'),
(62, 'Blink 182', 'Band'),
(63, '20', 'Age'),
(63, 'Software Engineer', 'Occupation'),
(64, 'How I Met Your Mother', 'TV Show'),
(64, 'Friends', 'TV Show'),
(64, 'Blink 182', 'Band'),
(65, '20', 'Age'),
(65, 'Software Engineer', 'Occupation'),
(66, 'How I Met Your Mother', 'TV Show'),
(66, 'Friends', 'TV Show'),
(66, 'Blink 182', 'Band'),
(67, '20', 'Age'),
(67, 'Software Engineer', 'Occupation'),
(68, 'How I Met Your Mother', 'TV Show'),
(68, 'Friends', 'TV Show'),
(68, 'Blink 182', 'Band'),
(69, '20', 'Age'),
(69, 'Software Engineer', 'Occupation'),
(70, 'How I Met Your Mother', 'TV Show'),
(70, 'Friends', 'TV Show'),
(70, 'Blink 182', 'Band'),
(71, '20', 'Age'),
(71, 'Software Engineer', 'Occupation'),
(72, 'How I Met Your Mother', 'TV Show'),
(72, 'Friends', 'TV Show'),
(72, 'Blink 182', 'Band'),
(73, 'Cricket', 'Interests'),
(73, 'Mark', 'Name'),
(73, 'Lots', 'Share'),
(73, 'Noh', 'Doing'),
(73, 'nah', 'Anything'),
(74, 'Cricket', 'Interests'),
(74, 'Mark Jones', 'Name'),
(74, 'PHP Knowledge', 'Share'),
(74, 'TOR', 'Doing'),
(74, 'Uni', 'Anything'),
(75, 'Hanging', 'Interests'),
(75, 'Mark Jones', 'Name'),
(75, 'Checkin System Knowledge', 'Share'),
(75, 'Meeting with Mark', 'Doing'),
(75, 'Blah', 'Anything'),
(76, 'Hanging', 'Interests'),
(76, 'Mark Jones', 'Name'),
(76, 'asdfasdfasdf', 'Share'),
(76, 'asdfadsf', 'Doing'),
(76, 'adsfadsfaf', 'Anything'),
(77, 'idontknow', 'StatusMessage'),
(78, 'idontknow', 'StatusMessage'),
(81, 'ThisismyfirstcheckinthroughProcessing', 'StatusMessage'),
(82, 'This', 'StatusMessage'),
(83, 'This is my first checkin through Processing', 'StatusMessage'),
(84, 'This is my first checkin through Processing v2', 'StatusMessage'),
(85, 'This is my first checkin through Processing v2', 'statusmessage'),
(86, 'This is my first checkin through Processing v2', 'statusmessage'),
(89, 'idontknow', 'statusmessage'),
(90, 'idontknow', 'statusmessage'),
(91, 'This is my first checkin through Processing v2', 'statusmessage'),
(92, 'This is my first checkin through Processing v2', 'statusmessage'),
(93, 'This is my first checkin through Processing v2', 'statusmessage'),
(94, 'This is my first checkin through Processing v2', 'statusmessage'),
(93, 'I have checked in at window bay 2', 'statusmessage'),
(95, 'I have checked in at window bay 2', 'statusmessage'),
(96, 'I have checked in at window bay 2', 'statusmessage'),
(97, 'I have checked in at window bay 3', 'statusmessage'),
(98, 'I have checked in at window bay 3', 'statusmessage'),
(99, 'I have checked in at window bay 4', 'statusmessage'),
(100, 'Alessandro is at Windowbay 3', 'statusmessage'),
(102, 'Alessandro is at Windowbay 3', 'statusmessage'),
(102, 'I am in window bay 3', 'statusmessage'),
(102, 'I am in window bay 2', 'statusmessage'),
(101, 'I am in window bay 2', 'statusmessage'),
(101, 'I am in window bay 1', 'statusmessage'),
(101, 'I am in window bay 10000', 'statusmessage'),
(103, 'I am in window bay 10000', 'statusmessage'),
(104, 'I am in window bay 2222', 'statusmessage'),
(105, 'I am in window bay 1212', 'statusmessage'),
(106, 'I am in window bay 1213', 'statusmessage'),
(107, 'I am in window bay 1213', 'statusmessage'),
(108, 'I am in window bay 1213', 'statusmessage'),
(109, 'I am in window bay 1213', 'statusmessage'),
(110, 'I am in window bay 1213', 'statusmessage'),
(111, 'I am in window bay 1213', 'statusmessage'),
(112, 'I am in window bay 1213', 'statusmessage'),
(113, 'I am in window bay 1213', 'statusmessage'),
(114, 'I am in window bay 1213', 'statusmessage'),
(115, 'I am in window bay 1213', 'statusmessage'),
(115, 'kliytvtq', 'statusmessage'),
(115, '234redsx', 'statusmessage'),
(115, 'gh', 'statusmessage'),
(115, 'uybnm', 'statusmessage'),
(115, 'werty', 'statusmessage'),
(116, 'hgfd', 'statusmessage'),
(117, 'frtyu', 'statusmessage'),
(118, 'ooooooo', 'statusmessage'),
(119, 'iiiiiiiii', 'statusmessage'),
(120, 'tttttttt', 'statusmessage'),
(121, 'uuuuuu', 'statusmessage'),
(122, 'anynomousboyyyyyyy', 'statusmessage'),
(123, 'uytg', 'statusmessage'),
(124, 'yyyyyyy', 'statusmessage'),
(125, '444444', 'statusmessage'),
(115, 'lllllll', 'statusmessage'),
(115, 'xsaqqqqqqqqwe', 'statusmessage'),
(115, 'zzssdd  :) hello!!!!!', 'statusmessage'),
(124, 'aaaaaaasssssssss', 'statusmessage'),
(126, 'wwwwwwwww', 'statusmessage'),
(127, 'rrrrrrrrrr', 'statusmessage'),
(128, 'wesdxc', 'statusmessage'),
(129, 'wertyiop', 'statusmessage'),
(130, 'zzzzzzzz', 'statusmessage'),
(131, 'zzzzzzzxxxxxccccc', 'statusmessage'),
(132, 'max is checked in:)', 'statusmessage'),
(133, 'hacking', 'statusmessage'),
(134, 'cheese :d:p:d:(:)', 'statusmessage'),
(135, '??', 'statusmessage'),
(136, ':d', 'statusmessage'),
(137, 'buttdsluryrrjf:dffsdguuys:d:d', 'statusmessage'),
(138, 'nuo fholbfii7x876va9r', 'statusmessage'),
(139, 'the hack', 'statusmessage'),
(140, 'fun', 'statusmessage'),
(141, 'mmmrymigo gt work done', 'statusmessage'),
(142, 'the cmpany', 'statusmessage'),
(144, 'coffee', 'statusmessage'),
(145, 'bbnhggnnnmmmmmdffgggggdffdedddhdtjhhhhhhdjkkkkkkkkkkkkk', 'statusmessage'),
(147, ' ', 'statusmessage'),
(148, 'ass', 'statusmessage'),
(157, 'hello worldasm', 'statusmessage'),
(158, 'I am working from bay 8 today', 'statusmessage'),
(159, 'I am working from bay 8 today 222', 'statusmessage'),
(160, 'medgecbjc', 'statusmessage'),
(161, 'medgecbjc', 'statusmessage'),
(162, 'asdfdsaf', 'statusmessage'),
(150, 'ass', 'statusmessage'),
(150, 'adsfadsfasdsdfgsdfhdgfhfgdh', 'statusmessage'),
(150, 'asdfasdfsdfasdfasdf', 'statusmessage'),
(150, 'asdfa', 'statusmessage'),
(150, 'asdfasdfasdfasdfasdf', 'statusmessage'),
(150, 'aqewrqewr', 'statusmessage'),
(150, 'p;iopoijlknl', 'statusmessage'),
(150, 'asdfasdf', 'statusmessage'),
(150, 'dasfasdfasdfasg', 'statusmessage'),
(150, ';lkajsd;glkjsdfbjoihbisdgal;ksdfjlaksjdf;lasdf', 'statusmessage'),
(163, 'laksdjfl;aksdfkladfadsf', 'statusmessage'),
(164, 'ich bin heute hier', 'statusmessage'),
(165, '', 'statusmessage'),
(166, 'wwedcvbnm  :):):):)', 'statusmessage'),
(167, 'thjk', 'statusmessage'),
(173, 'welcome to the edge', 'statusmessage'),
(174, 'Doing arduino hacking come n join me', 'statusmessage'),
(175, 'hahaha', 'statusmessage'),
(176, 'that is cool stuff! :)', 'statusmessage'),
(177, 'I\\''m doing my homework', 'statusmessage'),
(178, 'Im doing my homework', 'statusmessage'),
(179, 'I\\''m doing my homework', 'statusmessage'),
(180, 'Photoshop', 'statusmessage');

-- --------------------------------------------------------

--
-- Table structure for table `check_in`
--

CREATE TABLE IF NOT EXISTS `check_in` (
  `MainLocation` varchar(45) NOT NULL,
  `CheckInID` int(11) NOT NULL auto_increment,
  `SubLocation` varchar(45) default NULL,
  `Check_In_Time` datetime NOT NULL,
  `Check_Out_Time` datetime default NULL,
  `Method` varchar(45) NOT NULL,
  `PersonID` int(11) NOT NULL,
  `DontDisturb` bit(1) default '\0',
  PRIMARY KEY  (`MainLocation`,`CheckInID`),
  KEY `fk_CheckIn` (`CheckInID`),
  KEY `fk_Tag` (`CheckInID`),
  KEY `fk_Person` (`PersonID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=184 ;

--
-- Dumping data for table `check_in`
--

INSERT INTO `check_in` (`MainLocation`, `CheckInID`, `SubLocation`, `Check_In_Time`, `Check_Out_Time`, `Method`, `PersonID`, `DontDisturb`) VALUES
('The Edge', 45, 'Bay 1', '2011-10-16 10:29:06', '2011-10-16 10:42:58', 'Mobile Website Checkin', 34, b'0'),
('The Edge', 32, NULL, '2011-08-27 12:02:25', NULL, 'SMS', 25, b'0'),
('The Edge', 33, 'Bay 1', '2011-09-21 16:05:01', '2011-09-21 19:17:47', 'Mobile Website Checkin', 26, b'0'),
('The Edge', 44, 'Bay 1', '2011-10-16 10:24:10', '2011-10-16 10:28:42', 'Mobile Website Checkin', 33, b'0'),
('The Edge', 43, 'Bay 7', '2011-10-14 14:48:27', NULL, 'Mobile Website Checkin', 32, b'0'),
('The Edge', 42, 'Bay 2', '2011-10-07 18:07:30', NULL, 'Mobile Website Checkin', 31, b'0'),
('The Edge', 39, NULL, '2011-10-05 14:06:16', NULL, 'SMS', 25, b'0'),
('The Edge', 41, 'Bay 4', '2011-10-07 17:26:03', '2011-10-07 17:26:57', 'Mobile Website Checkin', 30, b'0'),
('The Edge', 46, 'Bay 1', '2011-10-16 10:40:15', '2011-10-16 12:19:07', 'Mobile Website Checkin', 35, b'0'),
('The Edge', 47, 'Bay 5', '2011-10-16 10:43:29', NULL, 'Mobile Website Checkin', 36, b'0'),
('The Edge', 48, NULL, '2011-10-16 11:32:19', NULL, 'SMS', 24, b'0'),
('The Edge', 49, NULL, '2011-10-28 17:07:18', NULL, 'SMS', 37, b'0'),
('The Edge', 50, NULL, '2011-11-02 13:24:45', NULL, 'SMS', 38, b'0'),
('The Edge', 51, NULL, '2011-11-02 13:24:47', NULL, 'SMS', 39, b'0'),
('The Edge', 63, NULL, '2011-11-14 11:32:19', NULL, 'Swipe Card', 43, b'0'),
('The Edge', 60, NULL, '2011-11-14 21:35:47', NULL, 'Mobile Website Checkin', 24, b'0'),
('The Edge', 61, NULL, '2011-11-14 11:32:19', NULL, 'Swipe Card', 43, b'0'),
('The Edge', 80, NULL, '2012-01-23 10:25:12', NULL, 'RFID', 55, b'0'),
('The Edge', 79, NULL, '2012-01-23 10:25:08', NULL, 'RFID', 55, b'0'),
('The Edge', 78, NULL, '2012-01-23 10:24:56', NULL, 'RFID', 55, b'0'),
('The Edge', 77, NULL, '2012-01-23 10:07:11', NULL, 'RFID', 55, b'0'),
('The Edge', 76, NULL, '2012-01-20 15:23:34', NULL, 'Swipe Card', 54, b'0'),
('The Edge', 72, NULL, '2011-12-09 09:05:00', NULL, 'Facebook', 44, b'0'),
('The Edge', 75, NULL, '2012-01-19 17:26:43', NULL, 'Swipe Card', 54, b'0'),
('The Edge', 71, NULL, '2011-12-09 09:17:19', '2011-12-09 09:18:56', 'Swipe Card', 43, b'0'),
('The Edge', 81, NULL, '2012-01-23 10:28:32', NULL, 'RFID', 56, b'0'),
('The Edge', 82, NULL, '2012-01-23 10:29:02', NULL, 'RFID', 55, b'0'),
('The Edge', 83, NULL, '2012-01-23 10:37:34', NULL, 'RFID', 56, b'0'),
('The Edge', 84, NULL, '2012-01-23 10:40:04', NULL, 'RFID', 56, b'0'),
('The Edge', 85, NULL, '2012-01-23 10:42:27', NULL, 'RFID', 56, b'1'),
('The Edge', 86, NULL, '2012-01-23 10:42:55', NULL, 'RFID', 55, b'0'),
('The Edge', 87, NULL, '2012-01-23 10:43:35', NULL, 'RFID', 55, b'0'),
('The Edge', 88, NULL, '2012-01-24 09:00:05', NULL, 'RFID', 55, b'0'),
('The Edge', 89, NULL, '2012-01-24 09:01:44', NULL, 'RFID', 55, b'0'),
('The Edge', 90, NULL, '2012-01-24 09:02:24', NULL, 'RFID', 55, b'0'),
('The Edge', 91, NULL, '2012-01-24 09:03:26', NULL, 'RFID', 56, b'1'),
('The Edge', 92, 'windowbay1', '2012-01-24 09:05:12', NULL, 'RFID', 56, b'1'),
('The Edge', 93, 'windowbay1', '2012-01-25 09:54:32', NULL, 'RFID', 56, b'1'),
('The Edge', 94, 'windowbay1', '2012-01-25 09:54:37', NULL, 'RFID', 56, b'1'),
('The Edge', 95, 'windowbay2', '2012-01-25 15:20:48', NULL, 'RFID', 57, b'1'),
('The Edge', 96, 'windowbay2', '2012-01-25 15:21:38', NULL, 'RFID', 57, b'1'),
('The Edge', 97, 'windowbay2', '2012-01-25 15:22:21', NULL, 'RFID', 57, b'1'),
('The Edge', 98, 'windowbay6', '2012-01-25 15:22:54', NULL, 'RFID', 57, b'1'),
('The Edge', 99, 'windowbay4', '2012-01-25 15:26:15', NULL, 'RFID', 57, b'1'),
('The Edge', 100, 'windowbay3', '2012-01-25 15:27:54', NULL, 'RFID', 57, b'1'),
('The Edge', 101, NULL, '2012-01-26 09:29:57', NULL, 'RFID', 55, b'0'),
('The Edge', 102, 'windowbay3', '2012-01-26 14:04:53', NULL, 'RFID', 57, b'1'),
('The Edge', 103, 'windowbay1', '2012-01-26 15:50:59', NULL, 'RFID', 58, b'0'),
('The Edge', 104, 'windowbay1', '2012-01-26 15:51:43', NULL, 'RFID', 59, b'0'),
('The Edge', 105, 'windowbay1', '2012-01-26 15:55:16', NULL, 'RFID', 60, b'0'),
('The Edge', 106, 'windowbay1', '2012-01-26 15:55:48', NULL, 'RFID', 60, b'0'),
('The Edge', 107, 'windowbay1', '2012-01-26 15:56:13', NULL, 'RFID', 60, b'0'),
('The Edge', 108, 'nowhere', '2012-01-26 16:33:16', NULL, 'RFID', 60, b'0'),
('The Edge', 109, 'auditorium', '2012-01-26 16:33:31', NULL, 'RFID', 60, b'0'),
('The Edge', 110, 'lab2', '2012-01-26 16:33:59', NULL, 'RFID', 60, b'0'),
('The Edge', 111, 'windowbay1', '2012-01-26 16:39:14', NULL, 'RFID', 60, b'0'),
('The Edge', 112, 'windowbay3', '2012-01-27 16:24:17', NULL, 'RFID', 60, b'0'),
('The Edge', 113, 'windowbay1', '2012-01-27 16:24:30', NULL, 'RFID', 60, b'0'),
('The Edge', 114, 'auditorium', '2012-01-30 12:06:04', NULL, 'RFID', 60, b'0'),
('The Edge', 115, 'lab2', '2012-01-31 08:34:05', NULL, 'RFID', 60, b'0'),
('The Edge', 116, 'windowbay5', '2012-01-31 14:33:43', NULL, 'RFID', 61, b'0'),
('The Edge', 117, 'windowbay6', '2012-01-31 14:34:35', NULL, 'RFID', 61, b'0'),
('The Edge', 118, 'windowbay5', '2012-01-31 14:35:11', NULL, 'RFID', 61, b'0'),
('The Edge', 119, 'windowbay6', '2012-01-31 14:38:27', NULL, 'RFID', 61, b'0'),
('The Edge', 120, 'nowhere', '2012-01-31 14:39:07', NULL, 'RFID', 61, b'0'),
('The Edge', 121, 'coffeekiosk', '2012-01-31 14:39:44', NULL, 'RFID', 62, b'0'),
('The Edge', 122, 'windowbay5', '2012-01-31 14:41:34', NULL, 'RFID', 63, b'0'),
('The Edge', 123, 'windowbay5', '2012-01-31 14:41:57', NULL, 'RFID', 63, b'0'),
('The Edge', 124, 'windowbay5', '2012-01-31 14:42:35', NULL, 'RFID', 64, b'0'),
('The Edge', 125, 'windowbay4', '2012-01-31 14:46:43', NULL, 'RFID', 64, b'0'),
('The Edge', 126, 'windowbay7', '2012-01-31 16:44:42', NULL, 'RFID', 65, b'0'),
('The Edge', 127, 'windowbay5', '2012-01-31 16:45:07', NULL, 'RFID', 65, b'0'),
('The Edge', 128, 'auditorium', '2012-01-31 17:03:36', NULL, 'RFID', 66, b'0'),
('The Edge', 129, 'windowbay5', '2012-01-31 17:04:46', NULL, 'RFID', 66, b'0'),
('The Edge', 130, 'windowbay5', '2012-01-31 17:05:21', NULL, 'RFID', 67, b'0'),
('The Edge', 131, 'lab1', '2012-01-31 17:06:04', NULL, 'RFID', 66, b'0'),
('The Edge', 132, 'windowbay10', '2012-01-31 17:36:54', NULL, 'RFID', 68, b'0'),
('The Edge', 133, 'coffeekiosk', '2012-02-02 17:50:12', NULL, 'RFID', 68, b'0'),
('The Edge', 134, 'auditorium', '2012-02-02 17:51:16', NULL, 'RFID', 68, b'0'),
('The Edge', 135, 'lab1', '2012-02-02 17:51:43', NULL, 'RFID', 68, b'0'),
('The Edge', 136, 'coffeekiosk', '2012-02-02 17:51:57', NULL, 'RFID', 68, b'0'),
('The Edge', 137, 'nowhere', '2012-02-02 17:52:41', NULL, 'RFID', 68, b'0'),
('The Edge', 138, 'auditorium', '2012-02-02 17:54:04', NULL, 'RFID', 68, b'0'),
('The Edge', 139, 'windowbay5', '2012-02-02 17:55:27', NULL, 'RFID', 68, b'0'),
('The Edge', 140, 'windowbay7', '2012-02-02 18:02:00', NULL, 'RFID', 68, b'0'),
('The Edge', 141, 'windowbay6', '2012-02-02 18:12:31', NULL, 'RFID', 68, b'0'),
('The Edge', 142, 'nowhere', '2012-02-07 13:18:20', NULL, 'RFID', 68, b'0'),
('The Edge', 143, 'windowbay8', '2012-02-07 13:18:29', NULL, 'RFID', 68, b'0'),
('The Edge', 144, 'coffeekiosk', '2012-02-07 13:18:44', NULL, 'RFID', 68, b'0'),
('The Edge', 145, 'lab1', '2012-02-07 13:19:53', NULL, 'RFID', 68, b'0'),
('The Edge', 146, 'auditorium', '2012-02-07 13:20:28', NULL, 'RFID', 68, b'0'),
('The Edge', 147, 'lab2', '2012-02-07 13:21:13', NULL, 'RFID', 68, b'0'),
('The Edge', 148, 'windowbay10', '2012-02-07 13:22:39', NULL, 'RFID', 68, b'0'),
('The Edge', 149, 'auditorium', '2012-02-07 13:23:31', NULL, 'RFID', 68, b'0'),
('The Edge', 150, NULL, '2012-02-09 10:57:29', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 151, NULL, '2012-02-09 10:57:37', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 152, NULL, '2012-02-09 10:57:46', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 153, NULL, '2012-02-09 10:57:58', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 154, 'Bay 1', '2012-02-09 11:01:14', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 155, 'Bay 2', '2012-02-09 11:01:37', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 156, 'Bay_1', '2012-02-09 11:04:49', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 157, 'Bay_4', '2012-02-09 11:06:18', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 158, 'Bay 8', '2012-02-09 11:07:17', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 159, 'Bay 8', '2012-02-09 11:07:38', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 160, 'Bay 2', '2012-02-09 11:45:08', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 161, 'Bay 4', '2012-02-09 11:45:21', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 162, 'Bay 1', '2012-02-09 11:57:15', NULL, 'Mobile Website', 69, b'0'),
('The Edge', 163, 'Bay 1', '2012-02-09 12:29:05', NULL, 'Mobile Website', 70, b'0'),
('The Edge', 164, 'Bay 1', '2012-02-09 12:30:19', NULL, 'Mobile Website', 71, b'0'),
('The Edge', 165, 'Bay 1', '2012-02-09 12:30:57', NULL, 'Mobile Website', 72, b'0'),
('The Edge', 166, 'lab2', '2012-02-09 17:27:23', NULL, 'RFID', 68, b'0'),
('The Edge', 167, 'auditorium', '2012-02-09 17:34:39', NULL, 'RFID', 68, b'0'),
('The Edge', 168, 'windowbay1', '2012-02-09 18:22:10', NULL, 'RFID', 68, b'0'),
('The Edge', 169, 'windowbay2', '2012-02-09 18:22:59', NULL, 'RFID', 68, b'0'),
('The Edge', 170, 'windowbay5', '2012-02-09 18:23:14', NULL, 'RFID', 68, b'0'),
('The Edge', 171, 'coffeekiosk', '2012-02-09 18:23:19', NULL, 'RFID', 68, b'0'),
('The Edge', 172, NULL, '2012-02-16 12:47:37', NULL, 'RFID', 68, b'0'),
('The Edge', 173, 'Bay 1', '2012-02-16 12:50:07', NULL, 'Mobile Website', 73, b'0'),
('The Edge', 174, 'Bay 2', '2012-02-16 14:59:13', NULL, 'Mobile Website', 74, b'0'),
('The Edge', 175, 'Bay 2', '2012-02-16 14:59:35', NULL, 'Mobile Website', 75, b'0'),
('The Edge', 176, 'Bay 2', '2012-02-16 15:00:03', NULL, 'Mobile Website', 76, b'0'),
('The Edge', 177, 'Bay 3', '2012-02-16 15:00:34', NULL, 'Mobile Website', 77, b'0'),
('The Edge', 178, 'Bay 3', '2012-02-16 15:00:56', NULL, 'Mobile Website', 78, b'0'),
('The Edge', 179, 'Bay 3', '2012-02-16 15:01:11', NULL, 'Mobile Website', 79, b'0'),
('The Edge', 180, 'Bay 4', '2012-02-16 15:01:33', NULL, 'Mobile Website', 80, b'0'),
('The Edge', 181, NULL, '2012-03-06 18:02:32', NULL, 'RFID', 81, b'0'),
('The Edge', 182, NULL, '2012-03-06 18:04:54', NULL, 'RFID', 82, b'0'),
('The Edge', 183, 'Lab1', '2012-03-06 18:06:04', NULL, 'RFID', 68, b'0');

-- --------------------------------------------------------

--
-- Table structure for table `edge_users`
--

CREATE TABLE IF NOT EXISTS `edge_users` (
  `swipe_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `username` varchar(20) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  PRIMARY KEY  (`swipe_id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `edge_users`
--

INSERT INTO `edge_users` (`swipe_id`, `name`, `password`, `username`, `lastname`) VALUES
(222, 'Alessandro', 'Alessandro', '', ''),
(555, 'Max', 'Max', '', ''),
(1111, 'Mark2', 'Mark2', '', ''),
(1234, 'Mark', 'Mark', '', ''),
(2222, 'Marin', 'Marin', '', ''),
(12345, '', '', '', ''),
(12342342, 'Mark testuser', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `expertise_table`
--

CREATE TABLE IF NOT EXISTS `expertise_table` (
  `swipe_id` int(11) NOT NULL,
  `expertise` varchar(255) NOT NULL,
  PRIMARY KEY  (`swipe_id`,`expertise`),
  KEY `swipe_fk_expertise` (`swipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `expertise_table`
--

INSERT INTO `expertise_table` (`swipe_id`, `expertise`) VALUES
(222, 'Java'),
(222, 'Processing'),
(555, 'Iphone development'),
(555, 'MySQL'),
(555, 'Processing'),
(555, 'Software Architecture'),
(1111, 'Illustrator'),
(1111, 'InDesign'),
(1111, 'Photoshop'),
(1234, 'arduino'),
(1234, 'high-speed photography'),
(1234, 'html'),
(1234, 'musicstudio'),
(1234, 'php'),
(1234, 'Processing'),
(1234, 'soldering'),
(1234, 'user interface design'),
(1234, 'xbee'),
(2222, 'MathLab');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE IF NOT EXISTS `feedback` (
  `ID` int(11) NOT NULL auto_increment,
  `Feedback` text NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `feedback`
--


-- --------------------------------------------------------

--
-- Table structure for table `interest_table`
--

CREATE TABLE IF NOT EXISTS `interest_table` (
  `swipe_id` int(11) NOT NULL,
  `interest` varchar(255) NOT NULL,
  PRIMARY KEY  (`swipe_id`,`interest`),
  KEY `swipe_fk` (`swipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `interest_table`
--

INSERT INTO `interest_table` (`swipe_id`, `interest`) VALUES
(222, 'Arduino'),
(222, 'Interaction Design'),
(222, 'Photography'),
(555, 'Brasilian cooking'),
(555, 'Italian cooking'),
(555, 'Japanese cooking'),
(555, 'Multitouch'),
(1111, 'Arduino'),
(1111, 'Graphic Design'),
(1111, 'Photography'),
(1111, 'Pottery'),
(1234, 'Arduino'),
(1234, 'Graphic Design'),
(1234, 'Interaction Design'),
(1234, 'Interactive Technology'),
(1234, 'Photography'),
(1234, 'Physical Computing'),
(2222, 'Dental Technology');

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE IF NOT EXISTS `people` (
  `PersonID` int(11) NOT NULL auto_increment,
  `ThirdPartyID` varchar(200) NOT NULL,
  `ThirdParty` varchar(45) NOT NULL,
  PRIMARY KEY  (`PersonID`,`ThirdPartyID`,`ThirdParty`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=83 ;

--
-- Dumping data for table `people`
--

INSERT INTO `people` (`PersonID`, `ThirdPartyID`, `ThirdParty`) VALUES
(24, '61425656751', 'Mobile Number'),
(25, '61427823071', 'Mobile Number'),
(26, '13165850121347623512', 'Random ID'),
(27, '131659631522673', 'Random ID'),
(28, '61450010530', 'Mobile Number'),
(29, '1317787613706292199', 'Random ID'),
(30, '13179723471472332565', 'Random ID'),
(31, '1317974839400179037', 'Random ID'),
(32, '1318567599661976201', 'Random ID'),
(33, '13187246311850104578', 'Random ID'),
(34, '13187249291002171106', 'Random ID'),
(35, '1318724666582186796', 'Random ID'),
(36, '1318725787123780915', 'Random ID'),
(37, '61413207607', 'Mobile Number'),
(38, '61430063354', 'Mobile Number'),
(39, '61423501185', 'Mobile Number'),
(40, '1321225084453612047', 'Random ID'),
(41, '132125667928891', 'Random ID'),
(51, '1236128', 'Facebook'),
(51, '96616161727', 'Swipe Card'),
(52, '', 'Facebook'),
(52, '100', 'Swipe Card'),
(53, '69', 'Swipe Card'),
(54, '1001', 'Swipe Card'),
(55, 'null', 'RFID'),
(56, 'w3skf234hld', 'RFID'),
(57, 'w3skf234hldlkjh', 'RFID'),
(58, '111', 'RFID'),
(59, '222', 'RFID'),
(60, '', ''),
(61, '123', ''),
(62, '12345', ''),
(63, '12345', 'anonymous'),
(64, '1234', 'anonymous'),
(65, '2233444', 'anonymous'),
(66, '223344', 'rfidcard'),
(67, '223345', 'rfidcard'),
(68, '555', 'rfidcard'),
(69, 'null', 'Random ID'),
(70, '13287545451932510257', 'Random ID'),
(71, '13287546191000532656', 'Random ID'),
(72, '1328754657862958088', 'Random ID'),
(73, '13293606071060487360', 'Random ID'),
(74, '13293683531065997228', 'Random ID'),
(75, '13293683751128968601', 'Random ID'),
(76, '1329368403522378754', 'Random ID'),
(77, '13293684342054432052', 'Random ID'),
(78, '13293684561115367579', 'Random ID'),
(79, '13293684711124044509', 'Random ID'),
(80, '1329368493231947519', 'Random ID'),
(81, '90222', 'rfidcard'),
(82, '90221', 'rfidcard');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `expertise_table`
--
ALTER TABLE `expertise_table`
  ADD CONSTRAINT `swipe_fk_expertise` FOREIGN KEY (`swipe_id`) REFERENCES `edge_users` (`swipe_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
