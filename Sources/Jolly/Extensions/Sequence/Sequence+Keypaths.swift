public extension Sequence {
    @inlinable
    @inline(__always)
    func compactMap<T>(
        _ keyPath: KeyPath<Element, T?>
    ) -> [T] {
        compactMap { $0[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func contains<E>(
        _ element: Element,
        at keyPath: KeyPath<Element, E>
    ) -> Bool where E: Equatable {
        contains { $0[keyPath: keyPath] == element[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func map<T>(
        _ keyPath: KeyPath<Element, T>
    ) -> [T] {
        map { $0[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func filter(
        _ keyPath: KeyPath<Element, Bool>
    ) -> [Self.Element] {
        filter { $0[keyPath: keyPath] }
    }

    @inlinable
    @inline(__always)
    func nilter<O>(
        _ nilter: (Element) -> O?
    ) -> [Self.Element] {
        filter { nilter($0) != nil }
    }

    @inlinable
    @inline(__always)
    func nilter<O>(
        _ nilter: (Element) throws -> O?
    ) rethrows -> [Self.Element] {
        try filter { try nilter($0) != nil }
    }

    @inlinable
    @inline(__always)
    func nilter<T>(
        _ keyPath: KeyPath<Element, T?>
    ) -> [Self.Element] {
        filter { $0[keyPath: keyPath] != nil }
    }
}
