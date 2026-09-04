-- =============================================================================
-- LOGISTICS WEB APP RELATIONAL ARCHITECTURE MODEL (SYSTEM RETROSPECTIVE)
-- =============================================================================

-- Table 1: Core Bookings Allocation Registry
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` BIGINT UNSIGNED NOT NULL,
  `driver_id` BIGINT UNSIGNED DEFAULT NULL,
  `service_type` ENUM('parcel', 'freight', 'furniture', 'tow_truck', 'taxi') NOT NULL,
  `order_total` DECIMAL(12,2) NOT NULL,
  `currency_symbol` VARCHAR(5) NOT NULL DEFAULT '$',
  `status` ENUM('pending', 'assigned', 'in_transit', 'completed', 'cancelled') NOT NULL DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_driver_status` (`driver_id`, `status`),
  INDEX `idx_customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 2: Decentralized System Notification Definitions (Dynamic Controls)
CREATE TABLE IF NOT EXISTS `system_notifications` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `notification_type` ENUM('system', 'service', 'driver') NOT NULL,
  `template_slug` VARCHAR(50) NOT NULL UNIQUE,
  `sms_body` TEXT DEFAULT NULL,
  `email_html_content` LONGTEXT DEFAULT NULL,
  `is_editable_from_portal` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table 3: Secure FinTech Gateway API Token Hashing Registers
CREATE TABLE IF NOT EXISTS `gateway_api_settings` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gateway_provider` ENUM('pesepay', '543_konse', 'sms_primary') NOT NULL,
  `environment_mode` ENUM('test', 'live') NOT NULL DEFAULT 'test',
  `public_client_key` VARCHAR(255) NOT NULL,
  `encrypted_secret_hash` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

