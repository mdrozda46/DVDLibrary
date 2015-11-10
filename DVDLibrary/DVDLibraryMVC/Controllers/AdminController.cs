using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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
            return View();
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