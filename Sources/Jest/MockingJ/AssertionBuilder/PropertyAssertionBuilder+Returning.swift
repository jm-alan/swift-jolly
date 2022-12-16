import XCTest

extension PropertyAssertionBuilder {
    @inlinable
    @inline(__always)
    @discardableResult
    func toReturn<Return>(
        _ expectedReturns: [Return],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where Return: Comparable {
        guard !expectedReturns.isEmpty else {
            XCTFail(
                """
                At least one return value must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[accessor],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard let typecastRecord = invocationRecordEntry as? [(Any, Return)] else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (Any, Any)
            XCTFail(
                """
                Function return type was incorrect
                Expected to find \(type(of: expectedReturns.first!))
                Instead found \(type(of: knownSafeTupleCast.1))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedReturns.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedReturns.count) test return values were provided
                """
            )
            return self
        }
        for (idx, actualTuple) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.1,
                expectedReturns[idx],
                """
                Incorrect return value produced on invocation \(idx + 1)
                Expected function to return \(expectedReturns[idx])
                But instead returned \(actualTuple.1)
                """,
                file: file,
                line: line
            )
        }
        return self
    }
}
