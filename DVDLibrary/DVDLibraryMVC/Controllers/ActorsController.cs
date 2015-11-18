using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DVDLibraryBLL;
using DVDLibraryModels;

namespace DVDLibraryMVC.Controllers
{
    public class ActorsController : ApiController
    {
        public List<ActorModel> Get()
        {
            var ops = new DVDLibraryOperations();

            return ops.GetActors();
        }

        public HttpResponseMessage Post(ActorModel newActor)
        {
            var ops = new DVDLibraryOperations();
            ops.AddActor(newActor.FirstName, newActor.LastName);

            var response = Request.CreateResponse(HttpStatusCode.Created, newActor);

            string uri = Url.Link("DefaultApi", new { id = newActor.ActorID });
            response.Headers.Location = new Uri(uri);

            return response;
        }
    }
}
