using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibraryBLL;
using DVDLibraryMVC.Models;
using DVDLibraryModels;

namespace DVDLibraryMVC.Controllers
{
    public class UserController : Controller
    {
        // GET: User
        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult SelectUserReturn()
        {
            var ops = new DVDLibraryOperations();
            var users = ops.GetUsers();
            var usersVM = new SelectUserViewModel(users);

            return View(usersVM);
        }

        public ActionResult UserRentalList(int UserID)
        {
            Session["userID"] = UserID;
            var ops = new DVDLibraryOperations();

            var userRentalsVM = new RentalListViewModel(ops.GetUserOutForRent(UserID));
            
            return View(userRentalsVM);
        }


        public ActionResult ReturnMovie(int RentalId)
        {
            var ops = new DVDLibraryOperations();

            ops.ReturnMovieByRentalID(RentalId);
            Session["RentalID"] = RentalId;

            return RedirectToAction("RateMovie");
        }

        public ActionResult SelectUserRent()
        {
            var ops = new DVDLibraryOperations();
            var users = ops.GetUsers().ToList();
            var usersVM = new SelectUserViewModel(users);

            return View(usersVM);
        }

        public ActionResult ViewCollection(int UserID)
        {
            var ops = new DVDLibraryOperations();
            var moviesVM = new RentMovieShortViewModel(ops.GetMovieListRentShort());

            Session["User"] = UserID;

            return View(moviesVM);
        }


        [HttpPost]
        public ActionResult CreateNewUser(User user)
        {
            var ops = new DVDLibraryOperations();
            ops.CreateUser(user);

            return RedirectToAction("SelectUserRent");
        }

        public ActionResult ViewMovieForRent(int movieID, int movieInventory)
        {
            var ops = new DVDLibraryOperations();
            var movie = ops.GetMovieDetails(movieID);
            var movieRatings = ops.GetMovieRatingsByID(movieID);
            
            var viewMovieVM = new RentMovieLongViewModel(movieRatings, movie);
            viewMovieVM.UserID = (int)Session["User"];
            viewMovieVM.MovieInventory = movieInventory;

            return View(viewMovieVM);
        }

        public ActionResult RentDVD(int movieID)
        {
            var userID = (int) Session["User"];

            var ops = new DVDLibraryOperations();
            ops.RentDVD(movieID, userID);

            return RedirectToAction("ViewCollection", new {UserID = userID});

        }

        public ActionResult RateMovie()
        {
            int RentalID = (int)Session["RentalID"];

            var ops = new DVDLibraryOperations();

            var rateMovie = ops.GetRateMovieDetailsByRentalID(RentalID);
            rateMovie.UserID = (int)Session["userID"];

            var rateMovieVM = new RateMovieViewModel(rateMovie);

            return View(rateMovieVM);
        }

        [HttpPost]
        public ActionResult RateMovie(RateMovieCarrier rateMovie)
        {

            var ops = new DVDLibraryOperations();
            ops.AddUserReview(rateMovie.Rating, rateMovie.MovieID, rateMovie.UserID, rateMovie.Note);

            var userRentalsVM = new RentalListViewModel(ops.GetUserOutForRent(rateMovie.UserID));

            return View("UserRentalList", userRentalsVM);
        }
    }
}