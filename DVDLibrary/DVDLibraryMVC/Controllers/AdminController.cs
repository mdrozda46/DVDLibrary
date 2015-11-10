using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibraryBLL;
using DVDLibraryModels;
using DVDLibraryMVC.Models;

namespace DVDLibraryMVC.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AddMovie()
        {
            var ops = new DVDLibraryOperations();
            var mpaa = ops.GetMPAARatings();
            var genres = ops.GetGenres();
            var directors = ops.GetDirectors();
            var studios = ops.GetStudios();
            var actors = ops.GetActors();
            var ratings = ops.GetRatings();
            
            var addMovieVM = new AddMovieViewModel(mpaa, genres, directors, studios, actors, ratings);

            return View(addMovieVM);
        }

        [HttpPost]
        public ActionResult MovieToRepo(AddMovieCarrier newMovie)
        {
            
        
            return RedirectToAction("Index");
        }

        public ActionResult ViewCollection()
        {
            return View();
        }

        public ActionResult RentalHistory()
        {
            return View();
        }
    }
}