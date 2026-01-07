-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 07, 2026 at 09:34 AM
-- Server version: 8.0.41
-- PHP Version: 8.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kyhsqcgs_smcdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `chapters`
--

CREATE TABLE `chapters` (
  `chapter_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `icon` varchar(50) DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `prerequisite_chapter_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `access_level` enum('starter','intermediate','advanced') DEFAULT 'starter',
  `estimated_hours` int DEFAULT '1',
  `prerequisites` json DEFAULT NULL,
  `completion_badge` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `chapters`
--

INSERT INTO `chapters` (`chapter_id`, `title`, `description`, `icon`, `display_order`, `prerequisite_chapter_id`, `is_active`, `created_at`, `access_level`, `estimated_hours`, `prerequisites`, `completion_badge`) VALUES
(1, 'Personal Foundation', 'Building your core identity and mindset', 'user-circle', 1, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(2, 'Vision & Purpose', 'Defining your life purpose and vision', 'bullseye', 2, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(3, 'Financial Blueprint', 'Creating wealth and financial freedom', 'credit-card', 3, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(4, 'Business Development', 'Building and scaling your business', 'briefcase', 4, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(5, 'Relationships & Networking', 'Mastering personal and professional relationships', 'users', 5, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(6, 'Health & Wellness', 'Optimizing physical and mental health', 'heartbeat', 6, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(7, 'Legacy Creation', 'Building a lasting impact and legacy', 'trophy', 7, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(8, 'Dating Profile Setup', 'Creating your ideal dating profile', 'heart', 8, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(9, 'Communication Skills', 'Mastering effective communication', 'comment-alt', 9, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL),
(10, 'Lifestyle Design', 'Designing your ideal lifestyle', 'home', 10, NULL, 1, '2025-12-20 19:03:47', 'starter', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `chapter_fields`
--

CREATE TABLE `chapter_fields` (
  `field_id` int NOT NULL,
  `chapter_id` int NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `field_label` varchar(100) NOT NULL,
  `field_type` enum('text','textarea','number','email','tel','date','select','checkbox','radio','file','range','color') DEFAULT 'text',
  `placeholder` varchar(255) DEFAULT NULL,
  `options` json DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT '0',
  `validation_rules` varchar(255) DEFAULT NULL,
  `min_length` int DEFAULT NULL,
  `max_length` int DEFAULT NULL,
  `field_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `chapter_fields`
--

INSERT INTO `chapter_fields` (`field_id`, `chapter_id`, `field_name`, `field_label`, `field_type`, `placeholder`, `options`, `is_required`, `validation_rules`, `min_length`, `max_length`, `field_order`, `created_at`) VALUES
(1, 1, 'core_values', 'Your Top 5 Core Values', 'textarea', 'List your most important values...', NULL, 1, 'required', 10, 500, 1, '2025-12-20 19:03:47'),
(2, 1, 'strengths', 'Your Key Strengths', 'textarea', 'What are you naturally good at?', NULL, 1, 'required', 10, 500, 2, '2025-12-20 19:03:47'),
(3, 1, 'mindset_blockers', 'Current Mindset Blockers', 'textarea', 'What beliefs are holding you back?', NULL, 0, NULL, NULL, 500, 3, '2025-12-20 19:03:47'),
(4, 1, 'life_vision_statement', 'Personal Vision Statement', 'textarea', 'Your vision for your life...', NULL, 1, 'required', 20, 1000, 4, '2025-12-20 19:03:47'),
(5, 2, 'purpose_statement', 'Life Purpose Statement', 'textarea', 'My purpose in life is...', NULL, 1, 'required', 20, 1000, 1, '2025-12-20 19:03:47'),
(6, 2, 'vision_5_years', '5-Year Vision', 'textarea', 'Where do you see yourself in 5 years?', NULL, 1, 'required', 20, 1000, 2, '2025-12-20 19:03:47'),
(7, 2, 'vision_10_years', '10-Year Vision', 'textarea', 'Where do you see yourself in 10 years?', NULL, 1, 'required', 20, 1000, 3, '2025-12-20 19:03:47'),
(8, 2, 'legacy_goal', 'Ultimate Legacy Goal', 'textarea', 'What legacy do you want to leave?', NULL, 1, 'required', 20, 1000, 4, '2025-12-20 19:03:47'),
(9, 3, 'current_income', 'Current Monthly Income (R)', 'number', '0.00', NULL, 1, 'required|numeric|min:0', NULL, NULL, 1, '2025-12-20 19:03:47'),
(10, 3, 'income_goal', 'Desired Monthly Income (R)', 'number', '0.00', NULL, 1, 'required|numeric|min:0', NULL, NULL, 2, '2025-12-20 19:03:47'),
(11, 3, 'net_worth_goal', 'Net Worth Goal (R)', 'number', '0.00', NULL, 1, 'required|numeric|min:0', NULL, NULL, 3, '2025-12-20 19:03:47'),
(12, 3, 'investment_plan', 'Investment Strategy', 'textarea', 'Describe your investment approach...', NULL, 0, NULL, NULL, 500, 4, '2025-12-20 19:03:47'),
(13, 3, 'financial_freedom_date', 'Financial Freedom Target Date', 'date', 'YYYY-MM-DD', NULL, 1, 'required|date|after:today', NULL, NULL, 5, '2025-12-20 19:03:47'),
(14, 4, 'business_idea', 'Business Idea/Niche', 'text', 'e.g., Online coaching, E-commerce...', NULL, 1, 'required', 5, 200, 1, '2025-12-20 19:03:47'),
(15, 4, 'target_market', 'Target Market Description', 'textarea', 'Describe your ideal customers...', NULL, 1, 'required', 10, 500, 2, '2025-12-20 19:03:47'),
(16, 4, 'revenue_streams', 'Planned Revenue Streams', 'textarea', 'List your revenue sources...', NULL, 1, 'required', 10, 500, 3, '2025-12-20 19:03:47'),
(17, 4, 'business_stage', 'Current Business Stage', 'select', 'Select stage...', '[\"Idea Stage\", \"Planning\", \"Launch Ready\", \"Early Growth\", \"Scaling\", \"Mature\"]', 1, 'required', NULL, NULL, 4, '2025-12-20 19:03:47'),
(18, 4, 'launch_timeline', 'Launch Timeline (Months)', 'number', '1-12', NULL, 1, 'required|numeric|min:1|max:12', NULL, NULL, 5, '2025-12-20 19:03:47'),
(19, 5, 'relationship_status', 'Current Relationship Status', 'select', 'Select status...', '[\"Single\", \"Dating\", \"In a Relationship\", \"Married\", \"Divorced\", \"Widowed\"]', 1, 'required', NULL, NULL, 1, '2025-12-20 19:03:47'),
(20, 5, 'relationship_goals', 'Relationship Goals', 'textarea', 'What are your relationship goals?', NULL, 1, 'required', 10, 500, 2, '2025-12-20 19:03:47'),
(21, 5, 'network_size', 'Current Professional Network Size', 'number', 'Approximate number', NULL, 1, 'required|numeric|min:0', NULL, NULL, 3, '2025-12-20 19:03:47'),
(22, 5, 'ideal_network', 'Ideal Network Description', 'textarea', 'Describe your ideal network...', NULL, 0, NULL, NULL, 500, 4, '2025-12-20 19:03:47'),
(23, 5, 'mentorship_needs', 'Mentorship Needs', 'textarea', 'What mentorship do you need?', NULL, 0, NULL, NULL, 500, 5, '2025-12-20 19:03:47'),
(24, 6, 'current_fitness_level', 'Current Fitness Level', 'select', 'Select level...', '[\"Beginner\", \"Intermediate\", \"Advanced\", \"Athlete\"]', 1, 'required', NULL, NULL, 1, '2025-12-20 19:03:47'),
(25, 6, 'health_goals', 'Health & Fitness Goals', 'textarea', 'What are your health goals?', NULL, 1, 'required', 10, 500, 2, '2025-12-20 19:03:47'),
(26, 6, 'mental_health_focus', 'Mental Health Focus Areas', 'textarea', 'Areas for mental wellbeing...', NULL, 0, NULL, NULL, 500, 3, '2025-12-20 19:03:47'),
(27, 6, 'sleep_hours', 'Average Sleep Hours/Night', 'number', '4-10', NULL, 1, 'required|numeric|min:4|max:10', NULL, NULL, 4, '2025-12-20 19:03:47'),
(28, 6, 'stress_level', 'Current Stress Level (1-10)', 'range', '1-10', '{\"max\": 10, \"min\": 1}', 1, 'required', NULL, NULL, 5, '2025-12-20 19:03:47'),
(29, 7, 'legacy_type', 'Type of Legacy', 'select', 'Select type...', '[\"Financial\", \"Business\", \"Family\", \"Philanthropic\", \"Knowledge\", \"Artistic\", \"Community\"]', 1, 'required', NULL, NULL, 1, '2025-12-20 19:03:47'),
(30, 7, 'legacy_project', 'Legacy Project Description', 'textarea', 'Describe your legacy project...', NULL, 1, 'required', 20, 1000, 2, '2025-12-20 19:03:47'),
(31, 7, 'impact_scale', 'Desired Impact Scale', 'select', 'Select scale...', '[\"Local\", \"National\", \"Continental\", \"Global\"]', 1, 'required', NULL, NULL, 3, '2025-12-20 19:03:47'),
(32, 7, 'timeline_years', 'Legacy Timeline (Years)', 'number', '5-50', NULL, 1, 'required|numeric|min:5|max:50', NULL, NULL, 4, '2025-12-20 19:03:47'),
(33, 8, 'dating_intention', 'Dating Intention', 'select', 'What are you looking for?', '[\"Casual Dating\", \"Serious Relationship\", \"Marriage\", \"Friendship First\", \"Not Sure\"]', 1, 'required', NULL, NULL, 1, '2025-12-20 19:03:47'),
(34, 8, 'ideal_partner', 'Description of Ideal Partner', 'textarea', 'Describe your ideal partner...', NULL, 1, 'required', 20, 1000, 2, '2025-12-20 19:03:47'),
(35, 8, 'deal_breakers', 'Relationship Deal Breakers', 'textarea', 'What are your deal breakers?', NULL, 1, 'required', 10, 500, 3, '2025-12-20 19:03:47'),
(36, 8, 'date_ideas', 'Perfect Date Ideas', 'textarea', 'Describe your perfect dates...', NULL, 0, NULL, NULL, 500, 4, '2025-12-20 19:03:47'),
(37, 8, 'relationship_values', 'Core Relationship Values', 'textarea', 'What values matter most?', NULL, 1, 'required', 10, 500, 5, '2025-12-20 19:03:47'),
(38, 9, 'communication_style', 'Primary Communication Style', 'select', 'Select style...', '[\"Direct\", \"Diplomatic\", \"Analytical\", \"Expressive\", \"Supportive\"]', 1, 'required', NULL, NULL, 1, '2025-12-20 19:03:47'),
(39, 9, 'improvement_areas', 'Communication Areas to Improve', 'textarea', 'What would you like to improve?', NULL, 1, 'required', 10, 500, 2, '2025-12-20 19:03:47'),
(40, 9, 'listening_skill_level', 'Active Listening Skill Level (1-10)', 'range', '1-10', '{\"max\": 10, \"min\": 1}', 1, 'required', NULL, NULL, 3, '2025-12-20 19:03:47'),
(41, 9, 'public_speaking_goal', 'Public Speaking Goals', 'textarea', 'Your public speaking aspirations...', NULL, 0, NULL, NULL, 500, 4, '2025-12-20 19:03:47'),
(42, 10, 'ideal_day_description', 'Description of Your Ideal Day', 'textarea', 'Describe your perfect day...', NULL, 1, 'required', 20, 1000, 1, '2025-12-20 19:03:47'),
(43, 10, 'work_style', 'Preferred Work Style', 'select', 'Select style...', '[\"9-5 Office\", \"Remote Work\", \"Hybrid\", \"Flexible Hours\", \"Entrepreneur\", \"Digital Nomad\"]', 1, 'required', NULL, NULL, 2, '2025-12-20 19:03:47'),
(44, 10, 'lifestyle_budget', 'Desired Monthly Lifestyle Budget (R)', 'number', '0.00', NULL, 1, 'required|numeric|min:0', NULL, NULL, 3, '2025-12-20 19:03:47'),
(45, 10, 'travel_frequency', 'Desired Travel Frequency', 'select', 'How often?', '[\"Never\", \"Rarely\", \"Monthly\", \"Quarterly\", \"Constantly\"]', 1, 'required', NULL, NULL, 4, '2025-12-20 19:03:47'),
(46, 10, 'work_life_balance', 'Work-Life Balance Goal (Work % / Life %)', 'text', 'e.g., 40/60, 50/50...', NULL, 1, 'required', 3, 10, 5, '2025-12-20 19:03:47');

-- --------------------------------------------------------

--
-- Table structure for table `chapter_rewards`
--

CREATE TABLE `chapter_rewards` (
  `reward_id` int NOT NULL,
  `chapter_id` int NOT NULL,
  `reward_type` enum('badge','points','resource','coaching') NOT NULL,
  `reward_value` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coaching_sessions`
--

CREATE TABLE `coaching_sessions` (
  `session_id` int NOT NULL,
  `user_id` int NOT NULL,
  `coach_id` int NOT NULL,
  `user_package_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `scheduled_time` timestamp NOT NULL,
  `duration_minutes` int DEFAULT '60',
  `meeting_link` varchar(255) DEFAULT NULL,
  `status` enum('scheduled','completed','cancelled','rescheduled') DEFAULT 'scheduled',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elbethuel_bookings`
--

CREATE TABLE `elbethuel_bookings` (
  `id` int NOT NULL,
  `reference` varchar(50) NOT NULL,
  `client_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `service_type` varchar(50) NOT NULL,
  `package` varchar(100) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','confirmed','completed','cancelled') DEFAULT 'pending',
  `booking_date` datetime DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `payment_method` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `elbethuel_bookings`
--

INSERT INTO `elbethuel_bookings` (`id`, `reference`, `client_name`, `email`, `phone`, `service_type`, `package`, `amount`, `status`, `booking_date`, `notes`, `created_at`, `updated_at`, `payment_method`) VALUES
(5, 'EL20251222033530654', 'Grey Moiun', 'gmoiun@gmail.com', '+27601125630', 'package', 'Growth Package', 35000.00, 'pending', NULL, 'sfsdfd dsfsdfds afdas sada dsa dasdsadsadasasds d asdas  dsa dasd ad asdasda s sadasdas dasdd sdas dsad ddsda d sdasdsada sd as dasdsad asd asds', '2025-12-22 03:35:30', '2025-12-22 03:35:30', 'payfast'),
(6, 'EL20251222142047489', 'Eler Doer', 'kasigeek@gmail.com', '+27815895085', 'service', 'AI Automation Setup', 25000.00, 'pending', NULL, 'I am looking for a ten year contract for this project can you please help me build this in two uears', '2025-12-22 14:20:47', '2025-12-22 14:20:47', 'bank'),
(7, 'EL20251225175633927', 'EL Molaadira', 'elbethuel@gmail.com', '071 989 7791', 'course', 'Web3 & Blockchain Basics', 2500.00, 'pending', NULL, 'lets go', '2025-12-25 17:56:33', '2025-12-25 17:56:33', 'bank');

-- --------------------------------------------------------

--
-- Table structure for table `elbethuel_course_enrollments`
--

CREATE TABLE `elbethuel_course_enrollments` (
  `id` int NOT NULL,
  `student_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `access_expires` date DEFAULT NULL,
  `status` enum('active','completed','cancelled') DEFAULT 'active',
  `enrolled_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elbethuel_email_subscribers`
--

CREATE TABLE `elbethuel_email_subscribers` (
  `id` int NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `subscribed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','unsubscribed') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `elbethuel_email_subscribers`
--

INSERT INTO `elbethuel_email_subscribers` (`id`, `email`, `name`, `subscribed_at`, `status`) VALUES
(1, 'gmoiun@gmail.com', 'Grey Moiun', '2025-12-22 03:35:30', 'active'),
(2, 'kasigeek@gmail.com', 'Eler Doer', '2025-12-22 14:20:47', 'active'),
(3, 'elbethuel@gmail.com', 'EL Molaadira', '2025-12-25 17:56:33', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `elbethuel_healing_requests`
--

CREATE TABLE `elbethuel_healing_requests` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `healing_type` varchar(50) NOT NULL,
  `request_details` text,
  `status` enum('pending','scheduled','completed') DEFAULT 'pending',
  `requested_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `elbethuel_leads`
--

CREATE TABLE `elbethuel_leads` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `source` varchar(50) DEFAULT 'website',
  `interest` varchar(100) DEFAULT NULL,
  `status` enum('new','contacted','qualified','converted','lost') DEFAULT 'new',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `elbethuel_leads`
--

INSERT INTO `elbethuel_leads` (`id`, `name`, `email`, `phone`, `source`, `interest`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'Grey Moiun', 'gmoiun@gmail.com', '+27601125630', 'website', 'Growth Package', 'converted', NULL, '2025-12-22 03:35:30', '2025-12-22 03:35:30'),
(2, 'Eler Doer', 'kasigeek@gmail.com', '+27815895085', 'website', 'AI Automation Setup', 'converted', NULL, '2025-12-22 14:20:47', '2025-12-22 14:20:47'),
(3, 'EL Molaadira', 'elbethuel@gmail.com', '071 989 7791', 'website', 'Web3 & Blockchain Basics', 'converted', NULL, '2025-12-25 17:56:33', '2025-12-25 17:56:33');

-- --------------------------------------------------------

--
-- Table structure for table `elbethuel_payments`
--

CREATE TABLE `elbethuel_payments` (
  `id` int NOT NULL,
  `booking_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('payfast','payshap','paypal','bank_transfer','cash') NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `elbethuel_payments`
--

INSERT INTO `elbethuel_payments` (`id`, `booking_id`, `amount`, `payment_method`, `transaction_id`, `status`, `payment_date`, `created_at`) VALUES
(5, 5, 35000.00, 'payfast', 'EL20251222033530654', 'pending', NULL, '2025-12-22 03:35:30'),
(6, 6, 25000.00, '', 'EL20251222142047489', 'pending', NULL, '2025-12-22 14:20:47'),
(7, 7, 2500.00, '', 'EL20251225175633927', 'pending', NULL, '2025-12-25 17:56:33');

-- --------------------------------------------------------

--
-- Table structure for table `elbethuel_referrals`
--

CREATE TABLE `elbethuel_referrals` (
  `id` int NOT NULL,
  `referrer_name` varchar(100) NOT NULL,
  `referrer_email` varchar(100) NOT NULL,
  `referred_name` varchar(100) NOT NULL,
  `referred_email` varchar(100) NOT NULL,
  `commission_amount` decimal(10,2) NOT NULL,
  `status` enum('pending','paid','cancelled') DEFAULT 'pending',
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_logs`
--

CREATE TABLE `email_logs` (
  `log_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `email_type` enum('verification','welcome','password_reset','notification','system') NOT NULL,
  `recipient_email` varchar(100) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `status` enum('sent','failed','pending') DEFAULT 'pending',
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `event_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `event_type` enum('webinar','retreat','workshop','qna','networking') NOT NULL,
  `access_level` enum('starter','intermediate','advanced') NOT NULL,
  `max_attendees` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event_registrations`
--

CREATE TABLE `event_registrations` (
  `registration_id` int NOT NULL,
  `event_id` int NOT NULL,
  `user_id` int NOT NULL,
  `status` enum('registered','attended','cancelled') DEFAULT 'registered',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forum_categories`
--

CREATE TABLE `forum_categories` (
  `category_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `access_level` enum('starter','intermediate','advanced') NOT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forum_posts`
--

CREATE TABLE `forum_posts` (
  `post_id` int NOT NULL,
  `thread_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `is_answer` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forum_threads`
--

CREATE TABLE `forum_threads` (
  `thread_id` int NOT NULL,
  `category_id` int NOT NULL,
  `user_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `is_pinned` tinyint(1) DEFAULT '0',
  `is_closed` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `goal_milestones`
--

CREATE TABLE `goal_milestones` (
  `milestone_id` int NOT NULL,
  `goal_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `target_date` date DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lovers_interactions`
--

CREATE TABLE `lovers_interactions` (
  `interaction_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `type` enum('match_request','message','virtual_wink') DEFAULT 'match_request',
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lovers_service_requests`
--

CREATE TABLE `lovers_service_requests` (
  `request_id` int NOT NULL,
  `user_id` int NOT NULL,
  `service_type` enum('Single & Mingle','Single & Hangout','Single & Virtual') NOT NULL,
  `message` text,
  `status` enum('pending','processed','connected') DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `package_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `duration_days` int NOT NULL,
  `level` enum('starter','intermediate','advanced') NOT NULL,
  `features` json DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`package_id`, `name`, `description`, `price`, `duration_days`, `level`, `features`, `is_active`, `created_at`) VALUES
(1, 'Foundation Package', 'Basic transformation starter package', 2500.00, 30, 'starter', '[\"Basic mindset training\", \"Introductory business templates\", \"Weekly email guidance\", \"Access to community forum\", \"1 monthly group coaching call\"]', 1, '2025-05-26 08:59:00'),
(2, 'Growth Package', 'Comprehensive growth package', 7500.00, 90, 'starter', '[\"All Foundation features\", \"Advanced business templates\", \"Bi-weekly 1:1 coaching\", \"Exclusive webinars\", \"Customized action plan\", \"Monthly accountability check-ins\"]', 1, '2025-05-26 08:59:00'),
(3, 'Business Accelerator', '3-month business transformation', 35500.00, 90, 'intermediate', '[\"All Growth features\", \"3-month intensive program\", \"Weekly 1:1 strategy sessions\", \"Custom business roadmap\", \"Financial planning toolkit\", \"VIP mastermind access\", \"Priority support\"]', 1, '2025-05-26 08:59:00'),
(4, 'Elite Transformation', '6-month elite transformation', 65000.00, 180, 'intermediate', '[\"All Business Accelerator features\", \"6-month comprehensive program\", \"Bi-weekly private coaching\", \"Personalized mentorship\", \"Exclusive retreat invitation\", \"Branding & marketing audit\", \"Legacy planning session\"]', 1, '2025-05-26 08:59:00'),
(5, 'Mastermind Experience', '12-month premium experience', 95000.00, 365, 'advanced', '[\"All Elite Transformation features\", \"12-month immersive experience\", \"Weekly private coaching\", \"Quarterly in-person retreats\", \"Business scaling strategies\", \"Personal concierge service\", \"Exclusive networking events\", \"Lifetime community access\"]', 1, '2025-05-26 08:59:00'),
(6, 'VIP Legacy', '2-year VIP legacy program', 140000.00, 730, 'advanced', '[\"All Mastermind Experience features\", \"24-month comprehensive journey\", \"Unlimited coaching access\", \"Personalized business team\", \"International retreats\", \"Brand partnership opportunities\", \"Wealth management program\", \"Legacy creation blueprint\", \"Dedicated success manager\"]', 1, '2025-05-26 08:59:00');

-- --------------------------------------------------------

--
-- Table structure for table `package_resources`
--

CREATE TABLE `package_resources` (
  `package_id` int NOT NULL,
  `resource_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `principles`
--

CREATE TABLE `principles` (
  `principle_id` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text,
  `category` enum('mindset','action','finance','relationships','health','business','spiritual','other') DEFAULT 'mindset',
  `application_tips` text,
  `difficulty` enum('beginner','intermediate','advanced') DEFAULT 'beginner',
  `estimated_time_minutes` int DEFAULT '15',
  `related_principles` json DEFAULT NULL,
  `video_url` varchar(500) DEFAULT NULL,
  `document_url` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `display_order` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `resource_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `file_path` varchar(255) NOT NULL,
  `resource_type` enum('document','video','audio','template','worksheet') NOT NULL,
  `access_level` enum('starter','intermediate','advanced') NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_requests`
--

CREATE TABLE `service_requests` (
  `request_id` int NOT NULL,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  `request_type` enum('additional_coaching','resource_access','account_help','feature_request','other') NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `status` enum('open','in_progress','completed','rejected') DEFAULT 'open',
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `assigned_to` int DEFAULT NULL,
  `resolution` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sh_password_resets`
--

CREATE TABLE `sh_password_resets` (
  `reset_id` int NOT NULL,
  `user_id` int NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sh_password_resets`
--

INSERT INTO `sh_password_resets` (`reset_id`, `user_id`, `token`, `expires_at`, `used`, `created_at`) VALUES
(1, 34, '6a882fb14713fc62b65ec575e4b21b65773a5a5e67230241e13c649f862bdf72', '2025-12-20 14:12:09', 0, '2025-12-20 18:12:09');

-- --------------------------------------------------------

--
-- Table structure for table `sh_remember_tokens`
--

CREATE TABLE `sh_remember_tokens` (
  `user_id` int NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_notifications`
--

CREATE TABLE `system_notifications` (
  `notification_id` int NOT NULL,
  `notification_type` enum('registration','payment','support','spam_alert','system_error') NOT NULL,
  `title` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `data` json DEFAULT NULL,
  `is_processed` tinyint(1) DEFAULT '0',
  `processed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payfast_token` varchar(100) DEFAULT NULL,
  `status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `verification_token` varchar(64) DEFAULT NULL,
  `verification_token_expires` timestamp NULL DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `bio` text,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `slug` varchar(100) DEFAULT NULL,
  `profile_updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `login_count` int DEFAULT '0',
  `timezone` varchar(50) DEFAULT 'Africa/Johannesburg',
  `preferences` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email`, `email_verified_at`, `verification_token`, `verification_token_expires`, `password_hash`, `phone`, `profile_image`, `bio`, `status`, `created_at`, `updated_at`, `slug`, `profile_updated_at`, `last_login`, `login_count`, `timezone`, `preferences`) VALUES
(1, 'elbethuel', 'User', 'elbethuel@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$f4skymff2BepxE6XA9wwTORIx9KKu/rXmzcbu.BoJEoVF7H0A4Jve', NULL, NULL, NULL, 'active', '2025-07-22 16:28:41', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(2, 'Mkwena', 'User', 'Nomvullathando14@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$jSYRuAmOGmKTmYnUnCXnHe1htEuMQN7q009qsAL1.zmXWPeRYWCx.', NULL, NULL, NULL, 'active', '2025-07-24 08:40:25', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(3, 'Kwanele', 'User', 'radebesinele52@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$rPwtL0gUI.sN/VdvDeZ.5Og2GLM5NqhGcZ7fdn57icnl8ua3.vXiu', NULL, NULL, NULL, 'active', '2025-07-24 10:29:34', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(4, 'Thapelo', 'User', 'linahphooko121@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$9pxm8xuWWTuq4uEeAnVkUeZxKTunoS.7LJYMh8xlBSU/EPhswhAKG', NULL, NULL, NULL, 'active', '2025-07-25 08:04:19', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(5, 'Small buddy', 'User', 'Mm.matsibana@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$4zYoWHqkbfrlMkTWzMXeKu2lWnwWHK7fGq4aQz4Wu9FGyg8izbTai', NULL, NULL, NULL, 'active', '2025-07-28 06:26:30', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(6, 'Athatsh95', 'User', 'athabiletshici95@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$LSp8STZZMp2iS0pUcy2vtuUpFAsztl9x71q36UZDJheGaAuE6akqO', NULL, NULL, NULL, 'active', '2025-08-06 17:19:04', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(7, 'Tshepo', 'User', 'tshepomakgoba64@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$8RZf8d.y3LamrAeH/scrmu7Ibm3oDbvv46Qdna9vQ/Snf93NH0V6u', NULL, NULL, NULL, 'active', '2025-08-11 13:23:57', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(8, 'Nkazimlo', 'User', 'nkazimlotshaka72@gmail.co', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$87Ed.ZlYOOa.SWa28R9GZuEOZljbtuctS5l4tkGjt1vEoLo3n.pza', NULL, NULL, NULL, 'active', '2025-08-19 03:43:07', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(9, 'ntshaka', 'User', 'nkazimlotshaka72@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$xc2by2nkwxiOS4ZxSo25BuviYtGVcQIvHc7/FvmPtjbIgAAuy61RG', NULL, NULL, NULL, 'active', '2025-08-19 04:15:15', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(10, 'zaezar', 'User', 'pulchritudinousza@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$rCCXKVQ0t8WBdrbsXrXumeRGQQXfAo1e3JiZSsVFamH1wt.m3mq1a', NULL, NULL, NULL, 'active', '2025-08-22 10:37:02', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(11, 'Frank', 'User', 'mafolofrank@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$YFZJRdWT7..WTi12zN7hz.MYQpcIM/hWE8Uz8uHFJVnBRcBBbX3g2', NULL, NULL, NULL, 'active', '2025-08-28 08:22:10', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(12, 'Robert', 'User', 'pventer160@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$c0P/f1.oCx4AFRmXlHi02OZnW0iJc4qpfUeHAKfj7HPga2CyLJZQS', NULL, NULL, NULL, 'active', '2025-08-29 19:33:20', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(13, 'motaungprince97@gmail.com', 'User', 'motaungprince97@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$XqgVk4GupHm/e1HWpJgwEubeO1qleihAQEvWhMJnlZKvCrUkYRN/S', NULL, NULL, NULL, 'active', '2025-08-30 19:30:12', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(14, 'Valdez', 'User', 'amzolo054@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$eWrwC3BWWXSTUrpmhbshsujbF6KIhJAL2TZV/WO6Ef8UrSZ55FqPG', NULL, NULL, NULL, 'active', '2025-09-13 15:51:09', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(15, 'Spikie', 'User', 'maritzpeter111@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$UtjbyahVptlGJp278WW8deF2lyc9sR2VneIbMTww8cBHxoDCnljdi', NULL, NULL, NULL, 'active', '2025-09-14 07:37:20', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(16, 'TIVANANI ALPHA', 'User', 'maganualpha8@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$ew4rVS.qXAPZRi7XHMEEJ.mXEIqd146k/fxo42xQCqHcE3o6eJQyu', NULL, NULL, NULL, 'active', '2025-09-22 13:16:05', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(17, 'junper2025', 'User', 'magicis49@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$jVi6ZBy1.zzY8KL.lfcBh.F7zCGGnVloWqdDeaX1kG12DtjTl..fG', NULL, NULL, NULL, 'active', '2025-10-16 09:14:49', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(18, 'memek', 'User', 'ratujotos@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$zb2r7mZuy7xv4GFQjdJhu.oeBW5tOWKW3uT0U99ugb8fakQuBqGSG', NULL, NULL, NULL, 'active', '2025-10-21 15:46:45', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(19, 'Dolf3', 'User', 'rudolffredericks97@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$xX33DPTu2plOI8.8UbkOruEDxVzwiIVUQJ68NDWixO8.3qM6pjUj6', NULL, NULL, NULL, 'active', '2025-10-27 19:46:40', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(20, 'mizNox', 'User', 'vinaple@gismail.online', NULL, NULL, NULL, '$2y$10$R4gcKtHe5nqGdVqKhxAk.eX5NUevu1LzdqID7muON7oLRKGUYanrO', NULL, NULL, NULL, 'inactive', '2025-10-28 02:13:32', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(21, 'Horny', 'User', 'fourie.marius3@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$DIOrIrPK8GxrjzBvW0ROh.1djDTbbsQIK8eUSxYKPQ3ydc95AsSNi', NULL, NULL, NULL, 'active', '2025-10-28 07:36:39', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(22, 'RubieFanny', 'User', 'albanxxesgrivas@gmx.com', NULL, NULL, NULL, '$2y$10$Nai38rm5SSVT2oWd/YSKF.qCnKJCNH5fy1VC9ntXdGyvtVAC/tO0q', NULL, NULL, NULL, 'inactive', '2025-10-28 15:30:21', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(23, 'P.O.S', 'User', 'sibisipromise02@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$hkK/lThjdGgZx8Qj4Z0lA.kLOA4khrfCiTiSbQiOKdK.9qiS8eysi', NULL, NULL, NULL, 'active', '2025-11-02 19:54:59', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(24, 'Graigo', 'User', 'adamsjulian51@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$PZZaZcxZjHDt.OIpGMUIJuSGpKXUH3TBKzTMwJsjUudKa6nPgDu/S', NULL, NULL, NULL, 'active', '2025-11-04 02:28:54', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(26, 'Nisha', 'User', 'charles000@hotmail.co.uk', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$jP4woBw0vcv3HG2Xh125PO41UGd6f4KeE/QDDHVcDLVbJbowLGnJ2', NULL, NULL, NULL, 'active', '2025-11-07 19:20:46', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(27, 'Loster dolos perdo d001 secretmatchesclub.co.za', 'User', 'm.itaxe.bandili.s@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$p2/6HVmGRhlJp4GxBkQTkOX2BPL1hPuIcp.Jn59gUPUiEXdfOgms2', NULL, NULL, NULL, 'active', '2025-11-24 03:27:32', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(28, 'mizNox', 'User', 'berenge@gismail.online', NULL, NULL, NULL, '$2y$10$LvPIGvGQsPCNsi9h0HIuCutH4S2mKKYAOmH5KgYChzN7KHItrNCeG', NULL, NULL, NULL, 'inactive', '2025-11-24 13:55:45', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(29, 'Theodoreken', 'User', 'krivotoidima@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$Xhqp3MNfFT//8qXj.RgJ7.Ee0xL417y7vqptF.tZ5rzCo0TjWWHE6', NULL, NULL, NULL, 'active', '2025-11-24 18:54:44', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(30, 'Doc Maghwai', 'User', 'mahlafunyajan@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$o6DrK3awIc25kVWyd6O3iOaD2VQsY.CpKiXP.3jQ7VW6.q7oFeUG6', NULL, NULL, NULL, 'active', '2025-11-26 08:47:03', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(31, 'Chris', 'User', 'cw8287042@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$1kZVyn5ZYjFlNMona9mbXuHbtbheeqgElKMDOBc4i5QgdPN7kX01a', NULL, NULL, NULL, 'active', '2025-11-26 09:41:08', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(32, 'Jamesoxype', 'User', 'hubrightacharolettew@gmx.com', NULL, NULL, NULL, '$2y$10$Hkmi3EhkuuxMOwQ982QwEe0ZT03giP5DtPFWwCvIgSf1V9SAYwBkG', NULL, NULL, NULL, 'inactive', '2025-11-26 16:26:13', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(33, 'Nancyvag', 'User', 'bsara5865@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$KVSPRlX7uSGK1kNBivaQmeoQBrSKHG6jT1.Ll8arG3kQH.4kjJp/u', NULL, NULL, NULL, 'active', '2025-12-02 02:34:41', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(34, 'KasiGeek', 'User', 'kasigeek@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$ZQs0CaKeWg.V1KQR0xgkMel.65f7aNxSgfHH6U/op/PCg815V7bcu', NULL, NULL, NULL, 'active', '2025-12-03 19:37:36', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(35, 'bmolaadira', 'User', 'bmolaadira@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$GuLTOUodssk0NhyuHDkJ6uF.6cVRYrLiJudSjXjNU7qFmJAzPdHZq', NULL, NULL, NULL, 'active', '2025-12-03 21:08:15', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(36, 'Wilhelm', '', 'Wilhelm@venterconsulting.co.za', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$kLfNyw4sbIThu4RETNumBujkoOEx4Oa8Bse0stlUbXbS9vG74nQ4a', NULL, NULL, NULL, 'active', '2025-12-04 08:48:39', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(37, 'Bruce', '', 'lovetrustandwealth@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$TCFZZp7yE9IASAjeacCybeqgdIobwbPyfg3RcTuqfxWTr6UsqCuEy', NULL, NULL, NULL, 'active', '2025-12-04 13:05:58', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(38, 'bahadur@bahadur.co.za', '', 'bahadur@bahadur.co.za', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$Tu1b40YXU7pYDErzRrzSe.0dG21xy68t4tmRQbqpJnSDFZwX5MB4e', NULL, NULL, NULL, 'active', '2025-12-04 13:25:28', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(39, 'Wesley', '', 'wsskimask0@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$27ZxatKnNTZhfEAHYzoNLO3ef6zHC2ULh/GzXPkgAvcje6.ueqV1i', NULL, NULL, NULL, 'active', '2025-12-04 21:06:28', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(40, 'Walterreumn', '', 'micucciodthersa6k@gmx.com', NULL, NULL, NULL, '$2y$10$59jvkdX.ynVJUfJ57UQcxeRTYm3v5OQwUvtE.8CmE4IcwbuyNSBku', NULL, NULL, NULL, 'inactive', '2025-12-05 15:58:17', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(41, 'RandyC', '', 'randallcoetzee45@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$P9wvLngxT3u92nN79OzhLecHA7VapBdZmzUYwXt/NpAZZ.d//hN8y', NULL, NULL, NULL, 'active', '2025-12-08 09:35:31', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(42, 'Charlesstone', '', 'nadinebiewer@t-online.de', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$vrHNEyde5ckBoRGgBooYR.dDL133QNfinBDc2avCWZ5vvMjrN78Qa', NULL, NULL, NULL, 'active', '2025-12-11 04:23:31', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(43, 'Varoshn', '', 'coaching@consciouswellbeing.co.za', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$hXgBYswmMyyRHBcMGUGhsO//D9jVP4Wr9zx2K7EG/BrJ1WkfyZqN.', NULL, NULL, NULL, 'active', '2025-12-11 08:23:12', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(44, 'Ernesto', '', 'ernie301159@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$8qtkpxekAD4P0nanLGw8LulmfkFJ8cZllPYd4a/5W9925mJR/5IlG', NULL, NULL, NULL, 'active', '2025-12-13 12:09:18', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(45, 'Frans', '', 'bonganifrans77@gmail.com', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$dSqS74YseMKrtm.lyIY6JetW35DUGRywn7sAYmV7d9128JzfCb04a', NULL, NULL, NULL, 'active', '2025-12-16 16:45:09', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(46, 'CliftonShina', '', 'p.luttkau@t-online.de', '2025-12-20 21:54:51', NULL, NULL, '$2y$10$SAF6uhJTtqxvgic5MJu5FuVN.5sdWvdZjwIpD7Gx.hgiQuuFtKFSC', NULL, NULL, NULL, 'active', '2025-12-18 20:17:12', '2025-12-20 21:54:51', NULL, '2025-12-20 21:54:51', NULL, 0, 'Africa/Johannesburg', NULL),
(47, 'Danielbog', '', 'oh.end.l.i.np.o.hta@gmail.com', NULL, NULL, NULL, '$2y$10$9pwyeYS0uP1lfteOuyuXL./EYc6dEYlTuVCeYdGmS7rJ411.9hwxW', NULL, NULL, NULL, 'active', '2025-12-21 13:21:06', '2025-12-21 13:21:06', NULL, '2025-12-21 13:21:06', NULL, 0, 'Africa/Johannesburg', NULL),
(48, 'Dillano', '', 'dillanomelrose87@gmail.com', NULL, NULL, NULL, '$2y$10$gfdJut8WcNHtQR2eUQ3OPeQwFXi6bfrv.5w3gQWW6eqH7eUdABbSG', NULL, NULL, NULL, 'active', '2025-12-23 19:37:17', '2025-12-23 19:37:17', NULL, '2025-12-23 19:37:17', NULL, 0, 'Africa/Johannesburg', NULL),
(49, 'MichaelCot', '', 'step.h.anie.b.u.r.t.o.lome.w@gmail.com', NULL, NULL, NULL, '$2y$10$AjgSR3Fn3WG.R/t3D3bCqOIyaDRLHOvlc2xo/6xSPvrKw/AiIp6SG', NULL, NULL, NULL, 'active', '2025-12-24 04:42:00', '2025-12-24 04:42:00', NULL, '2025-12-24 04:42:00', NULL, 0, 'Africa/Johannesburg', NULL),
(50, 'Kraigduase', '', 'coda_wolf23@yahoo.com', NULL, NULL, NULL, '$2y$10$6tAopDToA3cj/9RNpJWhFuUAJdi8r9xYqkSc3JoSlNX7oCSh/Wbvi', NULL, NULL, NULL, 'active', '2025-12-27 03:39:53', '2025-12-27 03:39:53', NULL, '2025-12-27 03:39:53', NULL, 0, 'Africa/Johannesburg', NULL),
(51, 'EthanJoult', '', 'kieu.trinh42@yahoo.com', NULL, NULL, NULL, '$2y$10$VWViDd8QqZ2bBGmRWVG.3.OFLnQCtUcG1dQZYAhgHAcD4evujsI22', NULL, NULL, NULL, 'active', '2025-12-28 18:57:36', '2025-12-28 18:57:36', NULL, '2025-12-28 18:57:36', NULL, 0, 'Africa/Johannesburg', NULL),
(52, 'Patricksax', '', 'sandra36@t-online.de', NULL, NULL, NULL, '$2y$10$cL1ApZyLQ78AtLU0xQaLhurQIPCflMp45IEc7zkKgQnMPCJq6EDO2', NULL, NULL, NULL, 'active', '2025-12-31 00:53:35', '2025-12-31 00:53:35', NULL, '2025-12-31 00:53:35', NULL, 0, 'Africa/Johannesburg', NULL),
(53, 'Lillith19slay', '', 'bothalillith@gmail.com', NULL, NULL, NULL, '$2y$10$yoxUdibrO7T5YfigP22cVuvqQ6y8s6ujBM8pByIMwnLyqRrxcYVFS', NULL, NULL, NULL, 'active', '2026-01-02 18:31:23', '2026-01-02 18:31:23', NULL, '2026-01-02 18:31:23', NULL, 0, 'Africa/Johannesburg', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_chapter_data`
--

CREATE TABLE `user_chapter_data` (
  `data_id` int NOT NULL,
  `user_id` int NOT NULL,
  `chapter_id` int NOT NULL,
  `field_id` int NOT NULL,
  `field_value` text,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_goals`
--

CREATE TABLE `user_goals` (
  `goal_id` int NOT NULL,
  `user_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `target_date` date DEFAULT NULL,
  `status` enum('not_started','in_progress','completed','abandoned') DEFAULT 'not_started',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_packages`
--

CREATE TABLE `user_packages` (
  `user_package_id` int NOT NULL,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `start_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` timestamp NULL DEFAULT NULL,
  `status` enum('active','expired','cancelled') DEFAULT 'active',
  `last_renewal` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `profile_id` int NOT NULL,
  `user_id` int NOT NULL,
  `bio` text,
  `location` varchar(100) DEFAULT NULL,
  `social_class` enum('Working Class','Self Employed','Business Owner','Corporate Professional','Creative','High Net Worth','Other') DEFAULT 'Other',
  `employment_status` varchar(100) DEFAULT NULL,
  `relationship_goal` enum('Single & Mingle','Single & Hangout','Single & Virtual','Long-term','Marriage') DEFAULT 'Single & Mingle',
  `age_range` varchar(20) DEFAULT '18-25',
  `zodiac_sign` varchar(20) DEFAULT NULL,
  `hobbies` text,
  `ideal_match_desc` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_slug_history`
--

CREATE TABLE `user_slug_history` (
  `history_id` int NOT NULL,
  `user_id` int NOT NULL,
  `old_slug` varchar(100) NOT NULL,
  `new_slug` varchar(100) NOT NULL,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chapters`
--
ALTER TABLE `chapters`
  ADD PRIMARY KEY (`chapter_id`),
  ADD KEY `idx_order` (`display_order`),
  ADD KEY `idx_active` (`is_active`);
ALTER TABLE `chapters` ADD FULLTEXT KEY `idx_chapter_search` (`title`,`description`);

--
-- Indexes for table `chapter_fields`
--
ALTER TABLE `chapter_fields`
  ADD PRIMARY KEY (`field_id`),
  ADD KEY `chapter_id` (`chapter_id`);

--
-- Indexes for table `chapter_rewards`
--
ALTER TABLE `chapter_rewards`
  ADD PRIMARY KEY (`reward_id`);

--
-- Indexes for table `coaching_sessions`
--
ALTER TABLE `coaching_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `coach_id` (`coach_id`),
  ADD KEY `user_package_id` (`user_package_id`);

--
-- Indexes for table `elbethuel_bookings`
--
ALTER TABLE `elbethuel_bookings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_reference` (`reference`);

--
-- Indexes for table `elbethuel_course_enrollments`
--
ALTER TABLE `elbethuel_course_enrollments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `elbethuel_email_subscribers`
--
ALTER TABLE `elbethuel_email_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `elbethuel_healing_requests`
--
ALTER TABLE `elbethuel_healing_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `elbethuel_leads`
--
ALTER TABLE `elbethuel_leads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `elbethuel_payments`
--
ALTER TABLE `elbethuel_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `elbethuel_referrals`
--
ALTER TABLE `elbethuel_referrals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_logs`
--
ALTER TABLE `email_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_email_type` (`email_type`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD PRIMARY KEY (`registration_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `forum_categories`
--
ALTER TABLE `forum_categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `forum_posts`
--
ALTER TABLE `forum_posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `thread_id` (`thread_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `forum_threads`
--
ALTER TABLE `forum_threads`
  ADD PRIMARY KEY (`thread_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `goal_milestones`
--
ALTER TABLE `goal_milestones`
  ADD PRIMARY KEY (`milestone_id`),
  ADD KEY `goal_id` (`goal_id`);

--
-- Indexes for table `lovers_interactions`
--
ALTER TABLE `lovers_interactions`
  ADD PRIMARY KEY (`interaction_id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `lovers_service_requests`
--
ALTER TABLE `lovers_service_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`package_id`);

--
-- Indexes for table `package_resources`
--
ALTER TABLE `package_resources`
  ADD PRIMARY KEY (`package_id`,`resource_id`),
  ADD KEY `resource_id` (`resource_id`);

--
-- Indexes for table `principles`
--
ALTER TABLE `principles`
  ADD PRIMARY KEY (`principle_id`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_difficulty` (`difficulty`),
  ADD KEY `idx_active_order` (`is_active`,`display_order`);
ALTER TABLE `principles` ADD FULLTEXT KEY `idx_search` (`title`,`description`,`application_tips`);

--
-- Indexes for table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`resource_id`);

--
-- Indexes for table `service_requests`
--
ALTER TABLE `service_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `package_id` (`package_id`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `sh_password_resets`
--
ALTER TABLE `sh_password_resets`
  ADD PRIMARY KEY (`reset_id`),
  ADD UNIQUE KEY `unique_token` (`token`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_expires` (`expires_at`,`used`);

--
-- Indexes for table `sh_remember_tokens`
--
ALTER TABLE `sh_remember_tokens`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `idx_token` (`token`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Indexes for table `system_notifications`
--
ALTER TABLE `system_notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `idx_processed` (`is_processed`),
  ADD KEY `idx_type` (`notification_type`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `package_id` (`package_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_last_login` (`last_login`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_email_verified` (`email_verified_at`);

--
-- Indexes for table `user_chapter_data`
--
ALTER TABLE `user_chapter_data`
  ADD PRIMARY KEY (`data_id`),
  ADD UNIQUE KEY `unique_user_chapter_field` (`user_id`,`chapter_id`,`field_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `chapter_id` (`chapter_id`),
  ADD KEY `field_id` (`field_id`);

--
-- Indexes for table `user_goals`
--
ALTER TABLE `user_goals`
  ADD PRIMARY KEY (`goal_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user_packages`
--
ALTER TABLE `user_packages`
  ADD PRIMARY KEY (`user_package_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `package_id` (`package_id`),
  ADD KEY `transaction_id` (`transaction_id`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`profile_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `user_slug_history`
--
ALTER TABLE `user_slug_history`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chapters`
--
ALTER TABLE `chapters`
  MODIFY `chapter_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `chapter_fields`
--
ALTER TABLE `chapter_fields`
  MODIFY `field_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `chapter_rewards`
--
ALTER TABLE `chapter_rewards`
  MODIFY `reward_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coaching_sessions`
--
ALTER TABLE `coaching_sessions`
  MODIFY `session_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `elbethuel_bookings`
--
ALTER TABLE `elbethuel_bookings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `elbethuel_course_enrollments`
--
ALTER TABLE `elbethuel_course_enrollments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `elbethuel_email_subscribers`
--
ALTER TABLE `elbethuel_email_subscribers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `elbethuel_healing_requests`
--
ALTER TABLE `elbethuel_healing_requests`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `elbethuel_leads`
--
ALTER TABLE `elbethuel_leads`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `elbethuel_payments`
--
ALTER TABLE `elbethuel_payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `elbethuel_referrals`
--
ALTER TABLE `elbethuel_referrals`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_logs`
--
ALTER TABLE `email_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `event_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_registrations`
--
ALTER TABLE `event_registrations`
  MODIFY `registration_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forum_categories`
--
ALTER TABLE `forum_categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forum_posts`
--
ALTER TABLE `forum_posts`
  MODIFY `post_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forum_threads`
--
ALTER TABLE `forum_threads`
  MODIFY `thread_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `goal_milestones`
--
ALTER TABLE `goal_milestones`
  MODIFY `milestone_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lovers_interactions`
--
ALTER TABLE `lovers_interactions`
  MODIFY `interaction_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lovers_service_requests`
--
ALTER TABLE `lovers_service_requests`
  MODIFY `request_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `package_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `principles`
--
ALTER TABLE `principles`
  MODIFY `principle_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `resource_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_requests`
--
ALTER TABLE `service_requests`
  MODIFY `request_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sh_password_resets`
--
ALTER TABLE `sh_password_resets`
  MODIFY `reset_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `system_notifications`
--
ALTER TABLE `system_notifications`
  MODIFY `notification_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `user_chapter_data`
--
ALTER TABLE `user_chapter_data`
  MODIFY `data_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_goals`
--
ALTER TABLE `user_goals`
  MODIFY `goal_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_packages`
--
ALTER TABLE `user_packages`
  MODIFY `user_package_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `profile_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_slug_history`
--
ALTER TABLE `user_slug_history`
  MODIFY `history_id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chapter_fields`
--
ALTER TABLE `chapter_fields`
  ADD CONSTRAINT `chapter_fields_ibfk_1` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE CASCADE;

--
-- Constraints for table `coaching_sessions`
--
ALTER TABLE `coaching_sessions`
  ADD CONSTRAINT `coaching_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `coaching_sessions_ibfk_2` FOREIGN KEY (`coach_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `coaching_sessions_ibfk_3` FOREIGN KEY (`user_package_id`) REFERENCES `user_packages` (`user_package_id`);

--
-- Constraints for table `email_logs`
--
ALTER TABLE `email_logs`
  ADD CONSTRAINT `email_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD CONSTRAINT `event_registrations_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`event_id`),
  ADD CONSTRAINT `event_registrations_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `forum_posts`
--
ALTER TABLE `forum_posts`
  ADD CONSTRAINT `forum_posts_ibfk_1` FOREIGN KEY (`thread_id`) REFERENCES `forum_threads` (`thread_id`),
  ADD CONSTRAINT `forum_posts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `forum_threads`
--
ALTER TABLE `forum_threads`
  ADD CONSTRAINT `forum_threads_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `forum_categories` (`category_id`),
  ADD CONSTRAINT `forum_threads_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `goal_milestones`
--
ALTER TABLE `goal_milestones`
  ADD CONSTRAINT `goal_milestones_ibfk_1` FOREIGN KEY (`goal_id`) REFERENCES `user_goals` (`goal_id`);

--
-- Constraints for table `lovers_interactions`
--
ALTER TABLE `lovers_interactions`
  ADD CONSTRAINT `lovers_interactions_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lovers_interactions_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `lovers_service_requests`
--
ALTER TABLE `lovers_service_requests`
  ADD CONSTRAINT `lovers_service_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `package_resources`
--
ALTER TABLE `package_resources`
  ADD CONSTRAINT `package_resources_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`),
  ADD CONSTRAINT `package_resources_ibfk_2` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`resource_id`);

--
-- Constraints for table `service_requests`
--
ALTER TABLE `service_requests`
  ADD CONSTRAINT `service_requests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `service_requests_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`),
  ADD CONSTRAINT `service_requests_ibfk_3` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `sh_password_resets`
--
ALTER TABLE `sh_password_resets`
  ADD CONSTRAINT `sh_password_resets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `sh_remember_tokens`
--
ALTER TABLE `sh_remember_tokens`
  ADD CONSTRAINT `sh_remember_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`);

--
-- Constraints for table `user_chapter_data`
--
ALTER TABLE `user_chapter_data`
  ADD CONSTRAINT `user_chapter_data_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_chapter_data_ibfk_2` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_chapter_data_ibfk_3` FOREIGN KEY (`field_id`) REFERENCES `chapter_fields` (`field_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_goals`
--
ALTER TABLE `user_goals`
  ADD CONSTRAINT `user_goals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `user_packages`
--
ALTER TABLE `user_packages`
  ADD CONSTRAINT `user_packages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `user_packages_ibfk_2` FOREIGN KEY (`package_id`) REFERENCES `packages` (`package_id`),
  ADD CONSTRAINT `user_packages_ibfk_3` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`);

--
-- Constraints for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_slug_history`
--
ALTER TABLE `user_slug_history`
  ADD CONSTRAINT `user_slug_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
