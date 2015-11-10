using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

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

        public AddMovieViewModel(List<string> mpaaRatings, List<string> genres, List<string> directors,
            List<string> studios, List<string> actors, List<string> ratings)
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

                e.Value = r;
                e.Text = r;

                MPAARatings.Add(e);
            }

            foreach (var r in genres)
            {
                var e = new SelectListItem();

                e.Value = r;
                e.Text = r;

                Genres.Add(e);
            }

            foreach (var r in directors)
            {
                var e = new SelectListItem();

                e.Value = r;
                e.Text = r;

                Directors.Add(e);
            }

            foreach (var r in studios)
            {
                var e = new SelectListItem();

                e.Value = r;
                e.Text = r;

                Studios.Add(e);
            }

            foreach (var r in actors)
            {
                var e = new SelectListItem();

                e.Value = r;
                e.Text = r;

                Actors.Add(e);
            }

            foreach (var r in ratings)
            {
                var e = new SelectListItem();

                e.Value = r;
                e.Text = r;

                Ratings.Add(e);
            }
        }
    }
}