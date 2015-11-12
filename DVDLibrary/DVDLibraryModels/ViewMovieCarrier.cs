using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class ViewMovieCarrier
    {
        public int MovieID { get; set; }
        public string Title { get; set; }
        public DateTime DateReleased { get; set; }
        public string MPAARating { get; set; }
        public string Genre { get; set; }
        public string RunTime { get; set; }
        public List<string> Director { get; set; } 
        public string Studio { get; set; }
        public List<string> Actor { get; set; }
        public string Synopsis { get; set; }
        public string OwnerRating { get; set; }
        public string ImageURL { get; set; }
    }
}
