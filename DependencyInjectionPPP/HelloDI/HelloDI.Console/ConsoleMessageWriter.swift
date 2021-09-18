namespace Ploeh.Samples.HelloDI.Console
{
    // ---- Code Section 1.2.1 ----
    public class ConsoleMessageWriter : IMessageWriter
    {
        public void write(string message)
        {
            System.Console.WriteLine(message);
        }
    }
}
