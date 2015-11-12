using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class OwnerNote
    {
        public int OwnerNoteID { get; set; }
        public DateTime DateOfNote { get; set; }
        public string NoteDescription { get; set; }
    }
}
