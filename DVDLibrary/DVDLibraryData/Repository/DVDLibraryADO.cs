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
        public List<string> GetMPAARatings()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var MPAARatings = cn.Query<string>("select MPAARating from MPAARatings").ToList();

                return MPAARatings;
            }
        }

        public List<string> GetGenres()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Genres = cn.Query<string>("select Genre from Genres").ToList();

                return Genres;
            }
        }

        public List<string> GetDirectors()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Directors = cn.Query<string>("select d.FirstName + ' ' + d.LastName from Directors d").ToList();

                return Directors;
            }
        }

        public List<string> GetActors()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Actors = cn.Query<string>("select d.FirstName + ' ' + d.LastName from Actors d").ToList();

                return Actors;
            }
        }

        public List<string> GetStudios()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Studios = cn.Query<string>("select Name from Studios").ToList();

                return Studios;
            }
        }

        public List<int> GetRatings()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Ratings = cn.Query<int>("select Rating from Ratings").ToList();

                return Ratings;
            }
        } 
    }
}
