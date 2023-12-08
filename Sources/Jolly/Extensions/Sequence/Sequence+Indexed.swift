public extension Sequence {
    @inlinable
    @inline(__always)
    func indexed<H>(
        by keyPath: KeyPath<Element, H>
    ) -> [H: Element] where H: Hashable {
        reduce(into: [:]) { $0[$1[keyPath: keyPath]] = $1 }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        extracting valuePath: KeyPath<Element, ValueType>
    ) -> [KeyType: ValueType] where KeyType: Hashable {
        reduce(into: [:]) { $0[$1[keyPath: keyPath]] = $1[keyPath: valuePath] }
    }

    @inlinable
    @inline(__always)
    func indexed<H>(
        by keySelector: (Element) throws -> H
    ) rethrows -> [H: Element] where H: Hashable {
        try reduce(into: [:]) { try $0[keySelector($1)] = $1 }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keySelector: (Element) throws -> KeyType,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try reduce(into: [:]) { try $0[keySelector($1)] = valueSelector($1) }
    }

    @inlinable
    @inline(__always)
    func indexed<KeyType, ValueType>(
        by keyPath: KeyPath<Element, KeyType>,
        valueSelector: (Element) throws -> ValueType
    ) rethrows -> [KeyType: ValueType] where KeyType: Hashable {
        try reduce(into: [:]) { try $0[$1[keyPath: keyPath]] = valueSelector($1) }
    }
}
