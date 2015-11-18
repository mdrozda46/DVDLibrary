using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class MovieRentShort
    {
        public int MovieID { get; set; }
        public string Title { get; set; }
        public string MPAARating { get; set; }
        public string Genre { get; set; }   
        public int Runtime { get; set; }
        public int Rating { get; set; }
        public int NumberOfCopies { get; set; }
        public int NumberAvailable { get; set; }
    }
}
