prefix operator <=

@inlinable
@inline(__always)
public prefix func <= <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable { { $0 <= rhs } }
