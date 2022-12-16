extension Mocked {
    @inlinable
    @inline(__always)
    func at<Param, Return>(
        key: KeyPath < Mockable, (Param) throws -> Return>
    ) -> (Param) throws -> Return {
        let mockedFunction: (Param) throws -> Return = { [self] param in
            let value = try Self.time(
                mocked[keyPath: key](param),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(for: key, with: param, returning: value)
            return value
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<Param1, Param2, Return>(
        key: KeyPath < Mockable, (Param1, Param2) throws -> Return>
    ) -> (Param1, Param2) throws -> Return {
        let mockedFunction: (Param1, Param2) throws -> Return = { [self] param1, param2 in
            let value = try Self.time(
                mocked[keyPath: key](param1, param2),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(for: key, with: (param1, param2), returning: value)
            return value
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<Param1, Param2, Param3, Return>(
        key: KeyPath < Mockable, (Param1, Param2, Param3) throws -> Return>
    ) -> (Param1, Param2, Param3) throws -> Return {
        let mockedFunction: (Param1, Param2, Param3) throws
            -> Return = { [self] param1, param2, param3 in
                let value = try Self.time(
                    mocked[keyPath: key](param1, param2, param3),
                    originatingFrom: key,
                    storingResultIn: &self.closureInvocationTimeRecord
                )
                makeClosureInvocationRecord(
                    for: key,
                    with: (param1, param2, param3),
                    returning: value
                )
                return value
            }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<Param1, Param2, Param3, Param4, Return>(
        key: KeyPath < Mockable, (Param1, Param2, Param3, Param4) throws -> Return>
    ) -> (Param1, Param2, Param3, Param4) throws -> Return {
        let mockedFunction: (Param1, Param2, Param3, Param4)
            throws -> Return = { [self] param1, param2, param3, param4 in
                let value = try Self.time(
                    mocked[keyPath: key](param1, param2, param3, param4),
                    originatingFrom: key,
                    storingResultIn: &self.closureInvocationTimeRecord
                )
                makeClosureInvocationRecord(
                    for: key,
                    with: (param1, param2, param3, param4),
                    returning: value
                )
                return value
            }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<Param1, Param2, Param3, Param4, Param5, Return>(
        key: KeyPath < Mockable, (Param1, Param2, Param3, Param4, Param5) throws -> Return>
    ) -> (Param1, Param2, Param3, Param4, Param5) throws -> Return {
        let mockedFunction: (Param1, Param2, Param3, Param4, Param5)
            throws -> Return = { [self] param1, param2, param3, param4, param5 in
                let value = try Self.time(
                    mocked[keyPath: key](param1, param2, param3, param4, param5),
                    originatingFrom: key,
                    storingResultIn: &self.closureInvocationTimeRecord
                )
                makeClosureInvocationRecord(
                    for: key,
                    with: (param1, param2, param3, param4, param5),
                    returning: value
                )
                return value
            }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<Param1, Param2, Param3, Param4, Param5, Param6, Return>(
        key: KeyPath < Mockable, (Param1, Param2, Param3, Param4, Param5, Param6) throws -> Return>
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6) throws -> Return {
        let mockedFunction: (Param1, Param2, Param3, Param4, Param5, Param6)
            throws -> Return = { [self] param1, param2, param3, param4, param5, param6 in
                let value = try Self.time(
                    mocked[keyPath: key](param1, param2, param3, param4, param5, param6),
                    originatingFrom: key,
                    storingResultIn: &self.closureInvocationTimeRecord
                )
                makeClosureInvocationRecord(
                    for: key,
                    with: (param1, param2, param3, param4, param5, param6),
                    returning: value
                )
                return value
            }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Return>(
        key: KeyPath < Mockable,
        (Param1, Param2, Param3, Param4, Param5, Param6, Param7) throws -> Return>
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7) throws -> Return {
        let mockedFunction: (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7
        ) throws -> Return = { [self] param1, param2, param3, param4, param5, param6, param7 in
            let value = try Self.time(
                mocked[keyPath: key](
                    param1,
                    param2,
                    param3,
                    param4,
                    param5,
                    param6,
                    param7
                ),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(
                for: key,
                with: (param1, param2, param3, param4, param5, param6, param7),
                returning: value
            )
            return value
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8, Return>(
        key: KeyPath<
        Mockable,
        (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8) throws -> Return
        >
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8) throws -> Return {
        let mockedFunction: (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8
        ) throws -> Return =
            { [self] param1, param2, param3, param4, param5, param6, param7, param8 in
                let value = try Self.time(
                    mocked[keyPath: key](
                        param1,
                        param2,
                        param3,
                        param4,
                        param5,
                        param6,
                        param7,
                        param8
                    ),
                    originatingFrom: key,
                    storingResultIn: &self.closureInvocationTimeRecord
                )
                makeClosureInvocationRecord(
                    for: key,
                    with: (param1, param2, param3, param4, param5, param6, param7, param8),
                    returning: value
                )
                return value
            }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5,
        Param6,
        Param7,
        Param8,
        Param9,
        Return
    >(
        key: KeyPath<
        Mockable, (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8,
            Param9
        ) throws -> Return
        >
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8, Param9) throws -> Return {
        let mockedFunction: (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8,
            Param9
        ) throws -> Return =
            { [self] param1, param2, param3, param4, param5, param6, param7, param8, param9 in
                let value = try Self.time(
                    mocked[keyPath: key](
                        param1,
                        param2,
                        param3,
                        param4,
                        param5,
                        param6,
                        param7,
                        param8,
                        param9
                    ),
                    originatingFrom: key,
                    storingResultIn: &self.closureInvocationTimeRecord
                )
                makeClosureInvocationRecord(
                    for: key,
                    with: (param1, param2, param3, param4, param5, param6, param7, param8, param9),
                    returning: value
                )
                return value
            }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    func at<
        Param1,
        Param2,
        Param3,
        Param4,
        Param5,
        Param6,
        Param7,
        Param8,
        Param9,
        Param10,
        Return
    >(
        key: KeyPath<
        Mockable, (
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
        ) throws -> Return
        >
    ) -> (
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
    ) throws -> Return {
        let mockedFunction: (
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
        ) throws -> Return =
            { [self] param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 in
                let value = try Self.time(
                    mocked[keyPath: key](
                        param1,
                        param2,
                        param3,
                        param4,
                        param5,
                        param6,
                        param7,
                        param8,
                        param9,
                        param10
                    ),
                    originatingFrom: key,
                    storingResultIn: &self.closureInvocationTimeRecord
                )
                makeClosureInvocationRecord(
                    for: key,
                    with: (
                        param1,
                        param2,
                        param3,
                        param4,
                        param5,
                        param6,
                        param7,
                        param8,
                        param9,
                        param10
                    ),
                    returning: value
                )
                return value
            }
        return mockedFunction
    }
}
