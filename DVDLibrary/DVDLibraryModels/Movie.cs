using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class Movie
    {
        public List<int> SerialNumbers { get; set; } 
        public string Title { get; set; }
        public string MPAARating { get; set; }
        public List<DirectorModel> Directors { get; set; }
        public string Studio { get; set; }
        public List<int> Ratings { get; set; } 
        public List<Note> Notes { get; set; } 
        public List<string> Actors { get; set; }
        public DateTime ReleaseDate { get; set; }
        public bool IsRented { get; set; }
        public Borrower Borrower { get; set; }
        public DateTime DateBorrowed { get; set; }
        public DateTime DueDate { get; set; }
        public string Synopsis { get; set; }
        public string Genre { get; set; } 
    }
}
