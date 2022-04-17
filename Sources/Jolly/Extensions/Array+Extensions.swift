public extension Array {
    // MARK: - An overload of reduce taking in a mutable initialResult

    @inlinable
    func reduce<R>(
        _ initialResult: inout R,
        _ reducer: (inout R, Element) -> Void
    ) -> R {
        var result = initialResult
        for el in self {
            reducer(&result, el)
        }
        return result
    }

    @inlinable
    func reduce<R>(
        _ initialResult: inout R,
        _ reducer: (inout R, Element) throws -> Void
    ) rethrows -> R {
        var result = initialResult
        for el in self {
            try reducer(&result, el)
        }
        return result
    }

    // MARK: - Overloads of existing functions using keypaths for simplicity

    @inlinable
    subscript(safe index: Index) -> Element? {
        get { indices.contains(index) ? self[index] : nil }
        set {
            guard
                indices.contains(index),
                let newValue = newValue
            else { return }
            self[index] = newValue
        }
    }

    @inlinable
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }

    @inlinable
    func filter<C>(
        _ comparator: KeyValComparator<Element, C>
    ) -> [Element] where C: Comparable {
        filter(comparator.getValue)
    }

    @inlinable
    func filter(_ keyPath: KeyPath<Element, Bool>) -> [Element] {
        filter { $0[keyPath: keyPath] }
    }

    @inlinable
    func nilter<O>(_ nilter: (Element) -> O?) -> [Element] {
        filter { nilter($0) != nil }
    }

    @inlinable
    func nilter<O>(_ nilter: (Element) throws -> O?) rethrows -> [Element] {
        try filter { try nilter($0) != nil }
    }

    @inlinable
    func nilter<T>(_ keyPath: KeyPath<Element, T?>) -> [Element] {
        filter { $0[keyPath: keyPath] != nil }
    }

    @inlinable
    func compactMap<T>(_ keyPath: KeyPath<Element, T?>) -> [T] {
        compactMap { $0[keyPath: keyPath] }
    }

    @inlinable
    func allSatisfy<C>(_ predicate: KeyValComparator<Element, C>) -> Bool {
        allSatisfy(predicate.getValue(comparing:))
    }

    @inlinable
    func contains<E>(
        _ element: Element,
        criteria keyPath: KeyPath<Element, E>
    ) -> Bool where E: Equatable {
        contains { $0[keyPath: keyPath] == element[keyPath: keyPath] }
    }

    @inlinable
    func contains<E>(
        _ element: Element,
        criteria keyPaths: [KeyPath<Element, E>]
    ) -> Bool where E: Equatable {
        contains { el in
            keyPaths.allSatisfy { el[keyPath: $0] == element[keyPath: $0] }
        }
    }

    // MARK: - New methods, array -> dictionary

    @inlinable
    func grouped<H>(
        by keySelector: (Element) -> H
    ) -> [H: [Element]] where H: Hashable {
        .init(grouping: self, by: keySelector)
    }

    @inlinable
    func grouped<KeyType, ValueType>(
        by keySelector: (Element) -> KeyType,
        valueSelector: (Element) -> ValueType
    ) -> [KeyType: [ValueType]] where KeyType: Hashable {
        grouped(by: keySelector) { $0.map(valueSelector) }
    }

    @inlinable
    func grouped<H>(
        by keyPath: KeyPath<Element, H>
    ) -> [H: [Element]] where H: Hashable {
        grouped { $0[keyPath: keyPath] }
    }

    @inlinable
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
    func grouped<KeyType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        sink: ([Element]) -> ResultType
    ) -> [KeyType: ResultType] where KeyType: Hashable {
        grouped(by: keyPath).mapValues(sink)
    }

    @inlinable
    func grouped<KeyType, ResultType>(
        by keySelector: (Element) -> KeyType,
        sink: ([Element]) -> ResultType
    ) -> [KeyType: ResultType] where KeyType: Hashable {
        grouped(by: keySelector).mapValues(sink)
    }

    @inlinable
    func grouped<KeyType, InterimType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, InterimType>,
        sink: ([InterimType]) -> ResultType
    ) -> [KeyType: ResultType] where KeyType: Hashable {
        grouped(by: keyPath, extracting: valuePath).mapValues(sink)
    }

    @inlinable
    func groupedFilter<H>(
        by keySelector: (Element) -> H,
        filter: (Element) -> Bool
    ) -> [H: [Element]] where H: Hashable {
        grouped(by: keySelector) { $0.filter(filter) }
    }

    @inlinable
    func groupedNilter<KeyType, OptionalType>(
        by keySelector: (Element) -> KeyType,
        nilter: (Element) -> OptionalType?
    ) -> [KeyType: [Element]] where KeyType: Hashable {
        grouped(by: keySelector) { $0.nilter(nilter) }
    }

    @inlinable
    func groupedReduce<KeyType, ResultType>(
        _ initialValue: ResultType,
        keySelector: (Element) -> KeyType,
        reducer: (ResultType, Element) -> ResultType
    ) -> [KeyType: ResultType] where KeyType: Hashable {
        grouped(by: keySelector) { $0.reduce(initialValue, reducer) }
    }

    // MARK: - Grouping methods but throwing

    @inlinable
    func grouped<H>(
        by keySelector: (Element) throws -> H
    ) rethrows -> [H: [Element]] where H: Hashable {
        try .init(grouping: self, by: keySelector)
    }

    @inlinable
    func grouped<KeyType, ValueType>(
        by keySelector: (Element) throws -> KeyType,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: [ValueType]] where KeyType: Hashable {
        try grouped(by: keySelector) { try $0.map(valueSelector) }
    }

    @inlinable
    func grouped<KeyType, ResultType>(
        by keySelector: (Element) throws -> KeyType,
        sink: ([Element]) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keySelector).mapValues(sink)
    }

    @inlinable
    func grouped<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        sink: ([Element]) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try grouped(by: keyPath).mapValues(sink)
    }

    @inlinable
    func grouped<KeyType, InterimType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, InterimType>,
        sink: ([InterimType]) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keyPath, extracting: valuePath).mapValues(sink)
    }

    @inlinable
    func groupedFilter<H>(
        by keySelector: (Element) throws -> H,
        filter: (Element) throws -> Bool
    ) rethrows -> [H: [Element]] where H: Hashable {
        try grouped(by: keySelector) { try $0.filter(filter) }
    }

    @inlinable
    func groupedNilter<KeyType, OptionalType>(
        by keySelector: (Element) throws -> KeyType,
        nilter: (Element) throws -> OptionalType?
    ) rethrows -> [KeyType: [Element]] where KeyType: Hashable {
        try grouped(by: keySelector) { try $0.nilter(nilter) }
    }

    @inlinable
    func groupedReduce<KeyType, ResultType>(
        _ initialValue: ResultType,
        keySelector: (Element) throws -> KeyType,
        reducer: (ResultType, Element) throws -> ResultType
    ) rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try grouped(by: keySelector) { try $0.reduce(initialValue, reducer) }
    }

    // MARK: - New methods, array -> indexed dictionary

    @inlinable
    func indexed<H>(
        by keySelector: (Element) -> H
    ) -> [H: Element] where H: Hashable {
        var indexed: [H: Element] = [:]
        forEach { indexed[keySelector($0)] = $0 }
        return indexed
    }

    @inlinable
    func indexed<KeyType, ValueType>(
        by keySelector: (Element) -> KeyType,
        valueSelector: (Element) -> ValueType
    ) -> [KeyType: ValueType] where KeyType: Hashable {
        var indexed: [KeyType: ValueType] = [:]
        forEach { indexed[keySelector($0)] = valueSelector($0) }
        return indexed
    }

    @inlinable
    func indexed<H>(
        by keyPath: KeyPath<Element, H>
    ) -> [H: Element] where H: Hashable {
        var indexed: [H: Element] = [:]
        forEach { indexed[$0[keyPath: keyPath]] = $0 }
        return indexed
    }

    @inlinable
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        valueSelector: (Element) -> ValueType
    ) -> [KeyType: ValueType] where KeyType: Hashable {
        var indexed: [KeyType: ValueType] = [:]
        forEach { indexed[$0[keyPath: keyPath]] = valueSelector($0) }
        return indexed
    }

    @inlinable
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, ValueType>
    ) -> [KeyType: ValueType] where KeyType: Hashable {
        var indexed: [KeyType: ValueType] = [:]
        forEach { indexed[$0[keyPath: keyPath]] = $0[keyPath: valuePath] }
        return indexed
    }

    // MARK: - Indexed methods but throwing

    @inlinable
    func indexed<H>(
        by keySelector: (Element) throws -> H
    ) rethrows -> [H: Element] where H: Hashable {
        var indexed: [H: Element] = [:]
        try forEach { try indexed[keySelector($0)] = $0 }
        return indexed
    }

    @inlinable
    func indexed<KeyType, ValueType>(
        by keySelector: (Element) throws -> KeyType,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        var indexed: [KeyType: ValueType] = [:]
        try forEach { try indexed[keySelector($0)] = valueSelector($0) }
        return indexed
    }

    @inlinable
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        var indexed: [KeyType: ValueType] = [:]
        try forEach { try indexed[$0[keyPath: keyPath]] = valueSelector($0) }
        return indexed
    }
}
