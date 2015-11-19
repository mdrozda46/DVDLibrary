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
            var directors = ops.GetDirectors().OrderBy(m => m.FirstName).ToList();
            var studios = ops.GetStudios().OrderBy(m => m.Name).ToList();
            var actors = ops.GetActors().OrderBy(m=>m.FirstName).ToList();
            var ratings = ops.GetRatings();

            var addMovieVM = new AddMovieViewModel(mpaa, genres, directors, studios, actors, ratings);

            return View(addMovieVM);
        }

        [HttpPost]
        public ActionResult MovieToRepo(AddMovieCarrier newMovie)
        {
            var ops = new DVDLibraryOperations();
            ops.AddMovie(newMovie);

            return RedirectToAction("ViewCollection");
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
            //Session["DeletedMovie"] = _deleted;
            _deleted.Push(MovieID);

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

        //[HttpPost]
        //public ActionResult ActorToRepoFromAdd(string firstName, string lastName)
        //{
        //    var ops = new DVDLibraryOperations();

        //    ops.AddActor(firstName, lastName);

        //    return RedirectToAction("AddMovie");
        //}

        //[HttpPost]
        //public ActionResult DirectorToRepoFromAdd(string firstName, string lastName)
        //{
        //    var ops = new DVDLibraryOperations();

        //    ops.AddDirector(firstName, lastName);

        //    return RedirectToAction("AddMovie");
        //}

        //[HttpPost]
        //public ActionResult UndoDelete()
        //{
        //    int id = _deleted.Pop();

        //    var ops = new DVDLibraryOperations();
        //    if (_deleted.Count != 0)
        //    {
        //        ops.UndoDeleteInDB(id);
        //    }

        //    return View("ViewCollection", collectionVM);
        //}
    }
}