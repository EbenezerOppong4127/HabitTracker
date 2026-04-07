-- Add Kanban Status column to existing Habits table
-- Run in phpMyAdmin → habittracker → SQL tab

ALTER TABLE `Habits`
    ADD COLUMN `Status` INT NOT NULL DEFAULT 0
    AFTER `Frequency`;
