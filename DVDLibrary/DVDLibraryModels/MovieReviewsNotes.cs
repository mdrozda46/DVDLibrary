using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class MovieReviewsNotes
    {
        public List<MovieRating> NotesList { get; set; }
        public List<int> RatingsList { get; set; }

        public MovieReviewsNotes()
        {
            NotesList = new List<MovieRating>();
            RatingsList = new List<int>();
        } 
    }
}
