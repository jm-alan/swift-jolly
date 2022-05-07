prefix operator ==
prefix operator <~
prefix operator >~
prefix operator >=
prefix operator <=

@inlinable
@inline(__always)
public func == <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs)
}

@inlinable
@inline(__always)
public func < <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesser)
}

@inlinable
@inline(__always)
public func <= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesserEqual)
}

@inlinable
@inline(__always)
public func > <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greater)
}

@inlinable
@inline(__always)
public func >= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greaterEqual)
}

@inlinable
@inline(__always)
public func == <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs)
}

@inlinable
@inline(__always)
public func < <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesser)
}

@inlinable
@inline(__always)
public func <= <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesserEqual)
}

@inlinable
@inline(__always)
public func > <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greater)
}

@inlinable
@inline(__always)
public func >= <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greaterEqual)
}

@inlinable
@inline(__always)
public func == <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs)
}

@inlinable
@inline(__always)
public func < <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesser)
}

@inlinable
@inline(__always)
public func <= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesserEqual)
}

@inlinable
@inline(__always)
public func > <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greater)
}

@inlinable
@inline(__always)
public func >= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greaterEqual)
}

@inlinable
@inline(__always)
public prefix func == <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable == rhs
    }
}

@inlinable
@inline(__always)
public prefix func <~ <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable < rhs
    }
}

@inlinable
@inline(__always)
public prefix func <= <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable <= rhs
    }
}

@inlinable
@inline(__always)
public prefix func >~ <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable > rhs
    }
}

@inlinable
@inline(__always)
public prefix func >= <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable >= rhs
    }
}
