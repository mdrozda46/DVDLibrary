using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DVDLibraryModels;

namespace DVDLibraryMVC.Models
{
    public class AddMovieViewModel
    {
        public List<SelectListItem> MPAARatings { get; set; }
        public List<SelectListItem> Genres { get; set; }
        public List<SelectListItem> Directors { get; set; }
        public List<SelectListItem> Studios { get; set; }
        public List<SelectListItem> Actors { get; set; }
        public List<SelectListItem> Ratings { get; set; }

        public AddMovieViewModel(List<MPAARatingModel> mpaaRatings, List<GenreModel> genres, List<DirectorModel> directors,
            List<Studio> studios, List<ActorModel> actors, List<RatingModel> ratings)
        {
            MPAARatings = new List<SelectListItem>();
            Genres = new List<SelectListItem>();
            Directors = new List<SelectListItem>();
            Studios = new List<SelectListItem>();
            Actors = new List<SelectListItem>();
            Ratings = new List<SelectListItem>();

            foreach (var r in mpaaRatings)
            {
                var e = new SelectListItem();

                e.Value = r.MPAARatingID.ToString();
                e.Text = r.MPAARating;

                MPAARatings.Add(e);
            }

            foreach (var r in genres)
            {
                var e = new SelectListItem();

                e.Value = r.GenreID.ToString();
                e.Text = r.Genre;

                Genres.Add(e);
            }

            foreach (var r in directors)
            {
                var e = new SelectListItem();

                e.Value = r.DirectorID.ToString();
                e.Text = r.FirstName + " " + r.LastName;

                Directors.Add(e);
            }

            foreach (var r in studios)
            {
                var e = new SelectListItem();

                e.Value = r.StudioID.ToString();
                e.Text = r.Name;

                Studios.Add(e);
            }

            foreach (var r in actors)
            {
                var e = new SelectListItem();

                e.Value = r.ActorID.ToString();
                e.Text = r.FirstName + " " + r.LastName;

                Actors.Add(e);
            }

            foreach (var r in ratings)
            {
                var e = new SelectListItem();

                e.Value = r.RatingID.ToString();
                if (r.Rating != 1)
                {
                    e.Text = r.Rating + " stars";
                }
                else
                {
                    e.Text = r.Rating + " star";
                }
                

                Ratings.Add(e);
            }
        }
    }

    public class MovieCollectionViewModel
    {
        public List<MovieCollectionCarrier> Movies { get; set; }

        public MovieCollectionViewModel(List<MovieCollectionCarrier> Movies)
        {
            this.Movies = Movies;
        }
    }

    public class ViewMovieViewModel
    {
        public ViewMovieCarrier movie { get; set; }

        public ViewMovieViewModel(ViewMovieCarrier movie)
        {
            this.movie = movie;
        }
    }

    public class RentalHistoryViewModel
    {
        public List<RentalHistory> History { get; set; }

        public RentalHistoryViewModel(List<RentalHistory> history)
        {
            this.History = history;
        }
    }
}