public extension Sequence {
    @inlinable
    @inline(__always)
    func forEach(
        _ body: (Element) async throws -> Void
    ) async rethrows {
        for el: Element in self {
            try await body(el)
        }
    }

    @inlinable
    @inline(__always)
    func map<R>(
        _ transform: (Element) async throws -> R.Element
    ) async rethrows -> R where R: RangeReplaceableCollection {
        var mapped: R = .init()
        for el: Element in self {
            try await mapped.append(transform(el))
        }
        return mapped
    }

    @inlinable
    @inline(__always)
    func compactMap<R>(
        _ transform: (Element) async throws -> R.Element?
    ) async rethrows -> R where R: RangeReplaceableCollection {
        var mapped: R = .init()
        for el: Element in self {
            guard let transformed: R.Element = try await transform(el) else { continue }
            mapped.append(transformed)
        }
        return mapped
    }

    @inlinable
    @inline(__always)
    func reduce<T>(
        _ initialValue: T,
        _ reducer: (T, Element) async throws -> T
    ) async rethrows -> T {
        var result: T = initialValue
        for el: Element in self {
            result = try await reducer(result, el)
        }
        return result
    }

    @inlinable
    @inline(__always)
    func reduce<T>(
        into initialValue: T,
        _ mutatingReducer: (inout T, Element) async throws -> Void
    ) async rethrows -> T {
        var result: T = initialValue
        for el: Element in self {
            try await mutatingReducer(&result, el)
        }
        return result
    }

    @inlinable
    @inline(__always)
    func contains(
        where isSatisfied: (Element) async throws -> Bool
    ) async rethrows -> Bool {
        for el: Element in self {
            if try await isSatisfied(el) { return true }
        }
        return false
    }

    @inlinable
    @inline(__always)
    func allSatisfy(
        _ predicate: (Element) async throws -> Bool
    ) async rethrows -> Bool {
        for el: Element in self {
            guard try await predicate(el) else { return false }
        }
        return true
    }

    @inlinable
    @inline(__always)
    func filter(
        _ isIncluded: (Element) async throws -> Bool
    ) async rethrows -> [Self.Element] {
        var filtered: [Self.Element] = .init()
        for el: Element in self {
            if try await isIncluded(el) { filtered.append(el) }
        }
        return filtered
    }

    @inlinable
    @inline(__always)
    func nilter<T>(
        _ nilter: (Element) async throws -> T?
    ) async rethrows -> [Self.Element] {
        var niltered: [Self.Element] = .init()
        for el: Element in self {
            guard try await nilter(el) != nil else { continue }
            niltered.append(el)
        }
        return niltered
    }
}
