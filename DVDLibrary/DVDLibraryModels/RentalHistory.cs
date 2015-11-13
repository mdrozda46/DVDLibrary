using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DVDLibraryModels
{
    public class RentalHistory
    {
        public string Name { get; set; }
        public string Title { get; set; }
        public DateTime DateBorrowed { get; set; }
        public DateTime DateReturned { get; set; }
        public int  SerialNumberID { get; set; }
    }
}
