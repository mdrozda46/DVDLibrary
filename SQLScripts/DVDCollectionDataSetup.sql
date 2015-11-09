--************** Uncomment this section to drop the table*************
--USE master
--go
--DROP DATABASE DVDCollection
--go
--*********************************************************************


-- **********************************
-- Create All Tables
-- **********************************
USE master
GO
CREATE DATABASE DVDCollection
GO

USE DVDCollection
GO

CREATE TABLE dbo.MPAARatings(
MPAARatingID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
MPAARating varchar(5) NOT NULL
)

GO
INSERT INTO dbo.MPAARatings (MPAARating)
	VALUES 
	 ('G'), ('PG'), ('PG-13'), ('R'), ('NC-17') 

GO
CREATE TABLE dbo.Ratings(
	RatingID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Rating int NOT NULL
	)

GO
INSERT INTO dbo.Ratings (Rating)
	VALUES 
	 (1), (2), (3), (4), (5) 

GO
CREATE TABLE dbo.Studios(
	StudioID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name varchar(50) NOT NULL
)

GO
CREATE TABLE dbo.Users(
	UserID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL
)

GO
CREATE TABLE dbo.Actors(
	ActorID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL
)

GO
CREATE TABLE dbo.Directors(
	DirectorID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL
)

GO
CREATE TABLE dbo.Movies(
	MovieID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Title varchar(30) NOT NULL,
	DateReleased Date NOT NULL,
	MPAARatingID int
	CONSTRAINT FK_RatingID FOREIGN KEY (MPAARatingID) 
		REFERENCES dbo.MPAARatings (MPAARatingID),
	StudioID int
	CONSTRAINT FK_StudioID FOREIGN KEY (StudioID) 
		REFERENCES dbo.Studios (StudioID)
)

GO
CREATE TABLE dbo.MovieRatings(
	MovieRatingID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DateRated Date NOT NULL,
	RatingID int,
	CONSTRAINT FK_RatingID2 FOREIGN KEY (RatingID) 
		REFERENCES dbo.Ratings (RatingID),
	MovieID int
	CONSTRAINT FK_MovieID FOREIGN KEY (MovieID) 
		REFERENCES dbo.Movies (MovieID),
	UserID int
	CONSTRAINT FK_UserID FOREIGN KEY (UserID) 
		REFERENCES dbo.Users (UserID)
)

GO
CREATE TABLE dbo.MovieCast(
	MovieCastID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ActorID int
	CONSTRAINT FK_ActorID FOREIGN KEY (ActorID) 
		REFERENCES dbo.Actors(ActorID),
	MovieID int
	CONSTRAINT FK_MovieID4 FOREIGN KEY (MovieID) 
		REFERENCES dbo.Movies (MovieID)
)

CREATE TABLE dbo.MovieDirectors(
	MovieDirectorsID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DirectorID int
	CONSTRAINT FK_DirectorID FOREIGN KEY (DirectorID) 
		REFERENCES dbo.Directors(DirectorID),
	MovieID int
	CONSTRAINT FK_MovieID2 FOREIGN KEY (MovieID) 
		REFERENCES dbo.Movies (MovieID)
)

GO
CREATE TABLE dbo.Notes(
	NoteID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NoteDescription varchar(500) NOT NULL,
	DateOfNote Date NOT NULL,
	UserID int
	CONSTRAINT FK_UserID2 FOREIGN KEY (UserID) 
		REFERENCES dbo.Users (UserID),
	MovieID int
	CONSTRAINT FK_MovieID3 FOREIGN KEY (MovieID) 
		REFERENCES dbo.Movies (MovieID)
)

GO 
CREATE TABLE dbo.Inventory(
	SerialNumberID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	OutForRent bit NOT NULL,
	MovieID int
	CONSTRAINT FK_MovieID5 FOREIGN KEY (MovieID) 
		REFERENCES dbo.Movies (MovieID)
)

GO
CREATE TABLE dbo.RentalHistory(
	RentalID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DateBorrowed Date NOT NULL,
	DateReturned Date,
	UserID int
	CONSTRAINT FK_UserID3 FOREIGN KEY (UserID) 
		REFERENCES dbo.Users (UserID),
	SerialNumberID int
	CONSTRAINT FK_SerialNumberID FOREIGN KEY (SerialNumberID) 
		REFERENCES dbo.Inventory (SerialNumberID)
)

-- **********************************
-- Insert Sample Data
-- **********************************

INSERT INTO Users (FirstName, LastName)
	VALUES	
	('Mike', 'Drozda'),
	('Andrew', 'Tang'),
	('Scott', 'Benz'),
	('Rocco', 'Riccardi');

INSERT INTO Studios (Name)
	VALUES 
	('20th Century Fox'),
	('Walt Disney Studios'),
	('Miramax'),
	('Paramount Pictures'),
	('Sony Pictures'),
	('Warner Bros.'),
	('New Line Cinema'),
	('Universal Studios'),
	('MGM');

INSERT INTO Directors (FirstName, LastName)
	VALUES	
	('George', 'Lucas'),
	('Quentin', 'Tarantino'),
	('Steven', 'Spielberg'),
	('James', 'Cameron'),
	('Martin', 'Scrosese'),
	('Christopher', 'Nolan'),
	('Peter', 'Jackson');

INSERT INTO Actors (FirstName, LastName)
	VALUES	
	('Harrison', 'Ford'),
	('Mark', 'Hamill'),
	('Samuuel', 'Jackson'),
	('Bruce', 'Willis'),
	('John', 'Travolta'),
	('Sam', 'Worthington'),
	('Zoe', 'Saldana'),
	('Sigourney', 'Weaver');

INSERT INTO Movies (Title, DateReleased, MPAARatingID, StudioID)
	VALUES
	('Pulp Fiction', '10/14/1994', '4', '3'),
	('Avatar', '12/18/2009', '3', '1'),
	('Star Wars', '5/25/1977', '2', '1');

INSERT INTO MovieCast (ActorID, MovieID)
	VALUES
	('1', '3'),
	('2', '3'),
	('3', '1'),
	('4', '1'),
	('5', '1'),
	('6', '2'),
	('7', '2'),
	('8', '2');

INSERT INTO MovieDirectors(DirectorID, MovieID)
	VALUES
	('2', '1'),
	('4', '2'),
	('1', '3');

INSERT INTO Inventory(OutForRent, MovieID)
	VALUES
	('0', '1'),
	('0', '1'),
	('1', '1'),
	('0', '2'),
	('0', '2'),
	('0', '2'),
	('1', '3'),
	('1', '3'),
	('1', '3'),
	('1', '3'),
	('1', '3');

INSERT INTO MovieRatings(DateRated, RatingID, MovieID, UserID)
	VALUES
	('11/01/2015', '5', '3', '1'),
	('11/01/2015', '4', '3', '2'),
	('11/02/2015', '5', '3', '3'),
	('11/03/2015', '3', '3', '4'),
	('10/11/2015', '2', '2', '1'),
	('10/18/2015', '3', '2', '2'),
	('01/12/2015', '2', '1', '2'),
	('02/04/2015', '3', '1', '3'),
	('05/08/2015', '4', '2', '4'),
	('03/02/2015', '5', '1', '4'),
	('11/10/2015', '3', '3', '1');

INSERT INTO Notes (NoteDescription, DateOfNote, UserID, MovieID)
	VALUES
	('Great movie! Must see!', '11/01/2015', '1', '3'),
	('Terrible, do not waste your money.', '11/02/2015', '2', '2'),
	('My favorite movie of all time!', '09/01/2015', '3', '3'),
	('Best movie ever!', '08/01/2015', '4', '2');

INSERT INTO RentalHistory (DateBorrowed, DateReturned, UserID, SerialNumberID)
	VALUES
	('10/01/2015', '10/03/2015', '1', '3'),
	('10/01/2015', '10/03/2015', '3', '7'),
	('10/09/2015', '10/11/2015', '2', '11'),
	('10/10/2015', '10/12/2015', '4', '1'),
	('10/11/2015', '10/13/2015', '1', '2'),
	('10/12/2015', '10/14/2015', '3', '4'),
	('10/15/2015', '10/17/2015', '3', '5'),
	('10/26/2015', '10/26/2015', '2', '6'),
	('11/01/2015', Null, '4', '3'),
	('11/02/2015', Null, '1', '7'),
	('11/03/2015', Null, '1', '8'),
	('11/03/2015', Null, '2', '9'),
	('11/04/2015', Null, '3', '10'),
	('11/05/2015', Null, '4', '11');