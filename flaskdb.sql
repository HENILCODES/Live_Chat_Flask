-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 03, 2022 at 11:56 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flaskdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `ID` bigint(20) NOT NULL,
  `SENDER` text NOT NULL,
  `MESSAGE` text NOT NULL DEFAULT ' ',
  `FILE` text NOT NULL,
  `T_FILE` text NOT NULL,
  `DATETIME` text NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`ID`, `SENDER`, `MESSAGE`, `FILE`, `T_FILE`, `DATETIME`) VALUES
(32, 'henil', 'hi', '', '', '2022-10-02 10:54:16'),
(33, 'heni', 's', '', '', '2022-10-02 11:24:59'),
(34, 'heni', 'j', '', '', '2022-10-02 11:25:55'),
(35, 'henil', 'msn', '', '', '2022-10-02 11:30:19'),
(36, 'henil', 's', '', '', '2022-10-02 11:30:22'),
(37, 'henil', 's', '', '', '2022-10-02 11:30:23'),
(38, 'henil', 's', '', '', '2022-10-02 11:34:00'),
(39, 'henil', 'n', '', '', '2022-10-02 12:25:09'),
(40, 'henil', 'd', '', '', '2022-10-03 13:30:06'),
(41, 'Henil', 'S', 'test.mdb', 'test.mdb', '2022-10-03 14:54:24'),
(42, 'Henil', 'S', 'test.mdb', 'test.mdb', '2022-10-03 14:55:01'),
(43, 'Henil', 'gd', '', '', '2022-10-03 15:15:19'),
(44, 'Henil', '.', '.gitignore', '.gitignore', '2022-10-03 15:16:06'),
(45, 'Henil', '.', '.gitignore', '.gitignore', '2022-10-03 15:16:36'),
(46, 'Henil', 'g', '', '', '2022-10-03 15:17:21'),
(47, 'Henil', ' ', 'html.html', 'html.html', '2022-10-03 15:17:30');

-- --------------------------------------------------------

--
-- Table structure for table `user_detail`
--

CREATE TABLE `user_detail` (
  `ID` bigint(20) NOT NULL,
  `USER_NAME` text NOT NULL,
  `USER_EMAIL` text NOT NULL,
  `USER_PASSWORD` text NOT NULL,
  `TIME_STAMP` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_detail`
--

INSERT INTO `user_detail` (`ID`, `USER_NAME`, `USER_EMAIL`, `USER_PASSWORD`, `TIME_STAMP`) VALUES
(1, 'Henil', 'he@hs', '123', '2022-10-01 23:42:03'),
(2, 'Henil1', 'he@hs', '123', '2022-10-01 23:43:07'),
(3, 'hari', 'hari@dk', '123', '2022-10-02 02:58:31'),
(4, 'heni', 'jsh@ejh', '5', '2022-10-02 05:53:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_detail`
--
ALTER TABLE `user_detail`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `name` (`USER_NAME`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `user_detail`
--
ALTER TABLE `user_detail`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
