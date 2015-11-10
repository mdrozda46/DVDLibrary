using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using DVDLibraryData.Config;
using DVDLibraryModels;

namespace DVDLibraryData.Repository
{
    public class DVDLibraryADO
    {
        public List<MPAARatingModel> GetMPAARatings()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var MPAARatings = cn.Query<MPAARatingModel>("select mp.MPAARatingID, mp.MPAARating from MPAARatings mp").ToList();

                return MPAARatings;
            }
        }

        public List<GenreModel> GetGenres()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Genres = cn.Query<GenreModel>("select g.GenreID, g.Genre from Genres g").ToList();

                return Genres;
            }
        }

        public List<DirectorModel> GetDirectors()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Directors = cn.Query<DirectorModel>("select d.DirectorID, d.FirstName, d.LastName from Directors d").ToList();

                return Directors;
            }
        }

        public List<ActorModel> GetActors()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Actors = cn.Query<ActorModel>("select d.ActorID, d.FirstName, d.LastName from Actors d").ToList();

                return Actors;
            }
        }

        public List<Studio> GetStudios()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Studios = cn.Query<Studio>("select * from Studios").ToList();

                return Studios;
            }
        }

        public List<RatingModel> GetRatings()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Ratings = cn.Query<RatingModel>("select * from Ratings").ToList();

                return Ratings;
            }
        } 
    }
}
