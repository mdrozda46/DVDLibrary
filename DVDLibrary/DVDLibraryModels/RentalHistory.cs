using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace DVDLibraryModels
{
    public class RentalHistory
    {
        public string Name { get; set; }
        public string Title { get; set; }

        //[DisplayFormat(DataFormatString="{0:MM/dd/yyy}")]
        public DateTime DateBorrowed { get; set; }

        //[DisplayFormat(DataFormatString = "{0:MM/dd/yyy}")]
        public DateTime DateReturned { get; set; }

        public int  SerialNumberID { get; set; }
    }
}
