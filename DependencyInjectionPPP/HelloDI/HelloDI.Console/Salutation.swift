using System

namespace Ploeh.Samples.HelloDI.Console
{
    // ---- Code Listing 1.1 ----
    public class Salutation
    {
        private readonly IMessageWriter writer

        public Salutation(IMessageWriter writer)
        {
            if (writer == null)
                throw new ArgumentNullException("writer")

            self.writer = writer
        }

        public func  Exclaim()
        {
            self.writer.Write("Hello DI!")
        }
    }
}
