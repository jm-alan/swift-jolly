@inlinable
@inline(__always)
public func <= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable { .init(lhs: lhs, rhs: rhs, method: .lessEqual) }

@inlinable
@inline(__always)
public func <= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable { .init(lhs: lhs, rhs: rhs, method: .lessEqual) }
