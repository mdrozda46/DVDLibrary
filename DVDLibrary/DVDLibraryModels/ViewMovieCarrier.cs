using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class ViewMovieCarrier
    {
        public int? MovieID { get; set; }
        public string Title { get; set; }
        public DateTime DateReleased { get; set; }
        public string MPAARating { get; set; }
        public string Genre { get; set; }
        public int RunTime { get; set; }
        public List<DirectorModel> Director { get; set; } 
        public string Studio { get; set; }
        public List<ActorModel> Actor { get; set; }
        public string Synopsis { get; set; }
        public int OwnerRating { get; set; }
        public int UserRating { get; set; }
        public string ImageURL { get; set; }
        public int UnitsInStock { get; set; }
        
    }
}
