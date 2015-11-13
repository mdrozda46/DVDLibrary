using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
    }
}