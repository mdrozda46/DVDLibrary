using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
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

        [TestCase(2, 2)]
        public void GetUserNotesByMovieIDTest(int movieID, int noteCount)
        {
            var repo = new DVDLibraryADO();
            var notes = repo.GetUserNotesByMovieID(movieID);

            Assert.AreEqual(notes.Count, noteCount);
        }
    }
}
