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
