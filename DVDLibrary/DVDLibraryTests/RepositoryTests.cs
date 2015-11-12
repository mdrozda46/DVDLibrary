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
        public void GetMPAARatings()
        {
            var repo = new DVDLibraryADO();
            var MPAARatings = repo.GetMPAARatings();

            Assert.AreEqual(MPAARatings.Count, 5);
            Assert.AreEqual(MPAARatings[0].MPAARating, "G");

        }
    }
}
