import XCTest

public func AsyncAssert(
    _ expression: @autoclosure () async throws -> Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) async rethrows {
    let result = try await expression()
    XCTAssert(result, message(), file: file, line: line)
}

public func AsyncAssertTrue(
    _ expression: @autoclosure () async throws -> Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) async rethrows {
    let result = try await expression()
    XCTAssertTrue(result, message(), file: file, line: line)
}

public func AsyncAssertFalse(
    _ expression: @autoclosure () async throws -> Bool,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) async rethrows {
    let result = try await expression()
    XCTAssertFalse(result, message(), file: file, line: line)
}

public func AsyncUnwrap<T>(
    _ expression: @autoclosure () async throws -> T?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) async throws -> T {
    let result = try await expression()
    return try XCTUnwrap(result, message(), file: file, line: line)
}

public func AsyncAssertNoThrow<T>(
    _ shouldNotThrow: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) async {
    do {
        try await _ = shouldNotThrow()
    } catch {
        var parsedMessage = message()
        if parsedMessage == "" {
            parsedMessage = "Caught unexpected error while evaluating expression"
        }
        XCTFail(parsedMessage, file: file, line: line)
    }
}

public func AsyncAssertNotNil<T>(
    _ shouldNotBeNil: @autoclosure () async throws -> T?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) async rethrows {
    let result = try await shouldNotBeNil()
    XCTAssertNotNil(result, message(), file: file, line: line)
}

public func AsyncAssertNil<T>(
    _ shouldBeNil: @autoclosure () async throws -> T?,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) async rethrows {
    let result = try await shouldBeNil()
    XCTAssertNil(result, message(), file: file, line: line)
}

public func AsyncAssertEqual<E>(
    _ expression1: @autoclosure () async throws -> E,
    _ expression2: @autoclosure () async throws -> E,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #file,
    line: UInt = #line
) async rethrows where E: Equatable {
    let lhs = try await expression1()
    let rhs = try await expression2()
    XCTAssertEqual(lhs, rhs, message(), file: file, line: line)
}
