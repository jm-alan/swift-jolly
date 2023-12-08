
public extension Sequence {
    @inlinable
    @inline(__always)
    func grouped<H>(
        by keyPath: KeyPath<Element, H>
    ) -> [H: [Element]] where H: Hashable {
        grouped { $0[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, ValueType>
    ) -> [KeyType: [ValueType]] where KeyType: Hashable {
        grouped {
            $0[keyPath: keyPath]
        } valueSelector: {
            $0[keyPath: valuePath]
        }
    }

    @inlinable
    @inline(__always)
    func grouped<H>(
        by keySelector: (Element) throws -> H
    ) rethrows -> [H: [Element]] where H: Hashable {
        try .init(grouping: self, by: keySelector)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keySelector: (Element) throws -> KeyType,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: [ValueType]] where KeyType: Hashable {
        try grouped(by: keySelector) { try $0.map(valueSelector) }
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ResultType>(
        by keySelector: (Element) throws -> KeyType,
        sink: ([Element]) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keySelector).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        sink: ([Element]) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try grouped(by: keyPath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, InterimType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, InterimType>,
        sink: ([InterimType]) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keyPath, extracting: valuePath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func groupedFilter<H>(
        by keySelector: (Element) throws -> H,
        filter: (Element) throws -> Bool
    ) rethrows -> [H: [Element]] where H: Hashable {
        try grouped(by: keySelector) { try $0.filter(filter) }
    }

    @inlinable
    @inline(__always)
    func groupedReduce<KeyType, ResultType>(
        _ initialValue: ResultType,
        keySelector: (Element) throws -> KeyType,
        reducer: (ResultType, Element) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keySelector) { try $0.reduce(initialValue, reducer) }
    }
}
