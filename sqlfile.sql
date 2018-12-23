CREATE DATABASE DelhiMetro;

USE DelhiMetro;

CREATE TABLE Passenger(
  PassengerID int(11) NOT NULL AUTO_INCREMENT,
  Name varchar(20) DEFAULT NULL,
  DOB date DEFAULT NULL,
  House_No varchar(30) DEFAULT NULL,
  Street varchar(30) DEFAULT NULL,
  City varchar(20) DEFAULT 'New Delhi',
  PINCODE int(11) DEFAULT NULL,
  PRIMARY KEY (PassengerID)
);

INSERT INTO Passenger VALUES(1000,'Ashwini Jha','1998-09-04','186','Sector-11, Rohini','New Delhi',110085);


CREATE TABLE Stations(
  Station_ID char(3) NOT NULL,
  Name varchar(20) DEFAULT NULL,
  Parking_Facility tinyint(1) DEFAULT '0',
  Feeder_Bus_Availability tinyint(1) DEFAULT '0',
  Distance_from_Rithala int(11) DEFAULT NULL,
  PRIMARY KEY (Station_ID)
);

INSERT INTO Stations VALUES('RTH','Rithala',1,1,0);
INSERT INTO Stations VALUES('RHW','Rohini West',1,1,1);
INSERT INTO Stations VALUES('RHE','Rohini East',0,0,2);
INSERT INTO Stations VALUES('PTM','Pitampura',1,1,3);

CREATE TABLE Account (
  PassengerId int(11) NOT NULL,
  password varchar(30) NOT NULL,
  PRIMARY KEY (PassengerId)
);

CREATE TABLE Wallet (
  PassengerID int(11) DEFAULT NULL,
  difference int(11) DEFAULT '0',
  Balance int(11) DEFAULT '0',
  transaction_time datetime DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE adminlogin (
  Admin_ID int(11) NOT NULL AUTO_INCREMENT,
  password varchar(20) DEFAULT NULL,
  Name varchar(20) DEFAULT NULL,
  PRIMARY KEY (Admin_ID)
);

CREATE TABLE notifications (
  Notification_ID int(11) NOT NULL AUTO_INCREMENT,
  Post varchar(500) DEFAULT NULL,
  Admin_ID int(11) DEFAULT NULL,
  PRIMARY KEY (Notification_ID)
);

CREATE VIEW notify AS select Notification_ID, Post, Admin_ID from notifications order by Notification_ID desc;


DELIMITER $$
DROP PROCEDURE TicketPrice $$
CREATE PROCEDURE TicketPrice(
 IN S1 int,IN S2 int)
BEGIN
 SELECT IF(ABS(S2-S1)>=4, 15+(ABS(S2-S1)-4)*2,15);
END$$
DELIMITER ;

call TicketPrice(16,5);

DELIMITER $$
CREATE PROCEDURE Balance(
 IN pID int)
BEGIN
 SELECT Balance FROM Wallet WHERE PassengerID=pID ORDER BY transaction_time DESC LIMIT 1;
END$$
DELIMITER ;

--trigger
Passenger_AFTER_INSERT | INSERT | Passenger | BEGIN
insert into Wallet(PassengerID) values (new.PassengerID);
END | AFTER  | 2018-11-11 23:49:51.93 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci