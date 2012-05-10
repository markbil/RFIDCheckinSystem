# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.1.44)
# Database: meetmee_checkin6
# Generation Time: 2012-03-27 17:00:09 +1000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table app_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app_users`;

CREATE TABLE `app_users` (
  `FB_ID` varchar(100) NOT NULL,
  `accesToken` varchar(200) NOT NULL,
  `LastCheckin` datetime DEFAULT NULL,
  PRIMARY KEY (`FB_ID`),
  UNIQUE KEY `acces token_UNIQUE` (`accesToken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `app_users` WRITE;
/*!40000 ALTER TABLE `app_users` DISABLE KEYS */;

INSERT INTO `app_users` (`FB_ID`, `accesToken`, `LastCheckin`)
VALUES
	('1236128','AAACOahlvPXUBAGGZAHJkJj65u0DZBLepcTBef73iO2GX6zM2WXIm3fw3GOCM4j3XcQiRoyr0KnZCqn2XPp7h5UOEQubOhoZD',NULL);

/*!40000 ALTER TABLE `app_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table characteristic
# ------------------------------------------------------------

DROP TABLE IF EXISTS `characteristic`;

CREATE TABLE `characteristic` (
  `CheckInID` int(11) NOT NULL,
  `Characteristic` varchar(250) NOT NULL,
  `Category` varchar(45) NOT NULL,
  PRIMARY KEY (`CheckInID`,`Characteristic`),
  KEY `fk_CheckIn` (`CheckInID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `characteristic` WRITE;
/*!40000 ALTER TABLE `characteristic` DISABLE KEYS */;

INSERT INTO `characteristic` (`CheckInID`, `Characteristic`, `Category`)
VALUES
	(55,'Age','20'),
	(54,'Age','20'),
	(54,'Occupation','Student'),
	(54,'TV Show','How I Met Your Mother'),
	(52,'testing','Visit Reason'),
	(53,'Meeting new people','Visit Reason'),
	(51,'Peter is fat','Help'),
	(48,'Who knows some good Flash keyboard plugins?','Help'),
	(49,'Test ','Help'),
	(50,'CALVIN IS A BOGANNN!!!!','Help'),
	(47,'test checkin','Visit Reason'),
	(48,'Would a virtual keyboard be better as a method to answer questions?','Help'),
	(46,'Meetmee API','Visit Reason'),
	(45,'mark b and mark j','Visit Reason'),
	(32,'2 Player TEAMS EVENT this SUNDAY at Swan Districts - Steel Blue Oval %5 per person Buy In Rego 12pm Start 1pm C U There! reply stop to opt out','Help'),
	(33,'JAVA, PHP, C#, JavaScript, C++','Visit Reason'),
	(44,'mark b and mark j meeting','Visit Reason'),
	(43,'Urban Informatics, interaction design, arduino','Visit Reason'),
	(42,'I am here','Visit Reason'),
	(39,'APL Free Poker Tournament Every Wednesday  Fuse Bar Hotel Northbridge Cnr Lake & Brisbane St 6PM Rego B There! reply stop to opt out','Help'),
	(41,'test test mark','Visit Reason'),
	(55,'Occupation','Student'),
	(55,'TV Show','How I Met Your Mother'),
	(56,'Age','20'),
	(56,'Occupation','Student'),
	(56,'TV Show','How I Met Your Mother'),
	(57,'Age','20'),
	(57,'Occupation','Student'),
	(57,'TV Show','How I Met Your Mother'),
	(58,'20','Age'),
	(58,'Software Engineer','Occupation'),
	(59,'How I Met Your Mother','TV Show'),
	(59,'Friends','TV Show'),
	(59,'Blink 182','Band'),
	(60,'Test','Help'),
	(61,'20','Age'),
	(61,'Software Engineer','Occupation'),
	(62,'How I Met Your Mother','TV Show'),
	(62,'Friends','TV Show'),
	(62,'Blink 182','Band'),
	(63,'20','Age'),
	(63,'Software Engineer','Occupation'),
	(64,'How I Met Your Mother','TV Show'),
	(64,'Friends','TV Show'),
	(64,'Blink 182','Band'),
	(65,'20','Age'),
	(65,'Software Engineer','Occupation'),
	(66,'How I Met Your Mother','TV Show'),
	(66,'Friends','TV Show'),
	(66,'Blink 182','Band'),
	(67,'20','Age'),
	(67,'Software Engineer','Occupation'),
	(68,'How I Met Your Mother','TV Show'),
	(68,'Friends','TV Show'),
	(68,'Blink 182','Band'),
	(69,'20','Age'),
	(69,'Software Engineer','Occupation'),
	(70,'How I Met Your Mother','TV Show'),
	(70,'Friends','TV Show'),
	(70,'Blink 182','Band'),
	(71,'20','Age'),
	(71,'Software Engineer','Occupation'),
	(72,'How I Met Your Mother','TV Show'),
	(72,'Friends','TV Show'),
	(72,'Blink 182','Band'),
	(73,'Cricket','Interests'),
	(73,'Mark','Name'),
	(73,'Lots','Share'),
	(73,'Noh','Doing'),
	(73,'nah','Anything'),
	(74,'Cricket','Interests'),
	(74,'Mark Jones','Name'),
	(74,'PHP Knowledge','Share'),
	(74,'TOR','Doing'),
	(74,'Uni','Anything'),
	(75,'Hanging','Interests'),
	(75,'Mark Jones','Name'),
	(75,'Checkin System Knowledge','Share'),
	(75,'Meeting with Mark','Doing'),
	(75,'Blah','Anything'),
	(76,'Hanging','Interests'),
	(76,'Mark Jones','Name'),
	(76,'asdfasdfasdf','Share'),
	(76,'asdfadsf','Doing'),
	(76,'adsfadsfaf','Anything'),
	(77,'idontknow','StatusMessage'),
	(78,'idontknow','StatusMessage'),
	(81,'ThisismyfirstcheckinthroughProcessing','StatusMessage'),
	(82,'This','StatusMessage'),
	(83,'This is my first checkin through Processing','StatusMessage'),
	(84,'This is my first checkin through Processing v2','StatusMessage'),
	(85,'This is my first checkin through Processing v2','statusmessage'),
	(86,'This is my first checkin through Processing v2','statusmessage'),
	(89,'idontknow','statusmessage'),
	(90,'idontknow','statusmessage'),
	(91,'This is my first checkin through Processing v2','statusmessage'),
	(92,'This is my first checkin through Processing v2','statusmessage'),
	(93,'This is my first checkin through Processing v2','statusmessage'),
	(94,'This is my first checkin through Processing v2','statusmessage'),
	(93,'I have checked in at window bay 2','statusmessage'),
	(95,'I have checked in at window bay 2','statusmessage'),
	(96,'I have checked in at window bay 2','statusmessage'),
	(97,'I have checked in at window bay 3','statusmessage'),
	(98,'I have checked in at window bay 3','statusmessage'),
	(99,'I have checked in at window bay 4','statusmessage'),
	(100,'Alessandro is at Windowbay 3','statusmessage'),
	(102,'Alessandro is at Windowbay 3','statusmessage'),
	(102,'I am in window bay 3','statusmessage'),
	(102,'I am in window bay 2','statusmessage'),
	(101,'I am in window bay 2','statusmessage'),
	(101,'I am in window bay 1','statusmessage'),
	(101,'I am in window bay 10000','statusmessage'),
	(103,'I am in window bay 10000','statusmessage'),
	(104,'I am in window bay 2222','statusmessage'),
	(105,'I am in window bay 1212','statusmessage'),
	(106,'I am in window bay 1213','statusmessage'),
	(107,'I am in window bay 1213','statusmessage'),
	(108,'I am in window bay 1213','statusmessage'),
	(109,'I am in window bay 1213','statusmessage'),
	(110,'I am in window bay 1213','statusmessage'),
	(111,'I am in window bay 1213','statusmessage'),
	(112,'I am in window bay 1213','statusmessage'),
	(113,'I am in window bay 1213','statusmessage'),
	(114,'I am in window bay 1213','statusmessage'),
	(115,'I am in window bay 1213','statusmessage'),
	(115,'kliytvtq','statusmessage'),
	(115,'234redsx','statusmessage'),
	(115,'gh','statusmessage'),
	(115,'uybnm','statusmessage'),
	(115,'werty','statusmessage'),
	(116,'hgfd','statusmessage'),
	(117,'frtyu','statusmessage'),
	(118,'ooooooo','statusmessage'),
	(119,'iiiiiiiii','statusmessage'),
	(120,'tttttttt','statusmessage'),
	(121,'uuuuuu','statusmessage'),
	(122,'anynomousboyyyyyyy','statusmessage'),
	(123,'uytg','statusmessage'),
	(124,'yyyyyyy','statusmessage'),
	(125,'444444','statusmessage'),
	(115,'lllllll','statusmessage'),
	(115,'xsaqqqqqqqqwe','statusmessage'),
	(115,'zzssdd  :) hello!!!!!','statusmessage'),
	(124,'aaaaaaasssssssss','statusmessage'),
	(126,'wwwwwwwww','statusmessage'),
	(127,'rrrrrrrrrr','statusmessage'),
	(128,'wesdxc','statusmessage'),
	(129,'wertyiop','statusmessage'),
	(130,'zzzzzzzz','statusmessage'),
	(131,'zzzzzzzxxxxxccccc','statusmessage'),
	(132,'max is checked in:)','statusmessage');

/*!40000 ALTER TABLE `characteristic` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table check_in
# ------------------------------------------------------------

DROP TABLE IF EXISTS `check_in`;

CREATE TABLE `check_in` (
  `CheckInID` int(11) NOT NULL AUTO_INCREMENT,
  `MainLocation` int(5) NOT NULL,
  `SubLocation` int(5) NOT NULL,
  `Check_In_Time` datetime NOT NULL,
  `Check_Out_Time` datetime DEFAULT NULL,
  `identification_media_id` int(10) NOT NULL,
  KEY `fk_CheckIn` (`CheckInID`),
  KEY `fk_Tag` (`CheckInID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `check_in` WRITE;
/*!40000 ALTER TABLE `check_in` DISABLE KEYS */;

INSERT INTO `check_in` (`CheckInID`, `MainLocation`, `SubLocation`, `Check_In_Time`, `Check_Out_Time`, `identification_media_id`)
VALUES
	(268,99,0,'2012-03-22 15:40:01',NULL,33),
	(267,99,0,'2012-03-22 15:39:57',NULL,39),
	(266,99,0,'2012-03-22 15:39:55',NULL,37),
	(265,99,0,'2012-03-22 15:39:52',NULL,29),
	(264,99,0,'2012-03-22 15:39:50',NULL,29),
	(263,99,0,'2012-03-22 15:39:47',NULL,29),
	(262,99,0,'2012-03-22 15:39:44',NULL,29),
	(261,99,0,'2011-03-22 13:11:01',NULL,39),
	(260,99,0,'2011-03-22 11:10:56',NULL,33),
	(259,99,0,'2012-03-22 13:10:49',NULL,29),
	(258,99,0,'2012-02-02 17:40:52',NULL,29),
	(257,99,0,'2012-03-21 17:40:48',NULL,39),
	(243,99,0,'2012-03-15 19:05:09',NULL,39),
	(242,99,0,'2012-03-15 19:05:05',NULL,37),
	(241,99,0,'2012-01-15 19:04:59',NULL,29),
	(240,99,0,'2012-03-15 19:04:52',NULL,33),
	(239,99,0,'2012-02-10 19:04:44',NULL,33),
	(256,99,0,'2012-03-21 17:40:45',NULL,37),
	(255,99,0,'2012-03-06 14:28:11',NULL,33),
	(254,99,0,'2012-03-05 14:28:09',NULL,33),
	(253,99,0,'2012-03-19 14:28:07',NULL,39),
	(252,99,0,'2012-03-21 14:28:05',NULL,29),
	(251,99,0,'2012-03-03 08:53:55',NULL,37),
	(250,99,0,'2012-03-21 08:53:48',NULL,37),
	(249,99,0,'2012-03-13 08:53:42',NULL,37),
	(248,99,0,'2012-03-12 08:53:38',NULL,37),
	(247,99,0,'2012-03-21 08:53:36',NULL,33),
	(246,99,0,'2012-03-20 08:53:34',NULL,39),
	(245,99,0,'2012-03-21 08:53:31',NULL,29),
	(269,99,0,'2012-03-23 10:36:34',NULL,37),
	(270,99,0,'2012-03-23 10:39:05',NULL,37),
	(271,99,4,'2012-03-23 10:40:11',NULL,37),
	(272,99,0,'2012-03-23 10:41:05',NULL,37),
	(273,99,0,'2012-03-23 10:47:46',NULL,29),
	(274,99,0,'2012-03-23 10:47:49',NULL,37),
	(275,99,0,'2012-03-23 10:47:50',NULL,39),
	(276,99,234,'2012-03-23 10:49:00',NULL,37),
	(277,99,2,'2012-03-23 10:49:22',NULL,37),
	(278,99,5,'2012-03-23 10:49:26',NULL,37),
	(279,99,9,'2012-03-23 10:49:30',NULL,37);

/*!40000 ALTER TABLE `check_in` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table edge_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `edge_users`;

CREATE TABLE `edge_users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `occupation` varchar(100) NOT NULL,
  `statusmessage` varchar(140) NOT NULL,
  `dontdisturb` int(4) DEFAULT NULL COMMENT '0=happytotalk, 1 = dont disturb ',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `edge_users` WRITE;
/*!40000 ALTER TABLE `edge_users` DISABLE KEYS */;

INSERT INTO `edge_users` (`ID`, `username`, `password`, `firstname`, `lastname`, `email`, `occupation`, `statusmessage`, `dontdisturb`)
VALUES
	(2,'markbil','Mark','Mark','Bilandzic','mabil@web.de','','',NULL),
	(8,'Mark','Mark','test','test','','','',NULL),
	(24,'Monkey','Pink','Spiderman','Monnkkey','qwery@loop.com','Student in Monkeystudies','Programming Monkey-Microcontrollers',NULL),
	(28,'Jim','frodo','Jeremiah','Down','www@sss.com','Programmer / Visual Artist','Developing a User Interface in Processing',NULL),
	(29,'Hal','dave','Hal','2000','hal@2001.space.com','','',NULL),
	(30,'DirkGently','douglas','Dirk','Gently','','','',NULL),
	(31,'LadyGaga','pokerface','Lady','Gaga','crazy@gaga.com','','',NULL),
	(32,'darkknight','batman','Batman','Black','batman@supermobile.com','superhero','Where is Robin?',NULL),
	(33,'Kendone','colours','','','','','',NULL),
	(34,'tiger','eyeofthetiger','Superman','Kent','superman@metropolis.com','superhero','beware of the cryptonite on level 2!',NULL),
	(35,'markimark','markimark','Mark','Bilandzic','mabil@web.de','','',NULL),
	(36,'asdfaf','asdfadf','','','','','',NULL),
	(37,'Beverly','Beverly','Branda','Walsh','Brenda.Walsh@qut.edu.au','Actress','I am just looking awesome...',NULL);

/*!40000 ALTER TABLE `edge_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table expertise_table
# ------------------------------------------------------------

DROP TABLE IF EXISTS `expertise_table`;

CREATE TABLE `expertise_table` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `expertise` varchar(300) NOT NULL,
  `level` int(2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `expertise_table` WRITE;
/*!40000 ALTER TABLE `expertise_table` DISABLE KEYS */;

INSERT INTO `expertise_table` (`ID`, `edge_users_id`, `expertise`, `level`)
VALUES
	(1,24,'basketball',1),
	(2,24,'criquet',3),
	(3,24,'criquet',5),
	(4,28,'soccer',2),
	(5,28,'networking',1),
	(6,28,'shopping',1),
	(7,24,'talking to people',4),
	(8,28,'Sleeping',5),
	(9,28,'Pink Hair',1),
	(10,32,'interactive graphics',4),
	(11,32,'belly dancing',3),
	(12,32,'hip hop dancing',4),
	(13,32,'freestyle rapping',2),
	(14,34,'flying',5),
	(15,34,'kissing Jane',4),
	(16,28,'test expertise',4),
	(17,28,'test expertise',4),
	(18,28,'test expertise',4),
	(19,28,'test expertise',4),
	(20,28,'test expertise',4),
	(21,28,'test expertise',4),
	(22,28,'test expertise',4),
	(23,28,'test expertise',4),
	(24,28,'test expertise',4),
	(25,28,'test expertise',4),
	(26,28,'test expertise',4),
	(27,28,'testtesttest expertise',4),
	(28,28,'testtesttest expertise',4),
	(29,28,'testtesttest expertise',4),
	(30,28,'testtesttest expertise',4),
	(31,28,'testtesttest expertise',4),
	(32,28,'testtesttest expertise',4),
	(33,28,'testtesttest expertise',4),
	(34,28,'testtesttest expertise',4),
	(35,28,'testtesttest expertise',4),
	(36,28,'testtesttest expertise',4),
	(37,28,'testtesttest expertise',4),
	(38,28,'testtesttest expertise',4),
	(39,28,'testtesttest expertise',4),
	(40,28,'testtesttest expertise',4),
	(41,28,'testtesttest expertise',4),
	(42,28,'testtesttest expertise',4),
	(43,28,'testtesttest expertise',4),
	(44,28,'testtesttest expertise',4),
	(45,28,'testtesttest expertise',4),
	(46,28,'testtesttest expertise',4),
	(47,28,'testtesttest expertise',4),
	(48,28,'testtesttest expertise',4),
	(49,28,'testtesttest expertise',4),
	(50,28,'testtesttest expertise',4),
	(51,28,'testtesttest expertise',4);

/*!40000 ALTER TABLE `expertise_table` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table feedback
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Feedback` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Dump of table identification_media
# ------------------------------------------------------------

DROP TABLE IF EXISTS `identification_media`;

CREATE TABLE `identification_media` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ThirdPartyID` varchar(45) NOT NULL,
  `Type` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `identification_media` WRITE;
/*!40000 ALTER TABLE `identification_media` DISABLE KEYS */;

INSERT INTO `identification_media` (`ID`, `ThirdPartyID`, `Type`)
VALUES
	(1,'55555',1),
	(3,'22222222',1),
	(4,'11111',1),
	(5,'2222222111111',1),
	(6,'55555',1),
	(7,'777777777',1),
	(8,'777777777',1),
	(9,'333333333',1),
	(10,'333333333',1),
	(11,'333333333',1),
	(12,'333333333',1),
	(13,'333333333',1),
	(14,'333333333',1),
	(15,'77777777777',1),
	(16,'99999999999',1),
	(17,'99999999999',1),
	(18,'99999999999',1),
	(19,'99999999999',1),
	(20,'2020202012',1),
	(21,'2020202012',1),
	(22,'2020202012',1),
	(23,'2020202012',1),
	(24,'2020202012',1),
	(25,'2020202012',1),
	(26,'2020202012',1),
	(27,'213123122',1),
	(28,'312435325',1),
	(29,'4500B8D75B71',1),
	(31,'2222234555',1),
	(32,'34348',1),
	(33,'4500B8DF290B',1),
	(34,'2001',1),
	(35,'05408544',1),
	(36,'05408545',1),
	(37,'4500B8C00D30',1),
	(38,'05408547',1),
	(39,'4500B8C293AC',1),
	(40,'1234',1),
	(41,'<?php /*if (isset($_GET[\'swipe_id\'])) echo $_',1),
	(42,'90210',1);

/*!40000 ALTER TABLE `identification_media` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table identification_media_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `identification_media_type`;

CREATE TABLE `identification_media_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `identification_media_type` WRITE;
/*!40000 ALTER TABLE `identification_media_type` DISABLE KEYS */;

INSERT INTO `identification_media_type` (`ID`, `Name`, `Description`)
VALUES
	(1,'RFID','Radio Frequency Identification Tag');

/*!40000 ALTER TABLE `identification_media_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table interest_table
# ------------------------------------------------------------

DROP TABLE IF EXISTS `interest_table`;

CREATE TABLE `interest_table` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `interest` varchar(255) NOT NULL,
  `level` int(2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `interest_table` WRITE;
/*!40000 ALTER TABLE `interest_table` DISABLE KEYS */;

INSERT INTO `interest_table` (`ID`, `edge_users_id`, `interest`, `level`)
VALUES
	(1,24,'Arduino',1),
	(2,24,'Graphic Design',2),
	(3,24,'Photography',3),
	(4,34,'Pottery',4),
	(5,34,'Android Development',5),
	(6,24,'Apple',1),
	(7,28,'Arduino',2),
	(8,28,'iphone development',3),
	(9,28,'Photography',4),
	(10,28,'User Interface Design',5),
	(11,32,'Drinking',1),
	(12,24,'Eating',2),
	(16,32,'Dental Technology',1),
	(20,37,'Brasilian cooking',5),
	(21,32,'Italian cooking',1),
	(22,32,'Japanese cooking',2),
	(23,37,'Multitouch',3),
	(24,37,'cooking',4),
	(25,37,'croatian radio',5),
	(26,37,'jogging',1),
	(27,37,'kids',2);

/*!40000 ALTER TABLE `interest_table` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table locations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `id` int(5) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;

INSERT INTO `locations` (`id`, `name`)
VALUES
	(1,'Window Bay 1'),
	(2,'Window Bay 2'),
	(3,'Window Bay 3'),
	(4,'Window Bay 4'),
	(5,'Window Bay 5'),
	(6,'Window Bay 6'),
	(7,'Window Bay 7'),
	(8,'Window Bay 8'),
	(9,'Window Bay 9'),
	(10,'Window Bay 10'),
	(11,'Window Bay 11'),
	(12,'Computer Lab (Lab 1)'),
	(13,'Physical Lab (Lab 2)'),
	(14,'Sound Studio'),
	(15,'Auditorium'),
	(16,'Coffee Kiosk'),
	(17,'Mezzanine'),
	(18,'Foyer'),
	(99,'The Edge');

/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table people
# ------------------------------------------------------------

DROP TABLE IF EXISTS `people`;

CREATE TABLE `people` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `identification_id` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;

INSERT INTO `people` (`ID`, `edge_users_id`, `identification_id`)
VALUES
	(1,24,29),
	(2,25,30),
	(3,26,31),
	(4,27,32),
	(5,28,33),
	(6,29,34),
	(7,30,35),
	(8,31,36),
	(9,32,37),
	(10,33,38),
	(11,34,39),
	(12,35,40),
	(13,36,41),
	(14,37,42);

/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projects`;

CREATE TABLE `projects` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(40) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;

INSERT INTO `projects` (`ID`, `Name`, `Description`)
VALUES
	(1,'RFID Checkin System','Develop a system whereby Edge Users can check into the centre using an RFID tag.'),
	(2,'I Do Not Like It','I want that one that one and that One'),
	(3,'Mouse Trap','Reinvent a mouse trap\r\nMonster Trucks - yeah Monster Trucks'),
	(5,'Smegel','A floating blue line'),
	(6,'Lily','Eats Cheese\r\nSings and dances'),
	(7,'Angus','Eating hamburgers\r\nTraining Blobs'),
	(8,'The Big Bazooka','A giant gun that likes to blow up and automatically fires'),
	(9,'Fly in the ointment','Take a fly for a ride in the Big Red Car with headgear'),
	(10,'Electric Glasses','Create glasses that can  turn on and off'),
	(11,'Balloon Fountain','Create a fountain made out of ballons'),
	(12,'Jumping Beans','Have a bean jump on a flea'),
	(13,'Bubbles','Bouncing Bubbles'),
	(14,'3D Printer','Make a 3D Printer'),
	(15,'Do it yourself Drone','this is a first version of my drone!!!'),
	(16,'',''),
	(17,'',''),
	(18,'',''),
	(19,'asdfasdf','asdfadf\r\nadf\r\nasdf\r\n\r\n\r\nasdf\r\nasdf\r\n\r\n\r\nasdf\r\na\r\ndfasf'),
	(20,'Blog','blah blah blah'),
	(21,'building the multitouch table','bla bla bla');

/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projects_edge_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projects_edge_users`;

CREATE TABLE `projects_edge_users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `projects_edge_users` WRITE;
/*!40000 ALTER TABLE `projects_edge_users` DISABLE KEYS */;

INSERT INTO `projects_edge_users` (`ID`, `edge_users_id`, `project_id`)
VALUES
	(1,24,2),
	(2,28,2),
	(3,24,3),
	(4,2,24),
	(18,8,3),
	(20,29,2),
	(21,2,1),
	(22,29,1),
	(23,30,2),
	(24,2,9),
	(25,24,9),
	(29,8,10),
	(30,24,10),
	(33,28,10),
	(34,24,11),
	(36,31,11),
	(37,8,11),
	(41,24,12),
	(42,28,12),
	(43,29,12),
	(45,30,6),
	(46,28,6),
	(47,31,6),
	(48,24,13),
	(49,30,13),
	(55,2,7),
	(56,24,7),
	(57,28,7),
	(58,30,7),
	(59,24,21),
	(61,31,21),
	(62,35,21);

/*!40000 ALTER TABLE `projects_edge_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table questions_table
# ------------------------------------------------------------

DROP TABLE IF EXISTS `questions_table`;

CREATE TABLE `questions_table` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `edge_users_id` int(11) NOT NULL,
  `question` varchar(300) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `questions_table` WRITE;
/*!40000 ALTER TABLE `questions_table` DISABLE KEYS */;

INSERT INTO `questions_table` (`ID`, `edge_users_id`, `question`)
VALUES
	(1,24,'who can hellp me with photoshp'),
	(2,28,'who can help me with android???'),
	(3,24,'who can help me with ipho'),
	(4,28,'Joking'),
	(5,24,'Sci Fi Movies'),
	(6,28,'Soldering');

/*!40000 ALTER TABLE `questions_table` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table view_checkins
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_checkins`;

CREATE TABLE `view_checkins` (
   `edge_user_id` INT(11) NOT NULL DEFAULT '0',
   `firstname` VARCHAR(50) NOT NULL,
   `lastname` VARCHAR(50) NOT NULL,
   `occupation` VARCHAR(100) NOT NULL,
   `statusmessage` VARCHAR(140) NOT NULL,
   `imt_name` VARCHAR(45) NOT NULL,
   `im_id` VARCHAR(45) NOT NULL,
   `checkin_timestamp` DATETIME NOT NULL,
   `months_since_checkin` BIGINT(21) DEFAULT NULL,
   `days_since_checkin` BIGINT(21) DEFAULT NULL,
   `hours_since_checkin` BIGINT(21) DEFAULT NULL,
   `minutes_since_checkin` BIGINT(21) DEFAULT NULL,
   `checkin_sublocation` VARCHAR(50) DEFAULT NULL
) ENGINE=MyISAM;



# Dump of table view_highscorelist_distinctusercheckins_all
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_highscorelist_distinctusercheckins_all`;

CREATE TABLE `view_highscorelist_distinctusercheckins_all` (
   `edge_user_id` INT(11) NOT NULL DEFAULT '0',
   `firstname` VARCHAR(50) NOT NULL,
   `lastname` VARCHAR(50) NOT NULL,
   `distinct_checkindays` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_highscorelist_distinctusercheckinsperday_thismonth
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_highscorelist_distinctusercheckinsperday_thismonth`;

CREATE TABLE `view_highscorelist_distinctusercheckinsperday_thismonth` (
   `edge_user_id` INT(11) NOT NULL DEFAULT '0',
   `firstname` VARCHAR(50) NOT NULL,
   `lastname` VARCHAR(50) NOT NULL,
   `thismonth_name` VARCHAR(9) DEFAULT NULL,
   `distinct_checkindays` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_highscorelist_distinctusercheckinsperday_thisweek
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_highscorelist_distinctusercheckinsperday_thisweek`;

CREATE TABLE `view_highscorelist_distinctusercheckinsperday_thisweek` (
   `edge_user_id` INT(11) NOT NULL DEFAULT '0',
   `firstname` VARCHAR(50) NOT NULL,
   `lastname` VARCHAR(50) NOT NULL,
   `weekofyear` INT(6) DEFAULT NULL,
   `distinct_checkindays` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_highscorelist_distinctusercheckinsperday_thisyear
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_highscorelist_distinctusercheckinsperday_thisyear`;

CREATE TABLE `view_highscorelist_distinctusercheckinsperday_thisyear` (
   `edge_user_id` INT(11) NOT NULL DEFAULT '0',
   `firstname` VARCHAR(50) NOT NULL,
   `lastname` VARCHAR(50) NOT NULL,
   `thisyear` INT(4) DEFAULT NULL,
   `distinct_checkindays` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_list_distinctusercheckins_all
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_list_distinctusercheckins_all`;

CREATE TABLE `view_list_distinctusercheckins_all` (
   `edge_user_id` INT(11) NOT NULL DEFAULT '0',
   `firstname` VARCHAR(50) NOT NULL,
   `lastname` VARCHAR(50) NOT NULL,
   `occupation` VARCHAR(100) NOT NULL,
   `statusmessage` VARCHAR(140) NOT NULL,
   `checkin_timestamp` DATETIME DEFAULT NULL,
   `months_since_checkin` BIGINT(21) DEFAULT NULL,
   `days_since_checkin` BIGINT(21) DEFAULT NULL,
   `hours_since_checkin` BIGINT(21) DEFAULT NULL,
   `minutes_since_checkin` BIGINT(21) DEFAULT NULL,
   `checkin_sublocation` VARCHAR(50) DEFAULT NULL
) ENGINE=MyISAM;



# Dump of table view_list_distinctusercheckins_perdate
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_list_distinctusercheckins_perdate`;

CREATE TABLE `view_list_distinctusercheckins_perdate` (
   `edge_user_id` INT(11) NOT NULL DEFAULT '0',
   `firstname` VARCHAR(50) NOT NULL,
   `lastname` VARCHAR(50) NOT NULL,
   `occupation` VARCHAR(100) NOT NULL,
   `statusmessage` VARCHAR(140) NOT NULL,
   `imt_name` VARCHAR(45) NOT NULL,
   `im_id` VARCHAR(45) NOT NULL,
   `checkin_timestamp` DATETIME NOT NULL,
   `months_since_checkin` BIGINT(21) DEFAULT NULL,
   `days_since_checkin` BIGINT(21) DEFAULT NULL,
   `hours_since_checkin` BIGINT(21) DEFAULT NULL,
   `minutes_since_checkin` BIGINT(21) DEFAULT NULL,
   `checkin_sublocation` VARCHAR(50) DEFAULT NULL
) ENGINE=MyISAM;



# Dump of table view_number_distinctusercheckins_all
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_distinctusercheckins_all`;

CREATE TABLE `view_number_distinctusercheckins_all` (
   `distinct_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_distinctusercheckins_perdate
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_distinctusercheckins_perdate`;

CREATE TABLE `view_number_distinctusercheckins_perdate` (
   `checkin_date` DATE DEFAULT NULL,
   `distinct_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_distinctusercheckins_perhour
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_distinctusercheckins_perhour`;

CREATE TABLE `view_number_distinctusercheckins_perhour` (
   `hour` INT(2) DEFAULT NULL,
   `distinct_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_distinctusercheckins_permonth
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_distinctusercheckins_permonth`;

CREATE TABLE `view_number_distinctusercheckins_permonth` (
   `month_index` INT(2) DEFAULT NULL,
   `month_name` VARCHAR(9) DEFAULT NULL,
   `distinct_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_distinctusercheckins_perweekday
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_distinctusercheckins_perweekday`;

CREATE TABLE `view_number_distinctusercheckins_perweekday` (
   `weekday_index` INT(1) DEFAULT NULL,
   `weekday_name` VARCHAR(9) DEFAULT NULL,
   `distinct_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_distinctusercheckins_thismonth_perday
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_distinctusercheckins_thismonth_perday`;

CREATE TABLE `view_number_distinctusercheckins_thismonth_perday` (
   `dayofmonth_index` INT(2) DEFAULT NULL,
   `weekday_name` VARCHAR(9) DEFAULT NULL,
   `date` DATE DEFAULT NULL,
   `distinct_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_distinctusercheckins_thisweek_perday
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_distinctusercheckins_thisweek_perday`;

CREATE TABLE `view_number_distinctusercheckins_thisweek_perday` (
   `weekday_index` INT(1) DEFAULT NULL,
   `weekday_name` VARCHAR(9) DEFAULT NULL,
   `date` DATE DEFAULT NULL,
   `distinct_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_distinctusercheckins_today_perhour
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_distinctusercheckins_today_perhour`;

CREATE TABLE `view_number_distinctusercheckins_today_perhour` (
   `hour` INT(2) DEFAULT NULL,
   `date` DATE DEFAULT NULL,
   `distinct_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_totalusercheckins_peryearmonth
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_totalusercheckins_peryearmonth`;

CREATE TABLE `view_number_totalusercheckins_peryearmonth` (
   `yearmonth_index` INT(6) DEFAULT NULL,
   `month_name` VARCHAR(9) DEFAULT NULL,
   `year` INT(4) DEFAULT NULL,
   `total_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table view_number_totalusercheckins_peryearweek
# ------------------------------------------------------------

DROP VIEW IF EXISTS `view_number_totalusercheckins_peryearweek`;

CREATE TABLE `view_number_totalusercheckins_peryearweek` (
   `yearweek_index` INT(6) DEFAULT NULL,
   `weekofyear` INT(2) DEFAULT NULL,
   `year` INT(4) DEFAULT NULL,
   `total_usercheckins` BIGINT(21) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;





# Replace placeholder table for view_number_distinctusercheckins_all with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_distinctusercheckins_all`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_all`
AS select
   count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins`
from `view_checkins`;


# Replace placeholder table for view_highscorelist_distinctusercheckinsperday_thisweek with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_highscorelist_distinctusercheckinsperday_thisweek`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_highscorelist_distinctusercheckinsperday_thisweek`
AS select
   `view_list_distinctusercheckins_perdate`.`edge_user_id` AS `edge_user_id`,
   `view_list_distinctusercheckins_perdate`.`firstname` AS `firstname`,
   `view_list_distinctusercheckins_perdate`.`lastname` AS `lastname`,yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) AS `weekofyear`,count(0) AS `distinct_checkindays`
from `view_list_distinctusercheckins_perdate`
where (yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) = yearweek((select now() AS `NOW()`),7)) group by `view_list_distinctusercheckins_perdate`.`edge_user_id` order by count(0) desc;


# Replace placeholder table for view_number_distinctusercheckins_perdate with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_distinctusercheckins_perdate`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_perdate`
AS select
   cast(`view_checkins`.`checkin_timestamp` as date) AS `checkin_date`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins`
from `view_checkins` group by cast(`view_checkins`.`checkin_timestamp` as date) order by cast(`view_checkins`.`checkin_timestamp` as date) desc;


# Replace placeholder table for view_number_distinctusercheckins_thisweek_perday with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_distinctusercheckins_thisweek_perday`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_thisweek_perday`
AS select
   weekday(`view_checkins`.`checkin_timestamp`) AS `weekday_index`,dayname(`view_checkins`.`checkin_timestamp`) AS `weekday_name`,cast(`view_checkins`.`checkin_timestamp` as date) AS `date`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins`
from `view_checkins`
where (yearweek(`view_checkins`.`checkin_timestamp`,7) = yearweek((select now() AS `NOW()`),7)) group by weekday(`view_checkins`.`checkin_timestamp`) order by weekday(`view_checkins`.`checkin_timestamp`);


# Replace placeholder table for view_list_distinctusercheckins_perdate with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_list_distinctusercheckins_perdate`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_list_distinctusercheckins_perdate`
AS select
   `view_checkins`.`edge_user_id` AS `edge_user_id`,
   `view_checkins`.`firstname` AS `firstname`,
   `view_checkins`.`lastname` AS `lastname`,
   `view_checkins`.`occupation` AS `occupation`,
   `view_checkins`.`statusmessage` AS `statusmessage`,
   `view_checkins`.`imt_name` AS `imt_name`,
   `view_checkins`.`im_id` AS `im_id`,
   `view_checkins`.`checkin_timestamp` AS `checkin_timestamp`,
   `view_checkins`.`months_since_checkin` AS `months_since_checkin`,
   `view_checkins`.`days_since_checkin` AS `days_since_checkin`,
   `view_checkins`.`hours_since_checkin` AS `hours_since_checkin`,
   `view_checkins`.`minutes_since_checkin` AS `minutes_since_checkin`,
   `view_checkins`.`checkin_sublocation` AS `checkin_sublocation`
from `view_checkins` group by `view_checkins`.`edge_user_id`,cast(`view_checkins`.`checkin_timestamp` as date);


# Replace placeholder table for view_number_distinctusercheckins_today_perhour with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_distinctusercheckins_today_perhour`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_today_perhour`
AS select
   hour(`view_checkins`.`checkin_timestamp`) AS `hour`,cast(`view_checkins`.`checkin_timestamp` as date) AS `date`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins`
from `view_checkins`
where (cast(`view_checkins`.`checkin_timestamp` as date) = cast((select now() AS `NOW()`) as date)) group by hour(`view_checkins`.`checkin_timestamp`) order by hour(`view_checkins`.`checkin_timestamp`);


# Replace placeholder table for view_number_totalusercheckins_peryearweek with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_totalusercheckins_peryearweek`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_totalusercheckins_peryearweek`
AS select
   yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) AS `yearweek_index`,week(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) AS `weekofyear`,year(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `year`,count(`view_list_distinctusercheckins_perdate`.`edge_user_id`) AS `total_usercheckins`
from `view_list_distinctusercheckins_perdate` group by yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7) order by yearweek(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`,7);


# Replace placeholder table for view_number_distinctusercheckins_thismonth_perday with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_distinctusercheckins_thismonth_perday`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_thismonth_perday`
AS select
   dayofmonth(`view_checkins`.`checkin_timestamp`) AS `dayofmonth_index`,dayname(`view_checkins`.`checkin_timestamp`) AS `weekday_name`,cast(`view_checkins`.`checkin_timestamp` as date) AS `date`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins`
from `view_checkins`
where (extract(year_month from `view_checkins`.`checkin_timestamp`) = extract(year_month from (select now() AS `NOW()`))) group by dayofmonth(`view_checkins`.`checkin_timestamp`) order by dayofmonth(`view_checkins`.`checkin_timestamp`);


# Replace placeholder table for view_highscorelist_distinctusercheckinsperday_thisyear with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_highscorelist_distinctusercheckinsperday_thisyear`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_highscorelist_distinctusercheckinsperday_thisyear`
AS select
   `view_list_distinctusercheckins_perdate`.`edge_user_id` AS `edge_user_id`,
   `view_list_distinctusercheckins_perdate`.`firstname` AS `firstname`,
   `view_list_distinctusercheckins_perdate`.`lastname` AS `lastname`,year(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `thisyear`,count(0) AS `distinct_checkindays`
from `view_list_distinctusercheckins_perdate`
where (year(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) = year((select now() AS `NOW()`))) group by `view_list_distinctusercheckins_perdate`.`edge_user_id` order by count(0) desc;


# Replace placeholder table for view_number_distinctusercheckins_perhour with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_distinctusercheckins_perhour`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_perhour`
AS select
   hour(`view_checkins`.`checkin_timestamp`) AS `hour`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins`
from `view_checkins` group by hour(`view_checkins`.`checkin_timestamp`) order by hour(`view_checkins`.`checkin_timestamp`);


# Replace placeholder table for view_number_distinctusercheckins_perweekday with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_distinctusercheckins_perweekday`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_perweekday`
AS select
   weekday(`view_checkins`.`checkin_timestamp`) AS `weekday_index`,dayname(`view_checkins`.`checkin_timestamp`) AS `weekday_name`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins`
from `view_checkins` group by weekday(`view_checkins`.`checkin_timestamp`) order by weekday(`view_checkins`.`checkin_timestamp`);


# Replace placeholder table for view_number_distinctusercheckins_permonth with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_distinctusercheckins_permonth`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_distinctusercheckins_permonth`
AS select
   month(`view_checkins`.`checkin_timestamp`) AS `month_index`,monthname(`view_checkins`.`checkin_timestamp`) AS `month_name`,count(distinct `view_checkins`.`edge_user_id`) AS `distinct_usercheckins`
from `view_checkins` group by month(`view_checkins`.`checkin_timestamp`) order by month(`view_checkins`.`checkin_timestamp`);


# Replace placeholder table for view_checkins with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_checkins`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_checkins`
AS select
   `eu`.`ID` AS `edge_user_id`,
   `eu`.`firstname` AS `firstname`,
   `eu`.`lastname` AS `lastname`,
   `eu`.`occupation` AS `occupation`,
   `eu`.`statusmessage` AS `statusmessage`,
   `imt`.`Name` AS `imt_name`,
   `im`.`ThirdPartyID` AS `im_id`,
   `check_in`.`Check_In_Time` AS `checkin_timestamp`,(select timestampdiff(MONTH,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(MONTH, check_in.check_in_time, (SELECT NOW()))`) AS `months_since_checkin`,(select timestampdiff(DAY,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(DAY, check_in.check_in_time, (SELECT NOW()))`) AS `days_since_checkin`,(select timestampdiff(HOUR,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(HOUR, check_in.check_in_time, (SELECT NOW()))`) AS `hours_since_checkin`,(select timestampdiff(MINUTE,`check_in`.`Check_In_Time`,(select now() AS `NOW()`)) AS `TIMESTAMPDIFF(MINUTE, check_in.check_in_time, (SELECT NOW()))`) AS `minutes_since_checkin`,
   `locations`.`name` AS `checkin_sublocation`
from (((((`identification_media` `im` join `identification_media_type` `imt` on((`im`.`Type` = `imt`.`ID`))) join `people` on((`people`.`identification_id` = `im`.`ID`))) join `edge_users` `eu` on((`eu`.`ID` = `people`.`edge_users_id`))) join `check_in` on((`check_in`.`identification_media_id` = `im`.`ID`))) left join `locations` on((`check_in`.`SubLocation` = `locations`.`id`))) order by `check_in`.`Check_In_Time` desc;


# Replace placeholder table for view_list_distinctusercheckins_all with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_list_distinctusercheckins_all`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_list_distinctusercheckins_all`
AS select
   `view_checkins`.`edge_user_id` AS `edge_user_id`,
   `view_checkins`.`firstname` AS `firstname`,
   `view_checkins`.`lastname` AS `lastname`,
   `view_checkins`.`occupation` AS `occupation`,
   `view_checkins`.`statusmessage` AS `statusmessage`,max(`view_checkins`.`checkin_timestamp`) AS `checkin_timestamp`,
   `view_checkins`.`months_since_checkin` AS `months_since_checkin`,
   `view_checkins`.`days_since_checkin` AS `days_since_checkin`,
   `view_checkins`.`hours_since_checkin` AS `hours_since_checkin`,
   `view_checkins`.`minutes_since_checkin` AS `minutes_since_checkin`,
   `view_checkins`.`checkin_sublocation` AS `checkin_sublocation`
from `view_checkins` group by `view_checkins`.`edge_user_id` order by max(`view_checkins`.`checkin_timestamp`) desc;


# Replace placeholder table for view_number_totalusercheckins_peryearmonth with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_number_totalusercheckins_peryearmonth`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_number_totalusercheckins_peryearmonth`
AS select
   extract(year_month
from `view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `yearmonth_index`,monthname(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `month_name`,year(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `year`,count(`view_list_distinctusercheckins_perdate`.`edge_user_id`) AS `total_usercheckins` from `view_list_distinctusercheckins_perdate` group by extract(year_month from `view_list_distinctusercheckins_perdate`.`checkin_timestamp`) order by extract(year_month from `view_list_distinctusercheckins_perdate`.`checkin_timestamp`);


# Replace placeholder table for view_highscorelist_distinctusercheckinsperday_thismonth with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_highscorelist_distinctusercheckinsperday_thismonth`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_highscorelist_distinctusercheckinsperday_thismonth`
AS select
   `view_list_distinctusercheckins_perdate`.`edge_user_id` AS `edge_user_id`,
   `view_list_distinctusercheckins_perdate`.`firstname` AS `firstname`,
   `view_list_distinctusercheckins_perdate`.`lastname` AS `lastname`,monthname(`view_list_distinctusercheckins_perdate`.`checkin_timestamp`) AS `thismonth_name`,count(0) AS `distinct_checkindays`
from `view_list_distinctusercheckins_perdate`
where (extract(year_month from `view_list_distinctusercheckins_perdate`.`checkin_timestamp`) = extract(year_month from (select now() AS `NOW()`))) group by `view_list_distinctusercheckins_perdate`.`edge_user_id` order by count(0) desc;


# Replace placeholder table for view_highscorelist_distinctusercheckins_all with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_highscorelist_distinctusercheckins_all`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_highscorelist_distinctusercheckins_all`
AS select
   `view_list_distinctusercheckins_perdate`.`edge_user_id` AS `edge_user_id`,
   `view_list_distinctusercheckins_perdate`.`firstname` AS `firstname`,
   `view_list_distinctusercheckins_perdate`.`lastname` AS `lastname`,count(0) AS `distinct_checkindays`
from `view_list_distinctusercheckins_perdate` group by `view_list_distinctusercheckins_perdate`.`edge_user_id` order by count(0) desc;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
