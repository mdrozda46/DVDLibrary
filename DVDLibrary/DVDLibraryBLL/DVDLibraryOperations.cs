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
    }
}
