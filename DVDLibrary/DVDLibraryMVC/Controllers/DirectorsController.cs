using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using DVDLibraryBLL;
using DVDLibraryModels;

namespace DVDLibraryMVC.Controllers
{
    public class DirectorsController : ApiController
    {
        public List<DirectorModel> Get()
        {
            var ops = new DVDLibraryOperations();

            return ops.GetDirectors();
        }

        public HttpResponseMessage Post(DirectorModel newDirector)
        {
            var ops = new DVDLibraryOperations();
            ops.AddDirector(newDirector.FirstName, newDirector.LastName);

            var response = Request.CreateResponse(HttpStatusCode.Created, newDirector);

            string uri = Url.Link("DefaultApi", new {id = newDirector.DirectorID});
            response.Headers.Location = new Uri(uri);

            return response;
        } 
    }
}
