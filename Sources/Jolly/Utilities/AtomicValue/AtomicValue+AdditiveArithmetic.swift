extension AtomicValue: AdditiveArithmetic where Wrapped: AdditiveArithmetic {
    @inlinable
    @inline(__always)
    public static var zero: AtomicValue<Wrapped> {
        return .init(wrapped: Wrapped.zero)
    }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> AtomicValue<Wrapped> {
        lhs.use { leftVal in rhs.use { .init(wrapped: leftVal + $0) } }
    }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> AtomicValue<Wrapped> { lhs.use { .init(wrapped: $0 + rhs) } }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> AtomicValue<Wrapped> { rhs.use { .init(wrapped: lhs + $0) } }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> Wrapped {
        lhs.use { leftVal in rhs.use { leftVal + $0 } }
    }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> Wrapped { lhs.use { $0 + rhs } }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> Wrapped { rhs.use { lhs + $0 } }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> AtomicValue<Wrapped> {
        lhs.use { leftVal in rhs.use { .init(wrapped: leftVal - $0) } }
    }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> AtomicValue<Wrapped> { lhs.use { .init(wrapped: $0 - rhs) } }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> AtomicValue<Wrapped> { rhs.use { .init(wrapped: lhs - $0) } }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> Wrapped {
        lhs.use { leftVal in rhs.use { leftVal - $0 } }
    }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> Wrapped { lhs.use { $0 - rhs } }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> Wrapped { rhs.use { lhs - $0 } }

    @inlinable
    @inline(__always)
    public static func += (
        lhs: inout AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) { rhs.use { rightVal in lhs.mut { $0 += rightVal } } }

    @inlinable
    @inline(__always)
    public static func += (
        lhs: inout AtomicValue<Wrapped>,
        rhs: Wrapped
    ) { lhs.mut { $0 += rhs } }

    @inlinable
    @inline(__always)
    public static func += (
        lhs: inout Wrapped,
        rhs: AtomicValue<Wrapped>
    ) { rhs.use { lhs += $0 } }

    @inlinable
    @inline(__always)
    public static func -= (
        lhs: inout AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) { rhs.use { rightVal in lhs.mut { $0 -= rightVal } } }

    @inlinable
    @inline(__always)
    public static func -= (
        lhs: inout AtomicValue<Wrapped>,
        rhs: Wrapped
    ) { lhs.mut { $0 -= rhs } }

    @inlinable
    @inline(__always)
    public static func -= (
        lhs: inout Wrapped,
        rhs: AtomicValue<Wrapped>
    ) { rhs.use { lhs -= $0 } }
}
