using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibraryBLL;
using DVDLibraryData.Repository;
using NUnit.Framework;

namespace DVDLibraryTests
{
    [TestFixture]
    public class RepositoryTests
    {

        [Test]
        public void GetMPAARatingsTest()
        {
            var repo = new DVDLibraryADO();
            var MPAARatings = repo.GetMPAARatings();

            Assert.AreEqual(MPAARatings.Count, 5);
            Assert.AreEqual(MPAARatings[0].MPAARating, "G");

        }

        [Test]
        public void GetGenresTest()
        {
            var repo = new DVDLibraryADO();
            var Genres = repo.GetGenres();

            Assert.AreEqual(Genres.Count, 9);
            Assert.AreEqual(Genres[0].Genre, "Action");

        }

        [Test]
        public void GetOwnerNotesTest()
        {
            var repo = new DVDLibraryADO();
            var note = repo.GetOwnerNoteByMovieId(2);

            Assert.AreEqual(note.NoteDescription, "The visual effects are so awesome!");
            Assert.AreEqual(note.OwnerNoteID, 2);

        }

        [TestCase(1,"Samuel", 3)]
        public void GetActorListByMovieIDTest(int movieID, string FirstName, int actorCount)
        {
            var repo = new DVDLibraryADO();
            var actorList = repo.GetActorListByMovieID(movieID);

            Assert.AreEqual(actorList.Count, actorCount);
            Assert.AreEqual(actorList[0].FirstName, FirstName);

        }


        [TestCase(1, "Quentin")]
        [TestCase(2, "James")]
        public void GetDirectorListByMovieIDTest(int movieID, string FirstName)
        {
            var repo = new DVDLibraryADO();
            var directorList = repo.GetDirectorListByMovieID(movieID).FirstOrDefault();

            Assert.AreEqual(directorList.FirstName, FirstName);

        }

        [TestCase(3, 2)]
        public void GetUserNotesByMovieIDTest(int movieID, int noteCount)
        {
            var repo = new DVDLibraryADO();
            var notes = repo.GetUserNotesByMovieID(movieID);

            Assert.AreEqual(notes.Count, noteCount);
        }

        //Tests Add movie functionality. Deletes movie after completion.
        [TestCase("Blah", "11/02/2015", 120, "A Boy and his Blah", "http://www.google.com/blah.jpg", 1, 3, 2, 2)]
        public void AddMovieToDBTest(string title, DateTime dateReleased, int runTime, string synopsis, 
            string imageUrl, int genreId, int ownerRatingId, int MPAARatingId, int studioId)
        {
            var repo = new DVDLibraryADO();

            //Find the last auto-generated movieID. We want to test that we have 1 more than we started with.
            var currentAutoIncID = repo.ReturnNextMovieID();

            currentAutoIncID += 1;

            var newMovie = repo.AddMovieToDB(title, dateReleased, runTime, synopsis, imageUrl, genreId, ownerRatingId, MPAARatingId, studioId);
            Assert.AreEqual(currentAutoIncID, newMovie);

            repo.DeleteMovieByID(newMovie);
            //dlo.DeleteMovie(newMovie);
            //Check to see that new total is not equal to newMovie.
            var totalMovies = repo.ReturnNextMovieID();

            Assert.AreNotEqual(totalMovies, newMovie);
        }
    }
}
