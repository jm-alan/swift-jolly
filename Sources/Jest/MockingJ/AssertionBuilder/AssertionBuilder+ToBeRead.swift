import XCTest

extension AssertionBuilder {
    @inlinable
    @inline(__always)
    @discardableResult
    func toBeRead(
        exactly expectedReads: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        let actualReads = accessRecord[targetKeyPath]?.count ?? 0
        XCTAssertEqual(
            expectedReads,
            actualReads,
            """
            Inordinate number of value reads
            Expected to be read exactly \(expectedReads) times
            But was instead read \(actualReads) times
            """,
            file: file,
            line: line
        )
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeRead(
        atLeast expectedReads: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        guard expectedReads > 0 else { return self }
        let actualReads = accessRecord[targetKeyPath]?.count ?? 0
        XCTAssertGreaterThanOrEqual(
            actualReads,
            expectedReads,
            """
            Inordinate number of value reads
            Expected value to be read at least \(expectedReads) times
            But was instead read only \(actualReads) times
            """,
            file: file,
            line: line
        )
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeRead(
        noMoreThan expectedReads: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        let actualReads = accessRecord[targetKeyPath]?.count ?? 0
        XCTAssertLessThanOrEqual(
            actualReads,
            expectedReads,
            """
            Inordinate number of value reads
            Expected value to be read no more than \(expectedReads) times
            But was instead read \(actualReads) times
            """,
            file: file,
            line: line
        )
        return self
    }
}
