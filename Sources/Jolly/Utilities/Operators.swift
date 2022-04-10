prefix operator ==
prefix operator <~
prefix operator >~
prefix operator >=
prefix operator <=

@inlinable
public func == <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs)
}

@inlinable
public func < <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesser)
}

@inlinable
public func <= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesserEqual)
}

@inlinable
public func > <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greater)
}

@inlinable
public func >= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: KeyPath<T, C>
) -> KeyComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greaterEqual)
}

@inlinable
public func == <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs)
}

@inlinable
public func < <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesser)
}

@inlinable
public func <= <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesserEqual)
}

@inlinable
public func > <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greater)
}

@inlinable
public func >= <C>(
    _ lhs: C,
    _ rhs: C
) -> ValueComparator<C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greaterEqual)
}

@inlinable
public func == <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs)
}

@inlinable
public func < <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesser)
}

@inlinable
public func <= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .lesserEqual)
}

@inlinable
public func > <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greater)
}

@inlinable
public func >= <T, C>(
    _ lhs: KeyPath<T, C>,
    _ rhs: C
) -> KeyValComparator<T, C> where C: Comparable {
    .init(lhs: lhs, rhs: rhs, method: .greaterEqual)
}

@inlinable
public prefix func == <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable == rhs
    }
}

@inlinable
public prefix func <~ <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable < rhs
    }
}

@inlinable
public prefix func <= <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable <= rhs
    }
}

@inlinable
public prefix func >~ <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable > rhs
    }
}

@inlinable
public prefix func >= <C>(_ rhs: C) -> ((C) -> Bool) where C: Comparable {
    return { (comparable: C) in
        comparable >= rhs
    }
}
