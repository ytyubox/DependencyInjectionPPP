import DependencyInjectionPPP
import XCTest
typealias Action = () throws -> Void
public class SecureMessageWriterTests: XCTestCase {
    // Tests missing? Send us a pull request.

    private let AuthenticatedIdentity: IIdentity = TestIdentity(IsAuthenticated: true)
    private let AnonymousIdentity: IIdentity = TestIdentity(IsAuthenticated: false)

    public func testSutIsMessageWriter() throws {
        try Assert.IsAssignableFrom<IMessageWriter>(CreateSecureMessageWriter())
    }

    public func testInitializeWithNullWriterThrows() throws {
        // Act
        let action: Action = {
            _ = try SecureMessageWriter(writer: nil, identity: WindowsIdentity.GetCurrent())
        }

        // Arrange
        Assert.Throws<ArgumentNullException>(action: action)
    }

    public func testInitializeWithNullIdentityThrows() throws {
        // Act
        let action: Action = { _ = try SecureMessageWriter(writer: SpyMessageWriter(), identity: nil) }

        // Arrange
        Assert.Throws<ArgumentNullException>(action: action)
    }

    public func testwriteInvokesDecoratedWriterWhenPrincipalIsAuthenticated() throws {
        // Arrange
        let expectedMessage = "Whatever"
        let writer = SpyMessageWriter()

        let sut: SecureMessageWriter = try CreateSecureMessageWriter(writer: writer, identity: AuthenticatedIdentity)

        // Act
        sut.write(message: expectedMessage)

        // Assert
        Assert.Equal(expected: expectedMessage, actual: writer.WrittenMessage)
    }

    public func testWriteDoesNotInvokeWriterWhenPrincipalIsNotAuthenticated() throws {
        // Arrange
        let writer = SpyMessageWriter()

        let sut: SecureMessageWriter = try CreateSecureMessageWriter(writer: writer, identity: AnonymousIdentity)

        // Act
        sut.write(message: "Anonymous value")

        // Assert
        Assert.Equal(expected: 0, actual: writer.messageCount)
    }

    public struct TestIdentity: IIdentity {
        public var AuthenticationType: String! = nil
        public var IsAuthenticated: Bool
        public var Name: String! = nil
    }
}

private func CreateSecureMessageWriter(
    writer: IMessageWriter? = nil, identity: IIdentity? = nil
) throws -> SecureMessageWriter {
    return try SecureMessageWriter(
        writer: writer ?? SpyMessageWriter(),
        identity: identity ?? WindowsIdentity.GetCurrent()
    )
}

enum Assert {
    static func Equal<E: Equatable>(expected: E, actual: E, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(expected, actual, file: file, line: line)
    }

    class Throws<E: Error> {
        @discardableResult
        init(action: @escaping () throws -> Void, file: StaticString = #filePath, line: UInt = #line) {
            XCTAssertThrowsError(try action(), file: file, line: line) { error in
                XCTAssertTrue(error is E, file: file, line: line)
            }
        }
    }

    class IsAssignableFrom<T> {
        @discardableResult
        init(_ any: Any, file: StaticString = #filePath, line: UInt = #line) {
            XCTAssertTrue(any is T, file: file, line: line)
        }
    }
}

enum WindowsIdentity {
    static func GetCurrent() -> IIdentity {
        StubIIdentity(IsAuthenticated: false)
    }
}

struct StubIIdentity: IIdentity {
    var IsAuthenticated: Bool
}
