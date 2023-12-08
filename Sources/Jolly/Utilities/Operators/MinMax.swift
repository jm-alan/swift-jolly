infix operator <>
infix operator ><

/// Returns the smaller of two values
///
///     let min = 7 <> 6
///     print(min) // 6
@inlinable
@inline(__always)
public func <> <C>(lhs: C, rhs: C) -> C where C: Comparable { lhs < rhs ? lhs : rhs }

/// Returns the larger of two values
///
///     let max = 7 >< 6
///     print(max) // 7
@inlinable
@inline(__always)
public func >< <C>(lhs: C, rhs: C) -> C where C: Comparable { lhs < rhs ? rhs : lhs }
