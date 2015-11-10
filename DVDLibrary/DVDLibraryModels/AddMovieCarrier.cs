using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class AddMovieCarrier
    {
        public string Title { get; set; }
        public DateTime DateReleased { get; set; }
        public string MPAARatingID { get; set; }
        public string GenreID { get; set; }
        public string RunTime { get; set; }
        public List<string> DirectorID { get; set; }
        public string StudioID { get; set; }
        public List<string> ActorID { get; set; } 
        public string Synopsis { get; set; }
        public string OwnerRatingID { get; set; }
        public string Copies { get; set; }
        public string ImageURL { get; set; }
    }
}
