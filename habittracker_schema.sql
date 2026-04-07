-- HabitTracker Database Schema
-- Import this file in phpMyAdmin: select the 'habittracker' database, go to SQL tab, paste and run.

SET NAMES utf8mb4;
SET foreign_key_checks = 0;

-- EF Core migration tracking
CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) NOT NULL,
    `ProductVersion` varchar(32) NOT NULL,
    PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Identity: Roles
CREATE TABLE IF NOT EXISTS `AspNetRoles` (
    `Id` varchar(127) NOT NULL,
    `Name` varchar(191) DEFAULT NULL,
    `NormalizedName` varchar(191) DEFAULT NULL,
    `ConcurrencyStamp` longtext DEFAULT NULL,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Identity: Users
CREATE TABLE IF NOT EXISTS `AspNetUsers` (
    `Id` varchar(127) NOT NULL,
    `DisplayName` longtext NOT NULL,
    `UserName` varchar(191) DEFAULT NULL,
    `NormalizedUserName` varchar(191) DEFAULT NULL,
    `Email` varchar(191) DEFAULT NULL,
    `NormalizedEmail` varchar(191) DEFAULT NULL,
    `EmailConfirmed` tinyint(1) NOT NULL DEFAULT 0,
    `PasswordHash` longtext DEFAULT NULL,
    `SecurityStamp` longtext DEFAULT NULL,
    `ConcurrencyStamp` longtext DEFAULT NULL,
    `PhoneNumber` longtext DEFAULT NULL,
    `PhoneNumberConfirmed` tinyint(1) NOT NULL DEFAULT 0,
    `TwoFactorEnabled` tinyint(1) NOT NULL DEFAULT 0,
    `LockoutEnd` datetime(6) DEFAULT NULL,
    `LockoutEnabled` tinyint(1) NOT NULL DEFAULT 1,
    `AccessFailedCount` int NOT NULL DEFAULT 0,
    PRIMARY KEY (`Id`),
    UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
    KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Identity: Role Claims
CREATE TABLE IF NOT EXISTS `AspNetRoleClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `RoleId` varchar(127) NOT NULL,
    `ClaimType` longtext DEFAULT NULL,
    `ClaimValue` longtext DEFAULT NULL,
    PRIMARY KEY (`Id`),
    KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
    CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId`
        FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Identity: User Claims
CREATE TABLE IF NOT EXISTS `AspNetUserClaims` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `UserId` varchar(127) NOT NULL,
    `ClaimType` longtext DEFAULT NULL,
    `ClaimValue` longtext DEFAULT NULL,
    PRIMARY KEY (`Id`),
    KEY `IX_AspNetUserClaims_UserId` (`UserId`),
    CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId`
        FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Identity: User Logins (external providers)
CREATE TABLE IF NOT EXISTS `AspNetUserLogins` (
    `LoginProvider` varchar(127) NOT NULL,
    `ProviderKey` varchar(127) NOT NULL,
    `ProviderDisplayName` longtext DEFAULT NULL,
    `UserId` varchar(127) NOT NULL,
    PRIMARY KEY (`LoginProvider`, `ProviderKey`),
    KEY `IX_AspNetUserLogins_UserId` (`UserId`),
    CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId`
        FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Identity: User Roles (junction)
CREATE TABLE IF NOT EXISTS `AspNetUserRoles` (
    `UserId` varchar(127) NOT NULL,
    `RoleId` varchar(127) NOT NULL,
    PRIMARY KEY (`UserId`, `RoleId`),
    KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
    CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId`
        FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
    CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId`
        FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Identity: User Tokens (2FA, etc.)
CREATE TABLE IF NOT EXISTS `AspNetUserTokens` (
    `UserId` varchar(127) NOT NULL,
    `LoginProvider` varchar(127) NOT NULL,
    `Name` varchar(127) NOT NULL,
    `Value` longtext DEFAULT NULL,
    PRIMARY KEY (`UserId`, `LoginProvider`, `Name`),
    CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId`
        FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- App: Habits
CREATE TABLE IF NOT EXISTS `Habits` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `Name` varchar(100) NOT NULL,
    `Description` varchar(500) NOT NULL DEFAULT '',
    `Frequency` int NOT NULL DEFAULT 0,
    `UserId` longtext NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- App: Habit Logs (daily completion tracking)
CREATE TABLE IF NOT EXISTS `HabitLogs` (
    `Id` int NOT NULL AUTO_INCREMENT,
    `HabitId` int NOT NULL,
    `Date` datetime(6) NOT NULL,
    `Completed` tinyint(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`Id`),
    KEY `IX_HabitLogs_HabitId` (`HabitId`),
    CONSTRAINT `FK_HabitLogs_Habits_HabitId`
        FOREIGN KEY (`HabitId`) REFERENCES `Habits` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tell EF Core this migration is applied (so it won't try to re-run it)
INSERT IGNORE INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
VALUES ('20260406014418_InitialCreate', '8.0.0');

SET foreign_key_checks = 1;
