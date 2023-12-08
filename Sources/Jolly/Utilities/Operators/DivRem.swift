infix operator /%

/// Returns the quotient and remainder resulting from dividing the left hand side by the right.
@inlinable
@inline(__always)
public func /% (lhs: Int, rhs: Int) -> (Int, Int) { lhs.quotientAndRemainder(dividingBy: rhs) }
