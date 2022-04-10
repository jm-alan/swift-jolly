public struct Comparator<T, C> where C: Comparable {
    public let lhs: KeyPath<T, C>
    public let rhs: C
    public var method: ComparisonTypes = .equal

    public enum ComparisonTypes {
        case equal
        case lesser
        case lesserEqual
        case greater
        case greaterEqual
    }

    @inlinable
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
    public init(lhs: KeyPath<T, C>, rhs: C, method: ComparisonTypes = .equal) {
        self.lhs = lhs
        self.rhs = rhs
        self.method = method
    }
}
