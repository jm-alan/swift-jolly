import XCTest

struct TestError: Error {
    let kind: ErrorKind
    let message: String

    enum ErrorKind: String {
        case unexpectedNil =
            "Unexpectedly found nil while unwrapping optional value"
        case expectedNil =
            "Expected nil, found value instead"
        case other
    }

    init(_ kind: ErrorKind, message: String? = nil) {
        self.kind = kind
        self.message = message ?? kind.rawValue
    }
}

public func AsyncUnwrap<T>(
    _ getValue: @autoclosure () async throws -> T?,
    file: StaticString = #file,
    line: UInt = #line
) async throws -> T {
    guard let result = try await getValue() else {
        XCTFail(file: file, line: line)
        throw TestError(.unexpectedNil)
    }
    return result
}

public func AsyncAssertEqual<E>(
    _ expression1: @autoclosure () async throws -> E,
    _ expression2: @autoclosure () async throws -> E,
    file: StaticString = #file,
    line: UInt = #line
) async where E: Equatable {
    do {
        let lhs = try await expression1()
        let rhs = try await expression2()
        XCTAssertEqual(lhs, rhs, file: file, line: line)
    } catch {
        XCTFail(
            "Unexpected error while asserting equality",
            file: file,
            line: line
        )
    }
}
