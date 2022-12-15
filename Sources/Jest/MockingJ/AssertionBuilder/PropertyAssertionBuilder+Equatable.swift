import XCTest

extension PropertyAssertionBuilder where Value: Equatable {
    @inlinable
    @inline(__always)
    @discardableResult
    func toBe(
        equalTo expectedValue: Value,
        file: StaticString = #file,
        line: UInt = #line

    ) -> Self {
        XCTAssertEqual(value, expectedValue, file: file, line: line)
        return self
    }
}
