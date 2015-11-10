using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DVDLibraryMVC.Models
{
    public class AddMovieViewModel
    {
        public List<SelectListItem> MPAARatings { get; set; }
        public List<SelectListItem> Genres { get; set; }
        public List<SelectListItem> Directors { get; set; }
        public List<SelectListItem> Studios { get; set; }
        public List<SelectListItem> Actors { get; set; }
        public List<SelectListItem> OwnerRatings { get; set; }
    }
}