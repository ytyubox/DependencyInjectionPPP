using Ploeh.Samples.HelloDI.Console

namespace Ploeh.Samples.HelloDI.Tests.Fakes {
    // ---- Start code Listing 1.4 ----
    public class SpyMessageWriter: IMessageWriter {
        public string WrittenMessage { get private set }

        public func write(message: String) {
            self.WrittenMessage += message
            self.MessageCount++
        }

        // ---- End code Listing 1.4 ----

        public int MessageCount { get private set }
    }
}
