USE [master]
GO
/****** Object:  Database [DVDCollection]    Script Date: 12/11/2015 9:45:25 AM ******/
CREATE DATABASE [DVDCollection]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DVDCollection', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\DVDCollection.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DVDCollection_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\DVDCollection_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DVDCollection] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DVDCollection].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DVDCollection] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DVDCollection] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DVDCollection] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DVDCollection] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DVDCollection] SET ARITHABORT OFF 
GO
ALTER DATABASE [DVDCollection] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DVDCollection] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DVDCollection] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DVDCollection] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DVDCollection] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DVDCollection] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DVDCollection] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DVDCollection] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DVDCollection] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DVDCollection] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DVDCollection] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DVDCollection] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DVDCollection] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DVDCollection] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DVDCollection] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DVDCollection] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DVDCollection] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DVDCollection] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DVDCollection] SET  MULTI_USER 
GO
ALTER DATABASE [DVDCollection] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DVDCollection] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DVDCollection] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DVDCollection] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DVDCollection] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DVDCollection]
GO
/****** Object:  Table [dbo].[Actors]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Actors](
	[ActorID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](30) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ActorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Directors]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Directors](
	[DirectorID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](30) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DirectorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Genres](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[Genre] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[SerialNumberID] [int] IDENTITY(1,1) NOT NULL,
	[OutForRent] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[MovieID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNumberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovieCast]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieCast](
	[MovieCastID] [int] IDENTITY(1,1) NOT NULL,
	[ActorID] [int] NULL,
	[MovieID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieCastID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovieDirectors]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieDirectors](
	[MovieDirectorsID] [int] IDENTITY(1,1) NOT NULL,
	[DirectorID] [int] NULL,
	[MovieID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieDirectorsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MovieRatings]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieRatings](
	[MovieRatingID] [int] IDENTITY(1,1) NOT NULL,
	[DateRated] [datetime] NOT NULL,
	[RatingID] [int] NULL,
	[MovieID] [int] NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieRatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movies]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](30) NOT NULL,
	[DateReleased] [datetime] NOT NULL,
	[RunTime] [int] NULL,
	[Synopsis] [text] NULL,
	[ImageURL] [text] NULL,
	[GenreID] [int] NULL,
	[OwnerRatingID] [int] NULL,
	[MPAARatingID] [int] NULL,
	[StudioID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MPAARatings]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MPAARatings](
	[MPAARatingID] [int] IDENTITY(1,1) NOT NULL,
	[MPAARating] [varchar](5) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MPAARatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notes]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notes](
	[NoteID] [int] IDENTITY(1,1) NOT NULL,
	[NoteDescription] [varchar](2000) NOT NULL,
	[DateOfNote] [datetime] NOT NULL,
	[UserID] [int] NULL,
	[MovieID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[NoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OwnerNotes]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OwnerNotes](
	[OwnerNoteID] [int] IDENTITY(1,1) NOT NULL,
	[NoteDescription] [varchar](500) NOT NULL,
	[DateOfNote] [datetime] NOT NULL,
	[MovieID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OwnerNoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ratings]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ratings](
	[RatingID] [int] IDENTITY(1,1) NOT NULL,
	[Rating] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RentalHistory]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RentalHistory](
	[RentalID] [int] IDENTITY(1,1) NOT NULL,
	[DateBorrowed] [datetime] NOT NULL,
	[DateReturned] [datetime] NULL,
	[UserID] [int] NULL,
	[SerialNumberID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RentalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Studios]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Studios](
	[StudioID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StudioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](30) NOT NULL,
	[LastName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD  CONSTRAINT [FK_MovieID5] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Inventory] CHECK CONSTRAINT [FK_MovieID5]
GO
ALTER TABLE [dbo].[MovieCast]  WITH CHECK ADD  CONSTRAINT [FK_ActorID] FOREIGN KEY([ActorID])
REFERENCES [dbo].[Actors] ([ActorID])
GO
ALTER TABLE [dbo].[MovieCast] CHECK CONSTRAINT [FK_ActorID]
GO
ALTER TABLE [dbo].[MovieCast]  WITH CHECK ADD  CONSTRAINT [FK_MovieID4] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[MovieCast] CHECK CONSTRAINT [FK_MovieID4]
GO
ALTER TABLE [dbo].[MovieDirectors]  WITH CHECK ADD  CONSTRAINT [FK_DirectorID] FOREIGN KEY([DirectorID])
REFERENCES [dbo].[Directors] ([DirectorID])
GO
ALTER TABLE [dbo].[MovieDirectors] CHECK CONSTRAINT [FK_DirectorID]
GO
ALTER TABLE [dbo].[MovieDirectors]  WITH CHECK ADD  CONSTRAINT [FK_MovieID2] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[MovieDirectors] CHECK CONSTRAINT [FK_MovieID2]
GO
ALTER TABLE [dbo].[MovieRatings]  WITH CHECK ADD  CONSTRAINT [FK_MovieID] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[MovieRatings] CHECK CONSTRAINT [FK_MovieID]
GO
ALTER TABLE [dbo].[MovieRatings]  WITH CHECK ADD  CONSTRAINT [FK_RatingID2] FOREIGN KEY([RatingID])
REFERENCES [dbo].[Ratings] ([RatingID])
GO
ALTER TABLE [dbo].[MovieRatings] CHECK CONSTRAINT [FK_RatingID2]
GO
ALTER TABLE [dbo].[MovieRatings]  WITH CHECK ADD  CONSTRAINT [FK_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[MovieRatings] CHECK CONSTRAINT [FK_UserID]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_GenreID] FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genres] ([GenreID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_GenreID]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_MPAARatingID] FOREIGN KEY([MPAARatingID])
REFERENCES [dbo].[MPAARatings] ([MPAARatingID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_MPAARatingID]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_OwnerRatingID] FOREIGN KEY([OwnerRatingID])
REFERENCES [dbo].[Ratings] ([RatingID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_OwnerRatingID]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [FK_StudioID] FOREIGN KEY([StudioID])
REFERENCES [dbo].[Studios] ([StudioID])
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [FK_StudioID]
GO
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_MovieID3] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_MovieID3]
GO
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_UserID2] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_UserID2]
GO
ALTER TABLE [dbo].[OwnerNotes]  WITH CHECK ADD  CONSTRAINT [FK_MovieID6] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[OwnerNotes] CHECK CONSTRAINT [FK_MovieID6]
GO
ALTER TABLE [dbo].[RentalHistory]  WITH CHECK ADD  CONSTRAINT [FK_SerialNumberID] FOREIGN KEY([SerialNumberID])
REFERENCES [dbo].[Inventory] ([SerialNumberID])
GO
ALTER TABLE [dbo].[RentalHistory] CHECK CONSTRAINT [FK_SerialNumberID]
GO
ALTER TABLE [dbo].[RentalHistory]  WITH CHECK ADD  CONSTRAINT [FK_UserID3] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RentalHistory] CHECK CONSTRAINT [FK_UserID3]
GO
/****** Object:  StoredProcedure [dbo].[AddActor]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ADD ACTOR TO DATABASE STORED PROCEDURE

CREATE PROCEDURE [dbo].[AddActor]
(
	@FirstName varchar(30),	
	@LastName varchar(30)
)
AS

BEGIN
	INSERT INTO dbo.Actors
	(
		FirstName,
		LastName
	)

	VALUES
	(
		@FirstName,
		@LastName
	)
END

GO
/****** Object:  StoredProcedure [dbo].[AddDirector]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ADD DIRECTOR TO DIRECTORS TABLE

CREATE PROCEDURE [dbo].[AddDirector]
(
	@FirstName varchar(30),	
	@LastName varchar(30)
)
AS

BEGIN
	INSERT INTO dbo.Directors
	(
		FirstName,
		LastName
	)

	VALUES
	(
		@FirstName,
		@LastName
	)
END

GO
/****** Object:  StoredProcedure [dbo].[AddMovie]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddMovie] 
(
	@Title varchar(30), 
	@DateReleased DateTime,
	@RunTime int,
	@Synopsis text,
	@ImageURL text, 
	@GenreID int,
	@OwnerRatingID int,
	@MPAARatingID int,
	@StudioID int,
	@MovieID int output
)
AS
	
BEGIN 

     INSERT INTO dbo.Movies
          ( 
            Title,
			DateReleased,
			RunTime,
			Synopsis,
			ImageURL,
			GenreID,
			OwnerRatingID,
			MPAARatingID,
			StudioID 
          ) 
     VALUES 
          ( 
			@Title,
			@DateReleased,
			@RunTime,
			@Synopsis,
			@ImageURL, 
			@GenreID,
			@OwnerRatingID,
			@MPAARatingID,
			@StudioID
          ) 
	 SET @MovieID = SCOPE_IDENTITY();
END 


GO
/****** Object:  StoredProcedure [dbo].[AddMovieActor]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddMovieActor]
(
	@MovieID int,
	@ActorID int
)
AS

BEGIN
	INSERT INTO dbo.MovieCast
	(
		MovieID,
		ActorID
	)
	VALUES
	(
		@MovieID,
		@ActorID
	)
END


GO
/****** Object:  StoredProcedure [dbo].[AddMovieDirector]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddMovieDirector]
(
	@MovieID int,
	@DirectorID int
)
AS

BEGIN
	INSERT INTO dbo.MovieDirectors
	(
		MovieID,
		DirectorID
	)
	VALUES
	(
		@MovieID,
		@DirectorID
	)
END


GO
/****** Object:  StoredProcedure [dbo].[AddMovieRating]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Add Movie Rating
CREATE PROCEDURE [dbo].[AddMovieRating]
(
	@Rating int,
	@MovieID int,
	@UserID int
)

AS
BEGIN
	
	INSERT INTO dbo.MovieRatings
          ( 
            DateRated,RatingID,MovieID,UserID
          ) 
     VALUES 
          ( 
			GETDATE(),
			@Rating,
			@MovieID,
			@UserID
		   )
			
END

GO
/****** Object:  StoredProcedure [dbo].[AddMovieToInventory]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ADD MOVIE TO THE INVENTORY TABLE

CREATE PROCEDURE [dbo].[AddMovieToInventory]
(
	@MovieID int,
	@OutForRent bit,
	@Active bit
)
AS

BEGIN
	INSERT INTO dbo.Inventory
	(
		MovieID,
		OutForRent,
		Active
	)
	VALUES
	(
		@MovieID,
		@OutForRent,
		@Active
	)
END


GO
/****** Object:  StoredProcedure [dbo].[AddStudio]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ADD STUDIO TO DATABASE STORED PROCEDURE

CREATE PROCEDURE [dbo].[AddStudio]
(
	@Name varchar(50)	
)
AS

BEGIN
	INSERT INTO dbo.Studios
	(
		Name
	)

	VALUES
	(
		@Name
	)
END

GO
/****** Object:  StoredProcedure [dbo].[AddToRentalHistory]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddToRentalHistory] (@UserID int, @SerialNumberID int)

AS 
BEGIN

INSERT INTO RentalHistory (DateBorrowed, UserID, SerialNumberID)
VALUES(GetDate(), @UserID, @SerialNumberID)

END

GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ADD USER TO DATABASE STORED PROCEDURE

CREATE PROCEDURE [dbo].[AddUser]
(
	@FirstName varchar(30),	
	@LastName varchar(30),
	@UserID int output
)
AS

BEGIN
	INSERT INTO dbo.Users
	(
		FirstName,
		LastName
	)

	VALUES
	(
		@FirstName,
		@LastName
	)
	SET @UserID = SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[AddUserNote]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Add Movie Rating
CREATE PROCEDURE [dbo].[AddUserNote]
(
	@NoteDescription varchar(2000),
	@MovieID int,
	@UserID int
)

AS
BEGIN
	
	INSERT INTO dbo.Notes
          ( 
            NoteDescription, DateOfNote, UserID, MovieID
          ) 
     VALUES 
          ( 
			@NoteDescription,
			GETDATE(),
			@UserID,
			@MovieID
		   )
			
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteMovie]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--delete movie
create procedure [dbo].[DeleteMovie]
(
	@MovieID int
)
as
begin
update Inventory
set Active = 0
from Inventory i
	inner join Movies m on m.MovieID = i.MovieID
where m.MovieID = @MovieID
end

GO
/****** Object:  StoredProcedure [dbo].[FindAvailableCopy]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--RentDVD by UserID and MovieID
CREATE PROCEDURE [dbo].[FindAvailableCopy] (@MovieID int)

AS 
BEGIN 

SELECT TOP 1 SerialNumberID FROM Inventory 
WHERE MovieId = @MovieID AND Active = 1 AND OutForRent = 0

END 

GO
/****** Object:  StoredProcedure [dbo].[GetMovieByID]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--get movie by ID
create procedure [dbo].[GetMovieByID] 
(
	@MovieID int
)
as
begin
select distinct m.MovieID, m.Title, m.DateReleased, mp.MPAARating, g.Genre, m.RunTime, s.Name as Studio,
	  (select count(*) from Inventory i where i.MovieID = m.MovieID and i.OutForRent = 0) as UnitsInStock, 
	  (select avg(mr.RatingID) from MovieRatings mr where mr.MovieID = m.MovieID) as UserRating,
	  (select r.Rating from Ratings r where m.OwnerRatingID = r.RatingID) as OwnerRating
	    from Movies m	
	inner join MPAARatings mp on m.MPAARatingID = mp.MPAARatingID
	inner join Genres g	on m.GenreID = g.GenreID
	inner join Inventory i on m.MovieID = i.MovieID	
	inner join Studios s on s.StudioID = m.StudioID
	where i.Active = 1 AND m.MovieID = @MovieID
end

GO
/****** Object:  StoredProcedure [dbo].[GetMovieByInventoryID]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- GET MOVIE DETAILS BY INVENTORY ID
CREATE PROCEDURE [dbo].[GetMovieByInventoryID]
(
@InventoryID int
)

AS
BEGIN
	SELECT @InventoryID as InventoryID, m.MovieID, m.Title, m.ImageURL, m.Synopsis
	FROM Movies m
	WHERE m.MovieID = (SELECT i.MovieID	
						FROM Inventory i 
						WHERE i.SerialNumberID = @InventoryID)
END

GO
/****** Object:  StoredProcedure [dbo].[GetMovieByRentalID]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- GET MOVIE DETAILS BY RentalID
CREATE PROCEDURE [dbo].[GetMovieByRentalID]
(
@RentalID int
)

AS
BEGIN
	SELECT @RentalID as RentalID, m.MovieID, m.Title, m.ImageURL, m.Synopsis
	FROM Movies m
	WHERE m.MovieID = (SELECT i.MovieID	
						FROM Inventory i 
						WHERE i.SerialNumberID = 
							(SELECT rh.SerialNumberID
							FROM RentalHistory rh
							WHERE rh.RentalID = @RentalID))
END

GO
/****** Object:  StoredProcedure [dbo].[GetMovieList]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--get movie list
create procedure [dbo].[GetMovieList]
as
begin
select distinct m.MovieID, m.Title, mp.MPAARating, g.Genre, m.RunTime, s.Name,
	  (select count(*) from Inventory i where i.MovieID = m.MovieID and i.OutForRent = 0) as UnitsInStock, 
	  (select avg(mr.RatingID) from MovieRatings mr where mr.MovieID = m.MovieID) as UserRating
	    from Movies m	
	inner join MPAARatings mp on m.MPAARatingID = mp.MPAARatingID
	inner join Genres g	on m.GenreID = g.GenreID
	inner join Inventory i on m.MovieID = i.MovieID
	inner join Studios s on s.StudioID = m.StudioID
	where i.Active = 1
end

GO
/****** Object:  StoredProcedure [dbo].[GetMovieListForBorrower]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Retrieve Movie Collection For Borrower
CREATE PROCEDURE [dbo].[GetMovieListForBorrower]

AS
BEGIN

	SELECT m.MovieID, m.Title, mp.MPAARating, g.Genre, m.RunTime, r.Rating, COUNT(m.MovieID) as NumberOfCopies, 
	COUNT(CASE WHEN i.OutForRent = 0 THEN 1 END) as NumberAvailable
	FROM Movies m
	INNER JOIN Genres g ON m.GenreID = g.GenreID
	INNER JOIN Ratings r ON m.OwnerRatingID = r.RatingID
	INNER JOIN MPAARatings mp ON m.MPAARatingID = mp.MPAARatingID
	INNER JOIN Inventory i ON m.MovieID = i.MovieID
	WHERE i.Active = 1
	GROUP BY m.MovieID, m.Title, mp.MPAARating, g.Genre, m.RunTime, r.Rating

END 

GO
/****** Object:  StoredProcedure [dbo].[GetMovieNotesByID]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Retrieve Movie Rating Notes By MovieID
CREATE PROCEDURE [dbo].[GetMovieNotesByID] (@MovieID int)

AS
BEGIN
  SELECT (u.FirstName + ' ' + u.LastName) AS Name, r.Rating, n.NoteDescription, mr.DateRated FROM MovieRatings mr
  INNER JOIN Users u ON mr.UserID = u.UserID
  INNER JOIN Ratings r ON mr.RatingID = r.RatingID
  INNER JOIN Notes n ON mr.UserID = n.UserID
  WHERE mr.MovieID = @MovieID
END

GO
/****** Object:  StoredProcedure [dbo].[GetMovieRatingList]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMovieRatingList] (@MovieID int)

AS
BEGIN

  SELECT RatingID FROM MovieRatings
  WHERE MovieID = @MovieID

END

GO
/****** Object:  StoredProcedure [dbo].[GetRentalHistory]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- GET RENTAL HISTORY STORED PROC
CREATE PROCEDURE [dbo].[GetRentalHistory]

AS
BEGIN
	SELECT rh.RentalID, rh.DateBorrowed, rh.DateReturned, rh.SerialNumberID, m.Title, u.FirstName + ' ' + u.LastName as Name 
	FROM RentalHistory rh
	Left Join Inventory i ON rh.SerialNumberID = i.SerialNumberID
	Inner Join Movies m ON i.MovieID = m.MovieID
	Inner Join Users u ON rh.UserID = u.UserID
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserNotesByMovieID]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserNotesByMovieID] (@MovieID int)

AS
BEGIN

  SELECT (u.FirstName + ' ' + u.LastName) AS Name, n.DateOfNote, n.NoteDescription FROM Notes n
  INNER JOIN Users u on n.UserID = u.UserID
  WHERE n.MovieID = @MovieID

END

GO
/****** Object:  StoredProcedure [dbo].[GetUserOutForRent]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- GET USER MOVIES OUT FOR RENT

CREATE PROCEDURE [dbo].[GetUserOutForRent]
(
	@UserID int
)

AS
BEGIN
	Select rh.RentalID, m.Title, rh.DateBorrowed
	FROM RentalHistory rh
	left join Inventory i ON rh.SerialNumberID = i.SerialNumberID
	inner join Movies m ON i.MovieID = m.MovieID 
	WHERE rh.UserID = @UserID AND rh.DateReturned is NULL
END

GO
/****** Object:  StoredProcedure [dbo].[GetUsers]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--GET USERS
CREATE PROCEDURE [dbo].[GetUsers]

AS
BEGIN
	SELECT UserID, FirstName + ' ' + LastName as Name
	FROM Users
	ORDER BY FirstName

END

GO
/****** Object:  StoredProcedure [dbo].[MarkAsRented]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MarkAsRented] (@SerialNumberID int)

AS 
BEGIN 

UPDATE Inventory 
SET OutForRent = 1
WHERE SerialNumberID = @SerialNumberID

END

GO
/****** Object:  StoredProcedure [dbo].[ReturnMovieByRentalID]    Script Date: 12/11/2015 9:45:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- RETURN MOVIE BY RENTAL ID
CREATE PROCEDURE [dbo].[ReturnMovieByRentalID]
(
	@RentalID int
)

AS
BEGIN

	UPDATe RentalHistory 
	SET DateReturned = GETDATE()
	WHERE RentalID = @RentalID

	UPDATe Inventory
	SET OutForRent = '0'
	WHERE SerialNumberID = (Select  rh.SerialNumberID FROM RentalHistory rh WHERE rh.RentalID = @RentalID)
END

GO
USE [master]
GO
ALTER DATABASE [DVDCollection] SET  READ_WRITE 
GO
