using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Azure.Storage.Queues;
using Azure.Storage.Queues.Models;

namespace PoresDemo.Function
{
    public static class NoweZamowienie
    {
        private static string CONNECTION_STRING = "";

        [FunctionName("NoweZamowienie")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("C# HTTP trigger function processed a request.");

            string name = req.Query["name"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            name = name ?? data?.name;

            string responseMessage = string.IsNullOrEmpty(name)
                ? "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."
                : $"Hello, {name}. This HTTP triggered function executed successfully.";

            QueueClient queue = new QueueClient(CONNECTION_STRING, "nowezamowienia");
            await queue.SendMessageAsync(JsonConvert.SerializeObject(new { Name = name, Data = "hello"}));

            return new OkObjectResult(responseMessage);
        }
    }
}
