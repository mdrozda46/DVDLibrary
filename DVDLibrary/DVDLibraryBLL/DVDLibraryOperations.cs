using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibraryData.Repository;
using DVDLibraryModels;

namespace DVDLibraryBLL
{
    public class DVDLibraryOperations
    {
        private DVDLibraryADO _repo;

        public DVDLibraryOperations() 
        {
            _repo = new DVDLibraryADO();
        }

        public List<MPAARatingModel> GetMPAARatings()
        {
            return _repo.GetMPAARatings();
        }

        public List<GenreModel> GetGenres()
        {
            return _repo.GetGenres();
        }

        public List<DirectorModel> GetDirectors()
        {
            return _repo.GetDirectors();
        }

        public List<ActorModel> GetActors()
        {
            return _repo.GetActors();
        }

        public List<Studio> GetStudios()
        {
            return _repo.GetStudios();
        }

        public List<RatingModel> GetRatings()
        {
            return _repo.GetRatings();
        }

        public void AddMovie(AddMovieCarrier amc)
        {
            int id = _repo.AddMovieToDB(amc.Title, amc.DateReleased, int.Parse(amc.RunTime), amc.Synopsis, amc.ImageURL,
                int.Parse(amc.GenreID), int.Parse(amc.OwnerRatingID), int.Parse(amc.MPAARatingID),
                int.Parse(amc.StudioID));

            foreach (var director in amc.DirectorID)
            {
                _repo.AddMovieDirectorToDB(id, int.Parse(director));
            }
            foreach (var actor in amc.ActorID)
            {
                _repo.AddMovieDirectorToDB(id, int.Parse(actor));
            }
            for (int i = 0; i < int.Parse(amc.Copies); i++)
            {
                _repo.AddMovieToInventoryDB(id, 0);
            }
        }

        public List<MovieCollectionCarrier> GetMovieListShortDetail()
        {
            var moviedata = _repo.GetMovieListFromDBShortDetail();
            return moviedata;
        }

        public void DeleteMovie(int movieId)
        {
            _repo.DeleteMovieFromDB(movieId);
        }

        public ViewMovieCarrier GetMovieDetails(int Id)
        {
            ViewMovieCarrier movie = _repo.GetMovieDetails(Id);

            return movie;
        }

        public List<RentalHistory> GetRentalHistory()
        {
            var rentalHistory = _repo.GetRentalHistory();

            return rentalHistory;
        }

        public List<User> GetUsers()
        {
            var users = _repo.GetUser();

            return users;
        } 
    }
}
