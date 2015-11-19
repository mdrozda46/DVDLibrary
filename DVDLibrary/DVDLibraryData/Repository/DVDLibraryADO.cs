using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using DVDLibraryData.Config;
using DVDLibraryModels;

namespace DVDLibraryData.Repository
{
    public class DVDLibraryADO
    {
        public List<MPAARatingModel> GetMPAARatings()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var MPAARatings =
                    cn.Query<MPAARatingModel>("select mp.MPAARatingID, mp.MPAARating from MPAARatings mp").ToList();

                return MPAARatings;
            }
        }

        public List<GenreModel> GetGenres()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Genres = cn.Query<GenreModel>("select g.GenreID, g.Genre from Genres g").ToList();

                return Genres;
            }
        }

        public List<DirectorModel> GetDirectors()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Directors =
                    cn.Query<DirectorModel>("select d.DirectorID, d.FirstName, d.LastName from Directors d").ToList();

                return Directors;
            }
        }

        public List<ActorModel> GetActors()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Actors = cn.Query<ActorModel>("select d.ActorID, d.FirstName, d.LastName from Actors d").ToList();

                return Actors;
            }
        }

        public List<Studio> GetStudios()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Studios = cn.Query<Studio>("select * from Studios").ToList();

                return Studios;
            }
        }

        public List<RatingModel> GetRatings()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Ratings = cn.Query<RatingModel>("select * from Ratings").ToList();

                return Ratings;
            }
        }

        public int AddMovieToDB(string title, DateTime dateReleased, int runTime, string synopsis, string imageUrl,
            int genreId, int ownerRatingId, int MPAARatingId, int studioId)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("Title", title);
                p.Add("DateReleased", dateReleased);
                p.Add("RunTime", runTime);
                p.Add("Synopsis", synopsis);
                p.Add("imageUrl", imageUrl);
                p.Add("GenreID", genreId);
                p.Add("OwnerRatingID", ownerRatingId);
                p.Add("MPAARatingID", MPAARatingId);
                p.Add("StudioID", studioId);
                p.Add("MovieID", DbType.Int32, direction: ParameterDirection.Output);

                cn.Execute("AddMovie", p, commandType: CommandType.StoredProcedure);

                int movieId = p.Get<int>("MovieID");
                return movieId;
            }
        }

        public void AddMovieActorToDB(int movieId, int actorId)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("MovieID", movieId);
                p.Add("ActorID", actorId);

                cn.Execute("AddMovieActor", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void AddMovieDirectorToDB(int movieId, int directorId)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("MovieID", movieId);
                p.Add("DirectorID", directorId);

                cn.Execute("AddMovieDirector", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void AddMovieToInventoryDB(int movieId, int outForRent)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("MovieID", movieId);
                p.Add("OutForRent", outForRent);
                p.Add("Active", 1);

                cn.Execute("AddMovieToInventory", p, commandType: CommandType.StoredProcedure);
            }
        }

        public List<MovieCollectionCarrier> GetMovieListFromDBShortDetail()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {

                List<MovieCollectionCarrier> movieList = new List<MovieCollectionCarrier>();

                movieList =
                    cn.Query<MovieCollectionCarrier>("GetMovieList", commandType: CommandType.StoredProcedure).ToList();

                return movieList;
            }
        }

        public void DeleteMovieFromDB(int movieId)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("MovieID", movieId);

                cn.Execute("DeleteMovie", p, commandType: CommandType.StoredProcedure);
            }
        }

        public OwnerNote GetOwnerNoteByMovieId(int Id)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                return cn.Query<OwnerNote>(
                    "select OwnerNoteID, NoteDescription, DateOfNote from Movies m inner join OwnerNotes n on m.MovieID = n.MovieID where m.MovieID = @movieId",
                    new {movieId = Id}).FirstOrDefault();
            }
        }

        public List<ActorModel> GetActorListByMovieID(int Id)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                List<ActorModel> actorList = new List<ActorModel>();

                actorList =
                    cn.Query<ActorModel>("SELECT mc.ActorID, a.FirstName, a.LastName " +
                                         "FROM MovieCast mc inner join Actors a on mc.ActorID = a.ActorID " +
                                         "WHERE mc.MovieID = @MovieID", new {movieID = Id}).ToList();

                return actorList;
            }
        }

        public List<DirectorModel> GetDirectorListByMovieID(int Id)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                List<DirectorModel> directorList = new List<DirectorModel>();

                directorList = cn.Query<DirectorModel>("SELECT md.DirectorID, d.FirstName, d.LastName " +
                                         "FROM MovieDirectors md inner join Directors d on md.DirectorID = d.DirectorID " +
                                         "WHERE MovieID = @MovieID", new { movieID = Id }).ToList();

                return directorList;
            }
        }

        public List<Note> GetUserNotesByMovieID(int Id)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                List<Note> notes = new List<Note>();

                notes = cn.Query<Note>("SELECT n.NoteID, n.NoteDescription, n.DateOfNote, u.FirstName, u.LastName " +
                                       "FROM Notes n inner join Users u on n.UserID = u.UserID " +
                                       "WHERE n.MovieID = @MovieID", new {movieID = Id}).ToList();

                return notes;  
            }
        }

        public ViewMovieCarrier GetMovieDetails(int Id)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {

                ViewMovieCarrier movie = new ViewMovieCarrier();
                var p = new DynamicParameters();
                p.Add("MovieID", Id);

                movie =
                    cn.Query<ViewMovieCarrier>("GetMovieByID", p, commandType: CommandType.StoredProcedure).FirstOrDefault();

                movie.Synopsis =
                    cn.Query<string>("SELECT m.Synopsis FROM Movies m WHERE m.MovieID = @MovieID", new {MovieID = Id})
                        .FirstOrDefault();


                movie.ImageURL =
                    cn.Query<string>("SELECT m.ImageURL FROM Movies m WHERE m.MovieID = @MovieID", new {MovieID = Id})
                        .FirstOrDefault();

                movie.Director = GetDirectorListByMovieID(Id);

                movie.Actor = GetActorListByMovieID(Id);

                return movie;
            }
        }

        public List<RentalHistory> GetRentalHistory()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                List<RentalHistory> rentalHistory = new List<RentalHistory>();

                rentalHistory =
                    cn.Query<RentalHistory>("GetRentalHistory", commandType: CommandType.StoredProcedure).ToList();

                return rentalHistory;
            }
        }

        public List<User> GetUser()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                List<User> users = new List<User>();

                users = cn.Query<User>("GetUsers", commandType: CommandType.StoredProcedure).ToList();

                return users;
            }
        }

        public List<MovieRental> GetUserOutForRent(int userID)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("UserID", userID);

                var rentals = cn.Query<MovieRental>("GetUserOutForRent", p, commandType: CommandType.StoredProcedure).ToList();

                return rentals; 
            }
        }

        public void ReturnMovieByRentalID(int rentalID)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("RentalID", rentalID);

                cn.Execute("ReturnMovieByRentalID", p, commandType: CommandType.StoredProcedure);

            }
        }
        
        //Created for Unit testing: Find next Auto_increment for movieID in DB.
        public int ReturnNextMovieID()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                int movieID = cn.Query<AddMovieCarrier>("SELECT m.MovieID AUTO_INCREMENT FROM Movies m ORDER BY m.MovieID DESC").ToString().FirstOrDefault();

                return movieID;
            }
        }

        //Created for Unit testing: Delete movie after Unit test adds.
        public void DeleteMovieByID(int movieID)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                //int total = cn.Query<AddMovieCarrier>("SELECT * FROM Movies").ToList().Count();

                string query = "Delete from Movies where Movies.MovieID = @movieID";
                cn.Execute(query, new
                {movieID});
            }
        }

        public User CreateUser(User user)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("FirstName", user.FirstName);
                p.Add("LastName", user.LastName);
                p.Add("UserID", DbType.Int32, direction: ParameterDirection.Output);

                cn.Execute("AddUser", p, commandType: CommandType.StoredProcedure);

                user.UserID = p.Get<int>("UserID");

                return user;

            }
        }

        public RateMovieCarrier GetMovieByRentalID(int RentalID)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var rateMovie = new RateMovieCarrier();

                var p = new DynamicParameters();
                p.Add("RentalID", RentalID);

               rateMovie = cn.Query<RateMovieCarrier>("GetMovieByRentalID", p, commandType: CommandType.StoredProcedure).FirstOrDefault();

                return rateMovie;
            }
        }

        public void AddMovieRating(int Rating, int MovieID, int UserID)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {

                var p = new DynamicParameters();
                p.Add("Rating", Rating);
                p.Add("MovieID", MovieID);
                p.Add("UserID",UserID);

                cn.Execute("AddMovieRating", p, commandType: CommandType.StoredProcedure);

            }
        }

        public void AddUserNote(string NoteDescription, int MovieID, int UserID)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {

                var p = new DynamicParameters();
                p.Add("NoteDescription", NoteDescription);
                p.Add("MovieID", MovieID);
                p.Add("UserID", UserID);

                cn.Execute("AddUserNote", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void AddActorToDB(string FirstName, string LastName)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                string query = "INSERT INTO Actors VALUES (@FirstName, @LastName)";

                cn.Execute(query, new
                { FirstName, LastName });
            }
        }

        public void AddDirectorToDB(string FirstName, string LastName)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                string query = "INSERT INTO Directors VALUES (@FirstName, @LastName)";

                cn.Execute(query, new
                { FirstName, LastName });
            }
        }

        public void UndoRecentDelete(int id)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                string query = "UPDATE Inventory SET Active=1 WHERE  MovieID=@id";

                cn.Execute(query, new
                {id});
            }
        }

        public List<MovieRentShort> GetMovieListRentShort()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var movies =
                    cn.Query<MovieRentShort>("GetMovieListForBorrower", commandType: CommandType.StoredProcedure)
                        .ToList();

                return movies;
            }
        }

        public MovieReviewsNotes GetMovieRatingByID(int movieID)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var ratingsPackage = new MovieReviewsNotes();
                var p = new DynamicParameters();
                p.Add("MovieID", movieID);

                var notesList = cn.Query<MovieRating>("GetUserNotesByMovieID", p,
                    commandType: CommandType.StoredProcedure).ToList();

                ratingsPackage.NotesList = notesList;
                ratingsPackage.RatingsList =
                    cn.Query<int>("GetMovieRatingList", p, commandType: CommandType.StoredProcedure).ToList();

                return ratingsPackage;

            }
        }
        

        public string RentDVD(int movieID, int userID)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                
                var serialNumber =
                    cn.Query<int>("FindAvailableCopy", new {movieID}, commandType: CommandType.StoredProcedure).FirstOrDefault();
                
                if (serialNumber != 0)
                {
                    var p1 = new DynamicParameters();
                    p1.Add("SerialNumberID", serialNumber);
                    cn.Execute("MarkAsRented", p1, commandType: CommandType.StoredProcedure);

                    var p2 = new DynamicParameters();
                    p2.Add("UserID", userID);
                    p2.Add("SerialNumberID", serialNumber);

                    cn.Execute("AddToRentalHistory", p2, commandType: CommandType.StoredProcedure);

                    return "Success!";
                }

                return "Someone beat you to it!";
            }
        }
    }
}
