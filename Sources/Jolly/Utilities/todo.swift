public func todo(_ message: String, line: UInt = #line, file: StaticString = #file) -> Never {
    fatalError("""
    Attempted to access unimplemented functionality
    Callsite message: \(message)
    """, file: file, line: line)
}
