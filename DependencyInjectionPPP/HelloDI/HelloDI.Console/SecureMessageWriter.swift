import Foundation
public protocol IIdentity {
    var IsAuthenticated: Bool { get }
}

/// ---- Code Listing 1.3 ----
public class SecureMessageWriter: IMessageWriter {
    private let writer: IMessageWriter
    private let identity: IIdentity

    public init(
        writer: IMessageWriter?,
        identity: IIdentity?
    ) throws {
        if writer == nil {
            throw ArgumentNullException("writer")
        }
        if identity == nil {
            throw ArgumentNullException("identity")
        }
        self.writer = writer!
        self.identity = identity!
    }

    public func write(message: String) {
        if identity.IsAuthenticated {
            writer.write(message: message)
        }
    }
}

public struct ArgumentNullException: LocalizedError {
    init(_ errorDescription: String) {
        self.errorDescription = errorDescription
    }

    public var errorDescription: String?
}
