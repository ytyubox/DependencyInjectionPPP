public class Salutation {
    private let writer: IMessageWriter
    public init(writer: IMessageWriter) {
        self.writer = writer
    }

    public func Exclaim() {
        writer.write(message: "Hello DI!")
    }
}
