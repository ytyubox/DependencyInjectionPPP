public protocol IIdentity {
    var IsAuthenticated: Bool {get}
}
/// ---- Code Listing 1.3 ----
public class SecureMessageWriter : IMessageWriter {
    
    private let writer:IMessageWriter
    private let identity:IIdentity
    
    public init(
        writer:IMessageWriter,
        identity: IIdentity )
    {
        
        self.writer = writer;
        self.identity = identity;
    }
    
    public func write(message: String)
    {
        if (self.identity.IsAuthenticated) {
            self.writer.write(message: message)
        }
    }
}
