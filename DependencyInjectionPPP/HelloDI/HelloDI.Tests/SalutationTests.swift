import DependencyInjectionPPP
import XCTest
public class SalutationTests: XCTestCase {
    // Tests missing? Send us a pull request.

    // ---- Code Listing 1.4 ----

    public func testExclaimWillWriteCorrectMessageToMessageWriter() {
        // Arrange
        let writer = SpyMessageWriter()

        let sut = Salutation(writer: writer)

        // Act
        sut.Exclaim()

        // Assert
        Assert.Equal(
            expected: "Hello DI!",
            actual: writer.WrittenMessage
        )
    }
}
