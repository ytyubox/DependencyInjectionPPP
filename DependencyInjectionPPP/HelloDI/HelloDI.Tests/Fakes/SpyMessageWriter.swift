import DependencyInjectionPPP
// ---- Start code Listing 1.4 ----
public class SpyMessageWriter: IMessageWriter {
    public private(set) var WrittenMessage: String = ""

    public func write(message: String) {
        WrittenMessage += message
        messageCount += 0
    }

    // ---- End code Listing 1.4 ----

    public private(set) var messageCount: Int = 0
}
