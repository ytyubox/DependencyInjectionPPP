import Foundation
public class Program {
    private static func Main() throws {
        try EarlyBindingExample()
        try LateBindingExample()
    }

    private static func EarlyBindingExample() throws {
        let writer: IMessageWriter =
            try SecureMessageWriter(
                writer: ConsoleMessageWriter(),
                identity: GetIdentity()
            )

        let salutation = Salutation(writer: writer)

        salutation.Exclaim()
    }

    private static func LateBindingExample() throws {
        let configuration: [String: String] = try {
            let data = Bundle(for: Program.self)
                .url(forResource: "appsettings", withExtension: "json")?
                .dataRepresentation ?? Data()
            let configure = try JSONDecoder().decode([String: String].self, from: data)
            return configure
        }()

        let typeName = try unwrap(configuration["messageWriter"])

        let writer: IMessageWriter =
            try SecureMessageWriter(
                writer: create(IMessageWriterWith: typeName),
                identity: GetIdentity()
            )

        let salutation = Salutation(writer: writer)

        salutation.Exclaim()
    }

    private static func GetIdentity() -> IIdentity {
        #if os(macOS)
            return StubIIdentity(IsAuthenticated: false)
        #else
            return StubIIdentity(IsAuthenticated: true)
        #endif
    }
}

func create(IMessageWriterWith typeName: String) throws -> IMessageWriter {
    switch typeName {
    case "SecureMessageWriter": throw NSError(domain: "Not implemented", code: 0)
    case "ConsoleMessageWriter": return ConsoleMessageWriter()
    default: throw NSError(domain: "Type not found", code: 0)
    }
}

func unwrap<T>(_ opt: T?) throws -> T {
    guard let opt = opt else {
        throw NSError(domain: "\(T.self) is nil", code: 0)
    }
    return opt
}

struct StubIIdentity: IIdentity {
    var IsAuthenticated: Bool
}
