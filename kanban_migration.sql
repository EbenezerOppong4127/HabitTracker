-- Add KanbanTasks table to HabitTracker database
-- Run this in phpMyAdmin → habittracker → SQL tab

CREATE TABLE IF NOT EXISTS `KanbanTasks` (
    `Id`          int          NOT NULL AUTO_INCREMENT,
    `Title`       varchar(200) NOT NULL,
    `Description` varchar(1000) NOT NULL DEFAULT '',
    `Status`      int          NOT NULL DEFAULT 0,
    `UserId`      longtext     NOT NULL,
    `CreatedAt`   datetime(6)  NOT NULL,
    PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
