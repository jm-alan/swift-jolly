extension AtomicValue: Equatable where Wrapped: Equatable {
    @inlinable
    @inline(__always)
    public static func == (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> Bool {
        var result: Bool!
        lhs.use { leftVal in
            rhs.use { rightVal in
                result = leftVal == rightVal
            }
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func == (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> Bool {
        var result: Bool!
        lhs.use { leftVal in
            result = leftVal == rhs
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func == (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> Bool {
        var result: Bool!
        rhs.use { rightVal in
            result = lhs == rightVal
        }
        return result
    }
}
