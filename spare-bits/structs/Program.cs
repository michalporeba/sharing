using System;

namespace structs
{
    class Program
    {
        static void Main(string[] args)
        {
            var rand = new Random();
            
            for (var i = 0; i < 100000; ++i)
            {
                var s = new SimpleStruct()
                {
                    A = rand.Next(10),
                    B = rand.Next(10),
                    C = rand.Next(10),
                    D = rand.Next(10)
                };    
                Print(s);
            }
            
            
        }

        private static void Print(SimpleStruct s)
        {
            Console.Out.WriteLine(s.A+s.B+s.C+s.D);
        }
    }
}
