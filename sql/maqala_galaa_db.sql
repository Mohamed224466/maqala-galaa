-- ملف SQL جاهز لمشروع مقلة الجلاء
-- يمكنك استيراد هذا الملف مباشرة في phpMyAdmin

-- 1. إنشاء قاعدة البيانات
CREATE DATABASE IF NOT EXISTS `maqala_galaa_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `maqala_galaa_db`;

-- 2. جدول الأقسام (Categories)
-- يحتوي على أقسام الماركت الرئيسية (منظفات، معلبات، زيوت، إلخ)
CREATE TABLE `categories` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name_ar` VARCHAR(255) NOT NULL UNIQUE,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `description_ar` TEXT,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 3. جدول المنتجات (Products)
-- يحتوي على جميع الأصناف وبيانات التسعير المرن
CREATE TABLE `products` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `category_id` BIGINT UNSIGNED NOT NULL,
  `name_ar` VARCHAR(255) NOT NULL,
  `sku` VARCHAR(255) UNIQUE,
  `description_ar` TEXT,
  `original_price` DECIMAL(10, 2), -- السعر قبل الخصم
  `wholesale_price` DECIMAL(10, 2), -- سعر البيع الفعلي
  `price_display_text` VARCHAR(255), -- نص بديل للسعر
  `discount_percentage` INT,
  `image` VARCHAR(255), -- مسار/اسم ملف الصورة
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 4. جدول الصفحات الديناميكية (Pages)
-- لإدارة صفحات العروض الجنونية وصفحات المحتوى (من نحن)
CREATE TABLE `pages` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title_ar` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL UNIQUE,
  `content_ar` LONGTEXT, -- محتوى المحرر WYSIWYG
  `is_special_offer` BOOLEAN NOT NULL DEFAULT FALSE, -- علامة للعروض الجنونية
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 5. جدول الحملات/العروض (Campaigns)
-- لإدارة المنتجات التي تظهر في صفحات العروض الجنونية
CREATE TABLE `campaigns` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `page_id` BIGINT UNSIGNED NOT NULL,
  `campaign_price` DECIMAL(10, 2) NOT NULL, -- السعر الخاص بالعرض
  `start_date` TIMESTAMP NULL,
  `end_date` TIMESTAMP NULL,
  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 6. جدول الفروع (Branches)
-- لحفظ عناوين وأرقام فروع مقلة الجلاء
CREATE TABLE `branches` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name_ar` VARCHAR(255) NOT NULL,
  `address_ar` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255),
  `Maps_link` VARCHAR(255),
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 7. جدول الإعدادات العامة (Settings)
-- لحفظ رقم الواتساب العام، وكود بث فيسبوك، إلخ.
CREATE TABLE `settings` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `setting_key` VARCHAR(255) NOT NULL UNIQUE,
  `setting_value` LONGTEXT,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;