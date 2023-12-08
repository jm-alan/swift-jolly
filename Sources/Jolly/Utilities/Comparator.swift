public struct KeyComparator<T, C> where C: Comparable {
    public let leftKey: KeyPath<T, C>
    public let rightKey: KeyPath<T, C>
    public let method: ComparisonType

    @inlinable
    @inline(__always)
    public func getValue(lhs: T, rhs: T) -> Bool {
        switch method {
        case .equal:
            return lhs[keyPath: leftKey] == rhs[keyPath: rightKey]
        case .less:
            return lhs[keyPath: leftKey] < rhs[keyPath: rightKey]
        case .lessEqual:
            return lhs[keyPath: leftKey] <= rhs[keyPath: rightKey]
        case .greater:
            return lhs[keyPath: leftKey] > rhs[keyPath: rightKey]
        case .greaterEqual:
            return lhs[keyPath: leftKey] >= rhs[keyPath: rightKey]
        }
    }

    public init(
        lhs: KeyPath<T, C>,
        rhs: KeyPath<T, C>,
        method: ComparisonType = .equal
    ) {
        leftKey = lhs
        rightKey = rhs
        self.method = method
    }
}

public struct KeyValComparator<T, C> where C: Comparable {
    public let lhs: KeyPath<T, C>
    public let rhs: C
    public var method: ComparisonType

    @inlinable
    @inline(__always)
    public func getValue(comparing value: T) -> Bool {
        switch method {
        case .equal:
            return value[keyPath: lhs] == rhs
        case .less:
            return value[keyPath: lhs] < rhs
        case .lessEqual:
            return value[keyPath: lhs] <= rhs
        case .greater:
            return value[keyPath: lhs] > rhs
        case .greaterEqual:
            return value[keyPath: lhs] >= rhs
        }
    }

    public init(lhs: KeyPath<T, C>, rhs: C, method: ComparisonType = .equal) {
        self.lhs = lhs
        self.rhs = rhs
        self.method = method
    }
}

public enum ComparisonType {
    case equal
    case less
    case lessEqual
    case greater
    case greaterEqual
}
