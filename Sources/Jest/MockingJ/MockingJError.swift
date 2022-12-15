public struct MockingJError: Error {
    let message: String
    let file: StaticString
    let line: UInt

    init(
        _ message: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        self.message = message
        self.file = file
        self.line = line
    }
}
