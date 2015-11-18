using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using DVDLibraryBLL;
using DVDLibraryData.Config;
using DVDLibraryModels;
using NUnit.Framework;
using NUnit.Framework.Constraints;

namespace DVDLibraryTests
{
    [TestFixture]
    public class OperationsTests
    {


        [Test]
        public void AddMovieToDBTest()
        {
            var movie = new AddMovieCarrier();

            movie.Title = "Friday";
            movie.DateReleased = DateTime.Parse("11/02/1995");
            movie.MPAARatingID = "4";
            movie.GenreID = "5";
            movie.RunTime = "120";
            movie.StudioID = "1";
            movie.Synopsis =
                "Two homies, Smokey and Craig, smoke up a dope dealers weed and try to figure a way to get the $200 they owe the dope dealer by 10:00pm that night. In that time they smoke weed, get jacked, and they get shot at in a drive-by.";
            movie.OwnerRatingID = "5";
            movie.Copies = "2";
            movie.ImageURL = "http://www.imdb.com/media/rm3404111360/tt0113118?ref_=tt_ov_i";
            movie.DirectorID = new List<string>() {"1", "2"};
            movie.ActorID = new List<string>() {"1", "2", "3"};

            var ops = new DVDLibraryOperations();
            ops.AddMovie(movie);


            var movieAdded = new ViewMovieCarrier();

            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                movieAdded = cn.Query<ViewMovieCarrier>("SELECT * FROM Movies m WHERE m.Title = 'Friday'").FirstOrDefault();
            }

            Assert.AreEqual(movieAdded.Title, movie.Title);
        }

       
        [TestCase(1, 1, 1, null, 0)]
        [TestCase(5, 2, 2, "Great Movie!", 1)]
        public void AddUserReviewTests(int Rating, int MovieID, int UserID, string NoteDescription, int noteCountAdder)
        {
            var ops = new DVDLibraryOperations();
            var ratingCountBefore = 0;
            var ratingCountAfter = 0;
            var noteCountBefore = 0;
            var noteCountAfter = 0;

            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                ratingCountBefore = cn.Query<RatingModel>("SELECT * FROM MovieRatings").Count();
                noteCountBefore = cn.Query<Note>("SELECT * FROM Notes").Count();
                ops.AddUserReview(Rating, MovieID, UserID, NoteDescription);

                ratingCountAfter = cn.Query<RatingModel>("SELECT * FROM MovieRatings").Count();
                noteCountAfter = cn.Query<Note>("SELECT * FROM Notes").Count();
            }

            // Rating count should increase in both cases
            Assert.AreEqual(ratingCountBefore + 1, ratingCountAfter);

            // Note count should only increase with a valid note. 
            Assert.AreEqual(noteCountBefore + noteCountAdder, noteCountAfter);
        }
    }
}
