import XCTest

extension AssertionBuilder where Value: Equatable {
    @inlinable
    @inline(__always)
    @discardableResult
    func toBe(
        equalTo expectedValue: Value,
        file: StaticString = #file,
        line: UInt = #line

    ) -> Self {
        XCTAssertEqual(mocked[keyPath: targetKeyPath], expectedValue, file: file, line: line)
        return self
    }
}
