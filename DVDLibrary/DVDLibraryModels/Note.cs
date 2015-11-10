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
        public DateTime TimeAdded { get; set; }
        public string Content { get; set; }
    }
}
