-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2025 at 11:39 AM
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
-- Database: `noteapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `email_verification_tokens`
--

CREATE TABLE `email_verification_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_verification_tokens`
--

INSERT INTO `email_verification_tokens` (`id`, `user_id`, `token`, `expires_at`, `created_at`) VALUES
(53, 16, 'deb92ed96493f22bdd6a45c4d5eb65f12774ddb93e5d8de45f2274a331246452', '2025-05-16 16:13:45', '2025-05-16 15:13:45');

-- --------------------------------------------------------

--
-- Table structure for table `labels`
--

CREATE TABLE `labels` (
  `label_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `labels`
--

INSERT INTO `labels` (`label_id`, `user_id`, `name`) VALUES
(31, 16, '12'),
(32, 16, '123'),
(33, 16, '12345'),
(37, 14, 'test');

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `note_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `pinned_at` datetime DEFAULT NULL,
  `images` text DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT 0,
  `password` varchar(255) DEFAULT NULL,
  `note_color` varchar(30) DEFAULT '#ffffff',
  `font_size` varchar(20) DEFAULT '1rem'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`note_id`, `user_id`, `title`, `content`, `created_at`, `updated_at`, `pinned_at`, `images`, `is_locked`, `password`, `note_color`, `font_size`) VALUES
(56, 16, '12', '12344', '2025-05-16 13:19:31', '2025-05-16 13:19:31', NULL, NULL, 0, NULL, '#ffffff', '1rem'),
(57, 16, 'bing chilling', '231', '2025-05-16 13:20:03', '2025-05-16 13:20:03', NULL, NULL, 0, NULL, '#ffffff', '1rem'),
(58, 14, 'Test23  ', '121234', '2025-05-16 15:26:17', '2025-05-16 16:11:25', NULL, NULL, 0, NULL, '#ffffff', '1rem'),
(63, 14, 'Test', '1', '2025-05-16 15:39:41', '2025-05-16 16:12:18', NULL, NULL, 0, NULL, '#ffffff', '1rem'),
(65, 14, 'test', '123123124214', '2025-05-16 16:11:44', '2025-05-16 16:18:31', NULL, 'uploads/682701500fa13_chatuml-diagram.png', 0, NULL, '#ffffff', '1rem'),
(66, 14, 'testlabel', '123  \n123456 \n', '2025-05-16 16:13:22', '2025-05-16 16:28:18', NULL, NULL, 0, NULL, '#ffffff', '1rem');

-- --------------------------------------------------------

--
-- Table structure for table `note_labels`
--

CREATE TABLE `note_labels` (
  `note_id` int(11) NOT NULL,
  `label_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `note_labels`
--

INSERT INTO `note_labels` (`note_id`, `label_id`) VALUES
(56, 32),
(57, 31),
(65, 37),
(66, 37);

-- --------------------------------------------------------

--
-- Table structure for table `shared_notes`
--

CREATE TABLE `shared_notes` (
  `id` int(11) NOT NULL,
  `note_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `permission` enum('read','edit') NOT NULL DEFAULT 'read',
  `verification_token` varchar(64) NOT NULL,
  `expires` datetime NOT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `shared_notes`
--

INSERT INTO `shared_notes` (`id`, `note_id`, `owner_id`, `recipient_id`, `permission`, `verification_token`, `expires`, `verified`, `created_at`) VALUES
(12, 65, 14, 16, 'edit', '34ec25e7a388922012c4fc44b4930712223c55ff163039dc1f7c6cf6a9f98b9c', '2025-05-23 11:18:05', 1, '2025-05-16 09:18:05'),
(13, 66, 14, 16, 'edit', '08671e336271fd3f45532c118955924628d67ec050e38f13d8121da2dccc2073', '2025-05-23 11:24:46', 1, '2025-05-16 09:24:46');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `totp_secret` varchar(255) DEFAULT NULL,
  `two_factor_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `avatar` varchar(255) DEFAULT NULL,
  `preferences` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `created_at`, `updated_at`, `is_verified`, `totp_secret`, `two_factor_enabled`, `avatar`, `preferences`) VALUES
(14, 'kiet', 'kietvdki@gmail.com', '$2y$10$HYXQLR2sg2g5WeZpiwZwp.Ipi5cHGgBjv0WQ7j/uKZdCLYrPTp9Tq', '2025-05-13 23:35:57', '2025-05-16 16:09:33', 1, NULL, 0, 'uploads/avatars/avatar_6826f4feafdfa.png', '{\"theme\":\"light\",\"note_layout\":\"list\",\"font_size\":\"medium\",\"note_color\":\"#ffffff\"}'),
(16, 'kiet1', 'kietvdbd@gmail.com', '$2y$10$SXyIAijrROgOxrA52hLjC.jV8R9LMSbJIcNHvlbsbfJbuHn3vD3uK', '2025-05-16 13:14:24', '2025-05-16 16:17:08', 1, NULL, 0, 'uploads/avatars/avatar_682702948360a.png', '{\"theme\":\"dark\",\"note_layout\":\"list\",\"font_size\":\"medium\",\"note_color\":\"#ffffff\"}');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `labels`
--
ALTER TABLE `labels`
  ADD PRIMARY KEY (`label_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `note_labels`
--
ALTER TABLE `note_labels`
  ADD PRIMARY KEY (`note_id`,`label_id`),
  ADD KEY `label_id` (`label_id`);

--
-- Indexes for table `shared_notes`
--
ALTER TABLE `shared_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `note_id` (`note_id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `recipient_id` (`recipient_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `labels`
--
ALTER TABLE `labels`
  MODIFY `label_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `shared_notes`
--
ALTER TABLE `shared_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `email_verification_tokens`
--
ALTER TABLE `email_verification_tokens`
  ADD CONSTRAINT `email_verification_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `labels`
--
ALTER TABLE `labels`
  ADD CONSTRAINT `labels_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `note_labels`
--
ALTER TABLE `note_labels`
  ADD CONSTRAINT `note_labels_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `notes` (`note_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `note_labels_ibfk_2` FOREIGN KEY (`label_id`) REFERENCES `labels` (`label_id`) ON DELETE CASCADE;

--
-- Constraints for table `shared_notes`
--
ALTER TABLE `shared_notes`
  ADD CONSTRAINT `shared_notes_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `notes` (`note_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shared_notes_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shared_notes_ibfk_3` FOREIGN KEY (`recipient_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
