infix operator /%

/// Returns the quotient and remainder resulting from dividing the left hand side by the right
///
///     let (quotient, remainder) = 13 /% 6
///     print(quotient, remainder) // 2, 1
@inlinable
@inline(__always)
public func /% (lhs: Int, rhs: Int) -> (Int, Int) { lhs.quotientAndRemainder(dividingBy: rhs) }
