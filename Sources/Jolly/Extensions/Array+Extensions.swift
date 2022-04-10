public extension Array {
    // MARK: - Overloads of existing extensions using keypaths for simplicity

    @inlinable
    subscript(safe index: Index) -> Element? {
        get { indices.contains(index) ? self[index] : nil }
        set {
            if indices.contains(index),
               let newValue = newValue
            {
                self[index] = newValue
            }
        }
    }

    @inlinable
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        map { $0[keyPath: keyPath] }
    }

    @inlinable
    func filter<C>(
        _ comparator: Comparator<Element, C>
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
    func grouped<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        sink: ([Element]) -> ValueType
    ) -> [KeyType: ValueType] where KeyType: Hashable {
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
        initialValue: ResultType,
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
        initialValue: ResultType,
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
