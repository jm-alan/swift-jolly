import XCTest

extension AssertionBuilder {
    @inlinable
    @inline(__always)
    @discardableResult
    func toBeWritten(
        exactly expectedWrites: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        let actualWrites = writeRecord[targetKeyPath]?.count ?? 0
        XCTAssertEqual(
            expectedWrites,
            actualWrites,
            """
            Inordinate number of value writes
            Expected to be written to exactly \(expectedWrites) times
            But was instead written to \(actualWrites) times
            """,
            file: file,
            line: line
        )
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeWritten(
        atLeast expectedWrites: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        let actualWrites = writeRecord[targetKeyPath]?.count ?? 0
        XCTAssertGreaterThanOrEqual(
            actualWrites,
            expectedWrites,
            """
            Inordinate number of value writes
            Expected value to be written to at least \(expectedWrites) times
            But was instead written to only \(actualWrites) times
            """,
            file: file,
            line: line
        )
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeWritten(
        noMoreThan expectedWrites: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        let actualWrites = writeRecord[targetKeyPath]?.count ?? 0
        XCTAssertLessThanOrEqual(
            actualWrites,
            expectedWrites,
            """
            Inordinate number of value writes
            Expected value to be written to no more than \(expectedWrites) times
            But was instead written to \(actualWrites) times
            """,
            file: file,
            line: line
        )
        return self
    }
}
