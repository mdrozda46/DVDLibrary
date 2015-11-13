using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class MovieRental
    {
        public string RentalID { get; set; }
        public string Title { get; set; }
        public DateTime DateBorrowed { get; set; }
    }
}
