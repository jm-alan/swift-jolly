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
        var result: AtomicValue<Wrapped>!
        lhs.use { leftVal in
            rhs.use { rightVal in
                result = .init(wrapped: leftVal + rightVal)
            }
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> AtomicValue<Wrapped> {
        var result: AtomicValue<Wrapped>!
        lhs.use { leftVal in
            result = .init(wrapped: leftVal + rhs)
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> AtomicValue<Wrapped> {
        var result: AtomicValue<Wrapped>!
        rhs.use { rightVal in
            result = .init(wrapped: lhs + rightVal)
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> Wrapped {
        var result: Wrapped!
        lhs.use { leftVal in
            rhs.use { rightVal in
                result = leftVal + rightVal
            }
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> Wrapped {
        var result: Wrapped!
        lhs.use { leftVal in
            result = leftVal + rhs
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func + (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> Wrapped {
        var result: Wrapped!
        rhs.use { rightVal in
            result = lhs + rightVal
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> AtomicValue<Wrapped> {
        var result: AtomicValue<Wrapped>!
        lhs.use { leftVal in
            rhs.use { rightVal in
                result = .init(wrapped: leftVal - rightVal)
            }
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> AtomicValue<Wrapped> {
        var result: AtomicValue<Wrapped>!
        lhs.use { leftVal in
            result = .init(wrapped: leftVal - rhs)
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> AtomicValue<Wrapped> {
        var result: AtomicValue<Wrapped>!
        rhs.use { rightVal in
            result = .init(wrapped: lhs - rightVal)
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) -> Wrapped {
        var result: Wrapped!
        lhs.use { leftVal in
            rhs.use { rightVal in
                result = leftVal - rightVal
            }
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: AtomicValue<Wrapped>,
        rhs: Wrapped
    ) -> Wrapped {
        var result: Wrapped!
        lhs.use { leftVal in
            result = leftVal - rhs
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func - (
        lhs: Wrapped,
        rhs: AtomicValue<Wrapped>
    ) -> Wrapped {
        var result: Wrapped!
        rhs.use { rightVal in
            result = lhs - rightVal
        }
        return result
    }

    @inlinable
    @inline(__always)
    public static func += (
        lhs: inout AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) {
        lhs.use { leftVal in
            rhs.use { rightVal in
                leftVal += rightVal
            }
        }
    }

    @inlinable
    @inline(__always)
    public static func += (
        lhs: inout AtomicValue<Wrapped>,
        rhs: Wrapped
    ) {
        lhs.use { leftVal in
            leftVal += rhs
        }
    }

    @inlinable
    @inline(__always)
    public static func += (
        lhs: inout Wrapped,
        rhs: AtomicValue<Wrapped>
    ) {
        rhs.use { rightVal in
            lhs += rightVal
        }
    }

    @inlinable
    @inline(__always)
    public static func -= (
        lhs: inout AtomicValue<Wrapped>,
        rhs: AtomicValue<Wrapped>
    ) {
        lhs.use { leftVal in
            rhs.use { rightVal in
                leftVal -= rightVal
            }
        }
    }

    @inlinable
    @inline(__always)
    public static func -= (
        lhs: inout AtomicValue<Wrapped>,
        rhs: Wrapped
    ) {
        lhs.use { leftVal in
            leftVal -= rhs
        }
    }

    @inlinable
    @inline(__always)
    public static func -= (
        lhs: inout Wrapped,
        rhs: AtomicValue<Wrapped>
    ) {
        rhs.use { rightVal in
            lhs -= rightVal
        }
    }
}
