import XCTest

extension InvocableAssertionBuilder {
    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled(
        exactly expectedCalls: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        let actualCalls = invocationRecord[memberFnName]?.count ?? 0
        XCTAssertEqual(
            actualCalls,
            expectedCalls,
            """
            Inordinate number of function calls
            Expected function to be called exactly \(expectedCalls) times
            But was instead called \(actualCalls) times
            """,
            file: file,
            line: line
        )
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled(
        atLeast expectedCalls: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        let actualCalls = invocationRecord[memberFnName]?.count ?? 0
        XCTAssertGreaterThanOrEqual(
            actualCalls,
            expectedCalls,
            """
            Inordinate number of function calls
            Expected function to be called at least \(expectedCalls) times
            But was only called \(actualCalls) times
            """,
            file: file,
            line: line
        )
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled(
        noMoreThan expectedCalls: Int,
        file _: StaticString = #file,
        line _: UInt = #line
    ) -> Self {
        let actualCalls = invocationRecord[memberFnName]?.count ?? 0
        XCTAssertLessThanOrEqual(
            actualCalls,
            expectedCalls,
            """
            Inordinate number of function calls
            Expected function to be called no more than \(expectedCalls) times
            But was instead called \(actualCalls) times
            """
        )
        return self
    }
}
