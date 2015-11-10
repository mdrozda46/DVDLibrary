using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Configuration;

namespace DVDLibraryData.Config
{
    public class Settings
    {
        private static string _connectionString;

        public static string ConnectionString
        {
            get
            {
                if (string.IsNullOrEmpty(_connectionString))
                {
                    _connectionString = WebConfigurationManager.ConnectionStrings["DVDCollection"].ConnectionString;
                }

                return _connectionString;
            }
        }
    }
}
