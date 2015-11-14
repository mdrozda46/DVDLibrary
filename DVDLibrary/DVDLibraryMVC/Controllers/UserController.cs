﻿using System;
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

        public ActionResult ViewCollection()
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

            int UserID = (int) Session["userID"];
            var userRentalsVM = new RentalListViewModel(ops.GetUserOutForRent(UserID));

            return View("UserRentalList", userRentalsVM);
        }

        public ActionResult SelectUserRent()
        {
            var ops = new DVDLibraryOperations();
            var users = ops.GetUsers();
            var usersVM = new SelectUserViewModel(users);

            return View(usersVM);
        }

        //public ActionResult ViewCollection()
        //{
        //    return View();
        //}

        [HttpPost]
        public ActionResult CreateNewUser(User user)
        {
            var ops = new DVDLibraryOperations();
            Session["User"] = ops.CreateUser(user);

            return RedirectToAction("ViewCollection");
        }
    }
}