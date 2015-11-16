using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class RateMovieCarrier
    {
        public int RentalID { get; set; }
        public int MovieID { get; set; }
        public string Title { get; set; }
        public string ImageURL { get; set; }
        public string Synopsis { get; set; }
        public List<RatingModel>Ratings { get; set; }
        public int Rating { get; set; }
        public string Note { get; set; }
        public int UserID { get; set; }


        public RateMovieCarrier()
        {
            Ratings = new List<RatingModel>();
        }
    }


}
