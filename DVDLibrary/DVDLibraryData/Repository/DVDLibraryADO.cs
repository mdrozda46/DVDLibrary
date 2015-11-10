﻿using System;
using System.Collections.Generic;
using System.Data;
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
                var Directors = cn.Query<DirectorModel>("select d.FirstName, d.LastName from Directors d").ToList();

                return Directors;
            }
        }

        public List<ActorModel> GetActors()
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var Actors = cn.Query<ActorModel>("select d.FirstName, d.LastName from Actors d").ToList();

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

        public void AddMovieToDB(string title, DateTime dateReleased, int runTime, string synopsis, string imageUrl, int genreId, int ownerRatingId, int MPAARatingId, int studioId)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("Title", title);
                p.Add("DateReleased", dateReleased);
                p.Add("RunTime", runTime);
                p.Add("Synopsis", synopsis);
                p.Add("imageUrl", imageUrl);
                p.Add("GenreID", genreId);
                p.Add("OwnerRatingID", ownerRatingId);
                p.Add("MPAARatingID", MPAARatingId);
                p.Add("StudioID", studioId);

                cn.Execute("AddMovie", p, commandType: CommandType.StoredProcedure);

                //TODO do something with this variable
                int movieId = p.Get<int>("MovieID");
            }
        }

        public void AddMovieActorToDB(int movieId, int actorId)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("MovieID", movieId);
                p.Add("ActorID", actorId);

                cn.Execute("AddMovieActor", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void AddMovieDirectorToDB(int movieId, int directorId)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("MovieID", movieId);
                p.Add("DirectorID", directorId);

                cn.Execute("AddMovieDirector", p, commandType: CommandType.StoredProcedure);
            }
        }

        public void AddMovieToInventoryDB(int movieId, bool outForRent)
        {
            using (SqlConnection cn = new SqlConnection(Settings.ConnectionString))
            {
                var p = new DynamicParameters();
                p.Add("MovieID", movieId);
                p.Add("OutForRent", outForRent);

                cn.Execute("AddMovieToInventory", p, commandType: CommandType.StoredProcedure);
            }
        }
    }
}
