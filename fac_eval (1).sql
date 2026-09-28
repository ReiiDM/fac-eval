-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2026 at 12:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fac_eval`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic_years`
--

CREATE TABLE `academic_years` (
  `id` int(11) NOT NULL,
  `year_label` varchar(20) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `academic_years`
--

INSERT INTO `academic_years` (`id`, `year_label`, `is_active`, `created_at`) VALUES
(1, '2024-2025', 0, '2026-05-15 10:22:26'),
(2, '2026-2027', 0, '2026-05-15 13:11:03'),
(3, '2025-2026', 1, '2026-09-24 00:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `user_id`, `department_id`, `created_at`) VALUES
(3, 4, 1, '2026-05-15 10:45:10');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `code` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `department_id`, `name`, `code`, `description`, `is_active`, `created_at`) VALUES
(1, 1, 'Bachelor of Science in Information Technology', 'BSIT', NULL, 1, '2026-05-15 10:22:26'),
(2, 1, 'Bachelor of Science in Computer Science', 'BSCS', NULL, 1, '2026-05-15 10:22:26'),
(3, 2, 'Bachelor of Science in Business Administration', 'BSBA', NULL, 1, '2026-05-15 10:22:26'),
(4, 1, 'qweqwe', 'qweqwe', 'qweqwe', 1, '2026-05-18 09:30:15');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `code` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `code`, `description`, `is_active`, `created_at`) VALUES
(1, 'College of Information Technology', 'CIT', 'Handles IT and Computer Science programs', 1, '2026-05-15 10:22:26'),
(2, 'College of Business Administration', 'CBA', 'Handles business and management programs', 1, '2026-05-15 10:22:26');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_answers`
--

CREATE TABLE `evaluation_answers` (
  `id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `rating_value` tinyint(4) DEFAULT NULL COMMENT '1-5 for rating questions',
  `comment_text` text DEFAULT NULL COMMENT 'For open-ended questions',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluation_answers`
--

INSERT INTO `evaluation_answers` (`id`, `submission_id`, `question_id`, `rating_value`, `comment_text`, `created_at`) VALUES
(1, 1, 1, 5, NULL, '2026-05-15 11:52:05'),
(2, 1, 2, 5, NULL, '2026-05-15 11:52:05'),
(3, 1, 3, 5, NULL, '2026-05-15 11:52:05'),
(4, 1, 4, 5, NULL, '2026-05-15 11:52:05'),
(5, 1, 5, NULL, 'asdassd', '2026-05-15 11:52:05'),
(6, 1, 6, 5, NULL, '2026-05-15 11:52:05'),
(7, 1, 7, 5, NULL, '2026-05-15 11:52:05'),
(8, 1, 8, 5, NULL, '2026-05-15 11:52:05'),
(9, 1, 9, 5, NULL, '2026-05-15 11:52:05'),
(10, 1, 10, 5, NULL, '2026-05-15 11:52:05'),
(11, 1, 11, 5, NULL, '2026-05-15 11:52:05'),
(12, 1, 12, 5, NULL, '2026-05-15 11:52:05'),
(13, 1, 13, 5, NULL, '2026-05-15 11:52:05'),
(14, 1, 14, 5, NULL, '2026-05-15 11:52:05'),
(15, 1, 15, 5, NULL, '2026-05-15 11:52:05'),
(16, 1, 16, NULL, 'asdasd', '2026-05-15 11:52:05'),
(17, 2, 1, 5, NULL, '2026-05-15 12:09:48'),
(18, 2, 2, 5, NULL, '2026-05-15 12:09:48'),
(19, 2, 3, 5, NULL, '2026-05-15 12:09:48'),
(20, 2, 4, 5, NULL, '2026-05-15 12:09:48'),
(21, 2, 5, NULL, '', '2026-05-15 12:09:48'),
(22, 2, 6, 5, NULL, '2026-05-15 12:09:48'),
(23, 2, 7, 5, NULL, '2026-05-15 12:09:48'),
(24, 2, 8, 3, NULL, '2026-05-15 12:09:48'),
(25, 2, 9, 5, NULL, '2026-05-15 12:09:48'),
(26, 2, 10, 5, NULL, '2026-05-15 12:09:48'),
(27, 2, 11, 5, NULL, '2026-05-15 12:09:48'),
(28, 2, 12, 4, NULL, '2026-05-15 12:09:48'),
(29, 2, 13, 5, NULL, '2026-05-15 12:09:48'),
(30, 2, 14, 4, NULL, '2026-05-15 12:09:48'),
(31, 2, 15, 5, NULL, '2026-05-15 12:09:48'),
(32, 2, 16, NULL, 'asd', '2026-05-15 12:09:48'),
(33, 3, 62, 5, NULL, '2026-09-24 00:13:22'),
(34, 3, 63, 5, NULL, '2026-09-24 00:13:22'),
(35, 3, 64, 5, NULL, '2026-09-24 00:13:22'),
(36, 3, 65, 5, NULL, '2026-09-24 00:13:22'),
(37, 3, 66, 5, NULL, '2026-09-24 00:13:22'),
(38, 3, 67, 5, NULL, '2026-09-24 00:13:22'),
(39, 3, 68, 5, NULL, '2026-09-24 00:13:22'),
(40, 3, 69, 5, NULL, '2026-09-24 00:13:22'),
(41, 3, 70, 5, NULL, '2026-09-24 00:13:22'),
(42, 3, 71, NULL, 'Exceptional teaching method. Makes difficult programming and database topics easy to grasp.', '2026-09-24 00:13:22'),
(43, 4, 62, 4, NULL, '2026-09-24 00:13:22'),
(44, 4, 63, 4, NULL, '2026-09-24 00:13:22'),
(45, 4, 64, 4, NULL, '2026-09-24 00:13:22'),
(46, 4, 65, 4, NULL, '2026-09-24 00:13:22'),
(47, 4, 66, 4, NULL, '2026-09-24 00:13:22'),
(48, 4, 67, 4, NULL, '2026-09-24 00:13:22'),
(49, 4, 68, 4, NULL, '2026-09-24 00:13:22'),
(50, 4, 69, 4, NULL, '2026-09-24 00:13:22'),
(51, 4, 70, 4, NULL, '2026-09-24 00:13:22'),
(52, 4, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:22'),
(53, 5, 62, 4, NULL, '2026-09-24 00:13:22'),
(54, 5, 63, 4, NULL, '2026-09-24 00:13:22'),
(55, 5, 64, 4, NULL, '2026-09-24 00:13:22'),
(56, 5, 65, 4, NULL, '2026-09-24 00:13:22'),
(57, 5, 66, 4, NULL, '2026-09-24 00:13:22'),
(58, 5, 67, 4, NULL, '2026-09-24 00:13:22'),
(59, 5, 68, 4, NULL, '2026-09-24 00:13:22'),
(60, 5, 69, 4, NULL, '2026-09-24 00:13:22'),
(61, 5, 70, 4, NULL, '2026-09-24 00:13:22'),
(62, 5, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:22'),
(63, 6, 62, 4, NULL, '2026-09-24 00:13:22'),
(64, 6, 63, 4, NULL, '2026-09-24 00:13:22'),
(65, 6, 64, 4, NULL, '2026-09-24 00:13:22'),
(66, 6, 65, 4, NULL, '2026-09-24 00:13:22'),
(67, 6, 66, 4, NULL, '2026-09-24 00:13:23'),
(68, 6, 67, 4, NULL, '2026-09-24 00:13:23'),
(69, 6, 68, 4, NULL, '2026-09-24 00:13:23'),
(70, 6, 69, 4, NULL, '2026-09-24 00:13:23'),
(71, 6, 70, 4, NULL, '2026-09-24 00:13:23'),
(72, 6, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23'),
(73, 7, 62, 4, NULL, '2026-09-24 00:13:23'),
(74, 7, 63, 4, NULL, '2026-09-24 00:13:23'),
(75, 7, 64, 4, NULL, '2026-09-24 00:13:23'),
(76, 7, 65, 3, NULL, '2026-09-24 00:13:23'),
(77, 7, 66, 4, NULL, '2026-09-24 00:13:23'),
(78, 7, 67, 4, NULL, '2026-09-24 00:13:23'),
(79, 7, 68, 4, NULL, '2026-09-24 00:13:23'),
(80, 7, 69, 4, NULL, '2026-09-24 00:13:23'),
(81, 7, 70, 3, NULL, '2026-09-24 00:13:23'),
(82, 7, 71, NULL, 'Very good instructor. Lectures are clear and practical exercises are helpful.', '2026-09-24 00:13:23'),
(83, 8, 62, 5, NULL, '2026-09-24 00:13:23'),
(84, 8, 63, 5, NULL, '2026-09-24 00:13:23'),
(85, 8, 64, 5, NULL, '2026-09-24 00:13:23'),
(86, 8, 65, 5, NULL, '2026-09-24 00:13:23'),
(87, 8, 66, 5, NULL, '2026-09-24 00:13:23'),
(88, 8, 67, 5, NULL, '2026-09-24 00:13:23'),
(89, 8, 68, 5, NULL, '2026-09-24 00:13:23'),
(90, 8, 69, 5, NULL, '2026-09-24 00:13:23'),
(91, 8, 70, 5, NULL, '2026-09-24 00:13:23'),
(92, 8, 71, NULL, 'Outstanding professor! Lessons are always engaging, well-prepared, and very informative.', '2026-09-24 00:13:23'),
(93, 9, 62, 5, NULL, '2026-09-24 00:13:23'),
(94, 9, 63, 5, NULL, '2026-09-24 00:13:23'),
(95, 9, 64, 5, NULL, '2026-09-24 00:13:23'),
(96, 9, 65, 5, NULL, '2026-09-24 00:13:23'),
(97, 9, 66, 5, NULL, '2026-09-24 00:13:23'),
(98, 9, 67, 5, NULL, '2026-09-24 00:13:23'),
(99, 9, 68, 5, NULL, '2026-09-24 00:13:23'),
(100, 9, 69, 5, NULL, '2026-09-24 00:13:23'),
(101, 9, 70, 5, NULL, '2026-09-24 00:13:23'),
(102, 9, 71, NULL, 'Exceptional teaching method. Makes difficult programming and database topics easy to grasp.', '2026-09-24 00:13:23'),
(103, 10, 62, 5, NULL, '2026-09-24 00:13:23'),
(104, 10, 63, 5, NULL, '2026-09-24 00:13:23'),
(105, 10, 64, 5, NULL, '2026-09-24 00:13:23'),
(106, 10, 65, 5, NULL, '2026-09-24 00:13:23'),
(107, 10, 66, 5, NULL, '2026-09-24 00:13:23'),
(108, 10, 67, 5, NULL, '2026-09-24 00:13:23'),
(109, 10, 68, 5, NULL, '2026-09-24 00:13:23'),
(110, 10, 69, 5, NULL, '2026-09-24 00:13:23'),
(111, 10, 70, 5, NULL, '2026-09-24 00:13:23'),
(112, 10, 71, NULL, 'Very supportive and approachable instructor. Always ready to guide students.', '2026-09-24 00:13:23'),
(113, 11, 62, 5, NULL, '2026-09-24 00:13:23'),
(114, 11, 63, 5, NULL, '2026-09-24 00:13:23'),
(115, 11, 64, 5, NULL, '2026-09-24 00:13:23'),
(116, 11, 65, 5, NULL, '2026-09-24 00:13:23'),
(117, 11, 66, 5, NULL, '2026-09-24 00:13:23'),
(118, 11, 67, 5, NULL, '2026-09-24 00:13:23'),
(119, 11, 68, 5, NULL, '2026-09-24 00:13:23'),
(120, 11, 69, 5, NULL, '2026-09-24 00:13:23'),
(121, 11, 70, 5, NULL, '2026-09-24 00:13:23'),
(122, 11, 71, NULL, 'Very supportive and approachable instructor. Always ready to guide students.', '2026-09-24 00:13:23'),
(123, 12, 62, 4, NULL, '2026-09-24 00:13:23'),
(124, 12, 63, 4, NULL, '2026-09-24 00:13:23'),
(125, 12, 64, 4, NULL, '2026-09-24 00:13:23'),
(126, 12, 65, 4, NULL, '2026-09-24 00:13:23'),
(127, 12, 66, 4, NULL, '2026-09-24 00:13:23'),
(128, 12, 67, 4, NULL, '2026-09-24 00:13:23'),
(129, 12, 68, 4, NULL, '2026-09-24 00:13:23'),
(130, 12, 69, 4, NULL, '2026-09-24 00:13:23'),
(131, 12, 70, 4, NULL, '2026-09-24 00:13:23'),
(132, 12, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23'),
(133, 13, 62, 3, NULL, '2026-09-24 00:13:23'),
(134, 13, 63, 3, NULL, '2026-09-24 00:13:23'),
(135, 13, 64, 3, NULL, '2026-09-24 00:13:23'),
(136, 13, 65, 3, NULL, '2026-09-24 00:13:23'),
(137, 13, 66, 3, NULL, '2026-09-24 00:13:23'),
(138, 13, 67, 3, NULL, '2026-09-24 00:13:23'),
(139, 13, 68, 3, NULL, '2026-09-24 00:13:23'),
(140, 13, 69, 3, NULL, '2026-09-24 00:13:23'),
(141, 13, 70, 3, NULL, '2026-09-24 00:13:23'),
(142, 13, 71, NULL, 'Good discussions overall, would be great to have more hands-on lab time.', '2026-09-24 00:13:23'),
(143, 14, 62, 5, NULL, '2026-09-24 00:13:23'),
(144, 14, 63, 5, NULL, '2026-09-24 00:13:23'),
(145, 14, 64, 5, NULL, '2026-09-24 00:13:23'),
(146, 14, 65, 5, NULL, '2026-09-24 00:13:23'),
(147, 14, 66, 5, NULL, '2026-09-24 00:13:23'),
(148, 14, 67, 5, NULL, '2026-09-24 00:13:23'),
(149, 14, 68, 5, NULL, '2026-09-24 00:13:23'),
(150, 14, 69, 4, NULL, '2026-09-24 00:13:23'),
(151, 14, 70, 4, NULL, '2026-09-24 00:13:23'),
(152, 14, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23'),
(153, 15, 62, 4, NULL, '2026-09-24 00:13:23'),
(154, 15, 63, 4, NULL, '2026-09-24 00:13:23'),
(155, 15, 64, 4, NULL, '2026-09-24 00:13:23'),
(156, 15, 65, 4, NULL, '2026-09-24 00:13:23'),
(157, 15, 66, 4, NULL, '2026-09-24 00:13:23'),
(158, 15, 67, 4, NULL, '2026-09-24 00:13:23'),
(159, 15, 68, 4, NULL, '2026-09-24 00:13:23'),
(160, 15, 69, 4, NULL, '2026-09-24 00:13:23'),
(161, 15, 70, 4, NULL, '2026-09-24 00:13:23'),
(162, 15, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23'),
(163, 16, 62, 4, NULL, '2026-09-24 00:13:23'),
(164, 16, 63, 4, NULL, '2026-09-24 00:13:23'),
(165, 16, 64, 4, NULL, '2026-09-24 00:13:23'),
(166, 16, 65, 4, NULL, '2026-09-24 00:13:23'),
(167, 16, 66, 4, NULL, '2026-09-24 00:13:23'),
(168, 16, 67, 4, NULL, '2026-09-24 00:13:23'),
(169, 16, 68, 4, NULL, '2026-09-24 00:13:23'),
(170, 16, 69, 4, NULL, '2026-09-24 00:13:23'),
(171, 16, 70, 4, NULL, '2026-09-24 00:13:23'),
(172, 16, 71, NULL, 'Very good instructor. Lectures are clear and practical exercises are helpful.', '2026-09-24 00:13:23'),
(173, 17, 62, 4, NULL, '2026-09-24 00:13:23'),
(174, 17, 63, 4, NULL, '2026-09-24 00:13:23'),
(175, 17, 64, 4, NULL, '2026-09-24 00:13:23'),
(176, 17, 65, 4, NULL, '2026-09-24 00:13:23'),
(177, 17, 66, 4, NULL, '2026-09-24 00:13:23'),
(178, 17, 67, 4, NULL, '2026-09-24 00:13:23'),
(179, 17, 68, 4, NULL, '2026-09-24 00:13:23'),
(180, 17, 69, 4, NULL, '2026-09-24 00:13:23'),
(181, 17, 70, 4, NULL, '2026-09-24 00:13:23'),
(182, 17, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23'),
(183, 18, 62, 4, NULL, '2026-09-24 00:13:23'),
(184, 18, 63, 4, NULL, '2026-09-24 00:13:23'),
(185, 18, 64, 3, NULL, '2026-09-24 00:13:23'),
(186, 18, 65, 3, NULL, '2026-09-24 00:13:23'),
(187, 18, 66, 4, NULL, '2026-09-24 00:13:23'),
(188, 18, 67, 3, NULL, '2026-09-24 00:13:23'),
(189, 18, 68, 3, NULL, '2026-09-24 00:13:23'),
(190, 18, 69, 3, NULL, '2026-09-24 00:13:23'),
(191, 18, 70, 3, NULL, '2026-09-24 00:13:23'),
(192, 18, 71, NULL, 'Interactive classes and great mastery of the subject matter.', '2026-09-24 00:13:23'),
(193, 19, 62, 5, NULL, '2026-09-24 00:13:23'),
(194, 19, 63, 5, NULL, '2026-09-24 00:13:23'),
(195, 19, 64, 5, NULL, '2026-09-24 00:13:23'),
(196, 19, 65, 5, NULL, '2026-09-24 00:13:23'),
(197, 19, 66, 5, NULL, '2026-09-24 00:13:23'),
(198, 19, 67, 5, NULL, '2026-09-24 00:13:23'),
(199, 19, 68, 5, NULL, '2026-09-24 00:13:23'),
(200, 19, 69, 5, NULL, '2026-09-24 00:13:23'),
(201, 19, 70, 5, NULL, '2026-09-24 00:13:23'),
(202, 19, 71, NULL, 'Outstanding professor! Lessons are always engaging, well-prepared, and very informative.', '2026-09-24 00:13:23'),
(203, 20, 62, 5, NULL, '2026-09-24 00:13:23'),
(204, 20, 63, 5, NULL, '2026-09-24 00:13:23'),
(205, 20, 64, 5, NULL, '2026-09-24 00:13:23'),
(206, 20, 65, 5, NULL, '2026-09-24 00:13:23'),
(207, 20, 66, 5, NULL, '2026-09-24 00:13:23'),
(208, 20, 67, 5, NULL, '2026-09-24 00:13:23'),
(209, 20, 68, 5, NULL, '2026-09-24 00:13:23'),
(210, 20, 69, 5, NULL, '2026-09-24 00:13:23'),
(211, 20, 70, 5, NULL, '2026-09-24 00:13:23'),
(212, 20, 71, NULL, 'Outstanding professor! Lessons are always engaging, well-prepared, and very informative.', '2026-09-24 00:13:23'),
(213, 21, 62, 5, NULL, '2026-09-24 00:13:23'),
(214, 21, 63, 5, NULL, '2026-09-24 00:13:23'),
(215, 21, 64, 5, NULL, '2026-09-24 00:13:23'),
(216, 21, 65, 5, NULL, '2026-09-24 00:13:23'),
(217, 21, 66, 5, NULL, '2026-09-24 00:13:23'),
(218, 21, 67, 5, NULL, '2026-09-24 00:13:23'),
(219, 21, 68, 5, NULL, '2026-09-24 00:13:23'),
(220, 21, 69, 5, NULL, '2026-09-24 00:13:23'),
(221, 21, 70, 5, NULL, '2026-09-24 00:13:23'),
(222, 21, 71, NULL, 'Outstanding professor! Lessons are always engaging, well-prepared, and very informative.', '2026-09-24 00:13:23'),
(223, 22, 62, 4, NULL, '2026-09-24 00:13:23'),
(224, 22, 63, 4, NULL, '2026-09-24 00:13:23'),
(225, 22, 64, 4, NULL, '2026-09-24 00:13:23'),
(226, 22, 65, 4, NULL, '2026-09-24 00:13:23'),
(227, 22, 66, 4, NULL, '2026-09-24 00:13:23'),
(228, 22, 67, 4, NULL, '2026-09-24 00:13:23'),
(229, 22, 68, 4, NULL, '2026-09-24 00:13:23'),
(230, 22, 69, 4, NULL, '2026-09-24 00:13:23'),
(231, 22, 70, 4, NULL, '2026-09-24 00:13:23'),
(232, 22, 71, NULL, 'Very good instructor. Lectures are clear and practical exercises are helpful.', '2026-09-24 00:13:23'),
(233, 23, 62, 3, NULL, '2026-09-24 00:13:23'),
(234, 23, 63, 3, NULL, '2026-09-24 00:13:23'),
(235, 23, 64, 3, NULL, '2026-09-24 00:13:23'),
(236, 23, 65, 3, NULL, '2026-09-24 00:13:23'),
(237, 23, 66, 3, NULL, '2026-09-24 00:13:23'),
(238, 23, 67, 3, NULL, '2026-09-24 00:13:23'),
(239, 23, 68, 3, NULL, '2026-09-24 00:13:23'),
(240, 23, 69, 3, NULL, '2026-09-24 00:13:23'),
(241, 23, 70, 3, NULL, '2026-09-24 00:13:23'),
(242, 23, 71, NULL, 'Good discussions overall, would be great to have more hands-on lab time.', '2026-09-24 00:13:23'),
(243, 24, 62, 5, NULL, '2026-09-24 00:13:23'),
(244, 24, 63, 5, NULL, '2026-09-24 00:13:23'),
(245, 24, 64, 5, NULL, '2026-09-24 00:13:23'),
(246, 24, 65, 5, NULL, '2026-09-24 00:13:23'),
(247, 24, 66, 5, NULL, '2026-09-24 00:13:23'),
(248, 24, 67, 5, NULL, '2026-09-24 00:13:23'),
(249, 24, 68, 5, NULL, '2026-09-24 00:13:23'),
(250, 24, 69, 5, NULL, '2026-09-24 00:13:23'),
(251, 24, 70, 5, NULL, '2026-09-24 00:13:23'),
(252, 24, 71, NULL, 'Exceptional teaching method. Makes difficult programming and database topics easy to grasp.', '2026-09-24 00:13:23'),
(253, 25, 62, 4, NULL, '2026-09-24 00:13:23'),
(254, 25, 63, 4, NULL, '2026-09-24 00:13:23'),
(255, 25, 64, 4, NULL, '2026-09-24 00:13:23'),
(256, 25, 65, 4, NULL, '2026-09-24 00:13:23'),
(257, 25, 66, 4, NULL, '2026-09-24 00:13:23'),
(258, 25, 67, 4, NULL, '2026-09-24 00:13:23'),
(259, 25, 68, 4, NULL, '2026-09-24 00:13:23'),
(260, 25, 69, 4, NULL, '2026-09-24 00:13:23'),
(261, 25, 70, 4, NULL, '2026-09-24 00:13:23'),
(262, 25, 71, NULL, 'Interactive classes and great mastery of the subject matter.', '2026-09-24 00:13:23'),
(263, 26, 62, 4, NULL, '2026-09-24 00:13:23'),
(264, 26, 63, 4, NULL, '2026-09-24 00:13:23'),
(265, 26, 64, 4, NULL, '2026-09-24 00:13:23'),
(266, 26, 65, 4, NULL, '2026-09-24 00:13:23'),
(267, 26, 66, 4, NULL, '2026-09-24 00:13:23'),
(268, 26, 67, 4, NULL, '2026-09-24 00:13:23'),
(269, 26, 68, 4, NULL, '2026-09-24 00:13:23'),
(270, 26, 69, 4, NULL, '2026-09-24 00:13:23'),
(271, 26, 70, 4, NULL, '2026-09-24 00:13:23'),
(272, 26, 71, NULL, 'Interactive classes and great mastery of the subject matter.', '2026-09-24 00:13:23'),
(273, 27, 62, 4, NULL, '2026-09-24 00:13:23'),
(274, 27, 63, 4, NULL, '2026-09-24 00:13:23'),
(275, 27, 64, 4, NULL, '2026-09-24 00:13:23'),
(276, 27, 65, 4, NULL, '2026-09-24 00:13:23'),
(277, 27, 66, 4, NULL, '2026-09-24 00:13:23'),
(278, 27, 67, 4, NULL, '2026-09-24 00:13:23'),
(279, 27, 68, 4, NULL, '2026-09-24 00:13:23'),
(280, 27, 69, 4, NULL, '2026-09-24 00:13:23'),
(281, 27, 70, 4, NULL, '2026-09-24 00:13:23'),
(282, 27, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23'),
(283, 28, 62, 3, NULL, '2026-09-24 00:13:23'),
(284, 28, 63, 3, NULL, '2026-09-24 00:13:23'),
(285, 28, 64, 4, NULL, '2026-09-24 00:13:23'),
(286, 28, 65, 4, NULL, '2026-09-24 00:13:23'),
(287, 28, 66, 4, NULL, '2026-09-24 00:13:23'),
(288, 28, 67, 3, NULL, '2026-09-24 00:13:23'),
(289, 28, 68, 4, NULL, '2026-09-24 00:13:23'),
(290, 28, 69, 4, NULL, '2026-09-24 00:13:23'),
(291, 28, 70, 3, NULL, '2026-09-24 00:13:23'),
(292, 28, 71, NULL, 'Very good instructor. Lectures are clear and practical exercises are helpful.', '2026-09-24 00:13:23'),
(293, 29, 62, 5, NULL, '2026-09-24 00:13:23'),
(294, 29, 63, 5, NULL, '2026-09-24 00:13:23'),
(295, 29, 64, 5, NULL, '2026-09-24 00:13:23'),
(296, 29, 65, 4, NULL, '2026-09-24 00:13:23'),
(297, 29, 66, 5, NULL, '2026-09-24 00:13:23'),
(298, 29, 67, 5, NULL, '2026-09-24 00:13:23'),
(299, 29, 68, 5, NULL, '2026-09-24 00:13:23'),
(300, 29, 69, 5, NULL, '2026-09-24 00:13:23'),
(301, 29, 70, 5, NULL, '2026-09-24 00:13:23'),
(302, 29, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23'),
(303, 30, 62, 5, NULL, '2026-09-24 00:13:23'),
(304, 30, 63, 5, NULL, '2026-09-24 00:13:23'),
(305, 30, 64, 5, NULL, '2026-09-24 00:13:23'),
(306, 30, 65, 5, NULL, '2026-09-24 00:13:23'),
(307, 30, 66, 5, NULL, '2026-09-24 00:13:23'),
(308, 30, 67, 5, NULL, '2026-09-24 00:13:23'),
(309, 30, 68, 5, NULL, '2026-09-24 00:13:23'),
(310, 30, 69, 5, NULL, '2026-09-24 00:13:23'),
(311, 30, 70, 5, NULL, '2026-09-24 00:13:23'),
(312, 30, 71, NULL, 'Very supportive and approachable instructor. Always ready to guide students.', '2026-09-24 00:13:23'),
(313, 31, 62, 5, NULL, '2026-09-24 00:13:23'),
(314, 31, 63, 5, NULL, '2026-09-24 00:13:23'),
(315, 31, 64, 5, NULL, '2026-09-24 00:13:23'),
(316, 31, 65, 5, NULL, '2026-09-24 00:13:23'),
(317, 31, 66, 5, NULL, '2026-09-24 00:13:23'),
(318, 31, 67, 5, NULL, '2026-09-24 00:13:23'),
(319, 31, 68, 5, NULL, '2026-09-24 00:13:23'),
(320, 31, 69, 5, NULL, '2026-09-24 00:13:23'),
(321, 31, 70, 5, NULL, '2026-09-24 00:13:23'),
(322, 31, 71, NULL, 'Exceptional teaching method. Makes difficult programming and database topics easy to grasp.', '2026-09-24 00:13:23'),
(323, 32, 62, 4, NULL, '2026-09-24 00:13:23'),
(324, 32, 63, 4, NULL, '2026-09-24 00:13:23'),
(325, 32, 64, 4, NULL, '2026-09-24 00:13:23'),
(326, 32, 65, 4, NULL, '2026-09-24 00:13:23'),
(327, 32, 66, 4, NULL, '2026-09-24 00:13:23'),
(328, 32, 67, 4, NULL, '2026-09-24 00:13:23'),
(329, 32, 68, 4, NULL, '2026-09-24 00:13:23'),
(330, 32, 69, 4, NULL, '2026-09-24 00:13:23'),
(331, 32, 70, 4, NULL, '2026-09-24 00:13:23'),
(332, 32, 71, NULL, 'Interactive classes and great mastery of the subject matter.', '2026-09-24 00:13:23'),
(333, 33, 62, 3, NULL, '2026-09-24 00:13:23'),
(334, 33, 63, 3, NULL, '2026-09-24 00:13:23'),
(335, 33, 64, 3, NULL, '2026-09-24 00:13:23'),
(336, 33, 65, 3, NULL, '2026-09-24 00:13:23'),
(337, 33, 66, 3, NULL, '2026-09-24 00:13:23'),
(338, 33, 67, 3, NULL, '2026-09-24 00:13:23'),
(339, 33, 68, 3, NULL, '2026-09-24 00:13:23'),
(340, 33, 69, 3, NULL, '2026-09-24 00:13:23'),
(341, 33, 70, 3, NULL, '2026-09-24 00:13:23'),
(342, 33, 71, NULL, 'Adequate teaching performance. Covers the necessary syllabus material.', '2026-09-24 00:13:23'),
(343, 34, 62, 5, NULL, '2026-09-24 00:13:23'),
(344, 34, 63, 5, NULL, '2026-09-24 00:13:23'),
(345, 34, 64, 5, NULL, '2026-09-24 00:13:23'),
(346, 34, 65, 5, NULL, '2026-09-24 00:13:23'),
(347, 34, 66, 5, NULL, '2026-09-24 00:13:23'),
(348, 34, 67, 5, NULL, '2026-09-24 00:13:23'),
(349, 34, 68, 5, NULL, '2026-09-24 00:13:23'),
(350, 34, 69, 5, NULL, '2026-09-24 00:13:23'),
(351, 34, 70, 5, NULL, '2026-09-24 00:13:23'),
(352, 34, 71, NULL, 'Outstanding professor! Lessons are always engaging, well-prepared, and very informative.', '2026-09-24 00:13:23'),
(353, 35, 62, 4, NULL, '2026-09-24 00:13:23'),
(354, 35, 63, 4, NULL, '2026-09-24 00:13:23'),
(355, 35, 64, 4, NULL, '2026-09-24 00:13:23'),
(356, 35, 65, 4, NULL, '2026-09-24 00:13:23'),
(357, 35, 66, 4, NULL, '2026-09-24 00:13:23'),
(358, 35, 67, 4, NULL, '2026-09-24 00:13:23'),
(359, 35, 68, 4, NULL, '2026-09-24 00:13:23'),
(360, 35, 69, 4, NULL, '2026-09-24 00:13:23'),
(361, 35, 70, 4, NULL, '2026-09-24 00:13:23'),
(362, 35, 71, NULL, 'Interactive classes and great mastery of the subject matter.', '2026-09-24 00:13:23'),
(363, 36, 62, 4, NULL, '2026-09-24 00:13:23'),
(364, 36, 63, 4, NULL, '2026-09-24 00:13:23'),
(365, 36, 64, 4, NULL, '2026-09-24 00:13:23'),
(366, 36, 65, 4, NULL, '2026-09-24 00:13:23'),
(367, 36, 66, 4, NULL, '2026-09-24 00:13:23'),
(368, 36, 67, 4, NULL, '2026-09-24 00:13:23'),
(369, 36, 68, 4, NULL, '2026-09-24 00:13:23'),
(370, 36, 69, 4, NULL, '2026-09-24 00:13:23'),
(371, 36, 70, 4, NULL, '2026-09-24 00:13:23'),
(372, 36, 71, NULL, 'Very good instructor. Lectures are clear and practical exercises are helpful.', '2026-09-24 00:13:23'),
(373, 37, 62, 4, NULL, '2026-09-24 00:13:23'),
(374, 37, 63, 4, NULL, '2026-09-24 00:13:23'),
(375, 37, 64, 4, NULL, '2026-09-24 00:13:23'),
(376, 37, 65, 4, NULL, '2026-09-24 00:13:23'),
(377, 37, 66, 4, NULL, '2026-09-24 00:13:23'),
(378, 37, 67, 4, NULL, '2026-09-24 00:13:23'),
(379, 37, 68, 4, NULL, '2026-09-24 00:13:23'),
(380, 37, 69, 4, NULL, '2026-09-24 00:13:23'),
(381, 37, 70, 4, NULL, '2026-09-24 00:13:23'),
(382, 37, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23'),
(383, 38, 62, 4, NULL, '2026-09-24 00:13:23'),
(384, 38, 63, 3, NULL, '2026-09-24 00:13:23'),
(385, 38, 64, 4, NULL, '2026-09-24 00:13:23'),
(386, 38, 65, 3, NULL, '2026-09-24 00:13:23'),
(387, 38, 66, 4, NULL, '2026-09-24 00:13:23'),
(388, 38, 67, 3, NULL, '2026-09-24 00:13:23'),
(389, 38, 68, 3, NULL, '2026-09-24 00:13:23'),
(390, 38, 69, 3, NULL, '2026-09-24 00:13:23'),
(391, 38, 70, 4, NULL, '2026-09-24 00:13:23'),
(392, 38, 71, NULL, 'Punctual and organized. Provides clear syllabus expectations and consistent feedback.', '2026-09-24 00:13:23');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_categories`
--

CREATE TABLE `evaluation_categories` (
  `id` int(11) NOT NULL,
  `evaluation_form_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `weight` decimal(5,2) NOT NULL COMMENT 'Percentage weight, all categories must sum to 100',
  `order_no` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluation_categories`
--

INSERT INTO `evaluation_categories` (`id`, `evaluation_form_id`, `name`, `weight`, `order_no`, `created_at`) VALUES
(1, 1, 'Teaching Effectiveness', 40.00, 1, '2026-05-15 11:50:40'),
(2, 1, 'Subject Mastery', 25.00, 2, '2026-05-15 11:50:40'),
(3, 1, 'Communication Skills', 15.00, 3, '2026-05-15 11:50:40'),
(4, 1, 'Punctuality & Attendance', 10.00, 4, '2026-05-15 11:50:40'),
(5, 1, 'Fairness & Student Engagement', 10.00, 5, '2026-05-15 11:50:40'),
(6, 2, 'Instructional Delivery & Technical Competence', 50.00, 1, '2026-05-15 13:16:29'),
(7, 2, 'Assessment & Student Progress Monitoring', 30.00, 2, '2026-05-15 13:16:29'),
(8, 2, 'Professionalism & Interpersonal Skills', 20.00, 3, '2026-05-15 13:16:29'),
(9, 3, 'Teaching Effectiveness & Methodology', 40.00, 1, '2026-09-24 00:12:26'),
(10, 3, 'Classroom Management & Punctuality', 25.00, 2, '2026-09-24 00:12:26'),
(11, 3, 'Instructional Materials & Technology', 20.00, 3, '2026-09-24 00:12:26'),
(12, 3, 'Student Engagement & Guidance', 15.00, 4, '2026-09-24 00:12:26');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_forms`
--

CREATE TABLE `evaluation_forms` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `academic_year_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluation_forms`
--

INSERT INTO `evaluation_forms` (`id`, `department_id`, `name`, `description`, `academic_year_id`, `semester_id`, `is_active`, `created_by`, `created_at`) VALUES
(1, 1, 'Faculty Evaluation Form - 1st Sem 2024-2025', 'Standard faculty evaluation form for CIT department', 1, 1, 0, 4, '2026-05-15 11:50:40'),
(2, 1, 'Faculty Evaluation Rubric - Granby Colleges', 'Comprehensive 45-item faculty evaluation rubric covering Instructional Delivery, Assessment & Monitoring, and Professionalism.', 2, 1, 1, 4, '2026-05-15 13:16:29'),
(3, 1, 'Faculty Performance Evaluation Instrument', 'Standard Granby evaluation rubric', 3, 2, 1, 4, '2026-09-24 00:12:26');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_periods`
--

CREATE TABLE `evaluation_periods` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `evaluation_form_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `status` enum('upcoming','open','closed') NOT NULL DEFAULT 'upcoming',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluation_periods`
--

INSERT INTO `evaluation_periods` (`id`, `department_id`, `semester_id`, `evaluation_form_id`, `title`, `start_date`, `end_date`, `status`, `created_by`, `created_at`) VALUES
(1, 1, 1, 1, 'Midterm Faculty Evaluation - 1st Sem 2024-2025', '2026-05-15 19:50:40', '2026-06-14 19:50:40', 'closed', 4, '2026-05-15 11:50:40'),
(2, 1, 2, 3, '1st Semester AY 2025-2026 Faculty Evaluation', '2026-09-19 09:43:05', '2026-10-19 09:43:05', 'open', 4, '2026-09-24 00:12:26');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_questions`
--

CREATE TABLE `evaluation_questions` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('rating','open_ended') NOT NULL DEFAULT 'rating',
  `order_no` tinyint(4) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluation_questions`
--

INSERT INTO `evaluation_questions` (`id`, `category_id`, `question_text`, `question_type`, `order_no`, `is_active`) VALUES
(1, 1, 'The faculty explains lessons clearly and in an organized manner.', 'rating', 1, 1),
(2, 1, 'The faculty uses effective teaching methods and strategies.', 'rating', 2, 1),
(3, 1, 'The faculty provides relevant examples and real-world applications.', 'rating', 3, 1),
(4, 1, 'The faculty encourages critical thinking and class participation.', 'rating', 4, 1),
(5, 1, 'Comments on teaching effectiveness:', 'open_ended', 5, 1),
(6, 2, 'The faculty demonstrates thorough knowledge of the subject matter.', 'rating', 1, 1),
(7, 2, 'The faculty answers questions accurately and confidently.', 'rating', 2, 1),
(8, 2, 'The faculty provides up-to-date information relevant to the field.', 'rating', 3, 1),
(9, 3, 'The faculty communicates clearly and is easy to understand.', 'rating', 1, 1),
(10, 3, 'The faculty is approachable and open to student concerns.', 'rating', 2, 1),
(11, 3, 'The faculty provides constructive feedback on student work.', 'rating', 3, 1),
(12, 4, 'The faculty arrives on time and conducts full class hours.', 'rating', 1, 1),
(13, 4, 'The faculty rarely misses class and informs students of absences in advance.', 'rating', 2, 1),
(14, 5, 'The faculty is fair and unbiased in grading and treatment of students.', 'rating', 1, 1),
(15, 5, 'The faculty encourages student participation and respects diverse opinions.', 'rating', 2, 1),
(16, 5, 'Overall comments or suggestions for this faculty:', 'open_ended', 3, 1),
(17, 6, 'Demonstrates mastery of the subject matter.', 'rating', 1, 1),
(18, 6, 'Explains complex concepts in a clear and understandable manner.', 'rating', 2, 1),
(19, 6, 'Organizes classroom activities effectively to maximize learning time.', 'rating', 3, 1),
(20, 6, 'Uses a variety of teaching strategies to engage different learning styles.', 'rating', 4, 1),
(21, 6, 'Integrates latest industry trends and technologies into the discussion.', 'rating', 5, 1),
(22, 6, 'Provides clear objectives at the start of every lesson.', 'rating', 6, 1),
(23, 6, 'Encourages critical thinking through questioning and problem-solving.', 'rating', 7, 1),
(24, 6, 'Uses instructional media (PPT, videos, software) effectively.', 'rating', 8, 1),
(25, 6, 'Responds to student questions with depth and clarity.', 'rating', 9, 1),
(26, 6, 'Relates lesson content to real-world applications.', 'rating', 10, 1),
(27, 6, 'Maintains a classroom atmosphere conducive to learning.', 'rating', 11, 1),
(28, 6, 'Demonstrates enthusiasm and passion for the subject.', 'rating', 12, 1),
(29, 6, 'Effectively manages student behavior and participation.', 'rating', 13, 1),
(30, 6, 'Adjusts the pace of the lesson according to student understanding.', 'rating', 14, 1),
(31, 6, 'Summarizes key points effectively at the end of the session.', 'rating', 15, 1),
(32, 7, 'Aligns quizzes and exams with the stated learning objectives.', 'rating', 1, 1),
(33, 7, 'Provides timely feedback on assignments and projects.', 'rating', 2, 1),
(34, 7, 'Uses fair and transparent grading criteria (rubrics).', 'rating', 3, 1),
(35, 7, 'Returns corrected papers and assessments promptly.', 'rating', 4, 1),
(36, 7, 'Offers constructive criticism to help students improve.', 'rating', 5, 1),
(37, 7, 'Conducts regular formative assessments (short quizzes/recitations).', 'rating', 6, 1),
(38, 7, 'Monitors individual student progress throughout the semester.', 'rating', 7, 1),
(39, 7, 'Provides remedial help or guidance to struggling students.', 'rating', 8, 1),
(40, 7, 'Encourages students to track their own academic growth.', 'rating', 9, 1),
(41, 7, 'Challenges students with high-level assignments and projects.', 'rating', 10, 1),
(42, 7, 'Varies assessment methods (written, oral, practical).', 'rating', 11, 1),
(43, 7, 'Clearly explains how final grades are calculated.', 'rating', 12, 1),
(44, 7, 'Ensures assessment tasks are free from bias.', 'rating', 13, 1),
(45, 7, 'Uses data from assessments to revisit difficult topics.', 'rating', 14, 1),
(46, 7, 'Recognizes and rewards student improvement and excellence.', 'rating', 15, 1),
(47, 8, 'Arrives at and dismisses classes punctually.', 'rating', 1, 1),
(48, 8, 'Shows respect and courtesy toward all students.', 'rating', 2, 1),
(49, 8, 'Is available for consultation during scheduled hours.', 'rating', 3, 1),
(50, 8, 'Maintains professional appearance and demeanor.', 'rating', 4, 1),
(51, 8, 'Upholds the core values of Granby Colleges of Science and Technology.', 'rating', 5, 1),
(52, 8, 'Communicates effectively through official school channels.', 'rating', 6, 1),
(53, 8, 'Shows consistency in following school policies and regulations.', 'rating', 7, 1),
(54, 8, 'Handles confidential student information with integrity.', 'rating', 8, 1),
(55, 8, 'Demonstrates approachability and openness to student concerns.', 'rating', 9, 1),
(56, 8, 'Promotes a culture of inclusivity and diversity in the classroom.', 'rating', 10, 1),
(57, 8, 'Acts as a positive role model for students.', 'rating', 11, 1),
(58, 8, 'Resolves classroom conflicts in a fair and professional manner.', 'rating', 12, 1),
(59, 8, 'Shows preparation and readiness for every class session.', 'rating', 13, 1),
(60, 8, 'Encourages student feedback to improve teaching methods.', 'rating', 14, 1),
(61, 8, 'Collaborates effectively within the academic community.', 'rating', 15, 1),
(62, 9, 'Demonstrates deep mastery and comprehensive knowledge of the course subject matter.', 'rating', 1, 1),
(63, 9, 'Explains difficult concepts clearly with practical, real-world examples.', 'rating', 2, 1),
(64, 9, 'Organizes class sessions logically and maintains student interest.', 'rating', 3, 1),
(65, 10, 'Starts and ends classes on time and uses instructional time productively.', 'rating', 1, 1),
(66, 10, 'Maintains a respectful, professional, and conducive classroom atmosphere.', 'rating', 2, 1),
(67, 11, 'Provides well-organized learning modules, references, and digital materials.', 'rating', 1, 1),
(68, 11, 'Uses relevant educational technology tools to enhance learning.', 'rating', 2, 1),
(69, 12, 'Encourages student participation, questions, and critical thinking.', 'rating', 1, 1),
(70, 12, 'Provides constructive, timely feedback on quizzes, projects, and assignments.', 'rating', 2, 1),
(71, 9, 'Constructive comments and suggestions for the faculty member', 'open_ended', 99, 1);

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_submissions`
--

CREATE TABLE `evaluation_submissions` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `evaluation_period_id` int(11) NOT NULL,
  `overall_score` decimal(4,2) NOT NULL DEFAULT 0.00,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evaluation_submissions`
--

INSERT INTO `evaluation_submissions` (`id`, `student_id`, `faculty_id`, `subject_id`, `section_id`, `evaluation_period_id`, `overall_score`, `submitted_at`) VALUES
(1, 1, 1, 1, 1, 1, 5.00, '2026-05-15 11:52:05'),
(2, 1, 1, 2, 1, 1, 4.73, '2026-05-15 12:09:48'),
(3, 5, 1, 60, 3, 2, 5.00, '2026-09-23 20:13:22'),
(4, 5, 2, 59, 3, 2, 4.00, '2026-09-23 20:13:22'),
(5, 5, 2, 61, 3, 2, 4.00, '2026-09-23 20:13:22'),
(6, 5, 3, 62, 3, 2, 4.00, '2026-09-23 20:13:22'),
(7, 5, 4, 8, 3, 2, 3.78, '2026-09-23 20:13:23'),
(8, 5, 5, 63, 4, 2, 5.00, '2026-09-23 20:13:23'),
(9, 6, 1, 60, 3, 2, 5.00, '2026-09-23 16:13:23'),
(10, 6, 2, 59, 3, 2, 5.00, '2026-09-23 16:13:23'),
(11, 6, 2, 61, 3, 2, 5.00, '2026-09-23 16:13:23'),
(12, 6, 3, 62, 3, 2, 4.00, '2026-09-23 16:13:23'),
(13, 6, 4, 8, 3, 2, 3.00, '2026-09-23 16:13:23'),
(14, 7, 1, 60, 3, 2, 4.78, '2026-09-23 12:13:23'),
(15, 7, 2, 59, 3, 2, 4.00, '2026-09-23 12:13:23'),
(16, 7, 2, 61, 3, 2, 4.00, '2026-09-23 12:13:23'),
(17, 7, 3, 62, 3, 2, 4.00, '2026-09-23 12:13:23'),
(18, 7, 4, 8, 3, 2, 3.33, '2026-09-23 12:13:23'),
(19, 8, 1, 60, 3, 2, 5.00, '2026-09-23 08:13:23'),
(20, 8, 2, 59, 3, 2, 5.00, '2026-09-23 08:13:23'),
(21, 8, 2, 61, 3, 2, 5.00, '2026-09-23 08:13:23'),
(22, 8, 3, 62, 3, 2, 4.00, '2026-09-23 08:13:23'),
(23, 8, 4, 8, 3, 2, 3.00, '2026-09-23 08:13:23'),
(24, 9, 1, 60, 3, 2, 5.00, '2026-09-23 04:13:23'),
(25, 9, 2, 59, 3, 2, 4.00, '2026-09-23 04:13:23'),
(26, 9, 2, 61, 3, 2, 4.00, '2026-09-23 04:13:23'),
(27, 9, 3, 62, 3, 2, 4.00, '2026-09-23 04:13:23'),
(28, 9, 4, 8, 3, 2, 3.56, '2026-09-23 04:13:23'),
(29, 10, 1, 60, 3, 2, 4.89, '2026-09-23 00:13:23'),
(30, 10, 2, 59, 3, 2, 5.00, '2026-09-23 00:13:23'),
(31, 10, 2, 61, 3, 2, 5.00, '2026-09-23 00:13:23'),
(32, 10, 3, 62, 3, 2, 4.00, '2026-09-23 00:13:23'),
(33, 10, 4, 8, 3, 2, 3.00, '2026-09-23 00:13:23'),
(34, 11, 1, 60, 3, 2, 5.00, '2026-09-22 20:13:23'),
(35, 11, 2, 59, 3, 2, 4.00, '2026-09-22 20:13:23'),
(36, 11, 2, 61, 3, 2, 4.00, '2026-09-22 20:13:23'),
(37, 11, 3, 62, 3, 2, 4.00, '2026-09-22 20:13:23'),
(38, 11, 4, 8, 3, 2, 3.44, '2026-09-22 20:13:23');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `employee_no` varchar(50) NOT NULL,
  `specialization` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `user_id`, `department_id`, `employee_no`, `specialization`, `created_at`) VALUES
(1, 5, 1, 'FAC-CIT-001', 'Web & Database Systems', '2026-05-15 11:50:39'),
(2, 21, 1, 'FAC-CIT-002', 'Algorithms & Programming', '2026-09-24 00:12:26'),
(3, 11, 1, 'FAC-CIT-003', 'Computer Networks & Security', '2026-09-24 00:12:26'),
(4, 12, 1, 'FAC-CIT-004', 'General Education & Ethics', '2026-09-24 00:12:26'),
(5, 13, 1, 'FAC-CIT-005', 'Emerging Technologies', '2026-09-24 00:12:26');

-- --------------------------------------------------------

--
-- Table structure for table `faculty_subject_assignments`
--

CREATE TABLE `faculty_subject_assignments` (
  `id` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty_subject_assignments`
--

INSERT INTO `faculty_subject_assignments` (`id`, `faculty_id`, `subject_id`, `section_id`, `semester_id`, `created_at`) VALUES
(1, 1, 1, 1, 1, '2026-05-15 11:50:39'),
(2, 1, 2, 1, 1, '2026-05-15 11:50:39'),
(5, 1, 3, 1, 1, '2026-05-16 03:32:09'),
(6, 1, 4, 1, 1, '2026-05-16 03:32:09'),
(7, 1, 58, 2, 2, '2026-09-24 00:12:26'),
(8, 1, 60, 3, 2, '2026-09-24 00:12:26'),
(9, 2, 59, 3, 2, '2026-09-24 00:12:26'),
(10, 2, 61, 3, 2, '2026-09-24 00:12:26'),
(11, 3, 62, 3, 2, '2026-09-24 00:12:26'),
(12, 3, 63, 4, 2, '2026-09-24 00:12:26'),
(13, 4, 7, 2, 2, '2026-09-24 00:12:26'),
(14, 4, 8, 3, 2, '2026-09-24 00:12:26'),
(15, 5, 62, 4, 2, '2026-09-24 00:12:26'),
(16, 5, 63, 4, 2, '2026-09-24 00:13:22');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) NOT NULL COMMENT 'e.g. evaluation_open, registration_accepted, results_available',
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `title`, `message`, `type`, `is_read`, `created_at`) VALUES
(7, 6, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 1, '2026-09-24 01:04:21'),
(8, 6, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 1, '2026-09-24 01:04:21'),
(9, 6, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 1, '2026-09-24 01:04:21'),
(10, 7, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(11, 7, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(12, 7, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(13, 8, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(14, 8, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(15, 8, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(16, 9, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(17, 9, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(18, 9, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(19, 14, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(20, 14, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(21, 14, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(22, 15, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(23, 15, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(24, 15, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(25, 16, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(26, 16, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(27, 16, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(28, 17, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(29, 17, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(30, 17, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(31, 18, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(32, 18, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(33, 18, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(34, 19, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(35, 19, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(36, 19, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(37, 20, 'Evaluation Period is Now Open!', '1st Semester AY 2025-2026 Faculty Evaluation has started. Please evaluate your enrolled professors before the deadline.', 'period_open', 0, '2026-09-24 01:04:21'),
(38, 20, 'Pending Faculty Evaluations', 'You have 5 pending faculty evaluations to complete for your enrolled subjects this semester.', 'reminder', 0, '2026-09-24 01:04:21'),
(39, 20, 'Account Activated', 'Welcome to the Granby Colleges Faculty Evaluation System! Your student account is active.', 'welcome', 0, '2026-09-24 01:04:21'),
(40, 4, 'Pending Student Registrations', 'New student registration requests are pending review. Visit the Registrations page to approve or reject.', 'reminder', 1, '2026-09-24 01:06:46'),
(41, 4, 'Evaluation Cycle Active', '1st Semester AY 2025-2026 Evaluation Period is currently open for the CIT Department.', 'period_open', 1, '2026-09-24 01:06:46'),
(42, 4, 'Faculty Overall Standings Ready', 'Preliminary faculty ratings and rankings are now calculating live on your Admin Dashboard.', 'results_available', 1, '2026-09-24 01:06:46'),
(43, 1, 'System-Wide Evaluation Status', 'Evaluation periods are currently running in the College of Information Technology.', 'period_open', 0, '2026-09-24 01:06:46'),
(44, 1, 'Security & Academic Limits Applied', 'System settings have updated password security and academic limit rules across all departments.', 'welcome', 0, '2026-09-24 01:06:46'),
(45, 5, 'Evaluation Results Available', 'Your official faculty performance evaluation results and student qualitative feedback are now available for review.', 'results_available', 1, '2026-09-24 01:06:46'),
(46, 5, 'Ongoing Semester Evaluation', 'Students in your assigned sections are currently submitting evaluations for the 1st Semester AY 2025-2026.', 'period_open', 1, '2026-09-24 01:06:46'),
(47, 11, 'Evaluation Results Available', 'Your official faculty performance evaluation results and student qualitative feedback are now available for review.', 'results_available', 0, '2026-09-24 01:06:46'),
(48, 11, 'Ongoing Semester Evaluation', 'Students in your assigned sections are currently submitting evaluations for the 1st Semester AY 2025-2026.', 'period_open', 0, '2026-09-24 01:06:46'),
(49, 12, 'Evaluation Results Available', 'Your official faculty performance evaluation results and student qualitative feedback are now available for review.', 'results_available', 0, '2026-09-24 01:06:46'),
(50, 12, 'Ongoing Semester Evaluation', 'Students in your assigned sections are currently submitting evaluations for the 1st Semester AY 2025-2026.', 'period_open', 0, '2026-09-24 01:06:46'),
(51, 13, 'Evaluation Results Available', 'Your official faculty performance evaluation results and student qualitative feedback are now available for review.', 'results_available', 0, '2026-09-24 01:06:46'),
(52, 13, 'Ongoing Semester Evaluation', 'Students in your assigned sections are currently submitting evaluations for the 1st Semester AY 2025-2026.', 'period_open', 0, '2026-09-24 01:06:46'),
(53, 21, 'Evaluation Results Available', 'Your official faculty performance evaluation results and student qualitative feedback are now available for review.', 'results_available', 0, '2026-09-24 01:06:46'),
(54, 21, 'Ongoing Semester Evaluation', 'Students in your assigned sections are currently submitting evaluations for the 1st Semester AY 2025-2026.', 'period_open', 0, '2026-09-24 01:06:46'),
(55, 1, 'System Backup Completed', 'The automated system database backup completed successfully.', 'success', 0, '2026-09-24 01:43:05'),
(56, 1, 'New Academic Year Active', 'Academic Year 2025-2026 has been marked as active.', 'info', 0, '2026-09-24 01:43:05'),
(57, 4, 'New Student Registration Request', 'Alex Torres submitted a registration request for BSIT.', 'warning', 1, '2026-09-24 01:43:05'),
(58, 4, 'Evaluation Period Open', '1st Semester AY 2025-2026 Faculty Evaluation is now active.', 'info', 1, '2026-09-24 01:43:05'),
(59, 5, 'Evaluation Period Open', 'Student evaluations for 1st Semester AY 2025-2026 are currently ongoing.', 'info', 0, '2026-09-24 01:43:05'),
(60, 5, 'Profile Verified', 'Your faculty department assignment has been confirmed.', 'success', 0, '2026-09-24 01:43:05'),
(61, 6, 'Faculty Evaluation Reminder', 'You have 5 pending faculty evaluations to complete for 1st Semester.', 'warning', 0, '2026-09-24 01:43:05'),
(62, 6, 'Enrollment Confirmed', 'You are officially enrolled in BSIT-2A subjects.', 'success', 0, '2026-09-24 01:43:05'),
(64, 1, 'New Student Registration', 'Test Student (BSIT - Year 1) has submitted a registration request.', 'welcome', 0, '2026-09-28 03:09:35');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL,
  `otp_code` varchar(10) NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `registration_qr_codes`
--

CREATE TABLE `registration_qr_codes` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `scan_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registration_qr_codes`
--

INSERT INTO `registration_qr_codes` (`id`, `admin_id`, `department_id`, `semester_id`, `token`, `expires_at`, `is_active`, `scan_count`, `created_at`) VALUES
(5, 3, 1, 1, 'd67145f2910a5afa18a8d0e9575811f9132e0ba23c7c728e26ec08d3331fbed4', '2026-06-17 07:37:00', 1, 2, '2026-05-16 05:38:08'),
(6, 3, 1, 1, '75d86107bbddb287a7c6e8d7742f70d77d6a7f5460f1cc4cb8430d73680f7c37', '2026-06-19 11:35:00', 1, 0, '2026-05-18 09:35:55'),
(7, 3, 1, 2, '42ee634f5a1556022e8c5ea3e57bddb52b5f5eda163aa673c914435d143beec4', '2026-10-24 02:37:00', 1, 2, '2026-09-24 00:37:35');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT 'e.g. BSIT-2A',
  `year_level` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `department_id`, `semester_id`, `course_id`, `name`, `year_level`, `created_at`) VALUES
(1, 1, 1, 1, 'BSIT-2A', 2, '2026-05-15 11:50:39'),
(2, 1, 2, 1, 'BSIT-1A', 1, '2026-09-24 00:12:05'),
(3, 1, 2, 1, 'BSIT-2A', 2, '2026-09-24 00:12:05'),
(4, 1, 2, 1, 'BSIT-3A', 3, '2026-09-24 00:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `semesters`
--

CREATE TABLE `semesters` (
  `id` int(11) NOT NULL,
  `academic_year_id` int(11) NOT NULL,
  `semester_no` tinyint(4) NOT NULL COMMENT '1=First, 2=Second, 3=Summer',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semesters`
--

INSERT INTO `semesters` (`id`, `academic_year_id`, `semester_no`, `start_date`, `end_date`, `is_active`, `created_at`) VALUES
(1, 1, 1, '2024-08-01', '2024-12-31', 0, '2026-05-15 10:22:26'),
(2, 3, 1, '2026-09-24', '2027-01-22', 1, '2026-09-24 00:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_group` varchar(50) NOT NULL DEFAULT 'general',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `setting_key`, `setting_value`, `setting_group`, `updated_at`) VALUES
(1, 'school_name', 'Granby Colleges of Science and Technology', 'school', '2026-05-15 14:45:47'),
(2, 'school_address', '', 'school', '2026-05-15 14:45:47'),
(3, 'school_contact', '', 'school', '2026-05-15 14:45:47'),
(4, 'school_email', '', 'school', '2026-05-15 14:45:47'),
(5, 'school_website', '', 'school', '2026-05-15 14:45:47'),
(6, 'student_password_prefix', 'Granby@', 'passwords', '2026-05-15 14:45:47'),
(7, 'faculty_default_password', 'Faculty@1234', 'passwords', '2026-05-15 14:45:47'),
(8, 'admin_default_password', 'Admin@1234', 'passwords', '2026-05-15 14:45:47'),
(9, 'force_password_change', '1', 'passwords', '2026-05-15 14:45:47'),
(10, 'score_outstanding_min', '4.50', 'evaluation', '2026-05-15 14:45:47'),
(11, 'score_outstanding_label', 'Outstanding', 'evaluation', '2026-05-15 14:45:47'),
(12, 'score_very_satisfactory_min', '3.50', 'evaluation', '2026-05-15 14:45:47'),
(13, 'score_very_satisfactory_label', 'Very Satisfactory', 'evaluation', '2026-05-15 14:45:47'),
(14, 'score_satisfactory_min', '2.50', 'evaluation', '2026-05-15 14:45:47'),
(15, 'score_satisfactory_label', 'Satisfactory', 'evaluation', '2026-05-15 14:45:47'),
(16, 'score_fair_min', '1.50', 'evaluation', '2026-05-15 14:45:47'),
(17, 'score_fair_label', 'Fair', 'evaluation', '2026-05-15 14:45:47'),
(18, 'score_poor_min', '1.00', 'evaluation', '2026-05-15 14:45:47'),
(19, 'score_poor_label', 'Poor', 'evaluation', '2026-05-15 14:45:47'),
(20, 'max_comment_length', '1000', 'evaluation', '2026-05-15 14:45:47'),
(21, 'allow_open_comments', '1', 'evaluation', '2026-05-15 14:45:47'),
(22, 'qr_default_expiry_days', '30', 'registration', '2026-05-15 14:45:47'),
(23, 'allow_photo_upload', '1', 'registration', '2026-05-15 14:45:47'),
(24, 'mail_host', 'smtp.gmail.com', 'general', '2026-05-16 05:44:21'),
(25, 'mail_port', '587', 'general', '2026-05-16 05:44:21'),
(26, 'mail_username', 'reydelamerced6@gmail.com', 'general', '2026-05-16 05:45:53'),
(27, 'mail_password', 'euei lqoy sufz tlaf', 'general', '2026-05-16 05:57:33'),
(28, 'mail_from_email', '', 'general', '2026-05-16 06:03:45'),
(29, 'mail_from_name', 'Granby Colleges - Faculty Evaluation System', 'general', '2026-05-16 05:44:21'),
(30, 'mail_encryption', 'tls', 'general', '2026-05-16 05:44:21'),
(31, 'mail_enabled', '1', 'general', '2026-05-16 06:06:05'),
(151, 'allow_manual_registration', '1', 'registration', '2026-09-23 23:42:25'),
(152, 'max_subjects_per_semester', '8', 'academic', '2026-09-23 23:42:25'),
(153, 'max_units_per_semester', '24', 'academic', '2026-09-23 23:42:25'),
(154, 'min_respondents_for_ranking', '5', 'ranking', '2026-09-23 23:42:25');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `student_no` varchar(50) NOT NULL,
  `year_level` tinyint(4) NOT NULL,
  `course_id` int(11) NOT NULL,
  `student_type` enum('regular','irregular') NOT NULL DEFAULT 'regular',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `department_id`, `student_no`, `year_level`, `course_id`, `student_type`, `is_active`, `created_at`) VALUES
(1, 6, 1, '2024-00001', 2, 1, 'regular', 1, '2026-05-15 11:50:39'),
(2, 7, 1, '2026-00002', 1, 1, 'regular', 1, '2026-05-15 14:21:41'),
(3, 8, 1, '2026-00003', 1, 1, 'irregular', 1, '2026-05-16 06:08:24'),
(4, 9, 1, '2026-00004', 1, 1, 'irregular', 1, '2026-05-16 06:09:00'),
(5, 14, 1, '2024-00002', 2, 1, 'regular', 1, '2026-09-24 00:12:26'),
(6, 15, 1, '2024-00003', 2, 1, 'regular', 1, '2026-09-24 00:12:26'),
(7, 16, 1, '2024-00004', 2, 1, 'regular', 1, '2026-09-24 00:12:26'),
(8, 17, 1, '2024-00005', 2, 1, 'regular', 1, '2026-09-24 00:12:26'),
(9, 18, 1, '2024-00006', 2, 1, 'regular', 1, '2026-09-24 00:12:26'),
(10, 19, 1, '2024-00007', 2, 1, 'regular', 1, '2026-09-24 00:12:26'),
(11, 20, 1, '2024-00008', 2, 1, 'irregular', 1, '2026-09-24 00:12:26'),
(12, 22, 1, '2026-00012', 1, 1, 'regular', 1, '2026-09-28 02:48:35'),
(13, 23, 1, '2026-00013', 1, 1, 'regular', 1, '2026-09-28 03:05:50');

-- --------------------------------------------------------

--
-- Table structure for table `student_registration_requests`
--

CREATE TABLE `student_registration_requests` (
  `id` int(11) NOT NULL,
  `qr_code_id` int(11) DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `contact_no` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `address` text NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `year_level` tinyint(4) NOT NULL,
  `course` varchar(100) NOT NULL,
  `student_type` enum('regular','irregular') NOT NULL DEFAULT 'regular',
  `photo_path` varchar(255) DEFAULT NULL,
  `status` enum('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  `rejection_reason` text DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_registration_requests`
--

INSERT INTO `student_registration_requests` (`id`, `qr_code_id`, `department_id`, `semester_id`, `full_name`, `date_of_birth`, `gender`, `contact_no`, `email`, `address`, `username`, `password`, `year_level`, `course`, `student_type`, `photo_path`, `status`, `rejection_reason`, `reviewed_by`, `reviewed_at`, `created_at`) VALUES
(2, 5, 1, 1, 'Del Rosario, Rey R.', '2001-05-16', 'male', '09972234526', 'tanglao@gmail.com', 'Bakduej jshse', NULL, NULL, 1, 'BSIT', 'irregular', NULL, 'accepted', NULL, 4, '2026-05-16 14:08:24', '2026-05-16 06:08:10'),
(3, 5, 1, 1, 'Del Rosario, Rey R.', '2001-05-16', 'male', '09972234526', 'reydelamerced058@gmail.com', 'Bakduej jshse', NULL, NULL, 1, 'BSIT', 'irregular', NULL, 'accepted', NULL, 4, '2026-05-16 14:09:00', '2026-05-16 06:08:54'),
(4, 7, 1, 2, 'Alex Torres', '0000-00-00', 'male', '', 'alex.torres@gmail.com', '', NULL, NULL, 1, 'BSIT', 'regular', NULL, 'rejected', NULL, 4, '2026-09-28 11:06:53', '2026-09-24 01:43:05'),
(6, 7, 1, 2, 'Timo, Sob Uko T.', '2026-09-28', 'male', '09268929949', 'dennieldavecupat3@gmail.com', 'ILOCOS SUR STREET', NULL, NULL, 1, 'BSIT', 'regular', NULL, 'accepted', NULL, 4, '2026-09-28 10:48:35', '2026-09-28 02:48:06'),
(7, 7, 1, 2, 'Jeje, Jojo J.', '2004-09-28', 'male', '09972234526', 'jeje@gmail.com', 'Jan lang', 'jeje123', '$2y$10$sh7e/bH7VXereXn6V1.Ategdp17MGAfR49oLDxzhy0LjbGSOCwESy', 1, 'BSIT', 'regular', NULL, 'accepted', NULL, 4, '2026-09-28 11:05:50', '2026-09-28 03:05:28');

-- --------------------------------------------------------

--
-- Table structure for table `student_subject_enrollments`
--

CREATE TABLE `student_subject_enrollments` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  `enrollment_type` enum('regular','irregular') NOT NULL DEFAULT 'regular',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_subject_enrollments`
--

INSERT INTO `student_subject_enrollments` (`id`, `student_id`, `subject_id`, `section_id`, `semester_id`, `enrollment_type`, `created_at`) VALUES
(1, 1, 1, 1, 1, 'regular', '2026-05-15 11:50:39'),
(2, 1, 2, 1, 1, 'regular', '2026-05-15 11:50:39'),
(3, 1, 60, 3, 2, 'regular', '2026-09-24 00:12:26'),
(4, 1, 59, 3, 2, 'regular', '2026-09-24 00:12:26'),
(5, 1, 61, 3, 2, 'regular', '2026-09-24 00:12:26'),
(6, 1, 62, 3, 2, 'regular', '2026-09-24 00:12:26'),
(7, 1, 8, 3, 2, 'regular', '2026-09-24 00:12:26'),
(8, 5, 60, 3, 2, 'regular', '2026-09-24 00:12:26'),
(9, 5, 59, 3, 2, 'regular', '2026-09-24 00:12:26'),
(10, 5, 61, 3, 2, 'regular', '2026-09-24 00:12:26'),
(11, 5, 62, 3, 2, 'regular', '2026-09-24 00:12:26'),
(12, 5, 8, 3, 2, 'regular', '2026-09-24 00:12:26'),
(13, 6, 60, 3, 2, 'regular', '2026-09-24 00:12:26'),
(14, 6, 59, 3, 2, 'regular', '2026-09-24 00:12:26'),
(15, 6, 61, 3, 2, 'regular', '2026-09-24 00:12:26'),
(16, 6, 62, 3, 2, 'regular', '2026-09-24 00:12:26'),
(17, 6, 8, 3, 2, 'regular', '2026-09-24 00:12:26'),
(18, 7, 60, 3, 2, 'regular', '2026-09-24 00:12:26'),
(19, 7, 59, 3, 2, 'regular', '2026-09-24 00:12:26'),
(20, 7, 61, 3, 2, 'regular', '2026-09-24 00:12:26'),
(21, 7, 62, 3, 2, 'regular', '2026-09-24 00:12:26'),
(22, 7, 8, 3, 2, 'regular', '2026-09-24 00:12:26'),
(23, 8, 60, 3, 2, 'regular', '2026-09-24 00:12:26'),
(24, 8, 59, 3, 2, 'regular', '2026-09-24 00:12:26'),
(25, 8, 61, 3, 2, 'regular', '2026-09-24 00:12:26'),
(26, 8, 62, 3, 2, 'regular', '2026-09-24 00:12:26'),
(27, 8, 8, 3, 2, 'regular', '2026-09-24 00:12:26'),
(28, 9, 60, 3, 2, 'regular', '2026-09-24 00:12:26'),
(29, 9, 59, 3, 2, 'regular', '2026-09-24 00:12:26'),
(30, 9, 61, 3, 2, 'regular', '2026-09-24 00:12:26'),
(31, 9, 62, 3, 2, 'regular', '2026-09-24 00:12:26'),
(32, 9, 8, 3, 2, 'regular', '2026-09-24 00:12:26'),
(33, 10, 60, 3, 2, 'regular', '2026-09-24 00:12:26'),
(34, 10, 59, 3, 2, 'regular', '2026-09-24 00:12:26'),
(35, 10, 61, 3, 2, 'regular', '2026-09-24 00:12:26'),
(36, 10, 62, 3, 2, 'regular', '2026-09-24 00:12:26'),
(37, 10, 8, 3, 2, 'regular', '2026-09-24 00:12:26'),
(38, 11, 60, 3, 2, 'regular', '2026-09-24 00:12:26'),
(39, 11, 59, 3, 2, 'regular', '2026-09-24 00:12:26'),
(40, 11, 61, 3, 2, 'regular', '2026-09-24 00:12:26'),
(41, 11, 62, 3, 2, 'regular', '2026-09-24 00:12:26'),
(42, 11, 8, 3, 2, 'regular', '2026-09-24 00:12:26'),
(44, 5, 63, 4, 2, 'regular', '2026-09-24 00:13:22');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(150) NOT NULL,
  `units` tinyint(4) NOT NULL DEFAULT 3,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `department_id`, `code`, `name`, `units`, `description`, `is_active`, `created_at`) VALUES
(1, 1, 'IT101', 'Introduction to Computing', 3, NULL, 1, '2026-05-15 10:22:26'),
(2, 1, 'IT102', 'Programming 1', 3, NULL, 1, '2026-05-15 10:22:26'),
(3, 1, 'IT201', 'Data Structures and Algorithms', 3, NULL, 1, '2026-05-15 10:22:26'),
(4, 1, 'IT202', 'Web Development', 3, NULL, 1, '2026-05-15 10:22:26'),
(5, 2, 'BA101', 'Principles of Management', 3, NULL, 1, '2026-05-15 10:22:26'),
(6, 2, 'BA102', 'Business Communication', 3, NULL, 1, '2026-05-15 10:22:26'),
(7, 1, 'GE101', 'Understanding the Self', 3, NULL, 1, '2026-05-16 06:12:11'),
(8, 1, 'GE102', 'Purposive Communication', 3, NULL, 1, '2026-05-16 06:12:11'),
(9, 1, 'GE103', 'Mathematics in the Modern World', 3, NULL, 1, '2026-05-16 06:12:11'),
(10, 1, 'GE104', 'Purposive Communication', 3, NULL, 1, '2026-05-16 06:12:11'),
(11, 1, 'IT101', 'Introduction to Computing', 3, NULL, 1, '2026-05-16 06:12:11'),
(12, 1, 'IT102', 'Computer Programming 1', 3, NULL, 1, '2026-05-16 06:12:11'),
(13, 1, 'IT103', 'Discrete Mathematics', 3, NULL, 1, '2026-05-16 06:12:11'),
(14, 1, 'PE101', 'Physical Fitness', 2, NULL, 1, '2026-05-16 06:12:11'),
(15, 1, 'NSTP1', 'National Service Training Program 1', 3, NULL, 1, '2026-05-16 06:12:11'),
(16, 1, 'GE105', 'Art Appreciation', 3, NULL, 1, '2026-05-16 06:12:11'),
(17, 1, 'GE106', 'Science, Technology and Society', 3, NULL, 1, '2026-05-16 06:12:11'),
(18, 1, 'GE107', 'Ethics', 3, NULL, 1, '2026-05-16 06:12:11'),
(19, 1, 'IT104', 'Computer Programming 2', 3, NULL, 1, '2026-05-16 06:12:11'),
(20, 1, 'IT105', 'Data Structures and Algorithms', 3, NULL, 1, '2026-05-16 06:12:11'),
(21, 1, 'IT106', 'Computer Organization and Architecture', 3, NULL, 1, '2026-05-16 06:12:11'),
(22, 1, 'IT107', 'Object-Oriented Programming', 3, NULL, 1, '2026-05-16 06:12:11'),
(23, 1, 'PE102', 'Rhythmic Activities', 2, NULL, 1, '2026-05-16 06:12:11'),
(24, 1, 'NSTP2', 'National Service Training Program 2', 3, NULL, 1, '2026-05-16 06:12:11'),
(25, 1, 'GE108', 'The Contemporary World', 3, NULL, 1, '2026-05-16 06:12:11'),
(26, 1, 'GE109', 'Filipino 1: Komunikasyon sa Akademikong Filipino', 3, NULL, 1, '2026-05-16 06:12:11'),
(27, 1, 'IT201', 'Information Management', 3, NULL, 1, '2026-05-16 06:12:11'),
(28, 1, 'IT202', 'Platform Technologies', 3, NULL, 1, '2026-05-16 06:12:11'),
(29, 1, 'IT203', 'Web Development 1', 3, NULL, 1, '2026-05-16 06:12:11'),
(30, 1, 'IT204', 'Networking 1', 3, NULL, 1, '2026-05-16 06:12:11'),
(31, 1, 'IT205', 'Human Computer Interaction', 3, NULL, 1, '2026-05-16 06:12:11'),
(32, 1, 'PE103', 'Individual and Dual Sports', 2, NULL, 1, '2026-05-16 06:12:11'),
(33, 1, 'GE110', 'Filipino 2: Pagbasa at Pagsulat', 3, NULL, 1, '2026-05-16 06:12:11'),
(34, 1, 'GE111', 'Life and Works of Rizal', 3, NULL, 1, '2026-05-16 06:12:11'),
(35, 1, 'IT206', 'Web Development 2', 3, NULL, 1, '2026-05-16 06:12:11'),
(36, 1, 'IT207', 'Networking 2', 3, NULL, 1, '2026-05-16 06:12:11'),
(37, 1, 'IT208', 'Database Management Systems', 3, NULL, 1, '2026-05-16 06:12:11'),
(38, 1, 'IT209', 'Systems Analysis and Design', 3, NULL, 1, '2026-05-16 06:12:11'),
(39, 1, 'IT210', 'Quantitative Methods', 3, NULL, 1, '2026-05-16 06:12:11'),
(40, 1, 'PE104', 'Team Sports', 2, NULL, 1, '2026-05-16 06:12:11'),
(41, 1, 'IT301', 'Application Development and Emerging Technologies', 3, NULL, 1, '2026-05-16 06:12:11'),
(42, 1, 'IT302', 'Information Assurance and Security', 3, NULL, 1, '2026-05-16 06:12:11'),
(43, 1, 'IT303', 'Systems Integration and Architecture', 3, NULL, 1, '2026-05-16 06:12:11'),
(44, 1, 'IT304', 'Mobile Application Development', 3, NULL, 1, '2026-05-16 06:12:11'),
(45, 1, 'IT305', 'Software Engineering', 3, NULL, 1, '2026-05-16 06:12:11'),
(46, 1, 'IT306', 'Multimedia Systems', 3, NULL, 1, '2026-05-16 06:12:11'),
(47, 1, 'ITE01', 'IT Elective 1: Cloud Computing', 3, NULL, 1, '2026-05-16 06:12:11'),
(48, 1, 'IT307', 'Capstone Project 1', 3, NULL, 1, '2026-05-16 06:12:11'),
(49, 1, 'IT308', 'Social and Professional Issues in IT', 3, NULL, 1, '2026-05-16 06:12:11'),
(50, 1, 'IT309', 'Advanced Database Systems', 3, NULL, 1, '2026-05-16 06:12:11'),
(51, 1, 'IT310', 'Network Administration', 3, NULL, 1, '2026-05-16 06:12:11'),
(52, 1, 'ITE02', 'IT Elective 2: Cybersecurity', 3, NULL, 1, '2026-05-16 06:12:11'),
(53, 1, 'ITE03', 'IT Elective 3: Data Analytics', 3, NULL, 1, '2026-05-16 06:12:11'),
(54, 1, 'IT401', 'Capstone Project 2', 3, NULL, 1, '2026-05-16 06:12:11'),
(55, 1, 'IT402', 'Technopreneurship', 3, NULL, 1, '2026-05-16 06:12:11'),
(56, 1, 'ITE04', 'IT Elective 4: Machine Learning', 3, NULL, 1, '2026-05-16 06:12:11'),
(57, 1, 'IT403', 'Practicum / OJT', 6, NULL, 1, '2026-05-16 06:12:11'),
(58, 1, 'CC101', 'Introduction to Computing', 3, NULL, 1, '2026-09-24 00:12:05'),
(59, 1, 'CC102', 'Data Structures & Algorithms', 3, NULL, 1, '2026-09-24 00:12:05'),
(60, 1, 'CC103', 'Web Systems & Technologies', 3, NULL, 1, '2026-09-24 00:12:05'),
(61, 1, 'CC104', 'Database Management Systems', 3, NULL, 1, '2026-09-24 00:12:05'),
(62, 1, 'CC105', 'Object Oriented Programming', 3, NULL, 1, '2026-09-24 00:12:05'),
(63, 1, 'CC106', 'Information Assurance & Security', 3, NULL, 1, '2026-09-24 00:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('superadmin','admin','faculty','student') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `first_login` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`, `role`, `is_active`, `first_login`, `created_at`, `updated_at`) VALUES
(1, 'Super Administrator', 'superadmin@granby.edu.ph', 'superadmin', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'superadmin', 1, 0, '2026-05-15 10:19:32', '2026-09-24 01:43:05'),
(4, 'CIT Department Admin', 'admin.cit@granby.edu.ph', 'admin_cit', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'admin', 1, 0, '2026-05-15 10:45:09', '2026-09-24 01:43:05'),
(5, 'Dr. Maria Santos', 'maria.santos@granby.edu.ph', 'FAC-CIT-001', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'faculty', 1, 0, '2026-05-15 11:50:39', '2026-09-24 01:43:05'),
(6, 'Dela Cruz, Juan M.', 'juan.delacruz.student@granby.edu.ph', '2024-00001', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'student', 1, 0, '2026-05-15 11:50:39', '2026-09-24 01:43:05'),
(7, 'Dela Merced, Rey R.', 'reydelamerced6@gmail.com', '2026-00002', '$2y$10$yIVPt.4LfCqsoJhavXGxc.b11GuOwwX4m2OWsyx5HqsZ5jrESeboO', 'student', 1, 0, '2026-05-15 14:21:41', '2026-09-24 00:48:31'),
(8, 'Del Rosario, Rey R.', 'tanglao@gmail.com', '2026-00003', '$2y$10$Abd3loB2IFpelFNAdB1Tc.3p5c0eEUv7wv0KgimJE/1Jz9uPZH3Xe', 'student', 1, 1, '2026-05-16 06:08:24', '2026-05-16 06:08:24'),
(9, 'Del Rosario, Rey R.', 'reydelamerced058@gmail.com', '2026-00004', '$2y$10$lFTZfhjLLGZucK1BDNyuFuguHPITUKdAJ1SU/BcDgQVNlF01U8KES', 'student', 1, 1, '2026-05-16 06:09:00', '2026-05-16 06:09:00'),
(11, 'Engr. Roberto Garcia', 'roberto.garcia@granby.edu.ph', 'FAC-CIT-003', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'faculty', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(12, 'Ms. Elena Ramos', 'elena.ramos@granby.edu.ph', 'FAC-CIT-004', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'faculty', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(13, 'Mr. David Tan', 'david.tan@granby.edu.ph', 'FAC-CIT-005', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'faculty', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(14, 'Lopez, Maria Kristina G.', 'maria.k.lopez@granby.edu.ph', '2024-00002', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'student', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(15, 'Reyes, Carlos Miguel D.', 'carlos.m.reyes@granby.edu.ph', '2024-00003', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'student', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(16, 'Bautista, Ana Patricia S.', 'ana.p.bautista@granby.edu.ph', '2024-00004', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'student', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(17, 'Mendoza, Mark Vincent R.', 'mark.v.mendoza@granby.edu.ph', '2024-00005', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'student', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(18, 'Villanueva, Grace Anne T.', 'grace.a.villanueva@granby.edu.ph', '2024-00006', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'student', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(19, 'Gonzales, Leo Angelo C.', 'leo.a.gonzales@granby.edu.ph', '2024-00007', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'student', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(20, 'Cruz, Samantha Nicole B.', 'samantha.cruz@granby.edu.ph', '2024-00008', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'student', 1, 0, '2026-09-24 00:12:26', '2026-09-24 01:43:05'),
(21, 'Prof. Juan Dela Cruz', 'juan.delacruz@granby.edu.ph', 'FAC-CIT-002', '$2y$10$d5U7A73WFi6LXFu31wLDpuAPpipRwPToghLhk8XS7uFktUu1Mg0we', 'faculty', 1, 0, '2026-09-24 00:12:58', '2026-09-24 01:43:05'),
(22, 'Timo, Sob Uko T.', 'dennieldavecupat3@gmail.com', '2026-00012', '$2y$10$3Myys8vjbIAFAEKYm610ZuFviI/KG11uqSFlpEo/z2rTZ7rpdFcri', 'student', 1, 1, '2026-09-28 02:48:35', '2026-09-28 02:48:35'),
(23, 'Jeje, Jojo J.', 'jeje@gmail.com', 'jeje123', '$2y$10$sh7e/bH7VXereXn6V1.Ategdp17MGAfR49oLDxzhy0LjbGSOCwESy', 'student', 1, 0, '2026-09-28 03:05:50', '2026-09-28 03:05:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_years`
--
ALTER TABLE `academic_years`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `evaluation_answers`
--
ALTER TABLE `evaluation_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id` (`submission_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `evaluation_categories`
--
ALTER TABLE `evaluation_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `evaluation_form_id` (`evaluation_form_id`);

--
-- Indexes for table `evaluation_forms`
--
ALTER TABLE `evaluation_forms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `academic_year_id` (`academic_year_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `evaluation_periods`
--
ALTER TABLE `evaluation_periods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `evaluation_form_id` (`evaluation_form_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `evaluation_questions`
--
ALTER TABLE `evaluation_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `evaluation_submissions`
--
ALTER TABLE `evaluation_submissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_submission` (`student_id`,`faculty_id`,`subject_id`,`evaluation_period_id`),
  ADD KEY `faculty_id` (`faculty_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `evaluation_period_id` (`evaluation_period_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `employee_no` (`employee_no`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `faculty_subject_assignments`
--
ALTER TABLE `faculty_subject_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_assignment` (`faculty_id`,`subject_id`,`section_id`,`semester_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `registration_qr_codes`
--
ALTER TABLE `registration_qr_codes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `semesters`
--
ALTER TABLE `semesters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `academic_year_id` (`academic_year_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `student_no` (`student_no`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `student_registration_requests`
--
ALTER TABLE `student_registration_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `qr_code_id` (`qr_code_id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `reviewed_by` (`reviewed_by`);

--
-- Indexes for table `student_subject_enrollments`
--
ALTER TABLE `student_subject_enrollments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_enrollment` (`student_id`,`subject_id`,`semester_id`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `semester_id` (`semester_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_years`
--
ALTER TABLE `academic_years`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `evaluation_answers`
--
ALTER TABLE `evaluation_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `evaluation_categories`
--
ALTER TABLE `evaluation_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `evaluation_forms`
--
ALTER TABLE `evaluation_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `evaluation_periods`
--
ALTER TABLE `evaluation_periods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `evaluation_questions`
--
ALTER TABLE `evaluation_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `evaluation_submissions`
--
ALTER TABLE `evaluation_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `faculty_subject_assignments`
--
ALTER TABLE `faculty_subject_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `registration_qr_codes`
--
ALTER TABLE `registration_qr_codes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `semesters`
--
ALTER TABLE `semesters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `student_registration_requests`
--
ALTER TABLE `student_registration_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `student_subject_enrollments`
--
ALTER TABLE `student_subject_enrollments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admins_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evaluation_answers`
--
ALTER TABLE `evaluation_answers`
  ADD CONSTRAINT `evaluation_answers_ibfk_1` FOREIGN KEY (`submission_id`) REFERENCES `evaluation_submissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `evaluation_questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evaluation_categories`
--
ALTER TABLE `evaluation_categories`
  ADD CONSTRAINT `evaluation_categories_ibfk_1` FOREIGN KEY (`evaluation_form_id`) REFERENCES `evaluation_forms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evaluation_forms`
--
ALTER TABLE `evaluation_forms`
  ADD CONSTRAINT `evaluation_forms_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_forms_ibfk_2` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_forms_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_forms_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `evaluation_periods`
--
ALTER TABLE `evaluation_periods`
  ADD CONSTRAINT `evaluation_periods_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_periods_ibfk_2` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_periods_ibfk_3` FOREIGN KEY (`evaluation_form_id`) REFERENCES `evaluation_forms` (`id`),
  ADD CONSTRAINT `evaluation_periods_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `evaluation_questions`
--
ALTER TABLE `evaluation_questions`
  ADD CONSTRAINT `evaluation_questions_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `evaluation_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `evaluation_submissions`
--
ALTER TABLE `evaluation_submissions`
  ADD CONSTRAINT `evaluation_submissions_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_submissions_ibfk_2` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_submissions_ibfk_3` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_submissions_ibfk_4` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `evaluation_submissions_ibfk_5` FOREIGN KEY (`evaluation_period_id`) REFERENCES `evaluation_periods` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `faculty`
--
ALTER TABLE `faculty`
  ADD CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `faculty_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `faculty_subject_assignments`
--
ALTER TABLE `faculty_subject_assignments`
  ADD CONSTRAINT `faculty_subject_assignments_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `faculty_subject_assignments_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `faculty_subject_assignments_ibfk_3` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `faculty_subject_assignments_ibfk_4` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `registration_qr_codes`
--
ALTER TABLE `registration_qr_codes`
  ADD CONSTRAINT `registration_qr_codes_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `registration_qr_codes_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `registration_qr_codes_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sections_ibfk_2` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sections_ibfk_3` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `semesters`
--
ALTER TABLE `semesters`
  ADD CONSTRAINT `semesters_ibfk_1` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `students_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `students_ibfk_3` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);

--
-- Constraints for table `student_registration_requests`
--
ALTER TABLE `student_registration_requests`
  ADD CONSTRAINT `student_registration_requests_ibfk_1` FOREIGN KEY (`qr_code_id`) REFERENCES `registration_qr_codes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_registration_requests_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_registration_requests_ibfk_3` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_registration_requests_ibfk_4` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `student_subject_enrollments`
--
ALTER TABLE `student_subject_enrollments`
  ADD CONSTRAINT `student_subject_enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_subject_enrollments_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_subject_enrollments_ibfk_3` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_subject_enrollments_ibfk_4` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
