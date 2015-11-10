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