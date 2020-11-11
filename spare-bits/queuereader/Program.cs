using System;
using System.Threading.Tasks;
using Azure.Storage.Queues;
using Azure.Storage.Queues.Models;

namespace queuereader
{
    class Program
    {
        private static string CONNECTION_STRING = "";

        static async Task Main(string[] args)
        {
            QueueClient queue = new QueueClient(CONNECTION_STRING, "nowezamowienia");
            if (await queue.ExistsAsync()) 
            {
                QueueProperties properties = await queue.GetPropertiesAsync();
                
                if (properties.ApproximateMessagesCount > 0) 
                {
                    QueueMessage[] messages = await queue.ReceiveMessagesAsync(1);

                    Console.WriteLine(messages[0].MessageText);

                    queue.DeleteMessage(messages[0].MessageId, messages[0].PopReceipt);
                }
            }
        }
    }
}
