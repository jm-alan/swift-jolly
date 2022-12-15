import XCTest

extension InvocableAssertionBuilder {
    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<Param1>(
        with expectedParameters: [Param1],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where Param1: Comparable {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard let typecastRecord = invocationRecordEntry as? [(Param1, Any)] else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (Any, Any)
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, actualTuple) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx],
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected function to be invoked with \(expectedParameters[idx])
                But was instead invoked with \(actualTuple.0)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<Param1, Param2>(
        with expectedParameters: [(Param1, Param2)],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard let typecastRecord = invocationRecordEntry as? [((Param1, Param2), Any)] else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! ((Any, Any), Any)
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<Param1, Param2, Param3>(
        with expectedParameters: [(Param1, Param2, Param3)],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable,
        Param3: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard
            let typecastRecord = invocationRecordEntry as? [((Param1, Param2, Param3), Any)]
        else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! ((Any, Any, Any), Any)
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.2,
                expectedParameters[idx].2,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected third argument to be \(expectedParameters[idx].2)
                But was instead \(actualTuple.2)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<
        Param1,
        Param2,
        Param3,
        Param4
    >(
        with expectedParameters: [(Param1, Param2, Param3, Param4)],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable,
        Param3: Comparable,
        Param4: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard
            let typecastRecord = invocationRecordEntry as? [(
                (
                    Param1,
                    Param2,
                    Param3,
                    Param4
                ),
                Any
            )]
        else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (
                (
                    Any,
                    Any,
                    Any,
                    Any
                ),
                Any
            )
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.2,
                expectedParameters[idx].2,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected third argument to be \(expectedParameters[idx].2)
                But was instead \(actualTuple.2)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.3,
                expectedParameters[idx].3,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fourth argument to be \(expectedParameters[idx].3)
                But was instead \(actualTuple.3)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5
    >(
        with expectedParameters: [(Param1, Param2, Param3, Param4, Param5)],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable,
        Param3: Comparable,
        Param4: Comparable,
        Param5: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard
            let typecastRecord = invocationRecordEntry as? [(
                (
                    Param1,
                    Param2,
                    Param3,
                    Param4,
                    Param5
                ),
                Any
            )]
        else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (
                (
                    Any,
                    Any,
                    Any,
                    Any,
                    Any
                ),

                Any
            )
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.2,
                expectedParameters[idx].2,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected third argument to be \(expectedParameters[idx].2)
                But was instead \(actualTuple.2)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.3,
                expectedParameters[idx].3,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fourth argument to be \(expectedParameters[idx].3)
                But was instead \(actualTuple.3)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.4,
                expectedParameters[idx].4,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fifth argument to be \(expectedParameters[idx].4)
                But was instead \(actualTuple.4)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5,
        Param6
    >(
        with expectedParameters: [(Param1, Param2, Param3, Param4, Param5, Param6)],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable,
        Param3: Comparable,
        Param4: Comparable,
        Param5: Comparable,
        Param6: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard
            let typecastRecord = invocationRecordEntry as? [(
                (
                    Param1,
                    Param2,
                    Param3,
                    Param4,
                    Param5,
                    Param6
                ),
                Any
            )]
        else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (
                (
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any
                ),
                Any
            )
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.2,
                expectedParameters[idx].2,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected third argument to be \(expectedParameters[idx].2)
                But was instead \(actualTuple.2)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.3,
                expectedParameters[idx].3,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fourth argument to be \(expectedParameters[idx].3)
                But was instead \(actualTuple.3)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.4,
                expectedParameters[idx].4,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fifth argument to be \(expectedParameters[idx].4)
                But was instead \(actualTuple.4)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.5,
                expectedParameters[idx].5,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected sixth argument to be \(expectedParameters[idx].5)
                But was instead \(actualTuple.5)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5,
        Param6,
        Param7
    >(
        with expectedParameters: [(Param1, Param2, Param3, Param4, Param5, Param6, Param7)],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable,
        Param3: Comparable,
        Param4: Comparable,
        Param5: Comparable,
        Param6: Comparable,
        Param7: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard
            let typecastRecord = invocationRecordEntry as? [(
                (
                    Param1,
                    Param2,
                    Param3,
                    Param4,
                    Param5,
                    Param6,
                    Param7
                ),
                Any
            )]
        else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (
                (
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any
                ),
                Any
            )
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.2,
                expectedParameters[idx].2,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected third argument to be \(expectedParameters[idx].2)
                But was instead \(actualTuple.2)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.3,
                expectedParameters[idx].3,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fourth argument to be \(expectedParameters[idx].3)
                But was instead \(actualTuple.3)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.4,
                expectedParameters[idx].4,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fifth argument to be \(expectedParameters[idx].4)
                But was instead \(actualTuple.4)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.5,
                expectedParameters[idx].5,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected sixth argument to be \(expectedParameters[idx].5)
                But was instead \(actualTuple.5)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.6,
                expectedParameters[idx].6,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected seventh argument to be \(expectedParameters[idx].6)
                But was instead \(actualTuple.6)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5,
        Param6,
        Param7,
        Param8
    >(
        with expectedParameters: [(
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8
        )],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable,
        Param3: Comparable,
        Param4: Comparable,
        Param5: Comparable,
        Param6: Comparable,
        Param7: Comparable,
        Param8: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard
            let typecastRecord = invocationRecordEntry as? [(
                (
                    Param1,
                    Param2,
                    Param3,
                    Param4,
                    Param5,
                    Param6,
                    Param7,
                    Param8
                ),
                Any
            )]
        else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (
                (
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any
                ),
                Any
            )
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.2,
                expectedParameters[idx].2,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected third argument to be \(expectedParameters[idx].2)
                But was instead \(actualTuple.2)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.3,
                expectedParameters[idx].3,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fourth argument to be \(expectedParameters[idx].3)
                But was instead \(actualTuple.3)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.4,
                expectedParameters[idx].4,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fifth argument to be \(expectedParameters[idx].4)
                But was instead \(actualTuple.4)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.5,
                expectedParameters[idx].5,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected sixth argument to be \(expectedParameters[idx].5)
                But was instead \(actualTuple.5)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.6,
                expectedParameters[idx].6,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected seventh argument to be \(expectedParameters[idx].6)
                But was instead \(actualTuple.6)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.7,
                expectedParameters[idx].7,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected eighth argument to be \(expectedParameters[idx].7)
                But was instead \(actualTuple.7)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5,
        Param6,
        Param7,
        Param8,
        Param9
    >(
        with expectedParameters: [(
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8,
            Param9
        )],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable,
        Param3: Comparable,
        Param4: Comparable,
        Param5: Comparable,
        Param6: Comparable,
        Param7: Comparable,
        Param8: Comparable,
        Param9: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard
            let typecastRecord = invocationRecordEntry as? [(
                (
                    Param1,
                    Param2,
                    Param3,
                    Param4,
                    Param5,
                    Param6,
                    Param7,
                    Param8,
                    Param9
                ),
                Any
            )]
        else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (
                (
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any
                ),
                Any
            )
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.2,
                expectedParameters[idx].2,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected third argument to be \(expectedParameters[idx].2)
                But was instead \(actualTuple.2)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.3,
                expectedParameters[idx].3,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fourth argument to be \(expectedParameters[idx].3)
                But was instead \(actualTuple.3)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.4,
                expectedParameters[idx].4,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fifth argument to be \(expectedParameters[idx].4)
                But was instead \(actualTuple.4)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.5,
                expectedParameters[idx].5,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected sixth argument to be \(expectedParameters[idx].5)
                But was instead \(actualTuple.5)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.6,
                expectedParameters[idx].6,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected seventh argument to be \(expectedParameters[idx].6)
                But was instead \(actualTuple.6)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.7,
                expectedParameters[idx].7,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected eighth argument to be \(expectedParameters[idx].7)
                But was instead \(actualTuple.7)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.8,
                expectedParameters[idx].8,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected ninth argument to be \(expectedParameters[idx].8)
                But was instead \(actualTuple.8)
                """,
                file: file,
                line: line
            )
        }
        return self
    }

    @inlinable
    @inline(__always)
    @discardableResult
    func toBeCalled<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5,
        Param6,
        Param7,
        Param8,
        Param9,
        Param10
    >(
        with expectedParameters: [(
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8,
            Param9,
            Param10
        )],
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self where
        Param1: Comparable,
        Param2: Comparable,
        Param3: Comparable,
        Param4: Comparable,
        Param5: Comparable,
        Param6: Comparable,
        Param7: Comparable,
        Param8: Comparable,
        Param9: Comparable,
        Param10: Comparable
    {
        guard !expectedParameters.isEmpty else {
            XCTFail(
                """
                At least one parameter must be provided to test against
                """,
                file: file,
                line: line
            )
            return self
        }
        guard
            let invocationRecordEntry = invocationRecord[memberFnName],
            !invocationRecordEntry.isEmpty
        else {
            XCTFail("Function was never invoked", file: file, line: line)
            return self
        }
        guard
            let typecastRecord = invocationRecordEntry as? [(
                (
                    Param1,
                    Param2,
                    Param3,
                    Param4,
                    Param5,
                    Param6,
                    Param7,
                    Param8,
                    Param9,
                    Param10
                ),
                Any
            )]
        else {
            let knownSafeTupleCast = invocationRecordEntry.first! as! (
                (
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any,
                    Any
                ),
                Any
            )
            XCTFail(
                """
                Function parameter type was incorrect
                Expected to find \(type(of: expectedParameters.first!))
                Instead found \(type(of: knownSafeTupleCast.0))
                """,
                file: file,
                line: line
            )
            return self
        }
        guard typecastRecord.count == expectedParameters.count else {
            XCTFail(
                """
                Function was invoked \(typecastRecord.count) times
                but \(expectedParameters.count) test parameters were provided
                """
            )
            return self
        }
        for (idx, (actualTuple, _)) in typecastRecord.enumerated() {
            XCTAssertEqual(
                actualTuple.0,
                expectedParameters[idx].0,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected first argument to be \(expectedParameters[idx].0)
                But was instead \(actualTuple.0)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.1,
                expectedParameters[idx].1,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected second argument to be \(expectedParameters[idx].1)
                But was instead \(actualTuple.1)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.2,
                expectedParameters[idx].2,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected third argument to be \(expectedParameters[idx].2)
                But was instead \(actualTuple.2)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.3,
                expectedParameters[idx].3,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fourth argument to be \(expectedParameters[idx].3)
                But was instead \(actualTuple.3)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.4,
                expectedParameters[idx].4,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected fifth argument to be \(expectedParameters[idx].4)
                But was instead \(actualTuple.4)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.5,
                expectedParameters[idx].5,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected sixth argument to be \(expectedParameters[idx].5)
                But was instead \(actualTuple.5)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.6,
                expectedParameters[idx].6,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected seventh argument to be \(expectedParameters[idx].6)
                But was instead \(actualTuple.6)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.7,
                expectedParameters[idx].7,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected eighth argument to be \(expectedParameters[idx].7)
                But was instead \(actualTuple.7)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.8,
                expectedParameters[idx].8,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected ninth argument to be \(expectedParameters[idx].8)
                But was instead \(actualTuple.8)
                """,
                file: file,
                line: line
            )
            XCTAssertEqual(
                actualTuple.9,
                expectedParameters[idx].9,
                """
                Incorrect parameter passed to function on invocation \(idx + 1)
                Expected tenth argument to be \(expectedParameters[idx].9)
                But was instead \(actualTuple.9)
                """,
                file: file,
                line: line
            )
        }
        return self
    }
}
