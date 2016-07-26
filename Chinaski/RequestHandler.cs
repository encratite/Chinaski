using BadListener.Runtime;
using Chinaski.Model;
using System;

namespace Chinaski
{
    class RequestHandler
	{
        [Controller]
        public void Index()
        {
        }

        [Controller(ControllerMethod.Post)]
        public RegisterModel Register(string user, string password, string invitationCode)
        {
            throw new NotImplementedException();
        }

        [JsonController(ControllerMethod.Post)]
        public LoginModel Login(string user, string password)
        {
            throw new NotImplementedException();
        }
	}
}
