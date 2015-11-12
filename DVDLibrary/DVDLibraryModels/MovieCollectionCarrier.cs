using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class MovieCollectionCarrier
    {
        public int MovieID { get; set; }
        public string Title { get; set; }
        public string MPAARating { get; set; }
        public string Genre { get; set; }
        public int RunTime { get; set; }
        public int UnitsInStock { get; set; }
        public int UserRating { get; set; }
    }
}
