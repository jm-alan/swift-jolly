extension Mocked {
    @inlinable
    @inline(__always)
    subscript<T>(key: KeyPath<Mockable, T>) -> T {
        let value = Mocked.time(
            mocked[keyPath: key],
            originatingFrom: key,
            storingResultIn: &accessTimeRecord
        )
        makeAccessRecord(for: key, of: value)
        return value
    }

    @inlinable
    @inline(__always)
    subscript<T>(key: WritableKeyPath<Mockable, T>) -> T {
        get {
            let value = Mocked.time(
                mocked[keyPath: key],
                originatingFrom: key,
                storingResultIn: &accessTimeRecord
            )
            makeAccessRecord(for: key, of: value)
            return value
        }
        set(value) {
            Mocked.time(
                mocked[keyPath: key] = value,
                originatingFrom: key,
                storingResultIn: &writeTimeRecord
            )
            makeWriteRecord(for: key, of: value)
        }
    }

    @inlinable
    @inline(__always)
    subscript<Param, Return>(
        key: KeyPath<Mockable, (Param) -> Return>
    ) -> (Param) -> Return {
        let mockedFunction: (Param) -> Return = { [self] param in
            let value = Mocked.time(
                mocked[keyPath: key](param),
                originatingFrom: key,
                storingResultIn: &self.invocationTimeRecord
            )
            makeInvocationRecord(for: key, with: param, returning: value)
            return value
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Return>(
        key: KeyPath<Mockable, (Param1, Param2) -> Return>
    ) -> (Param1, Param2) -> Return {
        let mockedFunction: (Param1, Param2) -> Return = { [self] param1, param2 in
            let value = Mocked.time(
                mocked[keyPath: key](param1, param2),
                originatingFrom: key,
                storingResultIn: &self.invocationTimeRecord
            )
            makeInvocationRecord(for: key, with: (param1, param2), returning: value)
            return value
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Param3, Return>(
        key: KeyPath<Mockable, (Param1, Param2, Param3) -> Return>
    ) -> (Param1, Param2, Param3) -> Return {
        let mockedFunction: (Param1, Param2, Param3) -> Return = { [self] param1, param2, param3 in
            let value = Mocked.time(
                mocked[keyPath: key](param1, param2, param3),
                originatingFrom: key,
                storingResultIn: &self.invocationTimeRecord
            )
            makeInvocationRecord(for: key, with: (param1, param2, param3), returning: value)
            return value
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Param3, Param4, Return>(
        key: KeyPath<Mockable, (Param1, Param2, Param3, Param4) -> Return>
    ) -> (Param1, Param2, Param3, Param4) -> Return {
        let mockedFunction: (Param1, Param2, Param3, Param4)
            -> Return = { [self] param1, param2, param3, param4 in
                let value = Mocked.time(
                    mocked[keyPath: key](param1, param2, param3, param4),
                    originatingFrom: key,
                    storingResultIn: &self.invocationTimeRecord
                )
                makeInvocationRecord(
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
    subscript<Param1, Param2, Param3, Param4, Param5, Return>(
        key: KeyPath<Mockable, (Param1, Param2, Param3, Param4, Param5) -> Return>
    ) -> (Param1, Param2, Param3, Param4, Param5) -> Return {
        let mockedFunction: (Param1, Param2, Param3, Param4, Param5)
            -> Return = { [self] param1, param2, param3, param4, param5 in
                let value = Mocked.time(
                    mocked[keyPath: key](param1, param2, param3, param4, param5),
                    originatingFrom: key,
                    storingResultIn: &self.invocationTimeRecord
                )
                makeInvocationRecord(
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
    subscript<Param1, Param2, Param3, Param4, Param5, Param6, Return>(
        key: KeyPath<Mockable, (Param1, Param2, Param3, Param4, Param5, Param6) -> Return>
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6) -> Return {
        let mockedFunction: (Param1, Param2, Param3, Param4, Param5, Param6)
            -> Return = { [self] param1, param2, param3, param4, param5, param6 in
                let value = Mocked.time(
                    mocked[keyPath: key](param1, param2, param3, param4, param5, param6),
                    originatingFrom: key,
                    storingResultIn: &self.invocationTimeRecord
                )
                makeInvocationRecord(
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
    subscript<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Return>(
        key: KeyPath<
            Mockable,
            (Param1, Param2, Param3, Param4, Param5, Param6, Param7) -> Return
        >
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7) -> Return {
        let mockedFunction: (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7
        ) -> Return = { [self] param1, param2, param3, param4, param5, param6, param7 in
            let value = Mocked.time(
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
                storingResultIn: &self.invocationTimeRecord
            )
            makeInvocationRecord(
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
    subscript<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8, Return>(
        key: KeyPath<
            Mockable,
            (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8) -> Return
        >
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8) -> Return {
        let mockedFunction: (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8
        ) -> Return = { [self] param1, param2, param3, param4, param5, param6, param7, param8 in
            let value = Mocked.time(
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
                storingResultIn: &self.invocationTimeRecord
            )
            makeInvocationRecord(
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
    subscript<
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
            ) -> Return
        >
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8, Param9) -> Return {
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
        ) -> Return =
            { [self] param1, param2, param3, param4, param5, param6, param7, param8, param9 in
                let value = Mocked.time(
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
                    storingResultIn: &self.invocationTimeRecord
                )
                makeInvocationRecord(
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
    subscript<
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
            ) -> Return
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
    ) -> Return {
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
        ) -> Return =
            { [self] param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 in
                let value = Mocked.time(
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
                    storingResultIn: &self.invocationTimeRecord
                )
                makeInvocationRecord(
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
