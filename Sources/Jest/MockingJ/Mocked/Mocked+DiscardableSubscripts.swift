extension Mocked {
    @inlinable
    @inline(__always)
    subscript<Param, Return>(
        discardable key: KeyPath<Mockable, (Param) -> Return>
    ) -> (Param) -> Void {
        let mockedFunction: (Param) -> Void = { [self] param in
            let value = Self.time(
                mocked[keyPath: key](param),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(for: key, with: param, returning: value)
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Return>(
        discardable key: KeyPath<Mockable, (Param1, Param2) -> Return>
    ) -> (Param1, Param2) -> Void {
        let mockedFunction: (Param1, Param2) -> Void = { [self] param1, param2 in
            let value = Self.time(
                mocked[keyPath: key](param1, param2),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(for: key, with: (param1, param2), returning: value)
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Param3, Return>(
        discardable key: KeyPath<Mockable, (Param1, Param2, Param3) -> Return>
    ) -> (Param1, Param2, Param3) -> Void {
        let mockedFunction: (Param1, Param2, Param3) -> Void = { [self] param1, param2, param3 in
            let value = Self.time(
                mocked[keyPath: key](param1, param2, param3),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(for: key, with: (param1, param2, param3), returning: value)
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Param3, Param4, Return>(
        discardable key: KeyPath<Mockable, (Param1, Param2, Param3, Param4) -> Return>
    ) -> (Param1, Param2, Param3, Param4) -> Void {
        let mockedFunction: (Param1, Param2, Param3, Param4)
        -> Void = { [self] param1, param2, param3, param4 in
            let value = Self.time(
                mocked[keyPath: key](param1, param2, param3, param4),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(
                for: key,
                with: (param1, param2, param3, param4),
                returning: value
            )
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Param3, Param4, Param5, Return>(
        discardable key: KeyPath<Mockable, (Param1, Param2, Param3, Param4, Param5) -> Return>
    ) -> (Param1, Param2, Param3, Param4, Param5) -> Void {
        let mockedFunction: (Param1, Param2, Param3, Param4, Param5)
        -> Void = { [self] param1, param2, param3, param4, param5 in
            let value = Self.time(
                mocked[keyPath: key](param1, param2, param3, param4, param5),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(
                for: key,
                with: (param1, param2, param3, param4, param5),
                returning: value
            )
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Param3, Param4, Param5, Param6, Return>(
        discardable key: KeyPath<Mockable, (Param1, Param2, Param3, Param4, Param5, Param6) -> Return>
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6) -> Void {
        let mockedFunction: (Param1, Param2, Param3, Param4, Param5, Param6)
        -> Void = { [self] param1, param2, param3, param4, param5, param6 in
            let value = Self.time(
                mocked[keyPath: key](param1, param2, param3, param4, param5, param6),
                originatingFrom: key,
                storingResultIn: &self.closureInvocationTimeRecord
            )
            makeClosureInvocationRecord(
                for: key,
                with: (param1, param2, param3, param4, param5, param6),
                returning: value
            )
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Return>(
        discardable key: KeyPath<
        Mockable,
        (Param1, Param2, Param3, Param4, Param5, Param6, Param7) -> Return
        >
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7) -> Void {
        let mockedFunction: (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7
        ) -> Void = { [self] param1, param2, param3, param4, param5, param6, param7 in
            let value = Self.time(
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
        }
        return mockedFunction
    }

    @inlinable
    @inline(__always)
    subscript<Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8, Return>(
        discardable key: KeyPath<
        Mockable,
        (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8) -> Return
        >
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8) -> Void {
        let mockedFunction: (
            Param1,
            Param2,
            Param3,
            Param4,
            Param5,
            Param6,
            Param7,
            Param8
        ) -> Void = { [self] param1, param2, param3, param4, param5, param6, param7, param8 in
            let value = Self.time(
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
        discardable key: KeyPath<
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
    ) -> (Param1, Param2, Param3, Param4, Param5, Param6, Param7, Param8, Param9) -> Void {
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
        ) -> Void =
        { [self] param1, param2, param3, param4, param5, param6, param7, param8, param9 in
            let value = Self.time(
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
        discardable key: KeyPath<
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
    ) -> Void {
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
        ) -> Void =
        { [self] param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 in
            let value = Self.time(
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
        }
        return mockedFunction
    }
}
