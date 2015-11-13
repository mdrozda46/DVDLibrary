using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class Movie
    {
        public int MovieID { get; set; }
        public string Title { get; set; }
        public DateTime DateReleased { get; set; }
        public int RunTime { get; set; }
        public string Synopsis { get; set; }
        public string ImageURL { get; set; }
        public string Genre { get; set; }
        public int OwnerRating { get; set; }
        public string MPAARating { get; set; }
        public string Studio { get; set; }
        public string Director { get; set; }
        public List<ActorModel> Actors { get; set; } 
    }
}
