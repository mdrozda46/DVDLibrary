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
	@LastName varchar(30)
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
END
GO

--get movie list
create procedure GetMovieList
as
begin
select distinct m.MovieID, m.Title, mp.MPAARating, g.Genre, m.RunTime, d.FirstName as [DirectorFirstName], d.LastName as [DirectorLastName], s.Name,
	  (select count(*) from Inventory i where i.MovieID = m.MovieID and i.OutForRent = 0) as UnitsInStock, 
	  (select avg(mr.RatingID) from MovieRatings mr where mr.MovieID = m.MovieID) as UserRating
	    from Movies m	
	inner join MPAARatings mp on m.MPAARatingID = mp.MPAARatingID
	inner join Genres g	on m.GenreID = g.GenreID
	inner join Inventory i on m.MovieID = i.MovieID
	inner join MovieDirectors md on m.MovieID = md.MovieID
	inner join Directors d on d.DirectorID = md.DirectorID
	inner join Studios s on s.StudioID = m.StudioID
	where i.Active = 1
end
go

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
