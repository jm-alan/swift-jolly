extension AtomicValue: Comparable where Wrapped: Comparable {
    @inlinable
    @inline(__always)
    public static func < (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> Bool { lhs.use { leftVal in rhs.use { leftVal < $0 } } }

    @inlinable
    @inline(__always)
    public static func < (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> Bool { lhs.use { $0 < rhs } }

    @inlinable
    @inline(__always)
    public static func < (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> Bool { rhs.use { lhs < $0 } }
}
