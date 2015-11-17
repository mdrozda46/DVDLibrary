using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
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

    public class RateMovieViewModel
    {
        public RateMovieCarrier RateMovie { get; set; }

        public RateMovieViewModel(RateMovieCarrier rateMovie)
        {
            this.RateMovie = rateMovie;
        }
    }

    public class RentMovieShortViewModel
    {
        public List<MovieRentShort> Movies { get; set; }

        public RentMovieShortViewModel(List<MovieRentShort> movies)
        {
            Movies = movies;
        }
    }

    public class RentMovieLongViewModel
    {
        public ViewMovieCarrier Movie { get; set; }
        public List<MovieRating> Ratings { get; set; }
        public decimal UserRatingsAverage { get; set; }
        public int NumberOfReviews { get; set; }

        public RentMovieLongViewModel(List<MovieRating> ratings, ViewMovieCarrier movie)
        {
            Movie = movie;
            Ratings = ratings;
            UserRatingsAverage = Ratings.Average(m => m.Rating);
            NumberOfReviews = Ratings.Count();
        } 
    }
}