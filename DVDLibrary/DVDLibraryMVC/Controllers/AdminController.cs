using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using DVDLibraryBLL;
using DVDLibraryModels;
using DVDLibraryMVC.Models;

namespace DVDLibraryMVC.Controllers
{
    public class AdminController : Controller
    {
        private Stack<int> _deleted { get; set; }
        public AdminController()
        {
            _deleted = new Stack<int>();
        }
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
            var ops = new DVDLibraryOperations();
            ops.AddMovie(newMovie);
        
            return RedirectToAction("Index");
        }

        public ActionResult ViewCollection()
        {
            var ops = new DVDLibraryOperations();
            var movies = ops.GetMovieListShortDetail();

            var collectionVM = new MovieCollectionViewModel(movies);
            
            return View(collectionVM);
        }

        public ActionResult ViewDVD(int MovieID)
        {
            var ops = new DVDLibraryOperations();
            var movie = ops.GetMovieDetails(MovieID);

            var dvdVM = new ViewMovieViewModel(movie);

            return View(dvdVM);
        }

        public ActionResult DeleteDvD(int MovieID)
        {
            //possible undo implementation
            //_deleted.Push(MovieID);
            //Session["DeletedMovie"] = _deleted;

            var ops = new DVDLibraryOperations();
            ops.DeleteMovie(MovieID);

            return RedirectToAction("ViewCollection");
        }

        public ActionResult RentalHistory()
        {
            var ops = new DVDLibraryOperations();

            var rentalHistory = ops.GetRentalHistory();

            var rentalVM = new RentalHistoryViewModel(rentalHistory);

            return View(rentalVM);
        }

        [HttpPost]
        public ActionResult ViewCollection(string MovieTitle)
        {
            var ops = new DVDLibraryOperations();
            var movies = ops.GetMovieListShortDetail();

            var filteredMovies = (from m in movies
                where m.Title.ToLower().Contains(MovieTitle.ToLower())
                select m).ToList();

            var collectionVM = new MovieCollectionViewModel(filteredMovies);

            return View(collectionVM);
        }
    }
}