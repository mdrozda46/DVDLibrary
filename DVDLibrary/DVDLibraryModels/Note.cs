using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class Note
    {
        public int NoteID { get; set; }
        public DateTime DateOfNote { get; set; }
        public string NoteDescription { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
