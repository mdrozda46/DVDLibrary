using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibraryBLL;

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

        public ActionResult UserRentalList(int UserID)
        {
            var ops = new DVDLibraryOperations();
            
            
            return View();
        }
    }
}