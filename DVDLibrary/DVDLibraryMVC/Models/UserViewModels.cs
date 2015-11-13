using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibraryModels;

namespace DVDLibraryMVC.Models
{
    public class RentalListViewModel
    {
        public List<MovieRental> Rentals { get; set; }

        public RentalListViewModel(List<MovieRental> Rentals)
        {
            this.Rentals = Rentals;
        }


    public class SelectUserViewModel
    {
        public List<SelectListItem> UsersDropDown { get; set; }

        public SelectUserViewModel(List<User> users)
        {
            List<SelectListItem> dropDown = new List<SelectListItem>();

            SelectListItem u = null;

            foreach (var i in users)
            {
                u = new SelectListItem();
                u.Text = i.Name;
                u.Value = i.UserID.ToString();

                dropDown.Add(u);
            }

            UsersDropDown = dropDown;
        } 
    }
}