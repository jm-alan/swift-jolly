public extension Sequence {
    @inlinable
    @inline(__always)
    func indexed<H>(
        by keySelector: (Element) async throws -> H
    ) async rethrows -> [H: Element] where H: Hashable {
        try await reduce(into: [:]) { try await $0[keySelector($1)] = $1 }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keySelector: (Element) async throws -> KeyType,
        valueSelector: (Element) async throws -> ValueType
    ) async rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try await reduce(into: [:]) { try await $0[keySelector($1)] = valueSelector($1) }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        valueSelector: (Element) async throws -> ValueType
    ) async rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try await reduce(into: [:]) { try await $0[$1[keyPath: keyPath]] = valueSelector($1) }
    }
}
