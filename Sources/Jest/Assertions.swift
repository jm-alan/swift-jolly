import XCTest

struct TestError: Error {
    let kind: ErrorKind
    let message: String
    var error: Error?

    enum ErrorKind: String {
        case unexpectedError = "Unexpected error thrown while evaluating expression"
        case unexpectedNil =
            "Unexpectedly found nil while unwrapping optional value"
        case expectedNil =
            "Expected nil, found value instead"
        case other
    }

    static func fail(
        _ kind: ErrorKind,
        message: String? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTFail(message ?? kind.rawValue, file: file, line: line)
    }

    init(
        _ kind: ErrorKind,
        message: String? = nil,
        caught error: Error? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTFail(message ?? kind.rawValue, file: file, line: line)
        self.kind = kind
        self.message = message ?? kind.rawValue
        self.error = error
    }
}

func AsyncUnwrap<T>(
    _ getValue: @autoclosure () async throws -> T?,
    file: StaticString = #file,
    line: UInt = #line
) async throws -> T {
    guard let result = try await getValue() else {
        XCTFail(file: file, line: line)
        throw TestError(.unexpectedNil, file: file, line: line)
    }
    return result
}

func AsyncAssertNoThrow(
    _ shouldNotThrow: @autoclosure () async throws -> Void,
    file: StaticString = #file,
    line: UInt = #line
) async {
    do {
        try await shouldNotThrow()
    } catch {
        TestError.fail(.unexpectedError, file: file, line: line)
    }
}

func AsyncAssertNotNil<T>(
    _ shouldNotBeNil: @autoclosure () async throws -> T?,
    file: StaticString = #file,
    line: UInt = #line
) async {
    do {
        guard (try await shouldNotBeNil()) != nil else {
            return TestError.fail(.unexpectedNil, file: file, line: line)
        }
    } catch {
        TestError.fail(.unexpectedError, file: file, line: line)
    }
}

func AsyncAssertNil<T>(
    _ shouldBeNil: @autoclosure () async throws -> T?,
    file: StaticString = #file,
    line: UInt = #line
) async {
    do {
        guard (try await shouldBeNil()) == nil else {
            return
        }
        TestError.fail(.expectedNil, file: file, line: line)
    } catch {
        TestError.fail(.unexpectedError, file: file, line: line)
    }
}

func AsyncAssertEqual<E>(
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
