using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryData.Models
{
    public class Movie
    {
        public string Title { get; set; }
        public DateTime DateReleased { get; set; }
        public int MPAARatingID { get; set; }

        //to be completed
    }

    public class MPAARating
    {
        public int ID { get; set; }
        public string Rating { get; set; }
    }


}
