using System;
using System.IO;
using BadListener.Runtime;
using Newtonsoft.Json;

namespace Chinaski
{
	class Program
    {
		private static Configuration GetConfiguration()
		{
			string content = File.ReadAllText("Configuration.json");
			var configuration = JsonConvert.DeserializeObject<Configuration>(content);
			return configuration;
		}

        static void Main(string[] arguments)
        {
			try
			{
				var configuration = GetConfiguration();
				var requestHandler = new RequestHandler();
				var server = new HttpServer(configuration.Prefix, requestHandler);
				server.Start();
			}
			catch (Exception exception)
			{
				Console.WriteLine($"Error: {exception.Message} ({exception.GetType()})");
			}
        }
    }
}
