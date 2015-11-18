USE DVDCollection
GO

CREATE PROCEDURE AddMovie 
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

CREATE PROCEDURE AddMovieDirector
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

CREATE PROCEDURE AddMovieActor
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

-- ADD MOVIE TO THE INVENTORY TABLE

CREATE PROCEDURE AddMovieToInventory
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

-- ADD DIRECTOR TO DIRECTORS TABLE

CREATE PROCEDURE AddDirector
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

-- ADD ACTOR TO DATABASE STORED PROCEDURE

CREATE PROCEDURE AddActor
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

-- ADD STUDIO TO DATABASE STORED PROCEDURE

CREATE PROCEDURE AddStudio
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

-- ADD USER TO DATABASE STORED PROCEDURE

CREATE PROCEDURE AddUser
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

--get movie list
create procedure GetMovieList
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
go

--get movie by ID
create procedure GetMovieByID 
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
go

--delete movie
create procedure DeleteMovie
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
go

-- GET RENTAL HISTORY STORED PROC
CREATE PROCEDURE GetRentalHistory

AS
BEGIN
	SELECT rh.RentalID, rh.DateBorrowed, rh.DateReturned, rh.SerialNumberID, m.Title, u.FirstName + ' ' + u.LastName as Name 
	FROM RentalHistory rh
	Left Join Inventory i ON rh.SerialNumberID = i.SerialNumberID
	Inner Join Movies m ON i.MovieID = m.MovieID
	Inner Join Users u ON rh.UserID = u.UserID
END
GO

-- GET USER MOVIES OUT FOR RENT

CREATE PROCEDURE GetUserOutForRent
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

-- RETURN MOVIE BY RENTAL ID
CREATE PROCEDURE ReturnMovieByRentalID
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

--GET USERS
CREATE PROCEDURE GetUsers

AS
BEGIN
	SELECT UserID, FirstName + ' ' + LastName as Name
	FROM Users
	ORDER BY FirstName

END
GO

-- GET MOVIE DETAILS BY INVENTORY ID
CREATE PROCEDURE GetMovieByInventoryID
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

-- GET MOVIE DETAILS BY RentalID
CREATE PROCEDURE GetMovieByRentalID
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

-- Add Movie Rating
CREATE PROCEDURE AddMovieRating
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

-- Add Movie Rating
CREATE PROCEDURE AddUserNote
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

-- Retrieve Movie Collection For Borrower
CREATE PROCEDURE GetMovieListForBorrower

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

--Retrieve Movie Rating Notes By MovieID
CREATE PROCEDURE GetMovieNotesByID (@MovieID int)

AS
BEGIN
  SELECT (u.FirstName + ' ' + u.LastName) AS Name, r.Rating, n.NoteDescription, mr.DateRated FROM MovieRatings mr
  INNER JOIN Users u ON mr.UserID = u.UserID
  INNER JOIN Ratings r ON mr.RatingID = r.RatingID
  INNER JOIN Notes n ON mr.UserID = n.UserID
  WHERE mr.MovieID = @MovieID
END
GO

--RentDVD by UserID and MovieID
CREATE PROCEDURE FindAvailableCopy (@MovieID int)

AS 
BEGIN 

SELECT TOP 1 SerialNumberID FROM Inventory 
WHERE MovieId = @MovieID AND Active = 1 AND OutForRent = 0

END 
GO

CREATE PROCEDURE MarkAsRented (@SerialNumberID int)

AS 
BEGIN 

UPDATE Inventory 
SET OutForRent = 1
WHERE SerialNumberID = @SerialNumberID

END
GO

CREATE PROCEDURE AddToRentalHistory (@UserID int, @SerialNumberID int)

AS 
BEGIN

INSERT INTO RentalHistory (DateBorrowed, UserID, SerialNumberID)
VALUES(GetDate(), @UserID, @SerialNumberID)

END
GO

CREATE PROCEDURE GetUserNotesByMovieID (@MovieID int)

AS
BEGIN

  SELECT (u.FirstName + ' ' + u.LastName) AS Name, n.DateOfNote, n.NoteDescription FROM Notes n
  INNER JOIN Users u on n.UserID = u.UserID
  WHERE n.MovieID = @MovieID

END
GO

CREATE PROCEDURE GetMovieRatingList (@MovieID int)

AS
BEGIN

  SELECT RatingID FROM MovieRatings
  WHERE MovieID = @MovieID

END
GO
