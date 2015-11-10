using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DVDLibraryData.Repository;

namespace DVDLibraryBLL
{
    public class DVDLibraryOperations
    {
        private DVDLibraryADO _repo;

        public DVDLibraryOperations() 
        {
            _repo = new DVDLibraryADO();
        }

        public List<string> GetMPAARatings()
        {
            return _repo.GetMPAARatings();
        }

        public List<string> GetGenres()
        {
            return _repo.GetGenres();
        }

        public List<string> GetDirectors()
        {
            return _repo.GetDirectors();
        }

        public List<string> GetActors()
        {
            return _repo.GetActors();
        }

        public List<string> GetStudios()
        {
            return _repo.GetStudios();
        }

        public List<int> GetRatings()
        {
            return _repo.GetRatings();
        }
    }
}
