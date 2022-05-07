public struct KeyComparator<T, C> where C: Comparable {
    public let leftKey: KeyPath<T, C>
    public let rightKey: KeyPath<T, C>
    public let method: ComparisonTypes

    @inlinable
    @inline(__always)
    public func getValue(lhs: T, rhs: T) -> Bool {
        switch method {
        case .equal:
            return lhs[keyPath: leftKey] == rhs[keyPath: rightKey]
        case .lesser:
            return lhs[keyPath: leftKey] < rhs[keyPath: rightKey]
        case .lesserEqual:
            return lhs[keyPath: leftKey] <= rhs[keyPath: rightKey]
        case .greater:
            return lhs[keyPath: leftKey] > rhs[keyPath: rightKey]
        case .greaterEqual:
            return lhs[keyPath: leftKey] >= rhs[keyPath: rightKey]
        }
    }

    @inlinable
    @inline(__always)
    public init(
        lhs: KeyPath<T, C>,
        rhs: KeyPath<T, C>,
        method: ComparisonTypes = .equal
    ) {
        leftKey = lhs
        rightKey = rhs
        self.method = method
    }
}

public struct ValueComparator<C> where C: Comparable {
    public let lhs: C
    public let rhs: C
    public let method: ComparisonTypes

    @inlinable
    @inline(__always)
    public func getValue() -> Bool {
        switch method {
        case .equal:
            return lhs == rhs
        case .lesser:
            return lhs < rhs
        case .lesserEqual:
            return lhs <= rhs
        case .greater:
            return lhs > rhs
        case .greaterEqual:
            return lhs >= rhs
        }
    }

    @inlinable
    @inline(__always)
    public init(lhs: C, rhs: C, method: ComparisonTypes = .equal) {
        self.lhs = lhs
        self.rhs = rhs
        self.method = method
    }
}

public struct KeyValComparator<T, C> where C: Comparable {
    public let lhs: KeyPath<T, C>
    public let rhs: C
    public var method: ComparisonTypes

    @inlinable
    @inline(__always)
    public func getValue(comparing value: T) -> Bool {
        switch method {
        case .equal:
            return value[keyPath: lhs] == rhs
        case .lesser:
            return value[keyPath: lhs] < rhs
        case .lesserEqual:
            return value[keyPath: lhs] <= rhs
        case .greater:
            return value[keyPath: lhs] > rhs
        case .greaterEqual:
            return value[keyPath: lhs] >= rhs
        }
    }

    @inlinable
    @inline(__always)
    public init(lhs: KeyPath<T, C>, rhs: C, method: ComparisonTypes = .equal) {
        self.lhs = lhs
        self.rhs = rhs
        self.method = method
    }
}

public enum ComparisonTypes {
    case equal
    case lesser
    case lesserEqual
    case greater
    case greaterEqual
}
