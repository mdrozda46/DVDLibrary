using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class MovieRating
    {
        public string Name { get; set; }
        public decimal Rating { get; set; }
        public string NoteDescription { get; set; }
        public DateTime DateRated { get; set; }
    }
}
