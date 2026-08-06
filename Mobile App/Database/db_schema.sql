-- Create Database
CREATE DATABASE IF NOT EXISTS reavaya_app;
USE reavaya_app;

-- 1. Standard Commuter Users Table
CREATE TABLE IF NOT EXISTS users_table (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    age INT,
    points_balance INT DEFAULT 0,
    qr_code VARCHAR(255),
    user_password VARCHAR(255) NOT NULL,
    is_active TINYINT DEFAULT 1,
    created_at DATETIME,
    updated_at DATETIME,
    last_login DATETIME,
    last_updated DATETIME
);

-- 2. Manager / Staff Users Table
CREATE TABLE IF NOT EXISTS manager_users_table (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    manager_id VARCHAR(50) UNIQUE NOT NULL,
    user_name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    qr_code VARCHAR(255),
    user_password VARCHAR(255) NOT NULL,
    is_active TINYINT DEFAULT 1,
    created_at DATETIME,
    updated_at DATETIME,
    last_login DATETIME,
    last_updated DATETIME
);

-- 3. Transactions Table
CREATE TABLE IF NOT EXISTS trasaction_table (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    email VARCHAR(150) NOT NULL,
    amount INT NOT NULL,
    Points INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (User_ID) REFERENCES users_table(user_id) ON DELETE CASCADE
);

-- 4. Commuter Feedback Table
CREATE TABLE IF NOT EXISTS feedback_table (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    cleanliness INT,
    driver INT,
    comments TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users_table(user_id) ON DELETE CASCADE
);

-- 5. Pickup Locations Table
CREATE TABLE IF NOT EXISTS locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL
);

-- 6. QR Code Validation Table
CREATE TABLE IF NOT EXISTS QrCodes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Qr VARCHAR(255) NOT NULL
);