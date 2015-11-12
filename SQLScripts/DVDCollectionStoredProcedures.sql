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
	@OutForRent bit
)
AS

BEGIN
	INSERT INTO dbo.Inventory
	(
		MovieID,
		OutForRent
	)
	VALUES
	(
		@MovieID,
		@OutForRent
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
	select distinct m.Title, mp.MPAARating, g.Genre, m.RunTime,
	  (select count(*) from Inventory i where i.MovieID = m.MovieID and i.OutForRent = 0) as UnitsInStock, 
	  (select avg(mr.RatingID) from MovieRatings mr where mr.MovieID = m.MovieID) as UserRating
	    from Movies m	
	inner join MPAARatings mp on m.MPAARatingID = mp.MPAARatingID
	inner join Genres g	on m.GenreID = g.GenreID
	inner join Inventory i on m.MovieID = i.MovieID
	where i.Active = 1
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
