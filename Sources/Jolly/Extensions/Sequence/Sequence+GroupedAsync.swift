public extension Sequence {
    @inlinable
    @inline(__always)
    func grouped<H>(
        by keySelector: (Element) async throws -> H
    ) async rethrows -> [H: [Element]] where H: Hashable {
        try await .init(grouping: self, by: keySelector)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keySelector: (Element) async throws -> KeyType,
        valueSelector: (Element) async throws -> ValueType
    ) async rethrows -> [KeyType: [ValueType]] where KeyType: Hashable {
        try await grouped(by: keySelector) { try await $0.map(valueSelector) }
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ResultType>(
        by keySelector: (Element) async throws -> KeyType,
        sink: ([Element]) async throws -> ResultType
    ) async rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try await grouped(by: keySelector).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        sink: ([Element]) async throws -> ValueType
    ) async rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try await grouped(by: keyPath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func grouped<KeyType, InterimType, ResultType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, InterimType>,
        sink: ([InterimType]) async throws -> ResultType
    ) async rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try await grouped(by: keyPath, extracting: valuePath).mapValues(sink)
    }

    @inlinable
    @inline(__always)
    func groupedFilter<H>(
        by keySelector: (Element) async throws -> H,
        filter: (Element) async throws -> Bool
    ) async rethrows -> [H: [Element]] where H: Hashable {
        try await grouped(by: keySelector) { try await $0.filter(filter) }
    }

    @inlinable
    @inline(__always)
    func groupedNilter<KeyType, OptionalType>(
        by keySelector: (Element) async throws -> KeyType,
        nilter: (Element) async throws -> OptionalType?
    ) async rethrows -> [KeyType: [Element]] where KeyType: Hashable {
        try await grouped(by: keySelector) { try await $0.nilter(nilter) }
    }

    @inlinable
    @inline(__always)
    func groupedReduce<KeyType, ResultType>(
        _ initialValue: ResultType,
        keySelector: (Element) async throws -> KeyType,
        reducer: (ResultType, Element) async throws -> ResultType
    ) async rethrows -> [KeyType: ResultType] where KeyType: Hashable {
        try await grouped(by: keySelector) { try await $0.reduce(initialValue, reducer) }
    }
}
