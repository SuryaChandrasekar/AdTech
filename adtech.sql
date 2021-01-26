-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 25, 2021 at 08:05 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `adtech`
--

-- --------------------------------------------------------

--
-- Table structure for table `click`
--

CREATE TABLE `click` (
  `ID` int(11) NOT NULL,
  `DeliveryID` int(11) NOT NULL,
  `ClickTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `click`
--

INSERT INTO `click` (`ID`, `DeliveryID`, `ClickTime`) VALUES
(2, 9, '2021-01-24 17:21:35'),
(3, 12, '2021-01-24 17:22:12'),
(4, 14, '2021-01-25 09:49:55'),
(5, 9, '2021-01-25 13:24:07'),
(6, 9, '2021-01-25 13:25:19'),
(7, 12, '2021-01-25 18:07:49');

-- --------------------------------------------------------

--
-- Table structure for table `deliver`
--

CREATE TABLE `deliver` (
  `ID` int(11) NOT NULL,
  `AdsID` int(11) NOT NULL,
  `DeliveryID` varchar(50) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Browser` varchar(50) NOT NULL,
  `OS` varchar(50) NOT NULL,
  `Site` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `deliver`
--

INSERT INTO `deliver` (`ID`, `AdsID`, `DeliveryID`, `Time`, `Browser`, `OS`, `Site`) VALUES
(9, 4483, '244cf0db-ba28-4c5f-8c9c-2bf11ee42988', '2020-01-07 13:02:23', 'Chrome', 'iOS', 'http://super-dooper-news.com'),
(11, 4483, '244cf0db-ba30-4c5f-8c9c-2bf11ee42999', '2020-01-07 13:02:23', 'Chrome', 'iOS', 'http://super-dooper-news.com'),
(12, 4480, '244cf0db-ba30-4c5f-8c9c-2bf11ee42111', '2020-01-07 13:02:23', 'Chrome', 'iOS', 'http://super-dooper-news.com'),
(14, 4454, '244cf0db-ba28-4c5f-8c9c-2bf11ee7890', '2020-01-07 13:02:23', 'Chrome', 'iOS', 'http://super-dooper-news.com'),
(15, 4500, '244cf0db-ba28-4c5f-8c9c-2bf11ee56980', '2020-01-07 13:02:23', 'Firefox', 'Android', 'http://Useful-Info-news.com');

-- --------------------------------------------------------

--
-- Table structure for table `install`
--

CREATE TABLE `install` (
  `ID` int(11) NOT NULL,
  `ClickID` int(11) NOT NULL,
  `InstallTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `install`
--

INSERT INTO `install` (`ID`, `ClickID`, `InstallTime`) VALUES
(1, 3, '2021-01-24 17:33:34'),
(2, 4, '2021-01-25 09:51:44'),
(3, 3, '2021-01-25 18:03:25');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `ID` int(11) NOT NULL,
  `Action` varchar(10) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `StatusCode` int(11) NOT NULL,
  `Message` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`ID`, `Action`, `Time`, `StatusCode`, `Message`) VALUES
(1, 'Deliver', '2021-01-24 13:35:42', 500, 'Duplicate entry \'1\' for key \'PRIMARY\''),
(2, 'Deliver', '2021-01-24 13:44:06', 500, 'Duplicate entry \'1\' for key \'PRIMARY\''),
(3, 'Deliver', '2021-01-24 13:44:09', 500, 'Duplicate entry \'1\' for key \'PRIMARY\''),
(4, 'Deliver', '2021-01-24 13:44:21', 200, 'Deliver Successful'),
(5, 'Deliver', '2021-01-24 16:06:38', 404, 'never received the given delivery:\'244cf0db-ba28-4c5f-8c9c-2bf11ee42988\''),
(6, 'Deliver', '2021-01-24 16:12:28', 404, 'never received the given delivery:\'244cf0db-ba28-4c5f-8c9c-2bf11ee42999\''),
(7, 'Deliver', '2021-01-24 16:18:14', 404, 'never received the given delivery:NULL'),
(8, 'Deliver', '2021-01-24 16:22:40', 500, 'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \'\' at line 1'),
(9, 'Deliver', '2021-01-24 16:23:57', 404, 'never received the given delivery:\'244cf0db-ba28-7c5f-8c9c-2bf11ee42988\''),
(10, 'Deliver', '2021-01-24 16:25:57', 404, 'never received the given delivery:\'244cf0db-ba28-7c5f-8c9c-2bf11ee42988\''),
(11, 'Deliver', '2021-01-24 16:27:06', 404, 'never received the given delivery:\'244cf0db-ba28-7c5f-8c9c-2bf11ee42988\''),
(12, 'Deliver', '2021-01-24 16:28:04', 404, 'never received the given delivery:\'244cf0db-ba28-7c5f-8c9c-2bf11ee42988\''),
(13, 'Deliver', '2021-01-24 16:29:42', 500, 'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \'244cf0db-ba28-7c5f-8c9c-2bf11ee42988\'\'\' at line 1'),
(14, 'Deliver', '2021-01-24 16:32:41', 404, 'never received the given delivery:\'244cf0db-ba28-7c5f-8c9c-2bf11ee42988\''),
(15, 'Click', '2021-01-24 17:13:35', 200, 'Click Successful'),
(16, 'Deliver', '2021-01-24 17:19:34', 200, 'Deliver Successful'),
(17, 'Deliver', '2021-01-24 17:19:57', 500, 'Duplicate entry \'244cf0db-ba28-4c5f-8c9c-2bf11ee42988\' for key \'DeliveryID\''),
(18, 'Deliver', '2021-01-24 17:20:16', 200, 'Deliver Successful'),
(19, 'Deliver', '2021-01-24 17:20:30', 200, 'Deliver Successful'),
(20, 'Click', '2021-01-24 17:21:35', 200, 'Click Successful'),
(21, 'Deliver', '2021-01-24 17:21:48', 404, 'never received the given delivery:\'244cf0db-ba28-4c5f-8c9c-2bf11ee42121\''),
(22, 'Click', '2021-01-24 17:22:13', 200, 'Click Successful'),
(23, 'Click', '2021-01-24 17:32:12', 500, 'Table \'adtech.delivery\' doesn\'t exist'),
(24, 'Click', '2021-01-24 17:32:53', 500, 'Unknown column \'C.DeliverID\' in \'on clause\''),
(25, 'Install', '2021-01-24 17:33:34', 200, 'Install Successful'),
(26, 'Click', '2021-01-24 17:33:45', 404, 'never received the given click:NULL'),
(27, 'Deliver', '2021-01-24 18:33:03', 200, 'Statics loaded Successful'),
(28, 'Deliver', '2021-01-24 18:33:44', 200, 'Statics loaded Successful'),
(29, 'Deliver', '2021-01-24 18:57:45', 200, 'Statics loaded Successful'),
(30, 'Deliver', '2021-01-24 18:58:18', 200, 'Statics loaded Successful'),
(31, 'Deliver', '2021-01-24 19:01:20', 200, 'Statics loaded Successful'),
(32, 'Deliver', '2021-01-24 19:02:51', 200, 'Statics loaded Successful'),
(33, 'Deliver', '2021-01-24 19:09:48', 200, 'Statics loaded Successful'),
(34, 'Deliver', '2021-01-24 19:14:01', 200, 'Statics loaded Successful'),
(35, 'Deliver', '2021-01-24 19:16:14', 200, 'Statics loaded Successful'),
(36, 'Deliver', '2021-01-24 19:16:39', 200, 'Statics loaded Successful'),
(37, 'Deliver', '2021-01-24 19:20:37', 200, 'Statics loaded Successful'),
(38, 'Deliver', '2021-01-24 19:21:20', 200, 'Statics loaded Successful'),
(39, 'Deliver', '2021-01-24 19:21:33', 200, 'Statics loaded Successful'),
(40, 'Deliver', '2021-01-24 19:23:29', 200, 'Statics loaded Successful'),
(41, 'Deliver', '2021-01-24 19:25:00', 200, 'Statics loaded Successful'),
(42, 'Deliver', '2021-01-24 19:32:19', 200, 'Statics loaded Successful'),
(43, 'Deliver', '2021-01-24 19:34:05', 200, 'Statics loaded Successful'),
(44, 'Deliver', '2021-01-24 19:34:59', 200, 'Statics loaded Successful'),
(45, 'Deliver', '2021-01-24 19:40:15', 200, 'Statics loaded Successful'),
(46, 'Click', '2021-01-24 20:28:09', 500, 'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \'2021-01-23 23:03:34\'\' and \'\'2021-01-25 23:03:34\'\') as Deliver,('),
(47, 'Deliver', '2021-01-24 20:29:17', 200, 'Statics loaded Successful'),
(48, 'Deliver', '2021-01-24 20:31:23', 200, 'Statics loaded Successful'),
(49, 'Deliver', '2021-01-24 20:31:57', 200, 'Statics loaded Successful'),
(50, 'Deliver', '2021-01-25 09:45:17', 500, 'Duplicate entry \'244cf0db-ba28-4c5f-8c9c-2bf11ee42988\' for key \'DeliveryID\''),
(51, 'Deliver', '2021-01-25 09:45:54', 500, 'Column \'AdsID\' cannot be null'),
(52, 'Deliver', '2021-01-25 09:46:40', 200, 'Deliver Successful'),
(53, 'Click', '2021-01-25 09:49:55', 200, 'Click Successful'),
(54, 'Deliver', '2021-01-25 09:50:09', 404, 'never received the given delivery:\'244cf0db-ba28-4c5f-8c9c-2bf11ee7678\''),
(55, 'Install', '2021-01-25 09:51:44', 200, 'Install Successful'),
(56, 'Click', '2021-01-25 09:52:00', 404, 'never received the given click:NULL'),
(57, 'Deliver', '2021-01-25 09:55:14', 200, 'Statics loaded Successful'),
(58, 'Deliver', '2021-01-25 09:56:40', 200, 'Statics loaded Successful'),
(59, 'Deliver', '2021-01-25 12:07:45', 200, 'Statics loaded Successful'),
(60, 'Click', '2021-01-25 12:10:40', 404, 'never received the given click:NULL'),
(61, 'Deliver', '2021-01-25 13:01:47', 500, 'Column \'AdsID\' cannot be null'),
(62, 'Deliver', '2021-01-25 13:14:21', 500, 'Column \'AdsID\' cannot be null'),
(63, 'Deliver', '2021-01-25 13:17:05', 500, 'Column \'AdsID\' cannot be null'),
(64, 'Deliver', '2021-01-25 13:23:21', 500, 'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \'?\' at line 1'),
(65, 'Click', '2021-01-25 13:24:08', 200, 'Click Successful'),
(66, 'Click', '2021-01-25 13:25:19', 200, 'Click Successful'),
(67, 'Deliver', '2021-01-25 13:25:24', 500, 'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \'?\' at line 1'),
(68, 'Deliver', '2021-01-25 13:25:56', 500, 'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \'?\' at line 1'),
(69, 'Click', '2021-01-25 13:27:26', 404, 'never received the given click:NULL'),
(70, 'Click', '2021-01-25 13:27:36', 500, 'You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near \'?\' at line 1'),
(71, 'Deliver', '2021-01-25 15:01:24', 200, 'Deliver Successful'),
(72, 'Deliver', '2021-01-25 15:59:23', 200, 'Statics loaded Successful'),
(73, 'Deliver', '2021-01-25 16:42:41', 200, 'Statics loaded Successful'),
(74, 'Deliver', '2021-01-25 17:05:26', 200, 'Statics loaded Successful'),
(75, 'Deliver', '2021-01-25 17:26:45', 200, 'Statics loaded Successful'),
(76, 'Deliver', '2021-01-25 17:28:56', 200, 'Statics loaded Successful'),
(77, 'Deliver', '2021-01-25 17:29:57', 200, 'Statics loaded Successful'),
(78, 'Deliver', '2021-01-25 17:31:19', 200, 'Statics loaded Successful'),
(79, 'Install', '2021-01-25 18:03:26', 200, 'Install Successful'),
(80, 'Click', '2021-01-25 18:07:49', 200, 'Click Successful'),
(81, 'Deliver', '2021-01-25 18:09:01', 200, 'Statics loaded Successful'),
(82, 'Deliver', '2021-01-25 18:45:40', 200, 'Statics loaded Successful');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `click`
--
ALTER TABLE `click`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `deliver`
--
ALTER TABLE `deliver`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `DeliveryID` (`DeliveryID`);

--
-- Indexes for table `install`
--
ALTER TABLE `install`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `click`
--
ALTER TABLE `click`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `deliver`
--
ALTER TABLE `deliver`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `install`
--
ALTER TABLE `install`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
