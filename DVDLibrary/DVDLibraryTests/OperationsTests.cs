using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibraryBLL;
using NUnit.Framework;

namespace DVDLibraryTests
{
    [TestFixture]
    public class OperationsTests
    {

        [Test]
        public void GetMPAARatings()
        {
            var ops = new DVDLibraryOperations();
            var MPAARatings = ops.GetMPAARatings();

            Assert.AreEqual(MPAARatings.Count, 5);
            Assert.AreEqual(MPAARatings[0].MPAARating, "G");

        }
    }
}
